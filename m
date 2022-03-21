Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD5AC433F5
	for <linux-block@archiver.kernel.org>; Mon, 21 Mar 2022 07:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243768AbiCUHYY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbiCUHYW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 03:24:22 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A275AECD
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 00:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxyJbMCEFiAZazyZNADzbxUFQ+yTbTeXllsquUFidQs7BzwbDB570FE+zK+8lfgIsc+932l3iGzXZotB31Zoi/4cnSjZ8pNNWwbZAoCkbBmDsQFWjHRz36Ohr3+ygWQOB/pP5/C9+V7hNvcFtvOt1RSGX4Bo6vmAQRw2hrLQ2UNueFFdcAse4gJGIlR7tU2PKAuAvwMBI3cXpRayF9z1yJcVmmCqhfsiaFuokXKZF+OUXzHxUYuWnBfTCKn1gyBu2BLGcNupIeSSQIz2uYVkba4BSxlj76rOzMGPOcoaOF+iA8wjHdmVDqmVTO2gPrSYJy0k0C0ezuTP1jr+WnnyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fPAvr5gl8O9B0TMMbAZpfU16p13bv61Thpa9Bzpa5o=;
 b=JXexzN02BDl/JvKUSQUWFgHjWXl83FD9imd2hswNGQ7pFEASXAvM4nv9bqY5FuxIfnf73TYa9w09nPaQghgZhUVIkZksY5WpQjFJ6iHoFrF9FKZGeP6NU8tFF1AfLMwdzwbwASBsuZwi67K3u3VQNxCK6jeLgHCKXwk09w94fVHB9sB+u66KCBeQwxQmtlxqWWpFAUEkLlmghAAROb14ED9CSy95DMJJP2YnIoG54aIfpW3l3KHb0m8RYkVU1PdPuD5BuMevzmCfqMuLKOX/FscJGqNm+9dpxkv/EBC6espBtedUBqFNBeG/+slIsOwlSK7o4FejV9la0JnJK14h9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fPAvr5gl8O9B0TMMbAZpfU16p13bv61Thpa9Bzpa5o=;
 b=IXQM0xXHemyNNw3Zz5K9k1IGVmuniyCFf7W0jXBgu1ravR6kj3ldXDoTn6T/5FptG4qhDRDmKNEUUUTI+DGTIHm1annKVDf7s4IVAYSijBGrKRqELaou9SU3638RVXbGZANFuwEa3fz1ZaJm5fgU9qi1XDuVrY+IgkO3NsPofP/yvQY0+i1/gYldXLhBr7mOcWOia9h79DUPVnm/1MqBbbOlKdmLMF07FJwwVo1BHUmOkQVuLvVeTcLknoDW/3nV4MQes7GHvSdYPSEyABW7HJSgc5QHF80IDkLe3knlSWQWH8HrFBs3iOmv/0hCWimMEiisyL3W7wm6f1CiWN5Pqw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Mon, 21 Mar
 2022 07:22:55 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 07:22:55 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jackie Liu <liu.yun@linux.dev>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] n64cart: convert bi_disk to bi_bdev->bd_disk fix build
