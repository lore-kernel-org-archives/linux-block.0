Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37F8C433B4
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 15:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91425610CF
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 15:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhDIP2Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:28:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33604 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIP2P (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Apr 2021 11:28:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139FEGcO014328;
        Fri, 9 Apr 2021 15:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=hrrcqNKaDah3dssJ0r+valxib8Pb8J9kqD99zRj9ns4=;
 b=dEAJIhmq0ozWLaYe0abL1PWbS662OI24LeB5EsF2BjEZYpGi6TCZSUn94thDrxUwzP8A
 oynLJ7ga+Tp/6/LJMEK5p5W4QEHViw60E4XXfR87krti+vDhNC47L3iqWHT4YQufqsai
 iW+oRQZzVYpSCzujPLJ+727Xgi+EvEa7St+xKuLHIAGqRl1til+ijvRS35XfybnfH0Oo
 ZYWQzygGwiClssObYLaJqNVo24LUG1JqsND7aLaqeceV4XCk8ANHum4/zLIFQb+z2BQM
 u7ExqsWGPgd4vWG6ZCZGu2t4kwz/eTFp81LorU8X+lbDt8cDt9Y2eTRBaLmYD9Tr+xwK KQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37rvaghtdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 15:27:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139FBEC1020323;
        Fri, 9 Apr 2021 15:27:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 37rvb2p64f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 15:27:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0cBQOJdZUxpwdKQ8dzG9zaX0Qd+zruLXKYkAPZgu6cvEYgWiMoMNw/FgfuBFUeC934yTVl3L6Z22UsHgK4Tf9tTWOmoghonCgsvvZHtv/ZXXJWwhA3KZcx0XHdi+aL4DAaiuTxG3xOtAHJ9cYCIFYCCGiMg1nIl7yq12dVx07rLmm5oKOcI+/EXFK3E1dhQcC/nFRgO4+SexFKy7uF0OjtlxLlClGWhTMW2j2eGnWNzFp+REpaF4bDE/HvdilOQ1PIadBRQID2nkAvCXN/eCGDZnpy5s8yU61ZAcQanv1h0H9K+qjH6xE0103ADv7FtaCITC/y/nZEvvwx91cno4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrrcqNKaDah3dssJ0r+valxib8Pb8J9kqD99zRj9ns4=;
 b=GYyddl93Ke/jmxufIZ4B2dZAIo8PwL7Pzt+QwBpGp3CGbgKMHQzB9sBM9d2zQrJWeny/GUTfshhHTNME6tEK5phK9+gb+ZrKEOA1Y6LVPvmXAoZvcqgFPXzpiLsBP9qCATUq/gQHu5S6KfGhpNLe6LGTP9+VTkvGNXD37Acb7BufF4K8Pt1QOZ5XsQOcBmAjKZZ9sL0kZa6AhL+pJ/PHhTcl+DYXOe2ZBgneTLbr43GPYQd03IluzFf5uzzAcI/F/UYqwDJ/sRiStEsnrhZi5Xx1PxIIDCNLuvr0pXFdc9cL9FP1FH6uizH3ql6+rEn5Jr9xKkZf0ndJhKPzJkNFyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrrcqNKaDah3dssJ0r+valxib8Pb8J9kqD99zRj9ns4=;
 b=qRoJQTWg9D66qwTTUy/nI932ma+naOkCx/jdLuq2kQGwXyPTaj3+YQtEZC6YC9LfV75rSPht4N4AU+NRf0i+JfSF5zNWAWHFd0FA0lSM8X17CN+w3P1UKwCl6eEgUmXjVy3KLbqgg7Dc51+bTtkIgAjZqt8crDejJ6akt+4+0XM=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4602.namprd10.prod.outlook.com (2603:10b6:806:f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 9 Apr
 2021 15:27:45 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1%4]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 15:27:45 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] block: remove an incorrect check from blk_rq_append_bio
