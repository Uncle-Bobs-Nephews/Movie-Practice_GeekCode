# GeekCode's Project

## History
- 230826 : 테이블뷰 구현


### 동작화면
<img width="300" alt="ezgif-4-c7260a6cb2" src="https://github.com/isGeekCode/TIL/assets/76529148/f79c8551-94c1-4026-a7c2-86d71e79be48">


## Clean Architecture 패턴
```
TMDBApp
├── AppFirst
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── TabBarController.swift
├── DataLayer
│   ├── APIResponseModel.swift
│   └── MovieListModel.swift
├── DomainLayer
│   └── MovieModel.swift
├── PresentationLayer
│   └── MovieListPresenterImpl.swift
├── UseCaseLayer
│   └── UseCaseImpl.swift
├── UserInterfaceLayer
│   └── MovieListViewController.swift
├── View
│   ├── MovieCell.swift
│   └── TVListViewController.swift
│
├── Base.lproj
│   ├── LaunchScreen.storyboard
│   └── Main.storyboard
└── Config
    ├── Configs.swift
    └── PrivateKey.swift
```
