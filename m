Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C821C43334
	for <linux-block@archiver.kernel.org>; Sun, 26 Jun 2022 08:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiFZIQa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jun 2022 04:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiFZIQ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jun 2022 04:16:29 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357FA1277E
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 01:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656231388; x=1687767388;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8/TXKXhoi12L+H7eZU3by1ai2OnYryoJSUZpq29AcsY=;
  b=NDpo/A8g6Xbfk06XWd8APNt4nsfUg9yCEH4icXkEsDLOj8UdzCKjH8aL
   U+rUnTcunKEy1mIW0LxtrI+Nd0r/YW0bt/MCgtrQPpV/zknb3L6iIhGEm
   LWRYOOjRMIThsvUa7SpOQIa/OuwXoeXy/tEaD2bR+Hxocm4NZS6nwHByo
   5h1UJZpnETq0eECwseep9TWgg63reHVu52jRwmLKqU6X6JEa6RKAMJEDi
   PO7jLvnBgXF7KYL/ncX81B7Rvae1+BBMp5kZDIJccRiWFRfc/kDbGP+jY
   84wA23qtCYsbc8B9k2ZjuuRC2gdbZXxjgDAknA7xbVEFY5PIEUPxVJoph
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="67024730"
X-IronPort-AV: E=Sophos;i="5.92,223,1650898800"; 
   d="scan'208";a="67024730"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 17:16:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldX7zH1dgKkRjV7i7MdF2W164U1QYLpj64MGipR4GRBc0qO93hDWTvbgcgQUnnxT8eL6+k+ZAK5yV6wwCp9v04jqhGxoUjkkGDWFBKHK+eCw91eW6bULjtI9q/ZMAPvuf4k/o+5sCflLKTFD0ikGjZdLZJBjVkHqPoMrnuEuTRkxs7XM4GKdn5adMmPvA0OTbcjpjsbCfwveLvJ3j976qChl0yL+4X0swYLIXpG506phPjNaP6R6syVriCljRtfs0meJFycrInsAJech+IU+zv1mwh3Wr5mqZztaliXNxjeBEq3Tq2vXYmYRYikCNTcrdvn4wq9JggRif8lsHBXSow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/TXKXhoi12L+H7eZU3by1ai2OnYryoJSUZpq29AcsY=;
 b=fc34Rwbdbkc2GgifDaAfbN+OYLP4ZJSrSHfHJZsExeTf72V0c83thG5NcKAiJo2FAtLKHNR67Wsf97vkn5N6Mn7NqttR5T1zsa1oxxUkV3x6dOtZbNQCyqxfP4+Mai4uUd0ziooDIpG5H+R7jTocNsH1taOA0fs1Zmyl5wipv8kl3Lxl18gVQZ/OMdnqFFD1ImW0AJ+BZhAC2jrRsvb6N28rHk2cAaKgK6A3au8P2Sf+zqSDvMVwDxr9IguWfnfdC1blPpSWde9cQEuZKbBH65Si/mUNGYRvnGooBARqFN4u3+VCBCSgNtgM1T9SjvgyWrNNVk9dSzc/M1wJnhnyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/TXKXhoi12L+H7eZU3by1ai2OnYryoJSUZpq29AcsY=;
 b=Ht/a+0rntdyNaK8/GCzulSlqZULxp5fB2zMa1aSMaxeSRhDHpWwTRM8OdmPpRgarnr3uuPT1ZZ60nMmtb36g9C3bc8UdmrgW03uZoK6hxwamknkqKLxBxqxY92bggx4uVwJIqw+yWmtXmaRTmX8zKEmu3mBMC8hFrMq0+lWJCL0=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSZPR01MB6891.jpnprd01.prod.outlook.com (2603:1096:604:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Sun, 26 Jun
 2022 08:16:22 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::64dc:d945:cbcf:6068]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::64dc:d945:cbcf:6068%7]) with mapi id 15.20.5373.018; Sun, 26 Jun 2022
 08:16:22 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] nvmeof-mp/rc: Avoid skipping tests due to the
 expected SKIP_REASON
Thread-Topic: [PATCH blktests] nvmeof-mp/rc: Avoid skipping tests due to the
 expected SKIP_REASON