Thread-Topic: [PATCH] block: remove an incorrect check from blk_rq_append_bio
Thread-Index: AQHXLVG1RxzqxXhM8kaXgf7f8aF7RKqsTx0A
Date:   Fri, 9 Apr 2021 15:27:44 +0000
Message-ID: <C9C2D5AE-3E66-45C5-BC2F-BDF79BB14FD8@oracle.com>
References: <20210409150447.1977410-1-hch@lst.de>
In-Reply-To: <20210409150447.1977410-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [70.114.128.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 480a31cd-1fd7-4ffc-0456-08d8fb6c0626
x-ms-traffictypediagnostic: SA2PR10MB4602:
x-microsoft-antispam-prvs: <SA2PR10MB46025D3E34ECB212E0451207E6739@SA2PR10MB4602.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GTeTTxE6F9y0xy9qM4ykCDOY16aoeKtI5hBrnxHQH/AUndsqApP9OXCXQvb9TXdW4kqea3IvzWPMdyoTDHaGdKPlTPS/X75XaliUSn00DUAsMRRWbg9FZPl8T388IApiEWH9G2PT/nXhFq8TGn5e3ri9mVJ+8m/LZmrASvmiKgT8dAEzihisQvfXVbT7N33gfASpNCHp7ajbjtovnAuKeF7VrmaQjBzrBMYNnOW63h+54+Ef8M1sncL/LqgDbl0/uSDk1w4VzL5RqoVljxV7HMSj9Z4/6XMpYx3sX4wRFfdzbJUcbkYLAhaLDeG4wwHKaA59paqoJosBtMNZSt1yJ0gdokswOAhxRvtnZvKBTVBoAMWriLLFgED5toxZ1/PuhVClvqnvR3/vJiLKjAAin/3xt1iP6w1IADyfamY2V+IGqyc7xmkWThKlvv/FePuCw/mJsLDZHlB0by4DJ8dBwqXVUGVvx70k4BSQ+8vnlrQNJI/wZOx4i+7kDZ8AMlQ1ZUUmQZ/FLrN8SiwrdYDOaK9mCFfjcVHEkCL1rxNaC2rmFwxgBHOPRMv5LvaogHVGynylJYmBrsA2qD8NkSpZVVg6pddtZfe7b9WfU40J1T7xOvsaW1lxhhTZ+37YNO+SNO45Pf26ZgyoXWwgES0l2pknS3q9alfbkTvSadqWlIGBZZeDPHonUNFrHT+4HaGp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39860400002)(346002)(366004)(83380400001)(478600001)(53546011)(2906002)(66446008)(54906003)(6506007)(66476007)(186003)(64756008)(66556008)(86362001)(76116006)(66946007)(8676002)(8936002)(71200400001)(5660300002)(26005)(6916009)(6486002)(4326008)(2616005)(36756003)(6512007)(33656002)(44832011)(38100700001)(316002)(4744005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UU1VVHk5VHkreFMxaHJwR3NVbHFZcGhPWWwzLzFCblQwb3NIVytJK0pjclJ3?=
 =?utf-8?B?Qm1rTlRpR1MzcmgwV0RvMGpFVG5icVgzWXVKZVQrUVU4OXZtYXVXT0RrZ0hB?=
 =?utf-8?B?b3dXK1lJWHhmYkdsZ1BSaGJMZldLZE5xV1p5Yk1CcmJBcloxUHk5SjR4Nk4y?=
 =?utf-8?B?WVA1Y3VtRldHYXI5dmVyWncyR2VObEhLYUpudUJDbXhHUWxpYmphc01wMUxj?=
 =?utf-8?B?RXhrb2RMbkNBZ1pTdzJmbmtIdk5jUnd4Qk5Xd1JOcXJxR2xlK0hNTmNuVHNM?=
 =?utf-8?B?M0hmRnJFTUQyT1VleXh4RWFxU0hYeVRjTkxCVVJXQmYycHNDOTA2N3R6MGVK?=
 =?utf-8?B?OHUrTmxYcDllNXJ4RzZISXI2R3IxSGtESDUrdUFrZWZvdmliWXExOWt1ZmFB?=
 =?utf-8?B?SHRuZVpXaGFCQTdFZVQva2ZmblMxaUJwRjVEZDNjbkdmSi9RcmRmci93YWY1?=
 =?utf-8?B?S1Y4TXZOdE1aUXJ6NUQzNlBOdkQ5YzBzNW5kV3VPV3JtZkQ3MDgyZm1yQUU0?=
 =?utf-8?B?TTAyckpaeTBKUnJhWnhYMUhyTzI0Y1ZCZ2dHV2Q4Y0VIK01sMGJFWXRGbDhi?=
 =?utf-8?B?bHVkY0NPV3J0ZFdUUzZISk1HWEdtNXJjRHowTlk2S0RISGpOZE05SDk2SWlX?=
 =?utf-8?B?eWlJRW1Gb0psb1NkbDV2UXg4ZVgrQU1yS3FKY0pOZDFpcUtWS1JtQkpwMCtr?=
 =?utf-8?B?ZVdXZFpndnhQQWthYnpLUjRtVDhQa2xZbHRpOHpvMEdPWVZicXZteWdMaEZF?=
 =?utf-8?B?RnRqQjVYYkNsbmhNblRSZVJEcTlRRktZQmxJS2k4NkQ0VklSaHBMZnE5SXQ5?=
 =?utf-8?B?MFl5cU1jc05WdW11c2l2TE12SnpBeE9iL1pJbWw4bExOQkRKWE1WdnlqNWlL?=
 =?utf-8?B?SHQ0dTZJcnlSKy9jdXA2ZllpTFhDTG1UcnNPV21MaDlpT1hwVnZBVmVGc0Iv?=
 =?utf-8?B?NHlzYlROMXIrTnVrRUpybkVUaHppemE3NmhvVmtIM0djRmpxc1NIbDJCN0N1?=
 =?utf-8?B?ZC9YV0dlb3VRN3lsbUFzZjZydkZNSUltZDB5NmlSUGQyaG13NEdjZWMxdFdI?=
 =?utf-8?B?OUZkNVJxZ0QwWllnUk5WazIvTGJOcVRKNHgyZ3pUMStzN3BKRW1KZng2MXBY?=
 =?utf-8?B?OVRwNjUrQncybHFGMWF2M3hpWjVaNWxncjBzRzNFNFdhYnRUZUxablkvUGVJ?=
 =?utf-8?B?Z2lIT2dDV0h0V1A1Ymt2RnVRRGg0UUNMU2t2aGdQeU5xekhqcHVBeXV0b1Bz?=
 =?utf-8?B?OXpiWHF3VVFZZXF3MnNWbVFFbFhsWVVycnVLYXNkdXBpZlVVTlVVdFhGU2Rl?=
 =?utf-8?B?SC8wNlBhelI3bTBWL25kemJFbXRnQlR3THVwQ2VuN3dhT3U1K0c5RSsxVzdC?=
 =?utf-8?B?RHFWdzNQSnp2dWxOUjNDUVRKbGlpSnVJY05BN0R4SCs0ZUIxZWZ6Q2lhQ0Zz?=
 =?utf-8?B?cExGa1lmc3M5RmYzUit6eGE4WWJlOVo5eTRzNitISE9kNFoyY1lGUzdxZDV2?=
 =?utf-8?B?WEZRVjhmcTVMcUhvWVl0YWlKRzR4aGNPVEVkTlNjY09aQ1VqUWpDSFB1WWFw?=
 =?utf-8?B?Y2ZLRlhpY0dHVzJ2ZmtoQnFZNDAwZGNrZU5DeHUzb2p2VTB0TWhPZUJSVHJY?=
 =?utf-8?B?ZzlxeVFMblZlRjN6VElmdUZ2OWQydlFJZjBSaFdVTkc4dDVYTVpSdWNMb0Za?=
 =?utf-8?B?VGdKdmJDelh1cUYyeXFXajFYUWs5Qyt3NGVObWkzRFozZ3NQY0xJUW9UT1BP?=
 =?utf-8?B?MGdmU1RYVVFnbmdHNW1oTXFxWjlsTHd0SzlTa3hXS3dXa1NreXBtWWRqaURp?=
 =?utf-8?B?VzNtWWxvL3A1V2kzQlpHdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9850A97A44E4C44933ABCD97814E3FD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480a31cd-1fd7-4ffc-0456-08d8fb6c0626
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 15:27:44.9800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B5Yz7tMTe28JPdiT9aRhB+OoizTSs7kuPEhUoxLlKpPnFLA4lnRiQgLymGG14FvY3Vj3bhrK8FlBitkj26TAEOc37/5DQUoiGozOJBpa750=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4602
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090112
X-Proofpoint-GUID: P9miTRKNueEfr0m7COESmcS_B8o_DfFi
X-Proofpoint-ORIG-GUID: P9miTRKNueEfr0m7COESmcS_B8o_DfFi
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1011 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090112
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCj4gT24gQXByIDksIDIwMjEsIGF0IDEwOjA0IEFNLCBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4gd3JvdGU6DQo+IA0KPiBibGtfcnFfYXBwZW5kX2JpbyBpcyBhbHNvIHVzZWQgZm9y
IHRoZSBjb3B5IGNhc2UsIG5vdCBqdXN0IHRoZSBtYXAgY2FzZSwNCj4gc28gdGlzIGRlYnVnIGNo
ZWNrIGlzIG5vdCBjb3JyZWN0Lg0KPiANCg0KU21hbGwgbml0Li4g4oCcdGhpc+KAnSBzcGVsbGVk
IGluY29ycmVjdGx5IGFib3ZlDQoNCj4gRml4ZXM6IDM5M2JiMTJlMDA1OCAoImJsb2NrOiBzdG9w
IGNhbGxpbmcgYmxrX3F1ZXVlX2JvdW5jZSBmb3IgcGFzc3Rocm91Z2ggcmVxdWVzdHMiKQ0KPiBS
ZXBvcnRlZC1ieTogR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pg0KPiBTaWduZWQt
b2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gVGVzdGVkLWJ5OiBHdWVu
dGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+DQo+IC0tLQ0KPiBibG9jay9ibGstbWFwLmMg
fCAzIC0tLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9ibG9jay9ibGstbWFwLmMgYi9ibG9jay9ibGstbWFwLmMNCj4gaW5kZXggZGFjNzgzNzZh
Y2M4OTkuLjM3NDMxNThkZGFlYjc2IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9ibGstbWFwLmMNCj4g
KysrIGIvYmxvY2svYmxrLW1hcC5jDQo+IEBAIC00ODUsOSArNDg1LDYgQEAgaW50IGJsa19ycV9h
cHBlbmRfYmlvKHN0cnVjdCByZXF1ZXN0ICpycSwgc3RydWN0IGJpbyAqYmlvKQ0KPiAJc3RydWN0
IGJpb192ZWMgYnY7DQo+IAl1bnNpZ25lZCBpbnQgbnJfc2VncyA9IDA7DQo+IA0KPiAtCWlmIChX
QVJOX09OX09OQ0UocnEtPnEtPmxpbWl0cy5ib3VuY2UgIT0gQkxLX0JPVU5DRV9OT05FKSkNCj4g
LQkJcmV0dXJuIC1FSU5WQUw7DQo+IC0NCj4gCWJpb19mb3JfZWFjaF9idmVjKGJ2LCBiaW8sIGl0
ZXIpDQo+IAkJbnJfc2VncysrOw0KPiANCj4gLS0gDQo+IDIuMzAuMQ0KPiANCg0KTG9va3MgZ29v
ZCBvdGhlcndpc2UuIA0KDQpSZXZpZXdlZC1ieTogSGltYW5zaHUgTWFkaGFuaSA8aGltYW5zaHUu
bWFkaGFuaUBvcmFjbGUuY29tPg0KDQotLQ0KSGltYW5zaHUgTWFkaGFuaQkgT3JhY2xlIExpbnV4
IEVuZ2luZWVyaW5nDQoNCg==
