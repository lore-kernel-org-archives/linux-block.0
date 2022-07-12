Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6C3C43334
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 07:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbiGLH6n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 03:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiGLH6l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 03:58:41 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Jul 2022 00:58:37 PDT
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B064E7F
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 00:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657612717; x=1689148717;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eKAWo6giASn6wBom1ZvvihvDN+oDQYRoMSnfabbh4zE=;
  b=To87nSXdmCQsxQGnNFesZK8YsREElTreDNFXRmSBODv9wPDKl5Wy9DLb
   yIAx4u79RBvcC6Ghua2yp4Re3Brqz/9ZL23Abkh4Ake1B1avDZfBPstcz
   rLS3uls1f9GCwhMWr6Qk3rLkcxCRVxDUwkUuadKZvbEkQVMOUkJ+K/YUG
   ADxMu4oAKTMRcJsdEaPCBB8VtZv/F9FUgsQciPmQC+oe2TDNhWDI/Fc5f
   QcyBTredxChxcBagY7wl9njQDFUFW5gtyBzRHW/YaM1kJcFUgkD76JE6z
   mwfUSZBVkKEmLA7Q/ZxbUrLNPJXRtUaBV2J8wiZ1RwNQF3j43PveGedrq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="60292980"
X-IronPort-AV: E=Sophos;i="5.92,265,1650898800"; 
   d="scan'208";a="60292980"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 16:57:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mS7NwLpEvF2m2nXlKz4+H7KCB9afv6EnOgc+wRC0skj9N+8JW+/lD+kwC5oBEl5uiFJVbNrbTb/Rd4SEswo9xS9t9Ec4GBMdU4/rab38IRY9sbZsJVDLgAWseeXDUauvlq2xQtTF4djEHCnn1/ubk/xNlr0Que/VGm1wO1wNSGO8uFWgUOUi9wmhlC8F1Ao92rRTPdIoPuvXXwUiDvadUR6N6vP5vcc3oU2wiQ7jI7Kmg29TBadMYzFOU6BEdxW8ciWuwlUXodfWxjAhXooQlCbQI+Dt+63zU8BA39eJIioYFBu21MzPogu6gZZA9nkl3wTXAuPsMD+GKIRxfGJ2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKAWo6giASn6wBom1ZvvihvDN+oDQYRoMSnfabbh4zE=;
 b=fT0I/dVmdDWkEeJf0gQFjmkOa1MxAjJwnpsUAOVIvHpq+OPvZJNG2DEqivsLlyjYXq4/TmTdcGeWCqhumLM0ADwTpUcShdQuxFBrokU/TgjnkWut+v0NpiZBqQhVIUJpk4H++ymucRAANVxhC41Snye0GL+W2GFsOQm7mGzG6DXO3+crJeB3iZ0HIXOwBHRprLNZKZbgl/sI1iDcbc5IJzttzmX+VFnrpurkJVMqWWekYSF6rOoL+qYtY1LpWXdQDJav5tAJyNeRPmdx5JCkGjcVfsXUVf70ZsAjXsd7trFEhBSTv4biRHWOSjJZE/MGssOLGo+8F36PbmMe43hEvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKAWo6giASn6wBom1ZvvihvDN+oDQYRoMSnfabbh4zE=;
 b=SiAIfPUzwGwXwKy/F655W+MYI+mePL3uFF/pDbeFTV83BSaAP/V8aT91lyv/P06Fgw4MYj3/KWrqeu0eO+A8QnXQhbezgMBCZuut3Sv37GwedhwEzJyUVbBXRZCgFZj+u9ljd8vRGodNNRtNpgmfM0zCcdrbyxjzRf99v7mMAxI=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TY2PR01MB3497.jpnprd01.prod.outlook.com (2603:1096:404:dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Tue, 12 Jul
 2022 07:57:27 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%8]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 07:57:27 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH blktests] common, tests: Support printing multiple skip
 reasons
Thread-Topic: [PATCH blktests] common, tests: Support printing multiple skip
 reasons
Thread-Index: AQHYkbRJkUvbHQedkkOfHUgIgL5Mh61yvXQAgAAMSQCAB5znAA==
Date:   Tue, 12 Jul 2022 07:57:27 +0000
Message-ID: <36df971d-78bd-5250-55dd-2d9c53c0f240@fujitsu.com>
References: <20220707035435.1794716-1-lizhijian@fujitsu.com>
 <20220707105804.dzxchu7tgeynsttb@shindev>
 <8118fa42-3242-bcf0-a01e-d98ad8c3a906@fujitsu.com>
