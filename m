Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A80C32771
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 05:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiIUFDV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 01:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIUFDR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 01:03:17 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5597F24B
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 22:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwMP4rR8iFTTD6b0/je7pgDc3JooJmca6ZsGOgWpoAviM6wSBxS3zGdIizZRRZZIGIKS4c5tTYWjyw1dAUQ8p20SGXYf7Neph2EcfykZBW2R3tPrKJH4Q00gTT88xribVN2c45yB8ptG8xxOV2MEPgzbQ9v0dCvHnp129BQ7hfK2pEDvXARm0RYrnI8xE42NX/kPoJueI9OUQGKAtacGiXR/wPtKcYDlBP9qWSSiHiCxz3cjudLrkoLiLKrwax/ddHDDhsTXVU/V0EJHsmVkbFYr8t4FbAFM7h+BWcuunoQ4BnNxD7DFOGNtY6ysm720ul76N7Wk4IW4KoAj7V9IVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gb8nZY3SlKReppM26lA9msEmMPiccNRnxiZOyqYfCQ=;
 b=lTvzsSHPYiAY0Bq61lPsVWTs+NpYGISDOs++z/l9ISKf9FC76EkFUUfNP/9IdrL/4a5LgtthlL2G/p7aI/ovqhj0iGrpJ2a3O43FM2adc+axav1+Q0GEht0D+GloYQYnqQnXDiJehyxB3UNMyrmMPtWZnnP6YJms6MnH4GHIxtOswBQKxl6HNoy3043AT1IpzTdTGGynXIh0YHjssMb8azuFQYMyBqkb5iivtm8wvXpE2nqDUQTyBSH/sYo6FdUl0YPGsnN3bRz4qpTRr4I2b6D0s3Cueye27bxtfm6FjmM0V0Yn2ENbc/yC0bqHeck0sViEN6VmtmIShThbY5uLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gb8nZY3SlKReppM26lA9msEmMPiccNRnxiZOyqYfCQ=;
 b=VhpD1JVIY3jqs8cdUbF/M3BLZd5za2FzSNGjbHjGgnRCps+DIq5C6w/rj9wRv3VvjNqLQYYQqIqFMJbFDCExCNf901QcDEP+wbV+XpsT71eHMLkddxbo+JZ2Sof0AJ/UwECMDe3xFUZoMeQoV+9+BFClc76+UZymuoCT4FyY4mMbf0yyIYJPgPxlOYKhGCB3t9FnSqrpFAKShaF2Ygsu104c8OkKZ66WjZ3hPTtaRSIsgRUs0TeIgE3XxEaOMwiR8S0Cm4oiylCONME7b0xHOwjKn+ezmjKO441AcAzNMh5LaDMpoTSO0SLDL3fu6eqGrH2X39VmNmq9wAaqLMAw7w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Wed, 21 Sep
 2022 05:03:15 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 05:03:15 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH v2 4/4] brd: implement secure erase and write zeroes
