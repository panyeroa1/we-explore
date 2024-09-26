import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class ExploreCall {
  static Future<ApiCallResponse> call({
    dynamic messagesJson,
    String? systemMessage = '',
  }) async {
    final messages = _serializeJson(messagesJson);
    final ffApiRequestBody = '''
{
  "model": "meta-llama/Llama-3.2-3B-Instruct-Turbo",
  "messages": [
    {
      "role": "user",
      "content": "$messages"
    },
    {
      "role": "assistant",
      "content": "In marketing AI business automations, there are several key aspects to understand, but here are some of the most important ones:\\n\\n1. *Clear Goals and Objectives: Understand what you want to achieve with your marketing AI automation. What are your business objectives? What specific tasks do you want to automate? What metrics will you use to measure success?\\n\\n2. **Data Quality and Integration: High-quality data is essential for effective marketing AI automation. Ensure that your data is accurate, complete, and consistent. Integrate your data from various sources, such as CRM, email, and social media, to get a comprehensive view of your customers and prospects.\\n\\n3. **Automation Goals vs. Optimization Goals: Understand the difference between automation goals (e.g., automating a specific task) and optimization goals (e.g., improving conversion rates). Focus on optimizing your marketing AI automation to achieve better outcomes.\\n\\n4. **Machine Learning and AI Concepts: Understand the basics of machine learning and AI concepts, such as supervised and unsupervised learning, clustering, and predictive modeling. This will help you to design and implement effective marketing AI automation strategies.\\n\\n5. **Customer Journey Mapping: Map out the customer journey to identify opportunities for automation. Understand the customer‛s pain points, preferences, and behaviors to design targeted and effective marketing AI automation.\\n\\n6. **Personalization: Personalization is key to successful marketing AI automation. Use data and analytics to create personalized experiences that resonate with your customers and prospects.\\n\\n7. **Continuous Testing and Optimization: Marketing AI automation is not a one-time setup; it requires continuous testing and optimization. Regularly review and refine your automation strategies to ensure they are working effectively.\\n\\n8. **Integration with Other Marketing Channels: Marketing AI automation should be integrated with other marketing channels, such as email, social media, and content marketing, to create a cohesive and effective marketing strategy.\\n\\n9. **Budget Allocation: Understand the budget allocation for marketing AI automation and ensure that it is aligned with your business objectives. Allocate resources effectively to maximize ROI.\\n\\n10. **Measuring Success*: Establish clear metrics to measure the success of your marketing AI automation. Use data and analytics to track key performance indicators (KPIs) and adjust your strategies accordingly.\\n\\nSome popular marketing AI automation tools to consider:\\n\\n1. HubSpot\\n2. Marketo\\n3. Pardot\\n4. Salesforce\\n5. Mailchimp\\n6. Klaviyo\\n7. Salesforce Einstein\\n8. Google Analytics\\n9. Salesforce Automation Studio\\n10. Microsoft Power Automate ("
    }
  ],
  "max_tokens": 512,
  "temperature": 0.7,
  "top_p": 0.7,
  "top_k": 50,
  "repetition_penalty": 1,
  "stop": [
    "<|eot_id|>",
    "<|eom_id|>"
  ],
  "stream": true
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Explore',
      apiUrl: 'https://api.together.xyz/v1/chat/completions',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Bearer 279216a928a5db9905961185a24099be58d4a34498eead707d38ee0f7fcc01b6',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: true,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