In-Reply-To: <8118fa42-3242-bcf0-a01e-d98ad8c3a906@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9d082ca-97d2-4173-6f21-08da63dc2a00
x-ms-traffictypediagnostic: TY2PR01MB3497:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 99zJcnhUqTR9xSS4d43v6CO5N2WVEb6SDh28F3rCElbVvodt9sgsUNhRmEsp7XL5oidi9kOX1QsLGN2yTfTldChFe6GgKCsR8gXCWkHfE0ZbVrhd2qunwhJTrEFi6LPJ22NK9oSBWBovZ8wS0m0GgAkl3wfpLozBzuPM0o4F8tSq9foUyW3qDgZ67zFwKkdT8EsmJHDvP/qRwxiXB6oo8Jph7ZGSx3N95XOapkyCMc+70QTHELAX9QvZCwZXzYWflOuSHj8gy4TYm7vWud+MpVDTvvOffoHsUfD83VZiO1cT/FEXN3LV9IgUcW7PFdkEE1lYFRX9/TY3ZAt4Jbxq9CO2i+jsFXD0cHdfdrJx0zC09E2mm8I8U5b8y8XRhxZTZJTsZG6R4abgqTm6g8LbrrH+iGLrEkPi7WyVAQYAS6RWoUcE9GLu5xA7Vi15eevvAU7Y9xKvjGw4p9vfLQT60v9d5oQ7hNNGt5l7X1KEi1c1yAYEr7R/eZzrXku7OfQdzqkItHZjghJrQGGcImjG2iBqx+8YATchEB4krlZ693fDeuZbnZn9dOkU2JzfTZTpa0D8YFFoXlof7js+tq89hIxV02lo6YMnvDVUKza/F9Ao7xtQ1nWVL6G+hlKM3t5xqaKdJwSeuAxCZohdrrkS5Ms+/1cH2hdhFL5ZO9dJpRd1YdS9V1Bo07CoI1FVl7s4yx/gwWOAPTTU4L6dDHo1G+BP41IMub2X02mVtSDHOR+5fb+ip6wOYUgvDSAOoyzy4TUYJh9o73ry3+dIlUO8QofHj5F9Qme1JvbBfajlJiOvu2W3shs7Nnl5r1skNZL2JJQky6adfv7yW3NF5nnIr2+l18Vv1vpbJwR2qY4yTXkSDVizn+Gqrqz7gW/hpZvI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(83380400001)(6486002)(36756003)(186003)(38100700002)(85182001)(478600001)(6512007)(26005)(122000001)(31686004)(2616005)(2906002)(31696002)(6916009)(8676002)(91956017)(4326008)(71200400001)(86362001)(66946007)(66476007)(5660300002)(64756008)(66556008)(76116006)(8936002)(66446008)(38070700005)(54906003)(41300700001)(82960400001)(316002)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0swK3JnaGRDWkQzT2FFdmRyd1ZuWm1HRy9Ka2Y4TWtQeWwxaCtoS0crWDBu?=
 =?utf-8?B?U0FpYVVIUkdJSFFCNVpDclkydUtpeVA0MlFHNVltUnFldmpJUjNTSmFZY211?=
 =?utf-8?B?dUU5MVVuSEEwVUVmQWdxaHBqSzE1dncxTEFURGxGOGc4YktTQU04UlNuRlZ2?=
 =?utf-8?B?eHlYa1FiUVI1R3lVT2N4eE12UzF0S2R5Q0tQM2NZNnM2OTlpY2JNZkgyNzJo?=
 =?utf-8?B?SlQ3dUdwdVhXejVabEVhcHVjMXZlbXRMWnV6WEtRSHIyNVRKaXRsTGFrZmFk?=
 =?utf-8?B?RVpCR1hYOEJuNW56dkU3N1pGUGFQTzJBWjBHZDdjcUlIcFFRTWs5ZVBGMEhz?=
 =?utf-8?B?UjNBeDQ2TlN4WHJoaVlTSm5zaEFhS1ZRUDAvM214MG85OXZBNW5hY0FUeitL?=
 =?utf-8?B?SUpSTXZWRzZKSlBJTWExQU1pTmFkcml3cWdEdXBhcVRoWUJmazgyRDZiUjFU?=
 =?utf-8?B?S1FwaktpMkxpeG9xVHVqMzBqdksyVURjZnMxS1docHRJdmUySHZRTVRObjQr?=
 =?utf-8?B?RWFMeTN2aXdWS2xoQmErYlFwbnhUcmxvci8wT1pLOHBvTzk2dVJ4Y21sYzJ1?=
 =?utf-8?B?UmtFcUdnd0RzcjlaNTlqM1p3b2xBZk9VL013YkJ5ek81aGp5d3NxSUExMXg1?=
 =?utf-8?B?djB4enRubEFjdkFXODNxYU5KcHJSK21OTW85QS9LWXJmemJXYmFXTGFHSmov?=
 =?utf-8?B?ZVFLR2grYmk5bzFNY3ZqMnBKWHkySWhpWmVtZmhmcjJnYm9UK05pdjdHbEFF?=
 =?utf-8?B?NDJ4dUNQMU9rNW1LQlprcFhDdjU1cmg2T05yd3VUclJma0p6YVQ5WFFSbFVL?=
 =?utf-8?B?cmtJaGkzVDdqdVNhUTdBVWRSaVptelBUbWN5YnNkL2hOaTcranZTRWNsNHVk?=
 =?utf-8?B?YUdBWHcrM0hydjFSM25SdU4xZGVGRncvNEZxbXhlYVlIRE9XQmd6Mlp4Ymky?=
 =?utf-8?B?dk1XbmNlUDBPKzl3QWZwdEdZK1FiMGdaR3VxWHVWUHZwTHdVM3hNS09vVFVW?=
 =?utf-8?B?dElHR1ZsVldCOXBnd1NIZVdYS1dwSHZSYmJRU09NMW1nU0NNWjhpMy9LWlU0?=
 =?utf-8?B?SkZ1M3JZZzArVEJ2Rnk4VlJ6RG5LUnEwVWVsS3FJQUNZT3hyQzdrSDNSS1dO?=
 =?utf-8?B?ZVhRSmU1c3JYbUhkV3NrZU50Smh1RTA0ZHFtNStGS1EyeGtyb08wam0wVWZY?=
 =?utf-8?B?cmo0R1VVdSt1cTlrU0p1VHZpM0gvM3BrNnI0OUpiQ2Fub3BtcElTbFVMTTVv?=
 =?utf-8?B?eEJTY2pyRW1BK09YbjF4UnFqdFQrY1lPZHNOTmRPZ0xydExtaVNxazFRTjNJ?=
 =?utf-8?B?YXhwVG9MMlhLN21RK0tHTGxMUnpPMUZQSWw4N2R3Rnh1Sno4UFNLS2FQTzg0?=
 =?utf-8?B?c0NXdy9RcTE0RnlLS0tFQlU5bENXTWlZOGFxV3doM2hhL2pqSUJ4RjhMSWhF?=
 =?utf-8?B?N01Jb2J0VHpsaVFSd3RBTU5HSWMzVDVuYzl0d0FBSDJOcVRpeHNFMWM2c0JH?=
 =?utf-8?B?ZDJqMVptTnJ3clloeDVVLytUL1pISmFabitOd2tZYlRWSExNdGJKUHg4YkRl?=
 =?utf-8?B?R0w5eTZaaFVIODhwSGdjZVZDbHR6RTQzV2ljTlV5YU5ucE5seFZYU1BEMDdT?=
 =?utf-8?B?SVprNW5XL0ZmUGFMZ2o4VUJlRVJ6cktpZUkwQ2xmYjVSNGpHZTJFWi9GT3Rm?=
 =?utf-8?B?eWpoTy9WSm5EZFFQZWoycFNJUm5NMmR1Ym5PWitzbmxhNG1xLzZua0lOcm5k?=
 =?utf-8?B?RFEyWU41OHQ1ZHBxdm5oTlJJVnFtbkY5NHI2MFBTSHhJaS80NUdIMzZ1RE5a?=
 =?utf-8?B?MllhRWJ2RWcrSEFDTGNhenZLRUNOblVmdk9QOEJpWDgveDVvYjNFS3lTc0pS?=
 =?utf-8?B?N2JoSm5SWnV0U0VmV2kyWVRUOXJ4MkVWZ2RFUXQvbjRoTVJQN1JtYS9LWm9W?=
 =?utf-8?B?WC8xWmZiTXBFajlLY1lLTXRWbjBPWUY0M2hPdGdIUHNLRVRZQlh5bC81RFJO?=
 =?utf-8?B?N3YwSUN6Slhodm9mQnlzZjNrbjRPU1lweCtYY2lBQUJYMW1nQTdqUnNBL0dG?=
 =?utf-8?B?Y1NadFI3bDEvTW9GeU16TXpLMmc1em5vVGYyMldFNSs0SVVhVUtTcHh6VTNE?=
 =?utf-8?B?dXhKV3VkdVVJb1RLZGhKdU5VVnEwOU1YenJuMHNXZ2xDd1REd0Yydm5jNHc4?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD64876AD8407C408731D2CC5F37FA17@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d082ca-97d2-4173-6f21-08da63dc2a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 07:57:27.4504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aGmBYmy+ZFaFBBIQgk73apkzywa3BhLqrlX65YQbWvpWBAOSfRKjSvfR6VtkQUwOScLCstrscalNRWQfTE4m2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3497
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGVsbG8gU2hpbmljaGlybw0KDQpTbyBzb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkoSnVzdCByZWFs
aXplZCB0aGF0IHRoZSBTTVRQIGdvdCBzb21ldGhpbmcgd3JvbmcsIHByZXZpb3VzIHJlcGx5IHdh
cyBkcm9wIHdpdGhvdXQgYW55IG5vdGlmaWNhdGlvbikuDQoNCnBvc3QgaXQgYWdhaW4uDQoNCg0K
T24gMDcvMDcvMjAyMiAxOTo0MiwgTGksIFpoaWppYW4gd3JvdGU6DQo+DQo+IG9uIDcvNy8yMDIy
IDY6NTggUE0sIFNoaW5pY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+PiAuLi4gZ3JvdXBfcmVxdWly
ZXMoKSBzaG91bGQgYWRkIHN0cmluZ3MgdG8gdGhlIFwkU0tJUF9SRUFTT05TIGFycmF5IHdoaWNo
DQo+PiBkZXNjcmliZSB3aHkgdGhlIGdyb3VwIGNhbm5vdCBiZSBydW4uDQo+Pg0KPj4+IMKgICMN
Cj4+PiDCoCAjIFVzdWFsbHksIGdyb3VwX3JlcXVpcmVzKCkganVzdCBuZWVkcyB0byBjaGVjayB0
aGF0IGFueSBuZWNlc3NhcnkgcHJvZ3JhbXMgYW5kDQo+Pj4gwqAgIyBrZXJuZWwgZmVhdHVyZXMg
YXJlIGF2YWlsYWJsZSB1c2luZyB0aGUgX2hhdmVfZm9vIGhlbHBlcnMuIElmDQo+Pj4gLSMgZ3Jv
dXBfcmVxdWlyZXMoKSBzZXRzIFwkU0tJUF9SRUFTT04sIGFsbCB0ZXN0cyBpbiB0aGlzIGdyb3Vw
IHdpbGwgYmUgc2tpcHBlZC4NCj4+PiArIyBncm91cF9yZXF1aXJlcygpIHNldHMgXCRTS0lQX1JF
QVNPTlMsIGFsbCB0ZXN0cyBpbiB0aGlzIGdyb3VwIHdpbGwgYmUgc2tpcHBlZC4NCj4+IC4uLiBn
cm91cF9yZXF1aXJlcygpIGFkZHMgc3RyaW5ncyB0byBcJFNLSVBfUkVBU09OUywgYWxsIHRlc3Rz
IGluIHRoaXMgLi4uDQo+DQo+IEkgdHJpZWQgdG8gZG8gdGhhdCBhcyB5b3VyIHN1Z2dlc3Rpb24u
IEl0IGNhdXNlcyBhIHNpZGUgZWZmZWN0IHRoYXQgaW4gb3JkZXIgdG8gbWFrZQ0KPiB0aGUgbGlu
ZSBsZW5ndGggbGVzcyB0aGFuIDgwIGJ5dGVzLCB3ZSBoYXZlIHRvIHVwZGF0ZSBhbGwgaXRzIHN1
YnNlcXVlbnQgbGluZXMgaW4gdGhlDQo+IHNhbWVzZWN0aW9uLiBJcyBpdCBva2F5PyBWVlYNCj4N
Cj4gwqAjIFRPRE86IGlmIHRoaXMgdGVzdCBncm91cCBoYXMgZXh0cmEgcmVxdWlyZW1lbnRzIGZv
ciB3aGF0IGRldmljZXMgaXQgY2FuIGJlDQo+IMKgIyBydW4gb24sIGl0IHNob3VsZCBkZWZpbmUg
YSBncm91cF9kZXZpY2VfcmVxdWlyZXMoKSBmdW5jdGlvbi4gSWYgdGVzdHMgaW4gdGhpcw0KPiAt
IyBncm91cCBjYW5ub3QgYmUgcnVuIG9uIHRoZSB0ZXN0IGRldmljZSwgaXQgc2hvdWxkIHNldCB0
aGUgXCRTS0lQX1JFQVNPTlMNCj4gLSMgdmFyaWFibGUuIFwkVEVTVF9ERVYgaXMgdGhlIGZ1bGwg
cGF0aCBvZiB0aGUgYmxvY2sgZGV2aWNlIChlLmcuLCAvZGV2L252bWUwbjENCj4gLSMgb3IgL2Rl
di9zZGExKSwgYW5kIFwkVEVTVF9ERVZfU1lTRlMgaXMgdGhlIHN5c2ZzIHBhdGggb2YgdGhlIGRp
c2sgKG5vdCB0aGUNCj4gLSMgcGFydGl0aW9uLCBlLmcuLCAvc3lzL2Jsb2NrL252bWUwbjEgb3Ig
L3N5cy9ibG9jay9zZGEpLiBJZiB0aGUgdGFyZ2V0IGRldmljZQ0KPiAtIyBpcyBhIHBhcnRpdGlv
biBkZXZpY2UsIFwkVEVTVF9ERVZfUEFSVF9TWVNGUyBpcyB0aGUgc3lzZnMgcGF0aCBvZiB0aGUN
Cj4gLSMgcGFydGl0aW9uIGRldmljZSAoZS5nLiwgL3N5cy9ibG9jay9udm1lMG4xL252bWUwbjFw
MSBvciAvc3lzL2Jsb2NrL3NkYS9zZGExKS4NCj4gLSMgT3RoZXJ3aXNlLCBcJFRFU1RfREVWX1BB
UlRfU1lTRlMgaXMgYW4gZW1wdHkgc3RyaW5nLg0KPiArIyBncm91cCBjYW5ub3QgYmUgcnVuIG9u
IHRoZSB0ZXN0IGRldmljZSwgaXQgc2hvdWxkwqAgYWRkcyBzdHJpbmdzIHRvDQo+ICsjIFwkU0tJ
UF9SRUFTT05TLiBcJFRFU1RfREVWIGlzIHRoZSBmdWxsIHBhdGggb2YgdGhlIGJsb2NrIGRldmlj
ZSAoZS5nLiwNCj4gKyMgL2Rldi9udm1lMG4xICMgb3IgL2Rldi9zZGExKSwgYW5kIFwkVEVTVF9E
RVZfU1lTRlMgaXMgdGhlIHN5c2ZzIHBhdGggb2YgdGhlDQo+ICsjIGRpc2sgKG5vdCB0aGUgIyBw
YXJ0aXRpb24sIGUuZy4sIC9zeXMvYmxvY2svbnZtZTBuMSBvciAvc3lzL2Jsb2NrL3NkYSkuIElm
DQo+ICsjIHRoZSB0YXJnZXQgZGV2aWNlIGlzIGEgcGFydGl0aW9uIGRldmljZSwgXCRURVNUX0RF
Vl9QQVJUX1NZU0ZTIGlzIHRoZSBzeXNmcw0KPiArIyBwYXRoIG9mIHRoZSBwYXJ0aXRpb24gZGV2
aWNlIChlLmcuLCAvc3lzL2Jsb2NrL252bWUwbjEvbnZtZTBuMXAxIG9yDQo+ICsjIC9zeXMvYmxv
Y2svc2RhL3NkYTEpLiBPdGhlcndpc2UsIFwkVEVTVF9ERVZfUEFSVF9TWVNGUyBpcyBhbiBlbXB0
eSBzdHJpbmcuDQo+IMKgIw0KPiDCoCMgVXN1YWxseSwgZ3JvdXBfZGV2aWNlX3JlcXVpcmVzKCkg
anVzdCBuZWVkcyB0byBjaGVjayB0aGF0IHRoZSB0ZXN0IGRldmljZSBpcw0KPiDCoCMgdGhlIHJp
Z2h0IHR5cGUgb2YgaGFyZHdhcmUgb3Igc3VwcG9ydHMgYW55IG5lY2Vzc2FyeSBmZWF0dXJlcyB1
c2luZyB0aGUNCj4NCj4gVGhhbmtzDQo+IFpoaWppYW4NCj4NCj4NCg==
