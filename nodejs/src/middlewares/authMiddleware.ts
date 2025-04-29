import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';


export const verifyToken = (req: Request, res: Response, next: NextFunction): void => {
    // Extract the token from the Authorization header (format: "Bearer <token>")
    const token = req.headers.authorization?.split(' ')[1];
    

    // Check if token exists
    if (!token) {
        res.status(403).json({ error: 'No token provided' });
        return;
    }

    try {
        // Verify the token using the secret key
        const decoded = jwt.verify(token, process.env.JWT_TOKEN || 'worisecretkey') as { id: string };
        
        // Attach the decoded user information to the request object
        req.user = decoded;
        
        // Proceed to the next middleware or route handler
        next();
    } catch (error) {
        res.status(401).json({ error: 'Invalid token' });
    }
};