#!/bin/bash
npm ci
npm run build
npm run serve -- --host 0.0.0.0 --port 3001 --no-open
