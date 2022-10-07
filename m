Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF1DC433F5
	for <linux-block@archiver.kernel.org>; Fri,  7 Oct 2022 05:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJGFih (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Oct 2022 01:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJGFif (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Oct 2022 01:38:35 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29EA115C2C
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 22:38:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yhh5r5CUJNWle48QM2iQmcie3uDt6iJDMOJHeZ3EEMi0m9qCl685ZIzWHJ8Ssz6Z8oaxtzHJZZYVBAXEU0RlUdKoLd4vSj7aUCDSOcoUx5Xmk53ccD0PN4gYajfasVEvJeYaqj7oUDRCT8nkXQZSIpT9QtDwQ8ie2Y9mhmOKuqmBafIdHwrD5Tdwnn8OychFD6OUF0XAtA7/eUgcbq1oXZ91OPknzimJ/qFLWjSaJK41fpcw33j0DFUKdrqiun3yyEakQR5JGGjTQXSpc+28FaauFLr5HLrmQuW1pLmWkSk2vTNtmG34PiA5RJaqhiGtHzDx0ehDsnwASVz04dnzNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibYqZxeLoo3vm/OvSUU+hpKFvLy65MYScdCcJWYi4LM=;
 b=cKXr+tJexnSDFNKPOmGfAnsc4m0WiGM4lhq6OYEb+CZH+35bHgJeSsH99mZSdbSTLW5q1oYpUcQWiW5KENB8bJnNAThxbtckPxIRMEisDBhdK52DgQ/2175NFix0gb001FHPugsOkK8s6qn9IunZgTtuNtDDJNeUbZeeDhGrBbnOlS05kpwnT/UoMdWMLUQ/F0nYf3iVFJ+jl815vSeHQAI6y0qoZvxwYwIsI4n9ncrejfc0BgkKGCUKnKXkTSQYTT6HluVfn0fax1O6c8jKw6xB9VE8TzJm4MrjcIlSuW+eNTmCLjEqZLtGgeaTqcFfIIo6CM94GDLChFCjjWhVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibYqZxeLoo3vm/OvSUU+hpKFvLy65MYScdCcJWYi4LM=;
 b=j9w0yFuJsTwxoAh7sSHiCTPydH3kFvhI2pDxQXX1HJpwKjdtcVFvDztDqHO3qy0Fd4A/3HOvcIaXC7eWAekfZF762HXZfDNQA+gLAAeDuWSwp3SdKUf3PDomLKFOr/bIthoFxT7ZSnPekLkkUOIUaizbF+qNGpZNWhGlXtFqRMr1v1lJIOKU6F40KhKLzQQ6rMo8+9YmQojQRLt1ZCSNqixJtZrp96Drz8dyuJyVdPk8SrhxmgzBrI27sdF+pAOnMmG4D2wwZ97Lb9lQB+HBOlYfUN2bXHry8lE3/kxLSrRwn/+r7YU12CvyvD+cQwSWnA/3u4OGDFIDsgT5loSWYg==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:102::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Fri, 7 Oct
 2022 05:38:30 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::a1bb:b25d:8309:27e6]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::a1bb:b25d:8309:27e6%7]) with mapi id 15.20.5676.028; Fri, 7 Oct 2022
 05:38:30 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
Thread-Topic: [PATCH] null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
Thread-Index: AQHY2UFEkIAKE36ytU6H0HwdEAigoa4A0sEAgAGYy4A=
Date:   Fri, 7 Oct 2022 05:38:30 +0000
Message-ID: <50136c06-498c-4058-731e-01938ad011de@nvidia.com>
References: <20221006050514.5564-1-kch@nvidia.com>
 <0ac14f65-d8ac-8d50-ccf1-010ec7bcaad9@opensource.wdc.com>
