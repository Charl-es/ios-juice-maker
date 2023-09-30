
# 🥤쥬스메이커
쥬스를 만들고 제작하는 


## 목차

1. [팀원](#1-팀원)
2. [클래스다이어그램](#2-클래스-다이어그램)
3. [타임라인](#3-타임라인)
4. [실행 화면(기능 설명)](#4-실행화면기능-설명)
5. [트러블 슈팅](#5-트러블-슈팅)
6. [참고 링크](#6-참고-링크)
7. [팀 회고](#7-팀-회고)

<br>

## 1.팀원

| [mireu](https://github.com/mireu79)  | [charles](https://github.com/Charl-es) |
| :--------: | :--------: |
|<img src=https://github.com/mireu79/ios-rock-paper-scissors/assets/125941932/b4a69222-b338-4a7f-984c-be5bd78dc1d8 height="150"/> |<img src=https://github.com/Charl-es/ios-juice-maker/assets/125941932/42b8b93c-6c9e-4a78-80fe-37a111da5666 height="150"/> | 

<br>

## 2. 클래스 다이어그램

![](https://hackmd.io/_uploads/Bk4OKjGlT.png)


<br>

## 3. 타임라인
|날짜|내용|
|------|---|
|23.09.11|프로젝트 흐름에 대한 파악 및 공식문서 공부|
|23.09.12|쥬스메이커 STEP1구현<br>`Fruit와Juice enum타입 생성`,<br> `과일재고를 담는 딕셔너리 타입의 fruitStock 변수 선언, 생성자 구현`, `과일개 변경하는 함수구현`,<br> `Juice 타입에 recipe 계산속성 추가`,<br> `쥬스를 만들면서 과일개수 재고에서 차감하는 함수 구현`,<br> `주스를 만드는 함수 구현`, `과일재고부족에대한 오류처리구현`   |
|23.09.13| 피드백반영<br>`strawbery -> strawberry로 수정. 재고를 변화를 주는 함수의 파라미터 fruitName-> name으로 수정`,<br>`접근을 제어하는 은닉화사용`, `FruitStore를 클래스에서 구조체로 수정. 이에 따른 멤버가 변화하는 함수에는 mutating 키워드 추가`, `makeJuice -> createJuice로 네이밍수정, 불필요한 분기처리 수정 및 중복코드 수정`,<br> `addFruitStock 함수의 private 제거`|
|23.09.14-15|STEP2에 대한 UIViewController에 대한 공부 및 구현|
|23.09.18|쥬스메이커 STEP2구현<br>`화면이동구성 및 UILabel설정`,<br>`첫 화면에 보여질 과일들의 재고를 설정하는 메서드 추가`, `orderJuice함수 생성, 열거형에 rawvalue 지정` |
|23.09.19|`주스가 나왔을 때, 얼럿과 재고가 모자랄 때 얼럿 구현`,<br> `버튼을 눌렀을때 주문되는 로직 구현`,<br>`두 개의 재료를 소모하는 주스에서 재고가 부족할 때 남아있는 다른 과일의 재고가 간혈적으로 소모되는 현상을 발견하여 해당 부분 함수 로직 수정`    |
|23.09.20|피드백반영<br>`네이밍 수정 및 clickStock함수의 파리미터 삭제`, `JuiceMaker의 조건 검사 함수를 삭제하고 FruitStore의 조건 검사 함수에서 처리하고 오류를 던지는 함수로 수정`, `화면전환하는 함수 분리 및 네이밍통일`, <br>`각 메서드 은닉화`    |
|23.09.21-22|STEP3오토레이아웃 및 화면사이 데이터 공유에 대한 공부|
|23.09.26|쥬스메이커 STEP3구현<br>`닫기버튼 구현하여 이전화면 복귀구현`,<br> `화면 진입시 과일의 현재 재고 수량 표시 구현`,<br> `제고수정화면 +,-를 통한 재고수정 구현`,<br> `화면 사이의 데이터 공유를 위해 델리게이트 패턴 사용`, `오토레이아웃적용`   |
|23.09.28|피드백반영<br>`화면 두 번이 되어 viewDidLoad() 메서드 삭제 및 IBOutlet 프로퍼티명 수정`, `네이밍수정 및 기능분리`,<br> `접근 제어자 삭제, 메서드명 수정, final 키워드 사용하여 상속 방지`|
 
<br>

## 4. 실행화면(기능 설명)


| 주문성공  | 재고부족 재고수정 화면 이동  |
| :--------: | :--------: | 
|![](https://hackmd.io/_uploads/ryJL5jMxa.gif)|![](https://hackmd.io/_uploads/H1aK5ifgp.gif)|


|재고수정 후 닫기버튼 클릭|
| :--------: |
|![](https://hackmd.io/_uploads/BJZgoiMl6.gif)|

  

<br>

## 5. 트러블 슈팅
### 1️⃣ 
딸바쥬스나 망키쥬스를 주문했을때 하나의 과일은 깎이고, 하나의 과일이 깎였다가 안깎이는 랜덤으로 과일이 수정이 되었는데, subtractFruitStock함수에 반복문을 추가해줘 랜덤으로 수정되는 것이 아니라 똑같이 동시에 수정되도록 해결해줬습니다.

<br>

- 수정전

 ~~~ swift
    private func checkFruitStock(name: Fruit, count: Int, juice: Juice) throws {
        for (name, count) in juice.recipe {
            guard let currentStock = fruitStock[name], currentStock >= count else {
                throw FruitStoreError.outOfStock
            }
        }
    }
    
    mutating func subtractFruitStock(name: Fruit, count: Int, juice: Juice) throws {
        try checkFruitStock(name: name, count: count, juice: juice)
        
        guard let currentStock = fruitStock[name] else { return }
        
        fruitStock.updateValue(currentStock - count, forKey: name)
    }
~~~
 - 수정후
 
~~~ swift
private func checkFruitStock(juice: Juice) throws {
        for (name, count) in juice.recipe {
            guard let currentStock = fruitStock[name], currentStock >= count else {
                throw FruitStoreError.outOfStock
            }
        }
    }
    
    func subtractFruitStock(juice: Juice) throws {
        try checkFruitStock(juice: juice)
        
        for (name, count) in juice.recipe {
            guard let currentStock = fruitStock[name] else { return }
            
            fruitStock.updateValue(currentStock - count, forKey: name)
        }
    }
~~~
<br>
 
### 2️⃣

재고수정 화면에서 과일의 데이터를 첫 번째 화면에 가져오는 것까지는 확인을 하였으나, 레이블 텍스트에 반영이 되지 않았었습니다.
이 부분에 대해 `willAppear`메서드와 `viewDidLoad` 메서드가 호출이 되나 확인을 해보았고 호출이 되지않아 공식문서를 확인해 보니, PresentationStyle을 따로 지정해주지 않으면 automatic으로 동작을 하며 이는 pageSheet으로 매핑이 되어(모든 경우는 아니다) 동작한다 나와있었습니다.
실제로 print(viewController.modalPresentationStyle.rawValue)로 확인을 하였을 때에 pageSheet 원시값이 프린트 되었습니다.
pageSheet의 동작방식은 높이가 높을 때엔 이전 화면을 전부 덮지 않는 방식으로 동작을 하고 높이가 컴팩트한 경우에는 fullScreen과 동일하게 동작한다 명시는 되어있었으나, 내부적으로는 fullScreen처럼 동작을 하지 않아 willAppear 메서드를 사용하여 재고수정화면에서 이전 화면으로 돌아올 때의 데이터를 화면에 반영시켜 주었습니다.

<br>

 - 수정 전
~~~ swift
  private func convertStockScreen() {
        guard let viewController = storyboard?.instantiateViewController(identifier: "StockViewController") as? StockViewController else { return }
        
        viewController.fruitInventory = juiceMaker.fruitStore.fruitStock
        
        viewController.delegate = self
        
        present(viewController, animated: true)
    }
~~~
 - 수정 후
~~~ swift
 private func convertStockScreen() {
        guard let viewController = storyboard?.instantiateViewController(identifier: "StockViewController") as? StockViewController else { return }
        
        viewController.fruitInventory = juiceMaker.fruitStore.fruitStock
        
        viewController.delegate = self
        
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
~~~


<br>

## 6. 참고 링크
[📖 공식문서 Naming](https://www.swift.org/documentation/api-design-guidelines/)<br>
[📖 공식문서 Initialization](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization/)<br>
[📖 공식문서 Access Control](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/accesscontrol/)<br>
[📖 공식문서 Nested Types](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/nestedtypes/)<br>
[📖 공식문서 Type Casting](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/typecasting/)<br>
[📖 공식문서 Error Handling](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/errorhandling/)<br>
[📖 공식문서 UIModalPresentationStyle](https://developer.apple.com/documentation/uikit/uimodalpresentationstyle)<br>


<br>

## 7. 팀 회고
- 😄우리팀이 잘한 점
    - 의견조율을 잘해서 코드짜는데 차질이 없었습니다.

<br>

- 😅우리팀이 개선할 점
    - 배려가 있는 모습은 좋으나 자기 주장과 자신감이 다소 부족했습니다.