Thread-Topic: [PATCH] n64cart: convert bi_disk to bi_bdev->bd_disk fix build
Thread-Index: AQHYPPMUhSUC17FQ6EGMljGFBhkXZ6zJbxCA
Date:   Mon, 21 Mar 2022 07:22:55 +0000
Message-ID: <af81b502-a5ae-b215-71f3-64eeba8774af@nvidia.com>
References: <20220321071216.1549596-1-liu.yun@linux.dev>
In-Reply-To: <20220321071216.1549596-1-liu.yun@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43d44570-a089-42af-a09e-08da0b0b9e8e
x-ms-traffictypediagnostic: BL1PR12MB5269:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5269E4150CCAE6C5B4C1CB35A3169@BL1PR12MB5269.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LDzuTo4Vr0evmQAaSDC3T+WNcTUAjBmibyJ5G2FIYOVfMgn3mdofocTFwXsx9YJ9R5JLcf9CPNPldw7MNA9nhTqvM5l4NXm7XckTzwnElvlbQPdjutZqDBIf9Rrix+WCfV34hFW0DYrmY5oEUZbnjS2IzfsFsY6U9R83ZAa/432v1IJJ8nGM5NwqDjRrTKlvIYTGHgxWFu33HlNCN/R902WxX+PztyBeH9zHEhrKsxWRRKeIR2rBf9d/glk0nOiD4hBGnh7uj6FcVebBRgV365gDNx509DI0ktfnRVFW5FVKERX+0yfcS3ohhi/hI2KZZhkRLVhgyOL5B8iPB+API3rRDiN9ywjAw2D/0hcDXmgsvPtpIXIHlMSUguIX4LiCaMgvc8bzTR+0Pp8hxNJ9mt33bIqXksjxzSM7K1I6/9I4QsSPjgg1edjLEvxU2jWCAMwggMjVDLgi6R2RpPrRhhsmwgAs7hdHVvUJIRvcTIN1etdNLLst2j4ekzW+0JtUcRgz2VPwMoCIamW5fXS2ov7JvrZjrPoTIXthLsmMtvuQHJth5HtuuUaUaoEtKSMQm693BtXOLdK9TF055ExKGrcJZs9LGKR09jVdroiwjoKgjAXLR2mfPHTgAaIBJDp6esiVobphNc6sIF5ae0IBujHY52TTgd2F0mPd1uxUH40dsrJhBs7PfIhSz4WxMYFl29wBkUVFQInapZmhpSbhA9WJFMn4SLBgh5RM0AiKPN4YlqABXsN1VqwTHSxN5uceXiH9OiVQJbEFVAn5LYHDBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(71200400001)(86362001)(186003)(4744005)(26005)(5660300002)(6512007)(83380400001)(53546011)(316002)(6506007)(110136005)(2906002)(36756003)(2616005)(6486002)(66946007)(91956017)(4326008)(31686004)(8676002)(76116006)(64756008)(66476007)(66446008)(66556008)(38100700002)(38070700005)(8936002)(508600001)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHhPY1RFeVFxa0diY0xZSmpPUWZ1SDlCSnMzMERsc21NYUdaZnRzUDluVmZy?=
 =?utf-8?B?ZU01YVcwTG96eXd6STdncFhsRU9vMmZJY3hsTktUOUZUeFVLTGY4QUVDQkEz?=
 =?utf-8?B?UDRwYXJpbDRnMmFsRTRNY0xQRHBIVFpzZWRZVHoxWFc1ZytNRmtUZm8reXEv?=
 =?utf-8?B?b1Z1ZnhjZVYzLytzRERnNkNaTDlmQmJSdnpBSnZrTWJ0WEhEVWZVcTV0aVBw?=
 =?utf-8?B?aWdENEVVc1k0aTJRL25tNmQ0QUJNQjlmZURDL0doM1NkRmdCTytwblptQWNK?=
 =?utf-8?B?QkZESWQ5V2NmZ0N4dmNjQmFQZWJsS3VQMEkwaSthVm1XSGlJTmxXYnJoeGgr?=
 =?utf-8?B?SWJIdGF5N1RZL3N5cy8yWTJlMlliTE5QMGowWEl5TENWcFBqMWlheFRvTmh5?=
 =?utf-8?B?N2ZzVmQ1NW5ob1g4a01BVUoycU9NaHdoYU5TbzN6NFI5ME9VaU1XSWM5ZnFK?=
 =?utf-8?B?Sm9pTG1EaTNyc040dERYV1h5RDFXUkp6OCs0WFZ5Wnp4L3ZzRkVqcTd4SHQ2?=
 =?utf-8?B?TGc0aHhqMVVYVkhLYjFUN1cwTWhjUEJPQmI1MnpzWjJJT05VZUlDTVMrdGs2?=
 =?utf-8?B?dnI5ZFBMOVlLT1drUVRERTA3L2dnbUFXWHVqMUtSS3VOYS9WUFdyWHRndFE1?=
 =?utf-8?B?QUx1OThXczd0bzBWZFVMQk8xbTZ2V3h3RHIwQnkvYTBrb1ErOVIrMUJMd1c1?=
 =?utf-8?B?Y2x6OFpLd0VtWFBRckRtTmExUGF1ZXN2YlR4U3ErVXA2MXB1QjZBRU4yK2lG?=
 =?utf-8?B?c3ltVFF1bUg1TmtXSm9ibXNVRDVzcTROa1FQSW5jK0hiL1B3ZlNJc01wZyt6?=
 =?utf-8?B?dGVEODIrR2V6MzhodjN0dUZPK05kZ0JvcjJGV3M0bXBFeTlGTGh4R1hhL2cr?=
 =?utf-8?B?cm1kcjRLWStnOU51bHZEUWFqVzUvNUZlRE94RWl5RFNta0haR3VzcXBWa2lk?=
 =?utf-8?B?NzdNYUVUcXBCM3JKSk5pS0xZU0N3QnZtVkVCM2xkM2xEMmw5QURpckp6SWVI?=
 =?utf-8?B?SnFBSEFRRFFWQmlNKzR5QXFqV2VyNUhrZ0J5TTV3Q1gwTGlkYXpKNm1abjBs?=
 =?utf-8?B?NVFpaHNqTXRlektIbXJNNE1LWkQ2SlkxMWVzYkxLRGhSN1pNK2JYOStSRGFo?=
 =?utf-8?B?NHdDK3NIMVZBSjdMS3FvcEZzS1Vuc0dzMUZqaWpTa2FnYU9CMGYzTSsxSDI1?=
 =?utf-8?B?V2FCa2RlT1lGdS9JK0d1Y3AxZUdPc0w4VXFjZVR5N2RMeWhORmRpNWRtTGtE?=
 =?utf-8?B?QjF4SFVZOVlFbVZOZk5aemtOU3hmZFg1YTZHSHJyWVN0VEV3K1RCZ3llVkdJ?=
 =?utf-8?B?L1hRRDNIMU9WcEpvSGdUdjR3ajl1T1Q1Vmk2a0RuT2dkVkMydXlibGdSWFRa?=
 =?utf-8?B?MkhOK3o2SHZsbjUvSXlmMFFYZGtHNHdXVTNXdVVBU2lGei9ZQzU3RFZISS94?=
 =?utf-8?B?ajFPSnhaWlBkS0NrZzBFSnlDZzdlUTEvazhQTkNmMmJEQmxsTHMzM2JLRDh1?=
 =?utf-8?B?czZqaDhyZ050QzUrYTBnUVFpTE5ieml2c0lYdWpPUFkvdVZvdTFHeGw0RFdp?=
 =?utf-8?B?VGdVWUVkY2U5aHd1V2t0ZHZOVDh6VDNsYVlyeEl4QWViNHFFaldOTE13YU1B?=
 =?utf-8?B?YXdrSktleDR0MHEwMTh2T3VubTBDbzJDVk54dHF4TnBKejlPY0I5V2hLdjlt?=
 =?utf-8?B?eG5LeSszZjdVczdaY1hwNEowYytGSWNhTThTaVE5M3Y5Q0J5aXluVnVSLzcr?=
 =?utf-8?B?NmxzVnF1UTJGOXBzeXRjY2dPdlNBRHA2V3lnSWUzQnJNV3JsZjA1RnF1bjY0?=
 =?utf-8?B?SXJKUTZJb2FmanNMK0Ixa1hHSkFlOE5mdC8zRWlsTER0Qk5ja0NjRWNRSnJY?=
 =?utf-8?B?UkEyV2dTd1g0ck00VGRRdlRZWFJpL0c3S0dqUzB6d0MzejJLdVdlb2F0Qmoz?=
 =?utf-8?Q?TGe7JJDprwgWh4+UmsbBxQPi0itQEkKH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE6BCC638126A84EADF7C6C10B35E9FA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d44570-a089-42af-a09e-08da0b0b9e8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 07:22:55.7945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wg+YRxbQhwtPWFnVkBPyLCBaCYEVmDAGt//DdeeB5VNL6V1iHAywjRvmlsbxFCtk+i1Hw/+yq2NWfllZjOVAFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8yMS8yMiAwMDoxMiwgSmFja2llIExpdSB3cm90ZToNCj4gRnJvbTogSmFja2llIExpdSA8