Thread-Topic: [PATCH v2 4/4] brd: implement secure erase and write zeroes
Thread-Index: AQHYzRr3QXDUB7Sxgk2nkklKV2iRsa3pVLIA
Date:   Wed, 21 Sep 2022 05:03:15 +0000
Message-ID: <8aa57d66-05d6-154e-445f-ee99ecf4ac5e@nvidia.com>
References: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2209201358580.26535@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2209201358580.26535@file01.intranet.prod.int.rdu2.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW4PR12MB7336:EE_
x-ms-office365-filtering-correlation-id: 49ee7b78-c7c8-41ee-5a23-08da9b8e972d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uQCRB4mz8BzfbhbklMYo6yoZ0eEtQGyffhiqp+6baivQRsqa1CThhQJsxwZIm014ghSrk/zHFwjCyRsxzFCfxKJwFJ3vo4/ZYrVvgSsn82dGXqfXpe4WKh4kz0+IA8IX+7CW13FIDf45ASglJ1M2Hv0Mes1mkAWu0eYmqEldlrcqthbtl0vIFVswYlwiAFFs9tyPvbJ2F6o8BxpgGUj+t6lVD9M1RNRpCK5seYlPf8GOKhsfO5NBzz/REWA6jDq7njtnqe4ROe1hITFgdFbcDyEjeKV1rWZGRqsuX1xGymahwL3wTi7YUKtyRH02zu1oXsDYMvAXdmCrR8Sc8CEaqFATP2Dt8WbmxDcKGn2gcVktUX7g/l0h4Wu1byOl5UmgCV7yqidHriBjYd7MT5ckOauCmfkNBMAJ3cwKGirNl2Bw2EDuDJJUMHLS0dbmop0X3cfmwiZAsc0rbduyXcNX13EMIe8cyCdRHTJSQigtn+0xxLc5xsXQ0qA58j1TymL4PtRdnm6tOZTbZ2e0h8faoWXBo0JI25V+sUom0wIf5Tbe09G0tp7QuMprT+DXTq/YdPK90JvtmbexOfAz+gbgGXYAY0hAfP8wh9JlkGJj96Mi/FZsBYl/kxTcJuFMEnNibo90p1vrF0Ah+s2e0Lp/+uE22Dg6TPBnWGHU3JNEX/QFjIo/6gvp7kCWQMcWlOngz7dVYb2m+FBNORGOQF9RuZEQR3EtLwmMXR5ircl5N87gAxyOvFXWCkcCmSPWvWwwJ45oOxzSoScRc+n9QoEecfZatu3P3ETvRrTgi+5r980y6rLspvTwxnNz7Grzrzu9NSAMbbkIrLLgfr7yhE7mrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(86362001)(38070700005)(31696002)(122000001)(5660300002)(4326008)(76116006)(64756008)(110136005)(66476007)(66556008)(66446008)(8676002)(316002)(6486002)(54906003)(41300700001)(2906002)(478600001)(186003)(2616005)(6512007)(6506007)(91956017)(38100700002)(66946007)(71200400001)(31686004)(8936002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGxhaFVxdDR2K09SM0pDeUpDRk1ES0NVUW9EbW1za0lmYzRLdllQNm5sdFJl?=
 =?utf-8?B?QWorMHN3UjRjd21FdThyK3gva0huY2NDckxGcUVGaGxXckJEVGR6alpubzcz?=
 =?utf-8?B?cTBldWhIU1ExOVZoYkZuL1VCeVhxdzlYSk1NNWxpakZEYTdiRVpJRmdyUzVO?=
 =?utf-8?B?dG1VdVNIeHB3bFdkZ1RnUDN4ejFVRDNneHJleHdNUHk5Rm1pa0ZESzhCZUVx?=
 =?utf-8?B?RE5nTzk0WGJWZzh4ajhoTVVkQjN3RXlQemtxQzhtOThHOFQ1dzd2T0tYaTZD?=
 =?utf-8?B?RmIxUDY5bERlcUQyd2tmSUl4MWRvc25WZVE4cHBnb042ZlVvRXhrWkxUQ3Ar?=
 =?utf-8?B?R2paQUUvZnlNZGgyYnh6VUE4MkZSTzdjalNlZXJKTkoxZDArbG0wb1BZVndv?=
 =?utf-8?B?WVE4Z3d4WGVZRm40UXBlQTc1Rmw1T3J1SjQzbFpiOGpnR2htcnpTb0RJYTJi?=
 =?utf-8?B?UmxjUlJ4a0pGakM5UHVMdnlQWndUZkpKTURrWGRlUEF2TDdNaHpQczAra3dP?=
 =?utf-8?B?US9Rem0raVdtbjc2QkcwbW9vUlZBQ3pQVDZBaU9Od1Z2WGdGN1EvR1lSdDFy?=
 =?utf-8?B?b21DZjlaVG1DdytFZTErU1ZveWFTS21ZOG5SNzZOSU9JS2t5dHNsZWlRMENQ?=
 =?utf-8?B?SmVqU3hMU0dMMVZRaHozcjRGbTVPZTdRM0g4MG82RHdOa1puaWNkeno4T2FL?=
 =?utf-8?B?eHBEb2F3TGMrQ2ZRZkEybmRId25lMlN0SXZNckN5Vmp0b1FzOHRyL1h0blBJ?=
 =?utf-8?B?OU8yNXllSkR0TTUvdElHNHBrdG1GdENSaU1TNWJXN2dsYjAyK1BYUStaY0ow?=
 =?utf-8?B?U1lGaDVMVTk1SjdybTErUGNQRlJtN216Mk02bWtnNGp2U3JnNnZSN0VGWHRm?=
 =?utf-8?B?bDdRUnVUelFwQzNlb1l0b2hicitmdEVONktWOFpjSzNnYkJWeFVxbThTdVc1?=
 =?utf-8?B?YllaZW9tMC94c3VzUnUwQUM0eE1oYXNLNjZzamZFMUx5bFN2Yi9pV0pLTllt?=
 =?utf-8?B?SEc1ZEpEdHJHU09WUlliVkQ0N1FFSlVNNVN0amJ1WlNaRXIxZXNXM3crU3VI?=
 =?utf-8?B?c2VvNWtIQk40UDVwUWxmTGFOUk03dDFsTEJZVjZNRVQzWUdPVlc2VXBxTWZU?=
 =?utf-8?B?ZVJkaFlBTUtOd252d3gwQVFqYkk3RHptTGtXMXQ4V3RFL05GV1BYdzZ5K0NY?=
 =?utf-8?B?WFZhRU0rNmZaOG9WNXRwTktwYWswMzlKRjRKU2t4SG9ldGs0ejZhS0R0SkRS?=
 =?utf-8?B?TVV0ZlA2SlZEQks3QnB4SE9LbEloUGE1ZXJkakRiT0hYcWZtaXNWRVFhY25T?=
 =?utf-8?B?TTJhaFlXaDUvWXl3Z1pDMXVzbmxUNWppdEZIRDVjVmY0cmpPTUR4WlBPZURi?=
 =?utf-8?B?dktUWUFUZytZS0I4MXpSUDVrdUoreDgvdld5eHNEMjk1OXU1b2xnOUNWWHJE?=
 =?utf-8?B?a3hBdWZqYU5uYnZRc3dGM3ZYMy9xcmFFZVA1MjZsYysxNFFQb0hMZU8vMUJW?=
 =?utf-8?B?cWdMZXovaFVxbEhhRGQ3N05Ld1Z1RkorcSszL3ExSUhPcXo2THBvMVgvNkVt?=
 =?utf-8?B?MXgxR0lWMkMzb1oydlY2ZlM5SXhHaFZ4NnRhQ1lXbTRob0xzOG90ZHNpZFdU?=
 =?utf-8?B?T1hUditPNS9DKzBWYXEwVjdsN3NJazdwOEZJOFVtV3VhV2g1eDh0Zlp5VjVR?=
 =?utf-8?B?cFVRQjN6ZGkxVUU2M1FLZzJrSDUyU3lVbXY3em52NG44Y1hsbWZyZk9HbDBS?=
 =?utf-8?B?dG1VK2hya2I2cURqcTBsclVJb3JuTGFrb0pSNjNDZDRNU0d3TDlWZ2RoTjRh?=
 =?utf-8?B?dGtJbHZtZnlmUkN1TXRvYUQ1UG43S09rbkxJVXBRenlIVS82RUhmeDRYcmIz?=
 =?utf-8?B?U2dzeWI2Z3o3ekhjVTRsbkhxOVZnUVVFZ3M3NXJZTStraEVoL1NoV3lGemM3?=
 =?utf-8?B?aW8zRE5ZczlEc295ekxRM1J0QWRlSzg5TjZidTQrVDlSUHNIQStwQ1pGS2Jm?=
 =?utf-8?B?Vm5YOE1qYk5VYlVORWhqVkVvWGpTNG9yQVRtWXJzQUMwS0E0Nm9CUXFUMHhx?=
 =?utf-8?B?RFNkNTlXNW5RUEgzcWQwN3NLVjRLZmR1c0xJWUo5S1NUajVmVEdGSERLeFR6?=
 =?utf-8?B?eUlJN0hPam5pUjhZL2pVNmVHTWZRcHpIN1ZqOWEvT2NVQXB3aHlFSkl5YjdM?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74A07A6D3C837540BCF351867B5EAC71@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ee7b78-c7c8-41ee-5a23-08da9b8e972d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 05:03:15.0027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Er93TbhcOXr94zRODFlK0LNnMXYq0Wf1sXzTTdEyFMxBuRAFbRhgVTFIKBtkOLzv+Eer9Q1y7dGf1dmPyIp0uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+ICAgLyoNCj4gQEAgLTMwMCwyMyArMzAzLDM0IEBAIG91dDoNCj4gICANCj4gICB2b2lkIGJy
ZF9kb19kaXNjYXJkKHN0cnVjdCBicmRfZGV2aWNlICpicmQsIHN0cnVjdCBiaW8gKmJpbykNCj4g
ICB7DQo+IC0Jc2VjdG9yX3Qgc2VjdG9yLCBsZW4sIGZyb250X3BhZDsNCj4gKwlib29sIHplcm9f
cGFkZGluZzsNCj4gKwlzZWN0b3JfdCBzZWN0b3IsIGxlbiwgZnJvbnRfcGFkLCBlbmRfcGFkOw0K
PiAgIA0KPiAgIAlpZiAodW5saWtlbHkoIWRpc2NhcmQpKSB7DQo+ICAgCQliaW8tPmJpX3N0YXR1
cyA9IEJMS19TVFNfTk9UU1VQUDsNCj4gICAJCXJldHVybjsNCj4gICAJfQ0KPiAgIA0KPiArCXpl
cm9fcGFkZGluZyA9IGJpb19vcChiaW8pID09IFJFUV9PUF9TRUNVUkVfRVJBU0UgfHwgYmlvX29w
KGJpbykgPT0gUkVRX09QX1dSSVRFX1pFUk9FUzsNCj4gICAJc2VjdG9yID0gYmlvLT5iaV9pdGVy
LmJpX3NlY3RvcjsNCj4gICAJbGVuID0gYmlvX3NlY3RvcnMoYmlvKTsNCj4gICAJZnJvbnRfcGFk
ID0gLXNlY3RvciAmIChQQUdFX1NFQ1RPUlMgLSAxKTsNCj4gKw0KPiArCWlmICh6ZXJvX3BhZGRp
bmcgJiYgdW5saWtlbHkoZnJvbnRfcGFkICE9IDApKQ0KPiArCQljb3B5X3RvX2JyZChicmQsIHBh
Z2VfYWRkcmVzcyhaRVJPX1BBR0UoMCkpLCBzZWN0b3IsIG1pbihsZW4sIGZyb250X3BhZCkgPDwg
U0VDVE9SX1NISUZUKTsNCj4gKw0KPiAgIAlzZWN0b3IgKz0gZnJvbnRfcGFkOw0KPiAgIAlpZiAo
dW5saWtlbHkobGVuIDw9IGZyb250X3BhZCkpDQo+ICAgCQlyZXR1cm47DQo+ICAgCWxlbiAtPSBm
cm9udF9wYWQ7DQo+IC0JbGVuID0gcm91bmRfZG93bihsZW4sIFBBR0VfU0VDVE9SUyk7DQo+ICsN
Cj4gKwllbmRfcGFkID0gbGVuICYgKFBBR0VfU0VDVE9SUyAtIDEpOw0KPiArCWlmICh6ZXJvX3Bh
ZGRpbmcgJiYgdW5saWtlbHkoZW5kX3BhZCAhPSAwKSkNCj4gKwkJY29weV90b19icmQoYnJkLCBw
YWdlX2FkZHJlc3MoWkVST19QQUdFKDApKSwgc2VjdG9yICsgbGVuIC0gZW5kX3BhZCwgZW5kX3Bh
ZCA8PCBTRUNUT1JfU0hJRlQpOw0KPiArCWxlbiAtPSBlbmRfcGFkOw0KPiArDQo+DQpJcyBpdCBw
b3NzaWJsZSB0byBhdm9pZCB0aGVzZSBsb25nIGxpbmVzID8NCg0KLWNrDQoNCg0K
