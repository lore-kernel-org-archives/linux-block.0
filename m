Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0EAC433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 00:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242019AbiF1AsW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 20:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiF1AsW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 20:48:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C20B11
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 17:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7oTej1/0cLKvkNoRo1izTHEi6lEbrcY9SDHZBOYZyPxPAoa5Bvo8Urp0g2jrF6fIvbRFbIBkKdILHAtxR6SZSgRpWArMih4xaEjDtxu8Zlvg3HV0gHF+NST6/WlmDHKWiJn3T7F1X1B7/n3NCyGptsYPMCgEfROSt38Tsdj3uE4mQhaQNcULxuMqImXXfcQttnABjqCTlIVWtSqkaviXTGtojScoh1aZWK/BP9MokWefD1M4T+1tZ70vD7XEyQrXV2ZS60kXlMDvdqV9xQuUxWB5Wsgcio9yLmwWBj8UhjNzHa2N0O9XebOk5mEQ5i6EFklpGuB4is/uDZQN5gP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sw1+EYDlCM7Dyl7pcxE8wv5dScHSXrwLtOxC8MKivWo=;
 b=duREuiNR/RZN3kcK6Nh5bE28rzKLcu2jTO0OvoTJHO5lMyqr1R+wJ3/JOfdXQ0YFD81VcYaKJd81aJrfAx2zfr0JFOeJeUCpwRGPk6nlkNW4sTz2NjChYNGu8WFzRxVDMLWWCtO4NNeooxk8PfqQ+AFFHjNBqljb+HhHjWApvicxbQGzAyekzTcyNZtXO2UQCnkxcuQVHhBvLqI9KigA7bLZb+on+eIA3aGvEML9L5gOY2BOl8bBJdDVwMLrCLMCKp4Fu3eBQhfB/eAm5oId4Zgvdix+M23kmXfuD0m88I5sZiLBW7XTgZ0AfKgo8ClPTQidHLSlPOinFuFoT1CcUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw1+EYDlCM7Dyl7pcxE8wv5dScHSXrwLtOxC8MKivWo=;
 b=boUUjN582mCY/0l8nbFtjCIWfpxpNu94BSxUzzTXIfQgRv31PSc+0+M7+KGtIyqxm4TM9yuft0ODlBd4OVBejGhlBEzoWW1IOkX6QtEjcFCZlv5BNolM1P8K0Tcl2ayOvOpfJmgq3tDFm0pQ6dYKsHskbvesAPPwOP5NiuNSCRnBOY5ec6NpjY8AGcT5jktHJzF0QqvgjMWjTmDH+qPpVbVmErr/oX+t+TS5tklstkDVz5kbXLQhy8z5rPKp5mqapnUeUv4rz1eGQLjk1i6HDzRznyouR3Brhch/8GSgwkp2eLrcsxxas1USTS8Zit/lY6O5yrfPp+8Pz2EoA2ixLw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN1PR12MB2365.namprd12.prod.outlook.com (2603:10b6:802:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 00:48:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 00:48:18 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v3 7/8] nvme: Make the number of retries command specific
Thread-Topic: [PATCH v3 7/8] nvme: Make the number of retries command specific
Thread-Index: AQHYin/ILJtxfU/2+US1jgvl7gWuN61j/IKA
Date:   Tue, 28 Jun 2022 00:48:18 +0000
Message-ID: <f3c1e76d-34b2-6c33-11a3-88c56e2a14fa@nvidia.com>
References: <20220627234335.1714393-1-bvanassche@acm.org>
 <20220627234335.1714393-8-bvanassche@acm.org>