Thread-Index: AQHYh58S/iZMmRw+q0eZC5++/0sMuK1eN1SAgAAbsgCAACaFAIABR+sAgAGZUwA=
Date:   Sun, 26 Jun 2022 08:16:22 +0000
Message-ID: <3f102165-026e-5715-2f87-9ebb47735abe@fujitsu.com>
References: <20220624082039.5x2cl26q7v6rnm5n@shindev>
 <3e731962-6bf1-e45d-0b57-04a41c96dd96@fujitsu.com>
 <20220624121737.iqo35ocrtttqjzzr@shindev>
 <8252f7c4-ad54-3740-f4dc-482136dc7982@fujitsu.com>
In-Reply-To: <8252f7c4-ad54-3740-f4dc-482136dc7982@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b984201-edf7-4d7a-8d5c-08da574c27db
x-ms-traffictypediagnostic: OSZPR01MB6891:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5iWil2G+9pijqqFOyhgjbTsbebH3qcBUc3ZIIEmIS/7qUway+qYvJmP4v8PnPtSVQLbPyNspaxYaqJFvWrISkIo8lwVtcdIHE4K1zvVouRVeT7yxQhQpxKL7SHy01sDQDhpvUikzRx8FTDmOZSUL/unmjYXwHQKpIjSbU+aznBHJn4Abp6Uacqcgaifqad7kJZ0uLnB4TWTrrGT3coSwiPyFi1axHjOQl4/yERDhF1ob9WpJENGVMXWz6vBU6VPEJammbiSovc5vomgn/XdUgMZ0CgIt3b0tDw1rvLQ8tpW9NU4LRyp2G1dM+KKsUOGnWcMnHYCxExXbVfIRk2OY02mQ7HRfE+2DOl5Bcdm/wGCZ+zPj2pmyYSXhfr4hTiiMsQGIXEVB8i/2/NhnOPtNjuXa3hS9xgWv78GyhISuTiFlL4ctdT02uOvVAZIzzee+mXErCqkmjItopENEyg4O8s5qFNf1FIvdSdjiYlFyC8HHcNArx6rzT7jqEBeVB98ma6wn9u3zWV2AM7i7bqSY42eC90W09ZigyMH1tMAsfTOO9QpOnc/4pOcleVbZXduQmg86lA9gZ4+25MWAuqWznh1N7L8NiNjsU6lHxzm8cKqoUFvJLHXnHv+otXZYZzPbbG8qy+8hUoslIfz1JatN1rG3cNDxf7yoeZg5nRburMiRlGfImzRdBR5rDr3BfNc58aDFy2Uq9YuI5lGx3mRhweRE7g5CI//kS3cxdQ0UnwJIcRDOUvXK7Tl279ejEr1v5LxbayYlfziJJv/q/IC1ZAwX9qkEexW7QSVNn3dpYViP8Eb7tUF+fsolkpihqt1TopujvO0DukrKqpkVuDmOVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(5660300002)(122000001)(31686004)(53546011)(6486002)(2906002)(86362001)(85182001)(186003)(36756003)(316002)(8936002)(26005)(31696002)(66556008)(76116006)(91956017)(66446008)(64756008)(66946007)(478600001)(66476007)(8676002)(4326008)(110136005)(82960400001)(38070700005)(6506007)(6512007)(41300700001)(2616005)(71200400001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzdJelZFZ2lhZ2l0Nm0yT0V4TXIrUjVjUERjNzdIMU9UQkpwcVJLak0vaVdv?=
 =?utf-8?B?MDhqdmpBckdTSlVibUtLd0ZPNHJlUnJCTFhramJITXVwelVINis3cTBuSThX?=
 =?utf-8?B?blcray9XVmtJT0JjT09jcDJPbVRNcm9nWWQ4dUFwc3RXanNxbTA0TmZLUTht?=
 =?utf-8?B?QjA1L3dOTVhyRS95TDlaVE5VVHdPOVF4a2IwZk5YdEZPVzhuTXZqTEVNdTk3?=
 =?utf-8?B?MDlrUjlZVzBsRitxSkFZMVZEaDFYSTJTMTIvSTJVbUVzeGlWQkFTS3hiUlQy?=
 =?utf-8?B?SVhhcStWR3hCNDA4aG55a21qUVVWcE85NEt5RW9uQm1UZ1RrVk52eXJsK204?=
 =?utf-8?B?aERhMDlBNVdSRmFzb2VjaGd2TlVySCtxQ25oK3M0MVdmZ1FHNUx2Z3ZuRUFu?=
 =?utf-8?B?MXBzS2pwY3UvRkx3cWpWRUZaTGtPcnpaQ3JsMFlkam9tN0pub2dWcUZmeWFS?=
 =?utf-8?B?UXRyN01LNVZGcW1vR2ZLekFnTi9UOE1Sb0wweVllQTZIZDRHTlE5WnAzMFQ0?=
 =?utf-8?B?RjljQ2dOSHpqZW1TeDhubDQyRk9qWnQwTkszdENnZndQeFRpdnJLRlJzazFu?=
 =?utf-8?B?VGRlTHdRNXVKZHRtSlEvaFVYZXFkajZLK1AwVHpSa2I3eU45N3BpSGZTaS9v?=
 =?utf-8?B?aXlYTHZtdFQxbDlyQWs5RXFLTmwwMHhwMXpXNXVoM25CMmo0NVppblVlWE9J?=
 =?utf-8?B?Wk00QjdWNVpBYTBxVnp4dGNEVytJQll0bnpZSUg1U3lMRllQM2lVMG81NnRk?=
 =?utf-8?B?dXNucXdqc3FrbjFwYkl0bjhHZDI1bWYvVEFIV3o2cENtcHFpNVJVemYrQUpk?=
 =?utf-8?B?ZkRmUG9VTGFkVE1PUGE1ZkkxdDE2NmdIaVJDd3A5ZmpJVjBqZkdNOVpFalVS?=
 =?utf-8?B?OFFNaTlpeStsTDl2RmMvWHFJZ0dYcFlJTWh4THF5RjJCMmk3ajd5c1Vwcmt5?=
 =?utf-8?B?YlRXWGFFNllENFIzb1h3WjE2TUM1SEZNOGNSeW5aR1Y5QmJTWjZGVE1Jb2sw?=
 =?utf-8?B?Y1RlL3FvMEJ6blNwR3lYZmRWNnZFUGFabTVQd3RSdmJlendGd1ZQUEZ3MENx?=
 =?utf-8?B?RkRVYi9JSURXZldtM3NzWlhNYjdFdXdtTjVoUUxIMG8zVkdJcitUL2dGZTBM?=
 =?utf-8?B?ZVBUczd0NmRnWHR1bWI0MHdHd01idTJ6dVhaUHdZd0E4c3l3RTBUTzJEclJ6?=
 =?utf-8?B?Vk50VlAvamJKdlVnalEzTDg3RmQzNXdTQnZmRzlnamg4NkM0N3pRMnhCOVpp?=
 =?utf-8?B?V2l1QjVsWnFmZldUakxJQVlXQnkzY0VaTzZzeTNPTFFoUGVJU1kxazRIZGdt?=
 =?utf-8?B?clBOZHBPRkEvQ2VKU0hVcDBidWpGUzVGTjhEaVlRSVJEYURLVFpMWkN5TnNP?=
 =?utf-8?B?TGlML0dYV0NRMFFOTWR4Ui8yV0RRTk1MQ0NiTU05eU9Sek5CQlVFNCszUkhX?=
 =?utf-8?B?VTE2cUpmWk5GTldReE1QNGtiOVUwVGNqdWJIcnA4NDRnR2k5NldaVHY3K1R5?=
 =?utf-8?B?YnBzRjBWbTFxbXdMTFNucmhQQWdENGh6QlNJM3VmWjN4U1IxQTFOQW9PZTc0?=
 =?utf-8?B?dmlCRTlSOFVuZHdERm5rSEwrL0ZNZjR4SjRsVUFscHA1bUtoVnZjSkU5UmhE?=
 =?utf-8?B?K2NHWjEwQ2JNKzFnbEExVmY5YUdBWHNuZklJSnRzQzlHaHFyQ0w1K1IvZkwr?=
 =?utf-8?B?Wlk4VTlqbER0RHI2YXVzbVV1bkFYTko3OGFCbUI0TXpoT2tnMytLNXg5MXNy?=
 =?utf-8?B?L1ZRNG1FbWFtOGs2Zm1qV0JkRVJRZTEvTS9lZ1I2d0tHWXZFdC9kZExaZ04x?=
 =?utf-8?B?VVlWMWFDYlJoeUFUZ244ZWNxZGNpdUVCSjZrVmJqeTNZMFFtT0pVcGhZVzFT?=
 =?utf-8?B?QUFHMFJFUy9PWkJOV0QwaUM3TklqSUZMQmlGVVRMM2p5c1pyL3lLSk1EY2o2?=
 =?utf-8?B?a0VsZlVOTlMyOTU2UURqd0JsMmZQMndHMllxbGJPTmFVL3dPUUpQcHJUclVz?=
 =?utf-8?B?UUZJcGcwT1hMaUIrbVhGbERSNHBXUFkvZVlsMHRmWlVQLzZhMGwzUGIzTVB3?=
 =?utf-8?B?bytRRGI1ZE5pOHZ5cU5zVm1JRkYxdGQxYWlpTFBhdSthbzgyZ0RNSFpRanJ5?=
 =?utf-8?B?VEZvSEloVCtvVGZzdmtPcFAyaWttblJMK0M4QnR2K2pqN2pjZG9vKzNxckx3?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B08BD2F665D7DE4B8D918790C468734A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b984201-edf7-4d7a-8d5c-08da574c27db
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2022 08:16:22.3552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t8wI9dYmeAXEq/nB7zCXRZU+cTLTLV6y1UlvSTifR2oPll8Gr5tKSM3Ak0KBTnDZs83SGaGe25NVfh/QNNVrDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6891
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMjAyMi82LzI1IDE1OjUxLCBMaSwgWmhpamlhbiB3cm90ZToNCj4+IEkgdGhpbmsgTGkncyBw
b2ludCBpcyBzdGlsbCB2YWxpZCwgYnV0IGxldCdzIHRha2UgYWN0aW9uIGZvciBpdCBsYXRlci4g
DQo+PiBPbmUgbW9yZQ0KPj4gcG9pbnQgSSB3YW50IHRvIG1lbnRpb24gaXMgdGhhdCAidW5zZXQg
U0tJUF9SRUFTT04iIGlzIG5vdCBhIGdvb2QgDQo+PiBwcmFjdGljZS4gVG8NCj4+IHNlZWsgZm9y
IHRoZSBiZXN0IHNoYXBlLCBJIGNhbiB0aGluayBvZiBmb2xsb3dpbmcgY2hhbmdlczoNCj4gDQo+
IGJlbG93IGNoYW5nZXMgc291bmQgZ29vZCA6KQ0KPiANCkhpIExpLCBTaGluaWNoaXJvDQoNClNv
cnJ5IGZvciB0aGUgbGF0ZSByZXBseS4NCg0KQWdyZWVkLiBJIGFsc28gdGhpbmsgInVuc2V0IFNL
SVBfUkVBU09OIiBpcyBhIHRlbXBvcmFyeSBzb2x1dGlvbiAobm90IGEgDQpiZXR0ZXIgc29sdXRp
b24pLg0KDQpJIHdpbGwgdHJ5IHRvIGRvIHRoZSBmb2xsb3dpbmcgY2hhbmdlIGFzIHlvdSBzdWdn
ZXN0ZWQuDQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0KPiANCj4+DQo+PiAxKSBJbnRyb2R1
Y2UgX2NoZWNrX2tlcm5lbF9vcHRpb24oKSwgd2hpY2ggY2hlY2tzIHRoZSBzcGVjaWZpZWQga2Vy
bmVsIA0KPj4gb3B0aW9uDQo+PiDCoMKgwqAgaXMgZGVmaW5lZCwgYnV0IGRvZXMgbm90IHNldCBT
S0lQX1JFU0FPTi4gVXNpbmcgdGhpcywgInVuc2V0IA0KPj4gU0tJUF9SRUFTT04iIG9mDQo+PiDC
oMKgwqAgZ3JvdXBfcmVxdWlyZXMoKSBpbiB0ZXN0cy9udm1lLW9mL3JjIChhbmQgdGVzdHMvbnZt
ZS8wMzkpIGNhbiBiZSANCj4+IGF2b2lkZWQuDQo+Pg0KPj4gMikgSW50cm9kdWNlIF9oYXZlX2tl
cm5lbF9jb25maWdfZmlsZSgpIHdoaWNoIHNldHMgU0tJUF9SRUFTT04gd2hlbiANCj4+IG5laXRo
ZXINCj4+IMKgwqDCoCAvYm9vdC9jb25maWcqIG5vciAvcHJvYy9jb25maWcuZ3ogaXMgYXZhaWxh
YmxlLiBJdCBjYW4gYmUgY2FsbGVkIA0KPj4gZnJvbSB0aGUNCj4+IMKgwqDCoCBncm91cF9yZXF1
aXJlcygpIGluIHRlc3RzL252bWUtb2YvcmMgYmVmb3JlIF9jaGVja19rZXJuZWxfb3B0aW9uKCkg
DQo+PiB0byBlbnN1cmUNCj4+IMKgwqDCoCB0aGUga2VybmVsIG9wdGlvbiBjaGVjayBpcyB2YWxp
ZC4=