In-Reply-To: <0ac14f65-d8ac-8d50-ccf1-010ec7bcaad9@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|DM4PR12MB7765:EE_
x-ms-office365-filtering-correlation-id: 9d01199c-d725-4e06-436d-08daa8262a86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8iK5WJzzHqPz51TzWbCbhxoELIt35Om/AQQ54WIO1ZKsdPhbuBNsALTLvWyy/OQFRBd48SpRSYrdo4Ccrl/D+bi/2pVmSAjQKd64GrBy2LdNI3X5pn4gAizbL21ahw2LA/+g6hUxrxaKJjzBYhfkqJDVxPNZUAVI31krijiLf67RU9pTAOfaPTzNgccv0XEGpI7TmSnRqi6rah9QUK9EgO2yUyyW6N8YfaV4RKZ2QG8+hN/V85SFazStHYr6vwHp6k5tkU970MJchIV8XxrRXSTioEjbQ8323IMHzUlIEMhzKh7WG5/VgmCao8sthR3wmJIocikAfEJMOmxIPmxOF9fFhNY8kxZJoU7eSdIwtPBp5fRWVzcsVHXE1y6wsXWL+DDP4AjaN4RvTMSQPsknxdMejCY1towlVFQezxANODReIsPbszNdkCf7eLiZSQM+zCP8WQOz4QZRcIo4SpNmm9U/KQ98bZLTbc3tBTP5Sp6uI83RE/T3NdoReoe0drfY2ESTyU79tOEtfvVrkkmJkQ+0x/mbshGa8I5a15iIWtciPJiX5gPE6gHKpyxC97Lf8CynR5q9jESXFLydvMS4rgOY1hw7j32USAshzDb9GYjqFqo3eiOGL/mGimYrW4xJ8lkzeOgemTdMaQ8kHpT7oIigjyHy65gR+Ti68ZnZbzN6gYtUYUsoWiAyWB3ETrc9DGV76VuQwdSlz1QwDb4jKHZ+I/XPjEyvmog8TWg4bm1TKHxy/gas+BBezLFaI6RME1AT4g8gs8BdyQs/wweS17HJ6Kc3AdEF1fN7M49PUbRiY+owB2Yyn8Wwrjg1ajPMxPLuZD3KxZfT90/NHRofNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199015)(86362001)(6512007)(6506007)(8936002)(38070700005)(316002)(83380400001)(2906002)(110136005)(53546011)(36756003)(66476007)(478600001)(122000001)(2616005)(31696002)(31686004)(71200400001)(64756008)(91956017)(8676002)(5660300002)(6486002)(66446008)(66946007)(66556008)(38100700002)(76116006)(186003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ulc3L1NuSTA4azFGZW1UbjFrQjN1SXUzODZWUGwwc3hsb3pSdGFaeEE1eUNG?=
 =?utf-8?B?K1ZlMEFqdElURW96L2Z6TmpYM3RielNEa1I1aG9TOEQxSGxOYUYrSFlnRnNj?=
 =?utf-8?B?YW53cUg5T0ZWbmhmS3QxRFgrcm5oSnM2QmFtVm1UaVNKNmJueW9Fck1GL1Fq?=
 =?utf-8?B?azhVbzZKajdMcmRLU2NmVCtFUUNLK0pVMkJVeTBYekx3cWZxc3QwS0FCM3ZC?=
 =?utf-8?B?WHY4T2l3NjZOMWhoSnpLQ0JuM3lIZkRXQXlSZ1BPbDZqWXYxck9kc1FEcmpD?=
 =?utf-8?B?WSsrOTc4M2NIb3RYbXgzVEZkOEkyWHVrYjgxOVdZMmkvTys4UUpqYkFibHAz?=
 =?utf-8?B?YkhGUlNhVGwwSnZXVHBTL25aL0lkNUJZUmRiemhmYlZJMEpUdFk5dlkvK21h?=
 =?utf-8?B?OFBSQWhJeENvQkZBaW5wUUdFaExnTUVNMHZhZUdweXBZYnloQ3BTV3c1MUlY?=
 =?utf-8?B?dnlGRXpKZlE4bExjazVpK0NYTkxTUnVVRXIxLzE1d0VXWnVqemllZElHZEVW?=
 =?utf-8?B?bnhGckh1N3ZaLzJMSlJNN2JKOHA3aXRCOTEvRCtGS1dwd0FuWFVMREwzVjNa?=
 =?utf-8?B?bzRCRTJjT3h6YWhjc2UzYlJBcEdLbGJpOTA3WTZ3L2xuS1hEaUZ4ZTZRMGhD?=
 =?utf-8?B?Y21tS1JzTUdwZHZvaG1qaENyb0lwVzlpK1czL2plQVFlcWsyVTJKTitZTjRF?=
 =?utf-8?B?czdFYmp6d3hpR3VHZEIxTnZlU1hieStkV2FOZTQ4dnN2UE90b1NwY3l3ZkNj?=
 =?utf-8?B?cW15dVdnVHhtRmpuUmd5cEkzR1JWVUliU29rdExLWWZCRG9KL2x2RWhlV2Jq?=
 =?utf-8?B?dVRiaUQ5VUtmWlpSZUxJY2ZLYXJiTkFIeTEzZFRCcFFsQWRkeFlaZGRBWG9i?=
 =?utf-8?B?dE9qd3RmdnRpdnhScHAzb0VESmJBeTlmcGw0eUQ3dFlHYWNCWmxNRGtVbWdY?=
 =?utf-8?B?dU5mZXFVSlN6Y2NsKzIxVkxkQVloOThKUWpPQWJ5Ulk1MHdIOWlCMVl1Z3By?=
 =?utf-8?B?Tis5UmpzQy9iRjRNYmZlNWlBVWFLemZLU3VOL20zcmROQXV1U2ZPQWF4NVNY?=
 =?utf-8?B?RWg2blZWNHRxWWlKQnFYYXRZWitSSUY3SzArRmJJTjR3a3dyeTc3ZlM1TWQy?=
 =?utf-8?B?QUM4L29ZQWY1aS9mem5ZNUFtSmg1K2R3VkptU3RiSDd4SllDT09VM2kwYXlM?=
 =?utf-8?B?b1V3eWxXNkFyRmNnenBVR3lUTHBWTFhXMzBhTkl0SHpCemlHWldFTlh2SU9a?=
 =?utf-8?B?YUxkaEY1ZFJpRmVJejJYbnZmVFZxRWFGT2tFU284UVk5Q1FCY0gwcnVlREZU?=
 =?utf-8?B?NldQSDhLalRJUDZTMGlYallNaVVpNDlIa1BHaU9jWW1yQ2dRTlFQaUZXZ29U?=
 =?utf-8?B?V3MxdFpDdU9zZzhRREFqMnB3NnFENGQwdDFnMzAzYTNXZFRhRHBNTGh4a1M4?=
 =?utf-8?B?NStWTUNlSng0VVNVWHozTjAzTEVvYU9WQjBDTjNVbGZOYzdJMkc2b2FwNWJY?=
 =?utf-8?B?aWF4Sll1cVlBR1BHVlZVY3oxOFA2QlFrTkJ6ZDh6KzJpVXVicDN1WnViKzNz?=
 =?utf-8?B?ZGdKZ01TamJmSlY0cGdGOFNsQnhCVWlLU1pFZ0hiVjdncGNUVE1lUXQ2WUlF?=
 =?utf-8?B?Z2hCWmhYMzduaEx5OHJPeTdnVndqV2cxN01zNmFHT3Z3WXFVT3JSOVJVdUtB?=
 =?utf-8?B?eDdzMHpiVnZWb0RFVW9NZWYxNndqVTRLU1pua0hnRzk1NlUxTUpJOVZNamVD?=
 =?utf-8?B?K0VjWXAvdVMyU0M4YlJScG1tUWMvTWE4dDBQeHplNFl1NWQydmgzU1ZCVzFH?=
 =?utf-8?B?UG1JaVUwUUZobmVnMkhBenJkSS9PMW5OcWUwczlSYjJkTFpDWjhqZ1pzVE4w?=
 =?utf-8?B?c3k4V0dqdjUxSXZGVUhuOEIwZmhGSGxNVWIxdEZPbTNNUVBrOVAyd2tRQW9C?=
 =?utf-8?B?NFViRFJ6UGh2MnphbTcvVjVSQldXTE5kZHI4eXdiRGpocmFac1lsM1N4cVI3?=
 =?utf-8?B?cWwxbE5xLzBuNFVEN1RyVkQ2ZGdWSE5xUFRLVWNYR0xqT3ZQR3NhRE1xOTdG?=
 =?utf-8?B?SDF2SFp4ZVhzdDZnZUppbHV1OUZDV1FWcm1tbDg5TFM0YURyTm1UU2ZnZTQv?=
 =?utf-8?B?dnd0U0JEbENMSS8wcThvaEtsa3I4dWJsc1pFOWlDV014dzJtb3ZpUUlJSEZO?=
 =?utf-8?Q?m7rVcwNSm0y+uDVsToKc3CdvUguvfyh21BND80aAp5cf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91A3F5C5D919AD40BBFFD3AA868A7AFE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d01199c-d725-4e06-436d-08daa8262a86
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 05:38:30.1387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6s9cBD5pj4Fgz5cxKey4MHTO1NNOD2giMyjobDRW7B9TUJcNsviWjSUhWlDkVJazSLZt8PxbHuVx5GVig37O1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvNS8yMiAyMjoxNSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IE9uIDEwLzYvMjIgMTQ6
MDUsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IEZvciBhIFpvbmVkIEJsb2NrIERldmlj
ZSB6b25lIHJlc2V0IGFsbCBpcyBlbXVsYXRlZCBpZiB1bmRlcmxheWluZw0KPj4gZGV2aWNlIGRv
ZXNuJ3Qgc3VwcG9ydCBSRVFfT1BfWk9ORV9SRVNFVF9BTEwgb3BlcmF0aW9uLiBJbiBudWxsX2Js
aw0KPj4gWm9uZWQgbW9kZSB0aGVyZSBpcyBubyB3YXkgdG8gdGVzdCB6b25lIHJlc2V0IGFsbCBl
bXVsYXRpb24gcHJlc2VudCBpbg0KPj4gdGhlIGJsb2NrIGxheWVyIHNpbmNlIHdlIGVuYWJsZSBp
dCBieSBkZWZhdWx0IDotDQo+Pg0KPj4gYmxrZGV2X3pvbmVfbWdtdCgpDQo+PiAgIGJsa2Rldl96
b25lX3Jlc2V0X2FsbF9lbXVsYXRpb24oKSA8LS0tDQo+PiAgIGJsa2Rldl96b25lX3Jlc2V0X2Fs
bCgpDQo+Pg0KPj4gQWRkIGEgbW9kdWxlIHBhcmFtZXRlciB6b25lX3Jlc2V0X2FsbCB0byBlbmFi
bGUgb3IgZGlzYWJsZQ0KPj4gUkVRX09QX1pPTkVfUkVTRVRfQUxMLCBlbmFibGUgaXQgYnkgZGVm
YXVsdCB0byByZXRhaW4gdGhlIGV4aXN0aW5nDQo+PiBiZWhhdmlvdXIuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCj4+IC0tLQ0KPj4g
IyBnaXQgbG9nIC0xDQo+PiBjb21taXQgOGNhMGJkNTNhOWM5ZTJmNThjNGZjOWUzOGUzZjVmODJk
MjZkMzg1MSAoSEVBRCAtPiBmb3ItbmV4dCkNCj4+IEF1dGhvcjogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCj4+IERhdGU6ICAgV2VkIE9jdCA1IDIxOjU3OjAwIDIwMjIgLTA3
MDANCj4+DQo+PiAgICAgIG51bGxfYmxrOiBhbGxvdyBSRVFfT1BfWk9ORV9SRVNFVF9BTEwgdG8g
Y29uZmlndXJlDQo+PiAgICAgIA0KPj4gICAgICBGb3IgYSBab25lZCBCbG9jayBEZXZpY2Ugem9u
ZSByZXNldCBhbGwgaXMgZW11bGF0ZWQgaWYgdW5kZXJsYXlpbmcNCj4+ICAgICAgZGV2aWNlIGRv
ZXNuJ3Qgc3VwcG9ydCBSRVFfT1BfWk9ORV9SRVNFVF9BTEwgb3BlcmF0aW9uLiBJbiBudWxsX2Js
aw0KPj4gICAgICBab25lZCBtb2RlIHRoZXJlIGlzIG5vIHdheSB0byB0ZXN0IHpvbmUgcmVzZXQg
YWxsIGVtdWxhdGlvbiBwcmVzZW50IGluDQo+PiAgICAgIHRoZSBibG9jayBsYXllciBzaW5jZSB3
ZSBlbmFibGUgaXQgYnkgZGVmYXVsdCA6LQ0KPj4gICAgICANCj4+ICAgICAgYmxrZGV2X3pvbmVf
bWdtdCgpDQo+PiAgICAgICBibGtkZXZfem9uZV9yZXNldF9hbGxfZW11bGF0aW9uKCkgPC0tLQ0K
Pj4gICAgICAgYmxrZGV2X3pvbmVfcmVzZXRfYWxsKCkNCj4+ICAgICAgDQo+PiAgICAgIEFkZCBh
IG1vZHVsZSBwYXJhbWV0ZXIgem9uZV9yZXNldF9hbGwgdG8gZW5hYmxlIG9yIGRpc2FibGUNCj4+
ICAgICAgUkVRX09QX1pPTkVfUkVTRVRfQUxMLCBlbmFibGUgaXQgYnkgZGVmYXVsdCB0byByZXRh
aW4gdGhlIGV4aXN0aW5nDQo+PiAgICAgIGJlaGF2aW91ci4NCj4+ICAgICAgDQo+PiAgICAgIFNp
Z25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQo+PiAjIC4v
Y29tcGlsZV9udWxsYi5zaA0KPj4gKyB1bW91bnQgL21udC9udWxsYjANCj4+IHVtb3VudDogL21u
dC9udWxsYjA6IG5vdCBtb3VudGVkLg0KPj4gKyBybWRpciAnY29uZmlnL251bGxiL251bGxiKicN
Cj4+IHJtZGlyOiBmYWlsZWQgdG8gcmVtb3ZlICdjb25maWcvbnVsbGIvbnVsbGIqJzogTm8gc3Vj
aCBmaWxlIG9yIGRpcmVjdG9yeQ0KPj4gKyBkbWVzZyAtYw0KPj4gKyBtb2Rwcm9iZSAtciBudWxs
X2Jsaw0KPj4gKyBsc21vZA0KPj4gKyBncmVwIG51bGxfYmxrDQo+PiArKyBucHJvYw0KPj4gKyBt
YWtlIC1qIDQ4IE09ZHJpdmVycy9ibG9jayBtb2R1bGVzDQo+PiArIEhPU1Q9ZHJpdmVycy9ibG9j
ay9udWxsX2Jsay8NCj4+ICsrIHVuYW1lIC1yDQo+PiArIEhPU1RfREVTVD0vbGliL21vZHVsZXMv
Ni4wLjAtcmM3YmxrKy9rZXJuZWwvZHJpdmVycy9ibG9jay9udWxsX2Jsay8NCj4+ICsgY3AgZHJp
dmVycy9ibG9jay9udWxsX2Jsay8vbnVsbF9ibGsua28gL2xpYi9tb2R1bGVzLzYuMC4wLXJjN2Js
aysva2VybmVsL2RyaXZlcnMvYmxvY2svbnVsbF9ibGsvLw0KPj4gKyBscyAtbHJ0aCAvbGliL21v
ZHVsZXMvNi4wLjAtcmM3YmxrKy9rZXJuZWwvZHJpdmVycy9ibG9jay9udWxsX2Jsay8vbnVsbF9i
bGsua28NCj4+IC1ydy1yLS1yLS0uIDEgcm9vdCByb290IDEuMk0gT2N0ICA1IDIxOjU3IC9saWIv
bW9kdWxlcy82LjAuMC1yYzdibGsrL2tlcm5lbC9kcml2ZXJzL2Jsb2NrL251bGxfYmxrLy9udWxs
X2Jsay5rbw0KPj4gKyBzbGVlcCAxDQo+PiArIGRtZXNnIC1jDQo+PiAjIG1vZHByb2JlIG51bGxf
YmxrIGdiPTEgem9uZWQ9MSB6b25lX3NpemU9MTI4IDwtLS0NCj4+ICMgbHNibGsNCj4+IE5BTUUg
ICAgTUFKOk1JTiBSTSAgU0laRSBSTyBUWVBFIE1PVU5UUE9JTlQNCj4+IHNkYSAgICAgICA4OjAg
ICAgMCAgIDUwRyAgMCBkaXNrDQo+PiDilJzilIBzZGExICAgIDg6MSAgICAwICAgIDFHICAwIHBh
cnQgL2Jvb3QNCj4+IOKUlOKUgHNkYTIgICAgODoyICAgIDAgICA0OUcgIDAgcGFydCAvaG9tZQ0K
Pj4gc2RiICAgICAgIDg6MTYgICAwICAxMDBHICAwIGRpc2sgL21udC9kYXRhDQo+PiBzcjAgICAg
ICAxMTowICAgIDEgMTAyNE0gIDAgcm9tDQo+PiBudWxsYjAgIDI1MDowICAgIDAgICAgMUcgIDAg
ZGlzaw0KPj4genJhbTAgICAyNTE6MCAgICAwICAgIDhHICAwIGRpc2sgW1NXQVBdDQo+PiB2ZGEg
ICAgIDI1MjowICAgIDAgIDUxMk0gIDAgZGlzaw0KPj4gbnZtZTBuMSAyNTk6MCAgICAwICAgIDFH
ICAwIGRpc2sNCj4+ICMgYmxrem9uZSByZXNldCAvZGV2L251bGxiMA0KPj4gIyBkbWVzZyAgLWMN
Cj4+IFsgIDM5Ny4wNzkyMjFdIG51bGxfYmxrOiBkaXNrIG51bGxiMCBjcmVhdGVkDQo+PiBbICAz
OTcuMDc5MjI2XSBudWxsX2JsazogbW9kdWxlIGxvYWRlZA0KPj4gWyAgNDA2LjYyNjUwMF0gYmxr
ZGV2X3pvbmVfcmVzZXRfYWxsIDIzNyA8LS0tDQo+PiAjIG1vZHByb2JlIC1yIG51bGxfYmxrDQo+
PiAjDQo+PiAjDQo+PiAjDQo+PiAjIG1vZHByb2JlIG51bGxfYmxrIGdiPTEgem9uZWQ9MSB6b25l
X3NpemU9MTI4IHpvbmVfcmVzZXRfYWxsPTAgPC0tLQ0KPj4gIyBsc2Jsaw0KPj4gTkFNRSAgICBN
QUo6TUlOIFJNICBTSVpFIFJPIFRZUEUgTU9VTlRQT0lOVA0KPj4gc2RhICAgICAgIDg6MCAgICAw
ICAgNTBHICAwIGRpc2sNCj4+IOKUnOKUgHNkYTEgICAgODoxICAgIDAgICAgMUcgIDAgcGFydCAv
Ym9vdA0KPj4g4pSU4pSAc2RhMiAgICA4OjIgICAgMCAgIDQ5RyAgMCBwYXJ0IC9ob21lDQo+PiBz
ZGIgICAgICAgODoxNiAgIDAgIDEwMEcgIDAgZGlzayAvbW50L2RhdGENCj4+IHNyMCAgICAgIDEx
OjAgICAgMSAxMDI0TSAgMCByb20NCj4+IG51bGxiMCAgMjUwOjAgICAgMCAgICAxRyAgMCBkaXNr
DQo+PiB6cmFtMCAgIDI1MTowICAgIDAgICAgOEcgIDAgZGlzayBbU1dBUF0NCj4+IHZkYSAgICAg
MjUyOjAgICAgMCAgNTEyTSAgMCBkaXNrDQo+PiBudm1lMG4xIDI1OTowICAgIDAgICAgMUcgIDAg
ZGlzaw0KPj4gIyBibGt6b25lIHJlc2V0IC9kZXYvbnVsbGIwDQo+PiAjIGRtZXNnICAtYw0KPj4g
WyAgNDI1LjQ1NjE4N10gbnVsbF9ibGs6IGRpc2sgbnVsbGIwIGNyZWF0ZWQNCj4+IFsgIDQyNS40
NTYxOTJdIG51bGxfYmxrOiBtb2R1bGUgbG9hZGVkDQo+PiBbICA0MzguNDE5NTI5XSBibGtkZXZf
em9uZV9yZXNldF9hbGxfZW11bGF0ZWQgMTk3IDwtLS0NCj4+ICMgbW9kcHJvYmUgLXIgbnVsbF9i
bGsNCj4+ICMNCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2Jsb2NrL251bGxfYmxrL21haW4uYyAgICAg
fCA1ICsrKysrDQo+PiAgIGRyaXZlcnMvYmxvY2svbnVsbF9ibGsvbnVsbF9ibGsuaCB8IDEgKw0K
Pj4gICBkcml2ZXJzL2Jsb2NrL251bGxfYmxrL3pvbmVkLmMgICAgfCAzICsrLQ0KPj4gICAzIGZp
bGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2Jsb2NrL251bGxfYmxrL21haW4uYyBiL2RyaXZlcnMvYmxvY2svbnVs
bF9ibGsvbWFpbi5jDQo+PiBpbmRleCA4YjdmNDIwMjRmMTQuLmEwNTcyZTZjMjhjZSAxMDA2NDQN
Cj4+IC0tLSBhL2RyaXZlcnMvYmxvY2svbnVsbF9ibGsvbWFpbi5jDQo+PiArKysgYi9kcml2ZXJz
L2Jsb2NrL251bGxfYmxrL21haW4uYw0KPj4gQEAgLTI2MCw2ICsyNjAsMTAgQEAgc3RhdGljIHVu
c2lnbmVkIGludCBnX3pvbmVfbWF4X2FjdGl2ZTsNCj4+ICAgbW9kdWxlX3BhcmFtX25hbWVkKHpv
bmVfbWF4X2FjdGl2ZSwgZ196b25lX21heF9hY3RpdmUsIHVpbnQsIDA0NDQpOw0KPj4gICBNT0RV
TEVfUEFSTV9ERVNDKHpvbmVfbWF4X2FjdGl2ZSwgIk1heGltdW0gbnVtYmVyIG9mIGFjdGl2ZSB6
b25lcyB3aGVuIGJsb2NrIGRldmljZSBpcyB6b25lZC4gRGVmYXVsdDogMCAobm8gbGltaXQpIik7
DQo+PiAgIA0KPj4gK3N0YXRpYyBib29sIGdfem9uZV9yZXNldF9hbGwgPSB0cnVlOw0KPj4gK21v
ZHVsZV9wYXJhbV9uYW1lZCh6b25lX3Jlc2V0X2FsbCwgZ196b25lX3Jlc2V0X2FsbCwgYm9vbCwg
MDQ0NCk7DQo+IA0KPiBOaXQ6IFdoeSByZWFkLW9ubHkgPyBZb3UgY2FuIG1ha2UgaXQgd3JpdGFi
bGUgd2l0aG91dCBhbnkgaXNzdWUsIG5vID8NCj4gDQoNClNvcnJ5IEkgZGlkbid0IHVuZGVyc3Rh
bmQgdGhpcyBjb21tZW50LiBJbiBjYXNlIHRoaXMgY29tbWVudCBpcyBhYm91dCANCm5ldyB6b25l
X3Jlc2V0X2FsbCBtb2RwcmFtIGJlaW5nIHJlYWRvbmx5IGFuZCBub3QgYWxsb3dlZCB0byBzZXQg
dmlhIA0KY29tbWFuZCBsaW5lPyBUaGUgdGVzdCBsb2cgc2hvd3MgSSB3YXMgYWJsZSB0byBzZXQg
aXQgdG8gMCBhbmQgdHJpZ2dlciANCmNhbGwgdG8gYmxrZGV2X3pvbmVfcmVzZXRfYWxsX2VtdWxh
dGVkKCkgYW5kIGRlZmF1bHQgYmVoYXZpb3IgZW5kcyB1cCANCmNhbGxpbmcgYmxrZGV2X3pvbmVf
cmVzZXRfYWxsKCkuDQoNCi1jaw0KDQo=
