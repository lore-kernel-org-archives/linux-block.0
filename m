Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10CBC433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 09:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiBPJm2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:42:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiBPJm2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 04:42:28 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2044.outbound.protection.outlook.com [40.107.95.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E7727AA2C
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 01:42:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahwqlwtTKqs9fYNuCVN3wsUFD7a0RBxYKvtXBEhDDf9hej6Ojh6q/mMwxp3/7yezodzP8Af7fiuvdrLs+vn0qHa3gmYLRYrLYEKnWLD3i+xUZotUINczGtFMDtMsr4/fCbcdnT8cGXkU9Z+qXofsHtkmDvqXMAswICQycjtSHkh8cNXXbh9X6xK5vuQMXkqjvuUuuGEa2OW2UGUpEbtQwgX9E5jnZwl8vvo5wMv/eEccar8w0l4zbIEqfJJiuM+0utfLxfak7r5djpyCl+nn01xG//SWE2l8Z+y2Z97DOo3hiAaggt8sRGjsgOmQfbriUI/cSUuWXboaFD7MKJ5+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bjjWK3gBtT28pnCpviuI+Adblj4E/tpNHqoOQBMjsE=;
 b=GO7VifxdhlGoKi/jpG2ehnpdO1CnJJpCGqjoJutzNdFpm/p1imF6kL3maHU8FMWD/ztCAFedWpUEly3QyQsMCmSlRuHLN4QbvaAtyLutZ/LJBNI1mVizvTdpP4Dw/RubOsxbTyiepWPx9nnssHAflc5GQtHVYAppJXqz21F8NCK3A7R/b2zeKiRWfhyCYdP+N5bZGjgC6+QlkNMiWkzghdJ1JWS4YVCxBX2hXvvTb4/62/Dgh88ypFsd0Mo/A7yRXydYU9qgVCar9B4Y0egEwwIpbnhViuI+9ZPbYgZGQgTcuhiwMgmp1Jtv+NuixMw0f1CsvwX+ws+J9o3goVCpPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bjjWK3gBtT28pnCpviuI+Adblj4E/tpNHqoOQBMjsE=;
 b=M5Ugl6k9O5FhZOYbEQxTHyj0VWZVC6PC2NE64bOF2xgGSZJVD/nG20ZnwIfvq/YHe7V8r2dUnrllL6RYVBFAa3FCEaFEkX9bJAhYP6+pkzIfjIJmPaunxszU2lvEvPczdQaMOeXCmj8WnAxVpJCvY0sp82cJMS+AmxqiMM1WgvMy2BVnAlkPmM12sg1aXzt6Xt2l5i0kmJEQzu5ghIX+beAAMDdr5oaUmjzeJ9jWWdQ4PkgBY2G4jFu2wWYqmuDu6wo8xegj7BorZMNUulu2/fo6qOjUyQZaBCaDDYKsqsgc/biJpbTq2ijK33ssHignyqxPk85sw6sdflts8SLrWA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Wed, 16 Feb
 2022 09:42:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Wed, 16 Feb 2022
 09:42:13 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Haimin Zhang <tcs.kernel@gmail.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block-map: add __GFP_ZERO flag for alloc_page in function
 bio_copy_kern
Thread-Topic: [PATCH] block-map: add __GFP_ZERO flag for alloc_page in
 function bio_copy_kern
Thread-Index: AQHYIxE0/IIgYxhY8EW3m7YIWmu8s6yV5HiAgAADmgCAAAS9AA==
Date:   Wed, 16 Feb 2022 09:42:13 +0000
Message-ID: <5614fef6-c8a8-6124-9aa0-740ed4f80d84@nvidia.com>
References: <20220216084038.15635-1-tcs.kernel@gmail.com>
 <47002290-3064-7de1-25e6-0716a89b94c0@nvidia.com>
 <56F42AA8-8554-455C-8734-0716AB4FB377@gmail.com>
In-Reply-To: <56F42AA8-8554-455C-8734-0716AB4FB377@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d123a36c-6f09-4222-3f86-08d9f1309c3f
x-ms-traffictypediagnostic: BYAPR12MB3285:EE_
x-microsoft-antispam-prvs: <BYAPR12MB3285810BF9E6C1B40016D141A3359@BYAPR12MB3285.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EGxfXS0p9lkK5LV5Ymm6f9k9Evwh67PJZkqDW7HypeSPwSi+uuQ2nSbydzRNPqBzHt/Nk10P5z/a+VWIFPmWoCjT0hpBumE3Tr2imuY0Mk0r4+CUCZWPm2M58NT1AdtXJKRRjGWxqwp76lUOTqTqPuIMXOCgzm/kkuxAivBTTuAMqxoR8/FgCZsmaxHcEf/HEnzsa3whTmNYZwdoynkB8O66zbvxTeJj4nHHRJ1vCgMHlZFEBFyk5YcEIEH+1F5c6tP6KhZDUHW50k1eWH0MRQu/p6MQkSRfd2vCZikpkGxAVZBaMyN2W0xFjPMGJV+bwOCzua59hethfGi0t9UUQjiRWG7O2kl4MqeqdQUW13SAxBV03RpW9E7cdYIGylYTKk+x28B4OMHVyetXcN0JgpjM5aFbViU22WkaH8dKF+6lQPT2fpGZ/8CA1hDTSEbL4FDCWZ+30OP8bC2t1m6mpJUYHqsYFlgkhg9NnMVBW2VM72RWSXgtES0FzXF8wLxe49cNlI5WxKrgJCcxhk3yZqCS7Re9Yc74jM+Inc/vgmpypKHAZua9Je3k/ZESOby2RicsqnImpwoZdp4oNVJUIR/FfsMjT8gbUfrmR2e7LCLZvMbJjNJdvItUPkMyjztsUWWaWTauf0Uz0/4j97Jt/AF4OHIRISC9MddDWcEoV2D2ZtQcW2LTToTn878GdE0YLebjVlXvDtBtm1cZP2xb7vlzI+t2jJq7LQNs5C3ZS0cIHPK76l7vIoHkhyPhdpM7TnvvTeoURaOWBFDsXD26TQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(31686004)(6916009)(6486002)(6506007)(71200400001)(8676002)(36756003)(66556008)(2616005)(91956017)(66946007)(4326008)(66446008)(66476007)(6512007)(316002)(76116006)(508600001)(122000001)(5660300002)(38100700002)(186003)(86362001)(8936002)(83380400001)(38070700005)(64756008)(31696002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zm54VVF6MWRjbC84VTQ3QzduNklhU3hrQlZ4RTZxUFpvY1FaQUxaaVMvVjNw?=
 =?utf-8?B?QTJ0TnZESHNQNmpmb0ZkTldBWmtXZ04zNkNiMXFxK3AvazBMUVRQamV4RmJq?=
 =?utf-8?B?OW9OMDFFQk5WRXNyeDZtZi9NeXdmUWZLaUdkamIybmhQLzNVRkw0VU9aQ0dY?=
 =?utf-8?B?OUJWaVZKM1hKQW9Lc2NnZGNKMU1jMzBYUGo4QnpvekRtOUxrSUdqc1Q5bjVk?=
 =?utf-8?B?VmlGRmV2VEVPQnVQRTNLYjliVkpNMTkzMXBPQlJ1MEQzTGZSRmRZL3FmRld6?=
 =?utf-8?B?cGx4cHJHcnF1Rzd4K2FVc0ZuWEFZQmJtY0Z6Q0ZBMXFXM2VxY2dlVXMraWVI?=
 =?utf-8?B?bEVpcGo0clBQWW5QVENGNVcxT2xEQVpPQ2Q0TnZaU0RhSXdQZVNtRnloTENY?=
 =?utf-8?B?SGFwd1c4WHpWL2J6ai9tdVQ0R2ZsWHpNc1U2VlAra2NrYmQxalNrQTZ6UCtH?=
 =?utf-8?B?WlA2OUlpaU1sMTh4cU4yUXJkcVNmeWNlRGo3bnIxaWNwR2RTQm9XTld6WjBR?=
 =?utf-8?B?M3dlUVc0Rk1sZVRWRjRTbzljWlp1TTdLYUZISTNRQlEwZjBxajlDb3FKMUlN?=
 =?utf-8?B?MXI3ZUpLNWpYNTlkVDFpUGRVMWJOUUZuZTZwYXdUVHVzQ0NnajRwUWVCOEtK?=
 =?utf-8?B?MEtQNlVnSEdvVUlzOFE5cnEzdWZqRUFNK2lzbnY4cW9uc243R21zaGEzKzVr?=
 =?utf-8?B?UDVXQ204MyszRGRFSVMxcFdqejBORVRyVnJSS3BTTklqWW1peFh1RmpUNFI4?=
 =?utf-8?B?MVhhRjRWeHhoUVV0cXJvVDNzeTJvR1dkWDZRNkVRSi9vQmt3TC9GNVZ1RDdN?=
 =?utf-8?B?Rmw4REVyMGFrQnBOZXRWSkthNEVOK2FSQzZMeHc4SXc4Qi9LRndyZEwydGJD?=
 =?utf-8?B?SHZMbEdaTk9UYnlxU3haT0NRMjVIQ0piTkNUWjUyM202cDZrUDJ2bzRpK2d5?=
 =?utf-8?B?aitlZUc0VjY0MFNXY1BOTnUyNm41cUJuUE9QY29DeUFzNDI1cU43Zm96eUZU?=
 =?utf-8?B?VGJmdEIrelRHVDh0MHJtcWtoSEdxY3BySVpnelNhMDlrLzd5S3BZdnNDRytN?=
 =?utf-8?B?cHNBcFJLd1EwcGo4KzJkREJyV3BVcXg5bDR6UEpmOUtJYUFDTVlOZWhnZXN3?=
 =?utf-8?B?QzYzN1k2b2QwblJKL1NUb0ZmRG0rNTZYMmJkL2dLU0hnNzgyMmtEcm1yb2xQ?=
 =?utf-8?B?dHFxZGxFSEV0TkZPU051Q1NDbkdzTmhDMW5zV1FndzU1anQvYWswcklyK1Zr?=
 =?utf-8?B?Wllob292QkxISG5kSGd4OGpFNkh4YUpjTDVLSE1vNWM4QlpRamorNmxGK0NY?=
 =?utf-8?B?cDFPeXUrZ25FL2c2dlV1RUQvWmN3dW9kTnVhQ3F4eUxXdlByZ0dGTklSbWhS?=
 =?utf-8?B?ZkY4S1V5bTljWDg4SDFvRGlzR3NQVVZGdFVGZ3l0WERLUWxza0twemlGYldX?=
 =?utf-8?B?a2ZEaHUvSms3TUtNeTc5L2UzdUYvVmtzRlNiYzhFRFFSME04b1FHK0QrdHl2?=
 =?utf-8?B?TFZpTjdZVFc0a3lnZGU1dUk2c004L2QveXRPZFNOTkZGN0dXNnc0ZGZrQnZ4?=
 =?utf-8?B?UkdQMXBpNFpManB0bDhCN0hndDc4Rms2SzhBakZBdktWb01DTmp5YnRleHow?=
 =?utf-8?B?d3NaUDNrdUpVejAwbjJ3VUlQbEluR1BJZ3l6cXZ2L0g5alJ1Mk9ORC9FN2Rm?=
 =?utf-8?B?djlGUlBwV0xGMkZ3OWxBM0JISHRwZVlsSDNXQjA2MHQ0QW9lQm5aQmRhQ2tN?=
 =?utf-8?B?cUhVRHBreXZCZzhrZVpBb1VsVnRybWh4YlZEUTJpSEZVQWJzSWlOalM5WUhT?=
 =?utf-8?B?cnRLZGxyTDhYQ3lyMUswZVA5bEErNFhneXhlV1l2T3p0eHZwTGliMkhXaXlm?=
 =?utf-8?B?U1R0Y2lnUnc4TjRJMW5FZml5VkFuNlZ4SHdYZS8raXBlOXJ0eEhvaStWODQv?=
 =?utf-8?B?ZUp6QnZlT213dU5vWldLdmdXcmlKTUh4ZVJrV0hJaWFzV05nT092QjB6aERR?=
 =?utf-8?B?YnpkT0dFcWhpS3psTmRkNVEvVmxYMWtoRksxSDkvaENPdzRkY09WODd1ZW11?=
 =?utf-8?B?R0pjWitsQmVRM1kyUzgrMHp5eThFaE8xNFJYUFFzTVZPMi83MGVra2N2aE1C?=
 =?utf-8?B?MEs1WTF1dnJiUGtrcnZMQjBmUlVwdm54elBzM1lMVGVkZzRxazNvUGs3NzM4?=
 =?utf-8?B?VlZHTVNCdkZ5RCs2Z2dJeUdSSjN1aHF4TFJ6SGpYMlU5NXZoRXhUMXhWM0Jv?=
 =?utf-8?Q?ORkG7W9ghAO1HfeiIiRUkOqEuPddzEYCUsepp/dV+0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8912D76880C3804689078EF2315CA565@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d123a36c-6f09-4222-3f86-08d9f1309c3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 09:42:13.0657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eZhdX4svZRunRCgH8p5fea64bswcadWv5WSJK+uZgvbXd8jyA+5gJJKXA8Qg1YSwnIGwplbZc9k2Ez+FFBw1Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3285
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8xNi8yMiAwMToyNSwgSGFpbWluIFpoYW5nIHdyb3RlOg0KPiBZZWFoLCBidXQgSSB0aGlu
ayBzZ19zY3NpX2lvY3RsIGlzIGp1c3Qgb25lIG9mIHNpdHVhdGlvbnMgdGhhdCB1c2UgdGhpcyB1
bmluaXRpYWxpemUgYnVmZmVyLCB0aGUgcm9vdCBjYXVzZSBpcyBzdGlsbCBpbiBiaW9fY29weV9r
ZXJuLiBJdCBzaG91bGQgemVybyB0aGUgYnVmZmVyIHdoZW4gYWxsb2NhdGVzIGEgbmV3IHBhZ2Ug
Zm9yIGEgYmlvLg0KPg0KDQpubyB0b3AgcG9zdGluZw0KDQo+IO+7v09uIDIwMjIvMi8xNiwgNTox
MiBQTSwgIkNoYWl0YW55YSBLdWxrYXJuaSIgPGNoYWl0YW55YWtAbnZpZGlhLmNvbT4gd3JvdGU6
DQo+IA0KPiAgICAgIE9uIDIvMTYvMjIgMDA6NDAsIEhhaW1pbiBaaGFuZyB3cm90ZToNCj4gICAg
ICA+IEFkZCBfX0dGUF9aRVJPIGZsYWcgZm9yIGFsbG9jX3BhZ2UgaW4gZnVuY3Rpb24gYmlvX2Nv
cHlfa2VybiB0byBpbml0aWFsaXplDQo+ICAgICAgPiB0aGUgYnVmZmVyIG9mIGEgYmlvLg0KPiAg
ICAgID4NCj4gICAgICA+IFNpZ25lZC1vZmYtYnk6IEhhaW1pbiBaaGFuZyA8dGNzLmtlcm5lbEBn
bWFpbC5jb20+DQo+ICAgICAgPiAtLS0NCj4gICAgICA+IFRoaXMgY2FuIGNhdXNlIGEga2VybmVs
LWluZm8tbGVhayBwcm9ibGVtLg0KPiAgICAgID4gMC4gVGhpcyBwcm9ibGVtIG9jY3VycmVkIGlu
IGZ1bmN0aW9uIHNjc2lfaW9jdGwuIElmIHRoZSBwYXJhbWV0ZXIgY21kIGlzIFNDU0lfSU9DVExf
U0VORF9DT01NQU5ELCB0aGUgZnVuY3Rpb24gc2NzaV9pb2N0bCB3aWxsIGNhbGwgc2dfc2NzaV9p
b2N0bCB0byBmdXJ0aGVyIHByb2Nlc3MuDQo+ICAgICAgPiAxLiBJbiBmdW5jdGlvbiBzZ19zY3Np
X2lvY3RsLCBpdCBjcmVhdGVzIGEgc2NzaSByZXF1ZXN0IGFuZCBjYWxscyBibGtfcnFfbWFwX2tl
cm4gdG8gbWFwIGtlcm5lbCBkYXRhIHRvIGEgcmVxdWVzdC4NCj4gICAgICA+IDMuIGJscV9ycV9t
YXBfa2VybiBjYWxscyBiaW9fY29weV9rZXJuIHRvIHJlcXVlc3QgYSBiaW8uDQo+ICAgICAgPiA0
LiBiaW9fY29weV9rZXJuIGNhbGxzIGFsbG9jX3BhZ2UgdG8gcmVxdWVzdCB0aGUgYnVmZmVyIG9m
IGEgYmlvLiBJbiB0aGUgY2FzZSBvZiByZWFkaW5nLCBpdCB3b3VsZG4ndCBmaWxsIGFueXRoaW5n
IGludG8gdGhlIGJ1ZmZlci4NCj4gDQo+ICAgICAgYnV0IGJsa19ycV9tYXBfa2VybigpIGRvZXMg
YWNjZXB0IGdmcF9tYXNrIGZvciBleGFjdGx5IHRoaXMgc2FtZSBjYXNlDQo+ICAgICAgYW5kIHRo
YXQgaXMgcGFzc2VkIG9uIHRvIHRoZSBiaW9fY29weV9rZXJuKCkgdW5sZXNzIEknbSB3cm9uZyBo
ZXJlLA0KPiAgICAgIHNvIHlvdSBuZWVkIHRvIHBhc3MgdGhlIF9fR0ZQX1pFUk8gZmxhZyBpbiB0
aGUgc3RlcCAzIGFib3ZlDQo+ICAgICAgKHNnX3Njc2lfaW9jdGwpIGFuZCBub3QgZm9yY2Ugenpl
cm9lZCBhbGxvY2F0aW9uIHRoZSBnZW5lcmljIEFQSS4uDQo+IA0KPiAgICAgIC1jaw0KPiANCj4g
DQo+IA0KPiANCg0KYW5kIHRoZXJlIGlzIGEgd2F5IHRvIGZpeCBpdCBieSBwYXNzaW5nIHRoZSBy
aWdodCBnZnAgZmxhZyBmb3Igc2NzaSBjYXNlDQp3aHkgbW9kaWZ5IGNvcmUgY29kZSA/IGluIGFi
c2VuY2Ugb2YgZmxhZyBJIGNhbiB1bmRlcnN0YW5kIGJ1dCB0aGF0IGlzDQpub3QgdGhlIGNhc2Ug
Li4uDQoNCi1jaw0KDQoNCg==
