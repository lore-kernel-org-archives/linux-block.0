Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E07C433FE
	for <linux-block@archiver.kernel.org>; Sat,  5 Nov 2022 16:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiKEQf2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Nov 2022 12:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEQf1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Nov 2022 12:35:27 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A24B2037E
        for <linux-block@vger.kernel.org>; Sat,  5 Nov 2022 09:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jrn8IxhQmCHbjNvKv9ipyLJBfFT/bPTycizW0258WcNdELeM+ygzuWiK/zVu0WTzHmxwFqzv2oD2AeP+3FTY2AunTUQpRq0F5p+YfX7ITtYr7vitDbUxq789QpbfpZIE5UOD+Oakhxglw0NhTL9wIDpQnuD+5M3cx5dNq+3wFJWriyhxomELJCUt2oOnCKaUPqE3mVgPMdj4e6CJ1YoltXshtBriZYKJe9hoQzqjQp4K2KHy7pxZWGA8RNc/NmqO8ccu6+ojf4f924gi3YuKUGym1XVuHFT67Ie+o+FENTxWmwbR3L3wz4SlFCajJTd7ksyXbuPfs7UgiChjefbRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLajiQqTHISxJkKoCsHJG7O4WjuGUIyKIo81/U3cKsE=;
 b=JAzUh2UQf1VfgWyKpNOX3AUj1mHxbCoUxR4IkXP49fcjgcSK/l1Xn9cmLJBUOdYeJtnZDvwwCJXgV8cLkoVIq0+/0MsN4dfqdXqeAgSPiJdU58Pw8hTkziR9sz0ap9jqpBSqkIah9obiHzd3pFPuK1RNwZwMLQvb9Z90MinkRYgJNWVYpGYqbz6EW8WXm7ewZIMUbcQUlGZBeFuhXFHU8iu9a2VbzyHf+y2ca+FfThrOeeQQjURCuqHdS3u58STJSULuWtP8p23Ug6yveBEXdAtC6+BcKJafa8LsfuzBghgyZUDjunFx03Qb/uH46hayF3mvH8tC6ke3kwciBOCOTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLajiQqTHISxJkKoCsHJG7O4WjuGUIyKIo81/U3cKsE=;
 b=rqIzFSgxqkAD+HBVwcC/YB5K4B0lQN86Zhe0MykqckcmVIcj+5LJXcoWYMn+ckZK/uZkqnbI75wgn+34LqndIV0b62iT04gjEq76iTXJf9nHQGHyiPMXnMvfg07ObbbW/4z57kvoymupLZlh64FgqPiZ5ZqEz5xW6TxZrV/4Sej+4OMAdjdfgJVMqus0wsmVBusWACd+dFDSjejHLvNbcm8wdoi1RSl1R7svlGqHSHmIimNfNzT/bnXjRaX1GWWxvUf8B07pElzcDuJMratAxySqhr4kDkhXe9wqhMjp0P3vMSAkHogRM4LFcziq/51kb61JgrsK3Kutyye3vvl0vw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Sat, 5 Nov
 2022 16:35:22 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Sat, 5 Nov 2022
 16:35:22 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>, Vincent Fu <vincent.fu@samsung.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
Thread-Topic: [PATCH] null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
Thread-Index: AQHY2UFEkIAKE36ytU6H0HwdEAigoa4izReAgAgrDgCABFJrgIABWEIAgAAT3IA=
Date:   Sat, 5 Nov 2022 16:35:21 +0000
Message-ID: <6e55d37c-f7b8-0124-7faa-450c094eb6ce@nvidia.com>
References: <20221006050514.5564-1-kch@nvidia.com>
 <CGME20221027200756uscas1p206196106ee2224a7653f1f2bc7ba31e9@uscas1p2.samsung.com>
 <20221027200654.147600-1-vincent.fu@samsung.com>
 <6270de4e-9f4a-fcfc-c4f1-d0ede32352bb@nvidia.com>
 <20221104185124.181754-1-vincent.fu@samsung.com>
 <4299f618-af81-84e6-8815-f921a704696b@kernel.dk>