bGl1eXVuMDFAa3lsaW5vcy5jbj4NCj4gDQo+IE15IGtlcm5lbCByb2JvdCByZXBvcnQgYmVsb3c6
DQo+IA0KPiAgICBkcml2ZXJzL2Jsb2NrL242NGNhcnQuYzogSW4gZnVuY3Rpb24g4oCYbjY0Y2Fy
dF9zdWJtaXRfYmlv4oCZOg0KPiAgICBkcml2ZXJzL2Jsb2NrL242NGNhcnQuYzo5MToyNjogZXJy
b3I6IOKAmHN0cnVjdCBiaW/igJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJhiaV9kaXNr4oCZDQo+
ICAgICAgIDkxIHwgIHN0cnVjdCBkZXZpY2UgKmRldiA9IGJpby0+YmlfZGlzay0+cHJpdmF0ZV9k
YXRhOw0KPiAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICBefg0KPiAgICAgIEND
ICAgICAgZHJpdmVycy9zbGltYnVzL3Fjb20tY3RybC5vDQo+ICAgICAgQ0MgICAgICBkcml2ZXJz
L2F1eGRpc3BsYXkvaGQ0NDc4MC5vDQo+ICAgICAgQ0MgICAgICBkcml2ZXJzL3dhdGNoZG9nL3dh
dGNoZG9nX2NvcmUubw0KPiAgICAgIENDICAgICAgZHJpdmVycy9udm1lL2hvc3QvZmF1bHRfaW5q
ZWN0Lm8NCj4gICAgICBBUiAgICAgIGRyaXZlcnMvYWNjZXNzaWJpbGl0eS9icmFpbGxlL2J1aWx0
LWluLmENCj4gICAgbWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI4ODogZHJp
dmVycy9ibG9jay9uNjRjYXJ0Lm9dIEVycm9yIDENCj4gDQo+IEZpeGVzOiAzMDlkY2EzMDlmYzMg
KCJibG9jazogc3RvcmUgYSBibG9ja19kZXZpY2UgcG9pbnRlciBpbiBzdHJ1Y3QgYmlvIik7DQo+
IFJlcG9ydGVkLWJ5OiBrMmNpIDxrZXJuZWwtYm90QGt5bGlub3MuY24+DQo+IFNpZ25lZC1vZmYt
Ynk6IEphY2tpZSBMaXUgPGxpdXl1bjAxQGt5bGlub3MuY24+DQo+IC0tLQ0KDQpMb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
LWNrDQoNCg0K