In-Reply-To: <20220627234335.1714393-8-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5f10a90-e70d-435e-477e-08da589fe4a2
x-ms-traffictypediagnostic: SN1PR12MB2365:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PAXqmRawbO4u7elod41x3lMl9O0aRKZINQbuixHEpxjRMXZOt9LBjQNJVcFG67h7JecxGrCkbc2v8eGVl7XH73gcHKfAp1v04bDUeu01ZnbWdq8wkg768pW5mJnr9jgwnseVRNoJ3BRf0d55diGi1t/O6+9rkGo/0Uvd4yKGtkWQJqjlwrUpwoJYyX1kBYowAK7Cnc5bDf6vvzmnn7q5DUy9n2/gq/ouTvj6u9XaDRiqGDjiaeVTOXjFxICJxjA3EAxR6pVrHmsFFTG46hb6uRM7ubAwS7sGhw2XV4kWAlRl77Q0oNea5+A6yZ8wJgppQGJdIkRYVoepJJ1DvsvgywrhO/MGqK5ZpOZ/NQeeMGLGu2Rl/Az490Yb6OjSKntkTSSPbjOsR/1N0PEkuKK8tAWOHWVWEU73Y+CZt4XQutQy3QiazErVGVUfHB43n2v4Ub9yzk8iz+sqn3GTVjN2ENzthOQuLqblayqC1d18ypyZOmXm4PNBJIYsZEvX9NSGGrD4I2FgGAorAPzFvgmpV44og4QY35hz5dNzMMcklIFFhUb6xHBvbJY31Dxm4eGuSzTpLh3MDDBHhequoqg+art2yhvmnBcDNMmLfTGGsoJkm1+fUr3b5N5AZX5Wxwk9D1ZLgaIuK5lZYbR5kCS02EcBhUM8CUpqOQaGJl/HhCanc6fcuU7BNIOTx0zZrndJrSXRJP9efxsvDRl9/1aS9zTQi6sbtIMfhWAYPNfNXF1gISiRmlhR/GawWMCVhWZHR9a3Ua14hyzZgmgbguhnj/4uSeKQaQihIFSkCnCosZyDiR5AV+lhifoszN89pHaGS6tuKPtJaFSuq6tW7UIxs3pOEgSkGuesNbJb4Yr2e/8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(8936002)(76116006)(66446008)(6916009)(31696002)(66556008)(66946007)(4326008)(8676002)(107886003)(86362001)(2616005)(64756008)(316002)(91956017)(6506007)(6512007)(38100700002)(54906003)(38070700005)(66476007)(41300700001)(83380400001)(36756003)(186003)(31686004)(122000001)(4744005)(2906002)(5660300002)(478600001)(71200400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXNrNDlSd0dOekdxN1NmWWc0UEhmRWV1bW5YWngxUkxwU1BDMi96c1MvTTVQ?=
 =?utf-8?B?T2RoblBDaUhIM2dydjg1VXJDdkgrMm15dkJyK1BKNDlUT1I2Kzg0SHVvby96?=
 =?utf-8?B?RHY0c2J3KzJqN1p3WUR3Y2tTUnZqZnVOL0J6N3dDeDZOZExCSWl4ODRoVlY3?=
 =?utf-8?B?Y2kzeW0zL3VzK3NzL1VkMlpNcG54QjloemszWmMwZkcvaWUwdi9takVzMG1x?=
 =?utf-8?B?akp4SVZYUHI4WmY0MC9LMDAzQ0RjMkJrVGNxMjkySUNVczl1cElpRXpiMU9w?=
 =?utf-8?B?S1YvUUg4UVpmRDJCUjNITndtZENXYVVQRFJJdkRnZ2FaRGtsUWRLQ0xGeFpT?=
 =?utf-8?B?SlZYd1V3Nmg0M2IvaTZZUHA1ejVlRC9FQ3NJcVZvN01ydkp6OHEyYkVTakRp?=
 =?utf-8?B?QkQwaXhVdE1xQ1VxWHpDaVIyVmd4TDBOY0krbnlEVzBDY1dram9Fbms3dE56?=
 =?utf-8?B?MFVidmdWVm0xUWZKTVVjcTZ1ZUh0OElhKzg5bFRKTTc0azBKSnpHY3l3RDA2?=
 =?utf-8?B?Yjk2aWtKZlQ1UW5RMUVHM2JvWldsRTJGei9leEZLZkJiZWVxMFgzdU5lMWt4?=
 =?utf-8?B?azNMN3UzSC91cmtlNHBDUDRST2YvZUxJTlFIRWdaY01qbTJtT2x2SzdaSXVT?=
 =?utf-8?B?SEF6Z3YwUUh6dEJ2eE5wbk5CSTA1QXpWemY2YWJqVmYzOTBRTktRN2xZR09n?=
 =?utf-8?B?cGFmNTd4MVJmMEdDeUo5M2ZuZCtyTTVydmZnbjd0U1hzSUZjK2l6UUt2VmRP?=
 =?utf-8?B?VExYa1JUUjRpaDhTdGlRc0FQVEE2ejc3RENIc2pQbzNkM0lIVHI1K0JmYzEw?=
 =?utf-8?B?WmYraEQ3TWZ2eVMrUnh4OXNCeS8xNkVVejgvWktPNkVXNVNVenhLbmVQVUlo?=
 =?utf-8?B?S2RWS242T2NqelF4dmJ6eWJCVVpGbGZWUHZuYno0Qk5zZVVmVGhJOE5uc0p4?=
 =?utf-8?B?V0E3VTZNMkpURzlObWtaQkJOZDJiVlZWemlxN241dVZIb3ptQm9uUzRQd1Zo?=
 =?utf-8?B?QmROcGtQNTE2dkpsV2FPU1FMdVlvYjFldnMvNHA5MXNVcFUzcGF0NllzN0hs?=
 =?utf-8?B?WjlpZVcyOVptLytxemJWL2JtRDFpSjkwNEtSWnFTVk5VbStRYUxaYUtQMnk4?=
 =?utf-8?B?UTB0bGhBWEhYQWNKMkpQN1Y2d1ByNlVWcGo5SDEySGtGMk50bWdGWVF1RWRs?=
 =?utf-8?B?am5rcURvdmJFcXpNTUcvODBpUVBHNmRUY3JOaFNDeGdwbTFHV1NqU1dGZnlW?=
 =?utf-8?B?bkF1Si9xbmdxOXdjTWNmY2tSb0dzTDhxbmlIWi9VZ1dDS1UzeFdVMk95NG14?=
 =?utf-8?B?RFBHUVlXSHNnTnBnQjZVa1I0cjZyUlpObVlwcU85NkVMcU1CLzZrNzhIWk9O?=
 =?utf-8?B?QjZqc0xUQUtxOWxNMVc0WXZYTkM2ZXJnMHI0YmRrbUJIQmpaT1g2a2liNHJL?=
 =?utf-8?B?MnJuVnlmSjUrQURVWno4a3cvMWM0aUwvVHZGbFE0ay9xSVNvRlZhaXl4YWlj?=
 =?utf-8?B?K3ZwR0tHTFlqaTlMSzJlN2RNZENjSFY5L1BCR0c0d3grSWlIc2haWjB1RVFp?=
 =?utf-8?B?Z2hMK3BzL0NSb09neUdZYkJOTS9Ec2JQTStFRW5vd2ZmZzQ4RUQrcUFOeWVM?=
 =?utf-8?B?THhpQXJwaHFPTTFPdHM5UlZ4Y3pjZTYyQ0pzbWRYYjlNMUV1d05EVXJ6Vnpi?=
 =?utf-8?B?TzlSUmRCOVZNa3JOc0Nmb1h1WW1KdlR2dm5vcmllMDF3OFJmamxkTnpHeDZ4?=
 =?utf-8?B?T3F2blVSMzQyaW9vTU5ML3dHVFJGTzIvQXVMT0VUVVRkOFkzbEtadExQUGxj?=
 =?utf-8?B?RTRLZUQ5UDZ4QjN5SVZKMGZoYXMvTmpLUFZvb1VjWVI4MzNpQ1VWY0RFS0c1?=
 =?utf-8?B?K0pQNjFOTEIwS1lDV1BJT1NUcm9DNXdkejU3OUFwMUJWYytFTHVnd25DZkRp?=
 =?utf-8?B?c1JUZHhKQ3NJYlFxM3kyd1kzUW9HNG5ONVVNNkVuVjVJSEh6VlIwb245QXdi?=
 =?utf-8?B?MUN6WGl3WGU0S2l2TGdpdmJiZWN6T1VzV1ZIVVFDM1czbWhxYUZoQmNVNWZM?=
 =?utf-8?B?T3B0TWlVUGNlVy9jZGJUbEY5dW1IQVAyUDRYeDBTNFFZZkV0akdVcjhUOFVr?=
 =?utf-8?B?VzJyS3VWNEZQc0lrb25SZGFnWUNnTjhBNnZtUG1hYW5UaUxuaElqK3pCV0JP?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E92E4402DFBBDD48AFA0BD692FC51F5D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f10a90-e70d-435e-477e-08da589fe4a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 00:48:18.4918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ulBTViMk0uOBINiZKBGC/YG4VKDuT/gn+YJXZEa+Eih6REXRm+aUG+kaEVr1gHhRaltVynMZGSDVT2jPruPFVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2365
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmggYi9kcml2ZXJzL252bWUv
aG9zdC9udm1lLmgNCj4gaW5kZXggMGRhOTRiMjMzZmVkLi5jYTQxNWNkOTU3MWUgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaA0KPiArKysgYi9kcml2ZXJzL252bWUvaG9z
dC9udm1lLmgNCj4gQEAgLTE2MCw2ICsxNjAsNyBAQCBzdHJ1Y3QgbnZtZV9yZXF1ZXN0IHsNCj4g
ICAJdW5pb24gbnZtZV9yZXN1bHQJcmVzdWx0Ow0KPiAgIAl1OAkJCWdlbmN0cjsNCj4gICAJdTgJ
CQlyZXRyaWVzOw0KPiArCXU4CQkJbWF4X3JldHJpZXM7DQo+ICAgCXU4CQkJZmxhZ3M7DQo+ICAg
CXUxNgkJCXN0YXR1czsNCj4gICAJc3RydWN0IG52bWVfY3RybAkqY3RybDsNCg0KSWYgSSB1bmRl
cnN0YW5kIGNvcnJlY3RseSB0aGVuIHBlciBjb21tYW5kIG1heF9yZXRyaWVzIGNvdW50IGlzIG9u
bHkNCm5lZWRlZCBmb3Igem9uZWQgZGV2aWNlcy4NCg0Kd2h5IG5vdCBtYWtlIHN0cnVjdCBudm1l
X3JlcXVlc3QtPm1heF9yZXRyaWVzIGZpZWxkIGFuZCBzdWJzZXF1ZW50IGNvZGUNCmNvbmZpZ3Vy
YWJsZSB1bmRlciBDT05GSUdfQkxLX0RFVl9aT05FRCA/DQoNClRoYXQgd2lsbCBhdm9pZCBpbmNy
ZWFzaW5nIHNpemUgb2YgdGhlIG52bWVfcmVxdWVzdCBmb3INCiFDT05GSUdfQkxLX0RFVl9aT05F
RCBjYXNlIHdoZXJlIHBlciBjb21tYW5kDQpudm1lX3JlcXVlc3QtPm1heF9yZXRyaWVzIGhhcyBu
byB1c2UuDQoNCi1jaw0KDQo=