In-Reply-To: <4299f618-af81-84e6-8815-f921a704696b@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW4PR12MB7335:EE_
x-ms-office365-filtering-correlation-id: b732ed87-3944-4cf7-81fe-08dabf4bbbc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?cUZyMjNCd3FwNE05SVp2NTRTYzYzSWJZRWtEOEM1bnVVaEt6UVNFWWV4V2lq?=
 =?utf-8?B?S2VpTlpMVW5HeCs2MnEvNk9yckc4ME1WRkVQLzJuVis4d09hZHorMWI1cEpC?=
 =?utf-8?B?NHU2cU05eSsrMkY0alUrS0k2dGtTbVJROGVqeDlZd3J5N0VSWWM0RUtBa09u?=
 =?utf-8?B?ejlicU43Y3A2QmNZZ1dPblYyOE9sMkdsWlBzYnlJdWFaYktyZDg4NE04MzRw?=
 =?utf-8?B?YVdYZnk0TEJqc2xXcTdJbUo4WTlDK0pXbGdLdFBQcGNoaWd4Sk8wS28wREFt?=
 =?utf-8?B?ekRud3EyMWkwbDlyYy9FTmdhNFFKUVYxM2ZwUXBrY0M5VGJvVG03bmd6K3JL?=
 =?utf-8?B?dmJiK3ZiVkh3bGF5RWJzUldTbjZSaXFwVUZ2Tm5aeXJwaTNieEVzdnFrK2pm?=
 =?utf-8?B?Qk84dG1oVXc4MWN1TElHTkdSNGtwYmhVS0E0OU5kaUozcjRlTHYvMXZGMkZE?=
 =?utf-8?B?SDB6bHFrLzhrU2VnTGlmOHV2Z05YTE9tUDJycHFLdG9rQ0lRWmdYYjMveUxx?=
 =?utf-8?B?Z1NXbkVDQlJaelZGeVppTmwxVlluN1dOcWtobm1wZ0Zqd1JrZWwrK01lZnJz?=
 =?utf-8?B?dmt0THJKZkRPb3piaDBXMmE5cVJNTVVtUFdzOTNmUlorTXU2c2RxSUVuVllM?=
 =?utf-8?B?NlpWczRBaVZYSy9kanhMdU11UkFVczczZk1VdFR4Tms3UE1wdzZYdUVmNmhz?=
 =?utf-8?B?ajN6cWlSa2VXVVZLVm4vdG1Kc0NzNk8vS01UZFVHaHZvMUJTck0zNFZmRldP?=
 =?utf-8?B?OWtEMEhObEtPYVo5ZUhNNHJnVzVtYXpUVzlDdTQxSVZrWStLVitYT3o2SUU1?=
 =?utf-8?B?TnBVZ1VzcUlkNXMxSEw2L2pndHdid011a0JZVVM0RmljSDI0dGJvaUgxeFNR?=
 =?utf-8?B?eG5DaTBzVjdRV1R3SDJ4dUNUeEtDOG8xYWlkWVRXcHBhbGNWbHozcE1Nb2t2?=
 =?utf-8?B?bG5rSjJjZDNSc0VPTjZhejRydlFTSUNlckVkT3JjSUc2eUhDeHhBUytjUFEy?=
 =?utf-8?B?THRORDYyQTZ6M0NwMVBEZG9XaHRBdmJvQWp2UGRoWDAza3Bndm9PeFUvZzBq?=
 =?utf-8?B?MGJweUpQQXJqaGNWYXlXejFnWDI3MHBtUzhzeHhxdEZza1BPYWdBb045dW50?=
 =?utf-8?B?Z1ZsYkNyQjhJditnM1JjVWtBVmVsZEtkcVJ6NCtjNzVIanhjd0tjQmE4Mlky?=
 =?utf-8?B?QStyb0JPWnlGeFJod3pBZmxlbDRKeTdPWElpU2JJUTNBR1ErNDNmUGQ1V3V1?=
 =?utf-8?B?R1RJRk1venltTHZyVzFRckF4d2Npc1pmSmUvemJUYXpLb0Vtdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199015)(38070700005)(31686004)(478600001)(6486002)(966005)(71200400001)(122000001)(38100700002)(31696002)(86362001)(6512007)(2906002)(8936002)(41300700001)(5660300002)(36756003)(110136005)(316002)(4326008)(53546011)(83380400001)(8676002)(6506007)(2616005)(186003)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amwrbmVQZ2pSdkorZHhudzMrbGJZZjZQT1BGc3F6bmdCa3FiUXpiQVM1Nnps?=
 =?utf-8?B?ZXRvaEw3bElyaHBDbnA0MjkxWTNnNHFSOWNJcnBueklzVDIxZmtEMGZwMHlZ?=
 =?utf-8?B?azI4T1k4cXo1WWkxbkZITzZaaHVWYnlpdllPZmovRHdtUiswZzU4Rzg2M25P?=
 =?utf-8?B?U09QSmdPTS8yemMwZFM1M1RCRkNuTkt1RWtjbkxxb1RsUEJBVXhQaHpnNjdk?=
 =?utf-8?B?bnkzWEFKSEdRU1hYT3llOVVaVWVMYmZqZUF0MDd3aGs3ajBjYU1oUHRqcGd1?=
 =?utf-8?B?VTFicFdkL0ZiVlJZeUU5aUZ0VDV2Wm5QUVgwT2R5dzlYWmdMMUJQOE16SWxC?=
 =?utf-8?B?ZitzcXV1MVhRZUh2akU4VVJydml4Ynh1WjVRWE9ha2lKbjQvendBV1FzTllT?=
 =?utf-8?B?OGJFVFFUaVdpeGNEUkxRMHk5MzVuMDJBU0plTldVcExrVGFKb2FOS2wrbWQy?=
 =?utf-8?B?NDJLTzVRN2NYcEthV1V0cnMrY0NsQm43dm5qL3RBQS9mZ0xnZzBjVHlJZmQ5?=
 =?utf-8?B?WkZneW1RWTBJcEdmUTZSKzM0cjNubVN5ZDE3RTB6OEhFWTcyTS9kUkNPSE9Y?=
 =?utf-8?B?NllzQStxVVlTVWFCN0U1SlBMRG93cWNrQzZFbmQ0TzJMdU13a3A5ellpdnlW?=
 =?utf-8?B?di9XeWtoRzJYR2ZsVDk5dU84dGpDQVdBcFRqMUIxeTlUT0VTZFhsc3hCbUUw?=
 =?utf-8?B?NkJGbjRMbmd0SkpxZEw1M0xOMWR4eGF3ZWdNaCtMaUx4OFI4djQ1WFVFakha?=
 =?utf-8?B?Y3FRY1ZkQzVpUEtWMXFveWVwMFVTQitSUktLZCt4S2xWb3VXWXRyazdFb1lM?=
 =?utf-8?B?U1hFamNIdDV6UDlDd0xXT3drMEZnVWduVGZrV3RTeVNvVStLd0lSZTY0S0Z4?=
 =?utf-8?B?L24xdTZOQ2hqcmNiWTltVi9VZTJ0L2tmdU9SSEpHQWZaaEhxMlFETlVpSURy?=
 =?utf-8?B?cEdPaURFR0xSZU1COFBJTTVOSkp1b3lINy9DcTlvdVQzclpuZ1JUa2FQblh4?=
 =?utf-8?B?WXR0WXBJRkdJaXRnbDV0bTlobjQ4azFqT1VJck9CYnVMcjVHWWJUYngxY0Q3?=
 =?utf-8?B?YVJnSjRzeEtZVlpDSTBwTyswN2J2cjU1VG9UTFRJMFp3UFkvTlY0RTVtVUR1?=
 =?utf-8?B?TFJIY1lXbkVkN3o1YUVTUUp2c2JFTlNNdXNIRCt3VUdjZDYyUTFDUVFvd0E5?=
 =?utf-8?B?VE1vSDFDc0p2MDVmVFlHdkNQa1FkRjVBMGtnQ1NiZVRXeUhNcnIrMngzRGF2?=
 =?utf-8?B?cEgwbU43OEtkYzBiMFJRUlp2OFNXZ1RPeThRMzcrUFBGR1ZSeHMyeHZabXIx?=
 =?utf-8?B?SnZ1ejFXekw0QmtrYlFlYXNwd09sS2dETlNtZ05ELzhaT0hlT241bjQyaWdk?=
 =?utf-8?B?L1dzK3RYUG9Tc1RrUGlVOTM0MmZkSThvZGtPRFNRbkFocUkvWXU1S0tNd2dR?=
 =?utf-8?B?TkJBUlMvdVdFeW9HdUlMKzJ3UWhLTTlUUUtQcG5LM0w4b0k0cGhkeFpvZXNG?=
 =?utf-8?B?cHpqUjIwak04SUtzYUJNN08zVTJXMi9qSnlRaFYwMTJqeUdBRFFxYW9zNUxl?=
 =?utf-8?B?alZqckJSSDU2N2lWUUltbHZBUWNESUp4WmF3bHd5QmNoOWxmSFFYdDhQL0M3?=
 =?utf-8?B?aHV6QXFEYVRzaXNzeFNLUzlCMFFBckpyaUtjMUxGNWE1SU8rMTdLN0QyVmZp?=
 =?utf-8?B?Z2N1UTJZWXd1T2xqSHdLZjByVHB5OTl2S0JFeGRtRUlKUENwQWxTWmpZTG83?=
 =?utf-8?B?cnhlNnkrYloxbTJKa1UrbnVqZjQ5VDRLY3BUZ2w2MXN2VkJ4MWdsbTFvUFZG?=
 =?utf-8?B?MXJEa2I2OXdwYms0VWJRZnZQRndRb24xSk9mZUJRY2FHdzFndkpOWXF0TlV4?=
 =?utf-8?B?OEdWNlZlMzdoOGs3THQ5V1hVSmhEVFhYSk0xMGc4L0Q3dnZ2Q1d5YkRMRlRT?=
 =?utf-8?B?SDlmNElnKzZ6MTczZHBDSExmV3lCbzVQUzZHYldBeDh4YWFjSzVLdVlYZXZG?=
 =?utf-8?B?cW1IMjZ5Zm8vd0xuNHpJSFY5d1lyZHBxTm85blF6S1lLU0ZNWlRkT3ZyYk9E?=
 =?utf-8?B?d24zUW5OS1JTNnNnWHBiVWJrSFVlbk9DZFpDM3dqYXZETjVGUUNqZnp3c25r?=
 =?utf-8?B?UVZYNmZMU3M1RlZ0OXVZUjhYYmEvUHFhdlFwTFFyTlZzc3RPS2FQZW94TVBV?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D77B02440347B49A6973CCE653AB0CD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b732ed87-3944-4cf7-81fe-08dabf4bbbc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2022 16:35:21.9744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8yEP0iO5XPI9qTuJiQQi21WMNBbTnOwqvDO0lxnSSQ5CHZ9sxQb+XvoLl8rzJyZcpFBzb3QYgaJTIKv8SEMBYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvNS8yMiAwODoyNCwgSmVucyBBeGJvZSB3cm90ZToNCj4gT24gMTEvNC8yMiAxMjo1MiBQ
