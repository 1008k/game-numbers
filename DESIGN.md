# DESIGN.md

This file defines portable design direction for AI design and coding agents.
Use it to keep UI generation, mockups, prototypes, and implementation visually consistent across tools.

UX principles and review criteria live in `docs/rules-ux.md`.
Product requirements and expected behavior live in `docs/project-spec.md`.

## How To Use This File
- Leave this file partially blank while the product direction is still unclear.
- After 1-2 representative screens or mockups establish a direction, update this file before expanding to more screens.
- Before generating UI, editing mockups, or implementing user-facing screens, check this file for visual direction and component rules.
- When the design direction changes intentionally, update this file in the same change.

## 1. Product Context
- Product:
- Audience:
- Primary user goal:
- Business objective:
- Desired user feeling:
- Design maturity: draft | direction-set | stable

## 2. Design Direction
- Overall tone:
- Visual keywords:
- Interaction keywords:
- Reference products:
- Avoid:

## 3. Do Not
- Do not use:
- Avoid visual patterns:
- Avoid interaction patterns:
- Never change without updating this file:
- Out of scope for design agents:

## 4. Experience Principles
- Primary screen goal:
- Information priority:
- Navigation principle:
- Feedback principle:
- Error recovery principle:

## 5. Visual System

### Color
- Primary:
- Secondary:
- Background:
- Surface:
- Text:
- Border:
- Success:
- Warning:
- Error:

### Typography
- Font direction:
- Heading style:
- Body style:
- Label style:
- Number/data style:

### Spacing
- Base spacing:
- Section spacing:
- Dense areas:
- Relaxed areas:

### Shape
- Border radius:
- Card shape:
- Button shape:
- Input shape:

### Elevation
- Default:
- Hover/focus:
- Modal/dialog:
- Avoid:

## 6. Component Rules

### Buttons
- Primary:
- Secondary:
- Destructive:
- Disabled:
- Loading:

### Forms
- Field layout:
- Required fields:
- Validation:
- Error display:

### Cards / Panels
- Usage:
- Density:
- Header/content/action layout:

### Tables / Lists
- Usage:
- Row actions:
- Empty state:
- Selection:

### Navigation
- Global navigation:
- Local navigation:
- Breadcrumbs/tabs:

## 7. Screen Patterns

### Screen:
- User goal:
- Primary action:
- Key information:
- Layout:
- Loading state:
- Empty state:
- Error state:
- Success state:

## 8. Responsive Rules
- Mobile:
- Tablet:
- Desktop:
- Wide desktop:

## 9. Content Style
- Voice:
- Button labels:
- Empty state copy:
- Error copy:
- Help text:

## 10. Stitch Prompt Block

Use this block when importing or prompting in Stitch.

```text
Create UI designs for:
Audience:
Primary action:
Desired feeling:
Visual direction:
References:
Avoid:
Important states:
```

## 11. Review Checklist
- The screen has one clear primary goal.
- The primary action is visually dominant.
- The visual tone matches the design direction.
- The design avoids everything listed in Do Not.
- Loading, empty, error, and success states are covered.
- Components follow the rules above.
- The design can be extended to another screen without re-explaining the style.
