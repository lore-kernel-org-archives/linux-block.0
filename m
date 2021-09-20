Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D85FC433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 05:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E9760F58
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 05:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhITFbp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 01:31:45 -0400
Received: from mail-eopbgr1310130.outbound.protection.outlook.com ([40.107.131.130]:28576
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231250AbhITFbp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 01:31:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4LNVXM9D6vIjCgeN1Y8uo6yjd+Zwgotk9CzWZ6ZSXwX/p63e/MsiK+7pgb4wrISbE7grjq2w8NKLQjQ0YKkfU5gU/CABpP1Ua+/qVcHpKq7lW/Ydx5gJJYFdfr6yq3hB60oZHS/fDR0vU+hJtxQVhOYwSLQCx1YhS0zsgJjWsfxav6k39VjtOECUZh2uJYwARqcn/gvsB8Q68v7GysR8m1vzAeiB9d7VcSP8DBbHH1cIddK9CMYt/T907EF/M/kqEqzmqcYIJhi90ju1r7XJEAmuFAkVsK2SlB5ytRrJJn62vptI4BHycLWi8ucIa4kOqfAfgzb3/Iy0iYSnZJ4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=00T7ZeqVF53EmsuHiCmkfMx1kJRdWADaIZYwnKcIin0=;
 b=SgHBageFQQE5u1MUJ2TXxM8Fx0xANhMqogNqzNx6oyWcITI2F9q31ccaC+fx4nFiydX+AgKXSF2fqZJQAOAePtleRyasZVzMmnH92y7fhXeHbgvUXws96ItQw0/Rf09yS/gsMOV7FAuQ3KsWIHswad36rmM9s9+zOqEqpzNu4vzX/dvIa/KQaPEJFPyi3SydHXf11L7XRZvrajO72HZMdUIo9APHEu6/xW4nUGOBOPrZ21q1AB46SFSpRQw4q3iEUl9zQS7Q0EsNcfmLkCZTIjYZEq2+MS6Ibq7Oqy7IifjNINoe4vfkne6ZexAZh/o/wxckm8vTMOEU94aeNgPbqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00T7ZeqVF53EmsuHiCmkfMx1kJRdWADaIZYwnKcIin0=;
 b=DoSF+xqDdhKxGKLpMUiEX5JfLKIDqy1ru2JRcWQPCkyYSjniXYDkxhD1kUBQMt54W0ku3t9Z9KTzSbuY+rR6cdi+USSJtP3GUi9wX+mVHfCKIHVEYMTVrCGMN2akr9zsCWtTu9LG9Wju9e53tobXtYKmYGXodrb9KnRchmwZIlQ=
Received: from PSAP153MB0518.APCP153.PROD.OUTLOOK.COM (2603:1096:301:63::10)
 by PSAP153MB0453.APCP153.PROD.OUTLOOK.COM (2603:1096:301:60::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.4; Mon, 20 Sep
 2021 05:30:14 +0000
Received: from PSAP153MB0518.APCP153.PROD.OUTLOOK.COM
 ([fe80::e060:1f09:dd2f:87e7]) by PSAP153MB0518.APCP153.PROD.OUTLOOK.COM
 ([fe80::e060:1f09:dd2f:87e7%5]) with mapi id 15.20.4566.006; Mon, 20 Sep 2021
 05:30:14 +0000
From:   Prasad Muppana <Lalita.Muppana@microsoft.com>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>
Subject: RE: [PATCH] blk-mq: export blk_mq_submit_bio symbol
Thread-Topic: [PATCH] blk-mq: export blk_mq_submit_bio symbol
Thread-Index: AQHXqG2BZxdFFy/L80y8f47JknRQoausbnCQ
Date:   Mon, 20 Sep 2021 05:30:14 +0000
Message-ID: <PSAP153MB0518F021C769875159C3A03984A09@PSAP153MB0518.APCP153.PROD.OUTLOOK.COM>
References: <20210909053653.144360-1-kumarpraveen@linux.microsoft.com>
 <7e80b65b-51a4-3ca1-da43-e87612b8ca5f@nvidia.com>
 <f7add831-ecf0-6599-158b-cd2f15543da5@linux.microsoft.com>
 <YT7rL4PhovDOHfHO@infradead.org>
 <75f77917-a8ba-0138-750b-8dedd8f7ce7d@linux.microsoft.com>
In-Reply-To: <75f77917-a8ba-0138-750b-8dedd8f7ce7d@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=68b5182d-9549-470f-b4c7-871572a64867;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-09-20T05:23:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0aba0788-b5d8-4d2c-fdb8-08d97bf7b978
x-ms-traffictypediagnostic: PSAP153MB0453:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PSAP153MB0453E58D3DC3A5895A942F0984A09@PSAP153MB0453.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rfzkuhDhllsBFClB1pwMGetlkDan2DtUXKy7nOg2V4Q0lRdoY+ICQ+Y7u0JNIW9Wuaef6i3cCFCmOPxSTG0zn7Kd1hmD/zPH4d62Y/4W6fYSNyYbkS0T81M6oelUISRQB+YQIuTSKQeuzSK2t5eJT9zWUT5L7gelFveARsBlOAubyhVoQj1iSqppy18AYmAbepG2K5WNERbeEKHZajSDWz4faQReeNqPiKupfLd0g0S12mdg+mI2SDm/npNip0vkQxa00K5xcqx4hhVAiXRnaJajVl/pNrv/gg4KhmoZKfG140Ht9UAs6OeBNNAnuExRrSYXteZjPWFeaeWF9GLzNELyy6oh4yBtifZb2cXOI0u1tS+Pt5yPiHlrY7VvFYSE0DNDaB+Az7U/Qmibbp2vwxVDhRpM8V/QVEs0KhMFjYDgLtat8yy6UCLMCen7keI49wxKXDPWn4JKDIzbSAWvpT2Z/F6oDZMQplTnPRKeMBWj8SEnoEc8Br1mRyS1a8Otm4IgViyLpM7LpLiS7InDBg4qz5oxl7SxK8RQg4sg+UosXdXQfPJadgX+wnLnu9UWkwTOUcg1xi8HWWCeL9P7M/n4tk6oZhqFTnIRJPiMYA+iEaDtBr0RT/lwhNUEMXkvCsm4GNvmV25agQMT6T9xge8gXcIHiyBoIv07723o5XM8XHIRJ5BFR9NIOkhnrAeRj3wqcRsVn13Uig66goS5BA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAP153MB0518.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(8990500004)(53546011)(6506007)(38070700005)(83380400001)(76116006)(66946007)(8936002)(4326008)(54906003)(110136005)(107886003)(5660300002)(9686003)(7696005)(66446008)(316002)(38100700002)(122000001)(52536014)(66476007)(10290500003)(8676002)(66556008)(33656002)(2906002)(64756008)(186003)(26005)(82950400001)(508600001)(82960400001)(55016002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVh0OWJHM0grRW53cktnSzVVYW13VWNIWEl2Zzh0Vks0ZUdBME40WlQvT0xP?=
 =?utf-8?B?ZWk0Z0hsWkRIWC9nb1gzOVRiQ0J0M3YrUm5BZytKbFg3dDBOektVcU1jckxW?=
 =?utf-8?B?RlBTOHVQVjlmMWFLdkFiMW0zQlNLei9Fek8xZGwyUEpQWThmZUJITm9YVjJs?=
 =?utf-8?B?UndHcUVyOHgrakc5dS9mZEM4L1RQY2lwMG1xUTFLVTB3RjRqdFpjbUQxRFk2?=
 =?utf-8?B?bE1mRGN0V0RGWjZrYlFtZmFrL3pRbzQ4dXdsV2JtOXBSdjU2S0NuOGJ2bTJK?=
 =?utf-8?B?dzFHVE9LN1ZadXZHRXdITjJGMWtENEcxVjcyU3B3VVUyNlFxSHBiVGt2cm5j?=
 =?utf-8?B?LzE3bzViWWNQajRsT2w4amtFV0VZRmtjazc1anowWGpVY3lpL0s1Uks5K2Rl?=
 =?utf-8?B?VXlwd3F0U3BxY0drbzdsTCt4VVVzVExiMTZJZ0VTQVBTTkRkRHM3RzR0ZDdO?=
 =?utf-8?B?eU44eVVxdFRpcnJpQzRBSWlXbTZwY250bTVsaC8rTnJacXdOMWZhTitOT3RZ?=
 =?utf-8?B?OUdkelZJRFRaRk5VR3FYOXpwdUtSZXljTVc5Q2haUUFxR3Z0UXNOK2ZYR2JY?=
 =?utf-8?B?U2hEQzFLS2thcDRwNmYxaXNwUHU0b05CMFVWYWF2bXZIKytVYnBQV0dXVlhJ?=
 =?utf-8?B?VnRSZTFhV05MUU1mNjhGcWVPTFY4WUE5UElGOEVlWWdWaG8vR1lOZURkb0pu?=
 =?utf-8?B?WG13ZHVPaitvbklKbk9kQ3ArOHRYb2xocUZyMmdEKzk2d1VUeTdmQ01TSVRo?=
 =?utf-8?B?SXd0d0tWM1ZCVWpVaEg3MWZZNGVFem5zelIxQ3JNalBmdEtIeHo3djJWNEVl?=
 =?utf-8?B?NjlIUlJaeGt3Qzl0a3J1UG5rUDNzYVA3STBjdTFwekM1UzQ2ZWNPUkJETE5j?=
 =?utf-8?B?QURDdzk4c1BCWm91eGsvdFFwRnV1djNXVHFwb3poZ0xXQldieFF5WUs2S0xi?=
 =?utf-8?B?Z2l4b3RrU2xsMEN6QlQ2Ny9GMnFZYkszNzgxS3oxWlpPeG5vTHFhekJZUWhY?=
 =?utf-8?B?b1lqQXFTcEZncFFpTkI0cFI4UXZ4MU1TMm8zS3ptdXV2NWw5aGVzc1EwVDZs?=
 =?utf-8?B?eXhMT0VpM01vRlplU0lSM1EwV1lHSGJoeExXb0Z2OFlnMzVoNE8yVkk0SWZv?=
 =?utf-8?B?T3dZcU94Q3FwNG5PVHJDN3c3dllwUHV2WHJzZnJjRGNHQXQ1a243aWJXVU1h?=
 =?utf-8?B?Q01acG4raCtWNWFuQjJFend1aldMUHFDRHdRZytjTkg2MjVmcWh3SE9Pblo2?=
 =?utf-8?B?Qk5vRTRTL2FCdXNKOU9tc0daZk9lSWI2UHBzTUVDbU9yK1lsSkhlUXkrVHUv?=
 =?utf-8?B?eTFZMnFGU3hjejIvRHVjaGpwTjdmcFVzaTRyemltOXZOdnZMSzlvdDQ5MTVi?=
 =?utf-8?B?ZXZhUmlVRkgrSmtOYlliV3drME5VWG95aXBnSERUcXliU1Jjb3ZhdFVrL3Fs?=
 =?utf-8?B?ZHhSTlRLckNOdEhmUmI0anZCUnpJM2cyaW5zRGU0aUE4MjhYZkFiRTJPYWk1?=
 =?utf-8?B?R0w1cElrT1BZWEorTHB0ZU44MjlyS0t1UlgwM2s1ODVrblhPU1lKeUpuYXJX?=
 =?utf-8?B?TEk0U1pvc0V4TXd2NXJnRmJEVkJlSm1aRDcvNEQraUlUWWRBeUw2UVhnNEZE?=
 =?utf-8?B?NVhmUDU3RCtLTGpXdm1sNlk5V0phTlNVOG1CQWF2WUdERUM1Mi9LSlZ5cTlZ?=
 =?utf-8?B?anJqamtVdFA2Kzd6N2R2ZTE3VWtqa0lxOU9YUkI5SG5SeCtLNTlnQXY3UHdz?=
 =?utf-8?Q?c/lzi+WuXUqX0eqP9n303hsju4L7OLP8572Zi+8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAP153MB0518.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aba0788-b5d8-4d2c-fdb8-08d97bf7b978
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 05:30:14.6238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6kzHAIZeGA6DR+kBt2gwKD4sO2AcNcxeAoD2yD5hSVN8MYfJyw6ph0eUUyHLuLMhJ4xTO6M37HF+5W5U+hvc/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAP153MB0453
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGkgQ2hyaXN0b3BoLA0KDQpXZSBhcmUgaW4gdGhlIHByb2Nlc3Mgb2Ygb3BlbmluZyB0aGUgc291
cmNlIGNvZGUgZm9yIHRoZSBkcml2ZXIgYW5kIHN0dWNrIHdpdGggdGhpcyBpc3N1ZSB3aGljaCBp
cyBjYXVzaW5nIGRlbGF5IGluIHRoZSBwcm9jZXNzLiBDdXJyZW50bHksIHRoZSBMaW51eCBjdXN0
b21lcnMgYXJlIGltcGFjdGVkIGJ5IHRoaXMgaXNzdWUgYW5kIG1vc3RseSBSSEVMOC40IGFuZCBV
YnVudHUgY3VzdG9tZXJzIGFyZSBibG9ja2VkLiBTbyB3ZSBhcmUgbG9va2luZyBmb3IgYW55IHNv
bHV0aW9uIHRoYXQgY2FuIG1pdGlnYXRlIHRoaXMgaXNzdWUgYXMgc2hvcnQgdGVybSBnb2FsIGFu
ZCBpbiB0aGUgbWVhbnRpbWUsIHdlIHdpbGwgb3BlbiB0aGUgc291cmNlIHdoaWNoIHdpbGwgaGF2
ZSBsb25nIHRlcm0gc29sdXRpb24gdG8gaGFuZGxlIHRoaXMgaXNzdWUuIFBsZWFzZSBoZWxwIGhl
cmUgaW4gdGhpcyBjYXNlLg0KDQpXaXRoIFRoYW5rcywNClByYXNhZCANCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IFByYXZlZW4gS3VtYXIgPGt1bWFycHJhdmVlbkBsaW51eC5t
aWNyb3NvZnQuY29tPiANClNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDEzLCAyMDIxIDEyOjM0IFBN
DQpUbzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPg0KQ2M6IENoYWl0YW55
YSBLdWxrYXJuaSA8Y2hhaXRhbnlha0BudmlkaWEuY29tPjsgbGludXgtYmxvY2tAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBheGJvZUBrZXJuZWwuZGs7IHNj
aGFrcmFiYXJ0aUBsaW51eC5taWNyb3NvZnQuY29tOyBQcmFzYWQgTXVwcGFuYSA8TGFsaXRhLk11
cHBhbmFAbWljcm9zb2Z0LmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGJsay1tcTogZXhwb3J0
IGJsa19tcV9zdWJtaXRfYmlvIHN5bWJvbA0KDQpPbiAxMy0wOS0yMDIxIDExOjM5LCBDaHJpc3Rv
cGggSGVsbHdpZyB3cm90ZToNCj4gT24gTW9uLCBTZXAgMTMsIDIwMjEgYXQgMDk6NTQ6NTRBTSAr
MDUzMCwgUHJhdmVlbiBLdW1hciB3cm90ZToNCj4+Pj4gK0VYUE9SVF9TWU1CT0xfR1BMKGJsa19t
cV9zdWJtaXRfYmlvKTsNCj4+Pj4NCj4+Pg0KPj4+IFdoZXJlIGlzIHRoZSBjb2RlIHRoYXQgdXNl
ZCB0aGlzIEFQSSA/DQo+Pj4NCj4+DQo+PiBUaGFua3MgQ2hhaXRhbnlhIGZvciB5b3VyIHJlc3Bv
bnNlLiBQbGVhc2UgY2hlY2sgbXkgcmVzcG9uc2UgdG8gQ2hyaXN0b3BoLg0KPj4gVGhhdCBzaG91
bGQgZ2l2ZSBvdmVyYWxsIHVuZGVyc3RhbmRpbmcgb2YgdGhlIHVzZS1jYXNlLg0KPiANCj4gV2hp
Y2ggcmVhbGx5IGRvZXNuJ3QgbWF0dGVyLCB3aGlsZSB5b3Uga2VlcCBpbmdvcmluZyB0aGUgcmVs
ZXZhbnQgDQo+IHF1ZXN0aW9uLiAgSWYgeW91IGNvZGUgaXMgbm90IHVwc3RyZWFtIG9yIGF0IGxl
YXN0IGFjdGl2ZWx5IGJlaW5nIA0KPiBzdWJtaXR0ZWQgdXBzdHJlYW0geW91ciBxdWVzdGlvbnMg
aGF2ZSBubyByZWxldmFuY2Ugd2hhdHNvZXZlci4NCj4gSWYgeW91IGRvIG5vdCB1bmRlcnRhbmQg
dGhhdCBiYXNpYyBmYWN0IHlvdXIgYXJlIGluIHRoZSB3cm9uZyBwbGFjZSANCj4gaGVyZS4NCj4g
DQoNCkhpIENocmlzdG9waCwNCg0KVGhlIHVwc3RyZWFtIGFjdGl2aXR5IGlzIGJlaW5nIHBsYW5u
ZWQgYW5kIHdpbGwgdGFrZSBzb21ldGltZSB0byByZWFjaCB0byB0aGF0IHN0YXRlIGFzIHdlIGhh
dmUgdG8gbWFrZSBpdCByZWFkeSBmb3IgbGF0ZXN0IGtlcm5lbC4NCg0KVG8gYWNoaWV2ZSB0aGUg
c2FtZSwgd2Ugd2VyZSBmaW5kaW5nIHNvbWUgc29sdXRpb25zIHRvIGhhbmRsZSBsYXRlc3QgY2hh
bmdlcy4NCklmIHlvdSBoYXZlIHNjYW5uZWQgbXkgcHJldmlvdXMgZW1haWwgd2hlcmUgSSBoYXZl
IHByb3ZpZGVkIGEgZGV0YWlsIHdoYXQgdGhlIGRyaXZlciBpcyBkb2luZywgSSBkaWQgbWVudGlv
biB0aGF0IHdlIHBsYW4gdG8gdXNlICJibGtfbXFfc3VibWl0X2JpbyIgYnV0IGZhaWxlZCB0byBk
byBzbywgYXMgY29kZSBpcyBub3QgZXhwb3J0ZWQuIFNvLCB0byB0aGUgc3BlY2lmaWMgYW5zd2Vy
LCB0aGlzIEFQSSBpcyBOT1QgYmVpbmcgdXNlZCBhbnl3aGVyZSBhcyBvZiBub3cuDQoNCkhvd2V2
ZXIsIGFzIHlvdSBtZW50aW9uZWQsIHRoZSBBUEkgY2Fubm90IGJlIGV4cG9ydGVkIGZvciBhbnkg
c3BlY2lmaWMgZHJpdmVyLCBpcyB0aGVyZSBhbnkgc29sdXRpb24gb3Igd2F5IGlmIGEgY3VzdG9t
IGRyaXZlciB3YW50cyB0byBob29rIHRoZSBleGlzdGluZyBiaW8gcGF0aCBhbmQgbWFzc2FnZSBp
dCBhbmQgdGhlbiBmYWxsIGJhY2sgdG8gb3JpZ2luYWwgZmxvdyA/DQoNClJlZ2FyZHMsDQoNCn5Q
cmF2ZWVuLg0K