TSwgVmluY2VudCBGdSB3cm90ZToNCj4+IE9uIFdlZCwgTm92IDAyLCAyMDIyIGF0IDEyOjUyOjA2
QU0gKzAwMDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+PiBPbiAxMC8yNy8yMiAxMzow
NywgVmluY2VudCBGdSB3cm90ZToNCj4+Pj4gT24gV2VkLCBPY3QgMDUsIDIwMjIgYXQgMTA6MDU6
MTNQTSAtMDcwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4+Pj4gRm9yIGEgWm9uZWQg
QmxvY2sgRGV2aWNlIHpvbmUgcmVzZXQgYWxsIGlzIGVtdWxhdGVkIGlmIHVuZGVybGF5aW5nDQo+
Pj4+PiBkZXZpY2UgZG9lc24ndCBzdXBwb3J0IFJFUV9PUF9aT05FX1JFU0VUX0FMTCBvcGVyYXRp
b24uIEluIG51bGxfYmxrDQo+Pj4+PiBab25lZCBtb2RlIHRoZXJlIGlzIG5vIHdheSB0byB0ZXN0
IHpvbmUgcmVzZXQgYWxsIGVtdWxhdGlvbiBwcmVzZW50IGluDQo+Pj4+PiB0aGUgYmxvY2sgbGF5
ZXIgc2luY2Ugd2UgZW5hYmxlIGl0IGJ5IGRlZmF1bHQgOi0NCj4+Pj4+DQo+Pj4+PiBibGtkZXZf
em9uZV9tZ210KCkNCj4+Pj4+IGJsa2Rldl96b25lX3Jlc2V0X2FsbF9lbXVsYXRpb24oKSA8LS0t
DQo+Pj4+PiBibGtkZXZfem9uZV9yZXNldF9hbGwoKQ0KPj4+Pj4NCj4+Pj4+IEFkZCBhIG1vZHVs
ZSBwYXJhbWV0ZXIgem9uZV9yZXNldF9hbGwgdG8gZW5hYmxlIG9yIGRpc2FibGUNCj4+Pj4+IFJF
UV9PUF9aT05FX1JFU0VUX0FMTCwgZW5hYmxlIGl0IGJ5IGRlZmF1bHQgdG8gcmV0YWluIHRoZSBl
eGlzdGluZw0KPj4+Pj4gYmVoYXZpb3VyLg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IENo
YWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQo+Pj4+DQo+Pj4+IEZvciB0aGUgc2Fr
ZSBvZiBjb21wbGV0ZW5lc3Mgd291bGQgaXQgYmUgcmVhc29uYWJsZSB0byBhbHNvIHByb3ZpZGUg
YQ0KPj4+PiBtZWFucyB0byBzZXQgdGhpcyBvcHRpb24gdmlhIGNvbmZpZ2ZzPw0KPj4+Pg0KPj4+
PiBWaW5jZW50DQo+Pj4NCj4+PiBJIGRlbGliZXJhdGVseSBhdm9pZGVkIHRoYXQgYXMgSSBkb24n
dCBzZWUgYW55IG5lZWQgZm9yIGl0IGFzIG9mIG5vdy4NCj4+PiBidXQgaWYgaXQgaXMgYSBoYXJk
IHJlcXVpcmVtZW50IEkgQ2FuIGNlcnRhaW5seSBzZW5kIFYyIHdpdGggY29uZmlnZnMNCj4+PiBw
YXJhbS4NCj4+Pg0KPj4+IC1jaw0KPj4NCj4+IEkgdGhpbmsgdGhlIGRlZmF1bHQgc2hvdWxkIGJl
IHRvIGhhdmUgZmVhdHVyZXMgYXZhaWxhYmxlIGFzIGJvdGggbW9kdWxlDQo+PiBvcHRpb25zIGFu
ZCB2aWEgY29uZmlnZnMgdW5sZXNzIHRoZXJlIGFyZSBnb29kIHJlYXNvbnMgdG8gbWFrZSBhbg0K
Pj4gZXhjZXB0aW9uLg0KPj4NCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJsb2Nr
L2YwZGFkYjYwLWMwMmQtZDU2OS0zMDA0LTgxZWFmZWViYjk1ZkBrZXJuZWwuZGsvDQo+PiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1ibG9jay9jYTIwNjIyMy0xMTJmLTJkNjAtMzRhMy1i
YjdlNjI5NWRlN2FAa2VybmVsLmRrLw0KPiANCj4gWWVzIGFncmVlLCB3b3JrIHdhcyBkb25lIHRv
IGJyaW5nIHRob3NlIGNsb3Nlciwgd291bGQgYmUgc2lsbHkgdG8gYWRkDQo+IHNvbWV0aGluZyBu
ZXcgYW5kIE5PVCBoYXZlIGJvdGggYXZhaWxhYmxlLg0KPiANCg0KSSB3YXMgdHJ5aW5nIHRvIGF2
b2lkIHBvbGx1dGluZyBjb25maWdmcyBzcGFjZSB3aXRoIHRvbnMgb2YgcGFyYW1zIGd1ZXNzDQp3
aGljaCBhcmUgb25seSByZXF1aXJlZCBmb3IgYmxrdGV0c3RzLCB3aWxsIHNlbmQgb3V0IFYyIHdp
dGggYWRkZWQNCnBhcmFtZXRlci4NCg0KLWNrDQoNCg==
