Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EC6C47088
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 23:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiK3Xb3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiK3XbH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 18:31:07 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14F1DEAE
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 15:21:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYwzzBJJeTEoz+kwpxX4dpNMIGUzKEPcgsSBhavMtyQgTsSegZYynw6GvTU8W6dSJJkepy7fNGXu5+VKCX1FSYE9vOrjI2MFFpelruO/TRUHTKavg6MH/rqH/057yIdPtwD33fkmG87EKLwAK8nFK2dmGbkKPtNPHbEe6dVsqUREIgI43vZbbbaNQwfDLGsciDDZeRmIIuQ+dVn2UVphQ9AJlr7XsajjSqM4/QM/lrQX939t+PigCXNKd4dpE5EoaXVN9nZOuvJIahOBN4sXc8YXyhiIxh3jK1mqSRvNww13Nq0eEskkUdfeZC7CxtYkkpcm52ysgeHOR17GfITm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBTEzjLvv7DFwMiqBcDC0tbRuyv4tKx7qoxmGWKAzng=;
 b=QC3kRPUb98qAhIG60E2vuN9OSJfLuMsXOv7YWXIHKw46Nt94O6O70T7CN2hETrEhTMkFYeigaSQD4TNenYW1dylhs6jn0ntiV6d5uBW4x8HGvrk7grGZN1b/J114TQzkMJ4sa9fUfm9mh65Ml+DqIxn7hYXN3lEJ1eZoAcSXZ74QEwAnc/UAGBrU3NVEB+jOoFOE+QzEdDx+4qz1VG5WVXCzal5Xf0tFYl7Pf+p+RFFkvLuaTcGTBvA2l847MZfPTfn8Oue32jR0nWti60mlfUwgY4/Xiz9uPl1O0iT2/d0A6C30puszFgXmm+Jda7u5K2PZYNNyc7vIlEWbHxRzdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBTEzjLvv7DFwMiqBcDC0tbRuyv4tKx7qoxmGWKAzng=;
 b=MwxaPfYMk5Bn98NW3yy+qRV9u7CQ0yV8LTm7RJioqorxOjUXspC1i1Ttx54CMA5LTFEtLxpzidJWNzG+ypiwclrwiIbl7PmfwF0qYbNPDToXw+t6C/qB8kVji0v/SYu+m9sKA4RUCxcMRmVXNOnm8PgkD27v6yn31K63VrHaskqlzJLsCoP4ueaHahxe03a9QRcX8qQSRCw7XITqjg40HY/hRD1gPAvkCN6E80b0gVcIUJLaZ8svwpUKtQvX1TJVyJgn56Dvi1jBR+QUG20CRKmZ+WB7Tg6t6dEnmJZtGXvsfVt7wSVpC6NxVNFuXnxqceoMXxBDD1RvxL9XH86YiA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Wed, 30 Nov
 2022 23:21:31 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc%7]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 23:21:30 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Pankaj Raghav <p.raghav@samsung.com>
CC:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] virtio-blk: replace ida_simple[get|remove] with
 ida_[alloc_range|free]
Thread-Topic: [PATCH] virtio-blk: replace ida_simple[get|remove] with
 ida_[alloc_range|free]
Thread-Index: AQHZBLe0LOzhdpcm9km+QeBo3FPe565X8ZOAgAAp8QA=
Date:   Wed, 30 Nov 2022 23:21:30 +0000
Message-ID: <96fc644e-e5f2-7dae-f81d-fa970c0f8bc7@nvidia.com>
References: <CGME20221130123126eucas1p2cd3287ee4e5c03642f1847c50af0e4f2@eucas1p2.samsung.com>
 <20221130123001.25473-1-p.raghav@samsung.com> <Y4fCS2d2r1YvSExI@fedora>
In-Reply-To: <Y4fCS2d2r1YvSExI@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA3PR12MB7859:EE_
x-ms-office365-filtering-correlation-id: bb735481-fe85-40ef-f6c4-08dad3299d0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tFYOnxYvLg52fhykfFyJSaEm3jOUJHDK/XRNlwmQRT5vu/7YE/FJhHEVy9cqXgAUmtW4U06VOPWDl2qq/TiRSubXGT84dWVsbu+627loCp/yhEC8H9eZPgy2o1Wj7R5NnzZou2WcVmCNERYrNtivAjeKdRxIGsJPjkVKpLsUdycnQZHmmK1kuptaRPA5Ysbj2t0zGO0E9lWjcYiVD9PHQziSqO8v3x6znp98EAeG9Uiw7NToGYq9+aLYR/PI0ltJO6Kthw98ilB+PZ7W+gj+q097AcO9DokomAHQeVriqQR3OQ73Hv+YZTxvNf7dT15vwkmDgsKS27YAOpTXe91Ns43M8yJWif6C+LShMpzy8PhdRiCW+D/ANFkf9dNHtcqnTAa1fiFUfYdHU1trvMGiGxZkcrBMxdryHqZyuDfhVQY9F8Jz9hsItDxNoCzPKqJ9acMTfeFJPva2v1HNl2PgsPECvPVfTZPCbKoRri1N3O9WxV1z1mt0VJ0+DMbL77U19/b1/2PB4urY06LmTQlmqSW1Y9SFJSgtCkAOiZ7ISMUvIGdMCFPeEIY0HcsGtdQfars+dnDLrkN5lzAPEKHNmm5d4Zvc0OvnyUU02NBuUGoCX1SUxMT+86vWnGM6HFz5iyIsOHhGT729SXp6g+UcPNCIzns2sivXLQo46dxCIALYKrqrVhFsM8kDlBGhTEKIjzcsNdJKYaREwN6ZocFrmx3iR/W0bgFdoXdiiXXNun7tJW97JTaLLdkNiycx40rcHvdQoRcGFEH0MdqPsfE3OfmWBaGt9MDhnnWHC4biomPH9+aGWP4cgmkJU1tNlex8mxnrysHVm0Ti749s0uHtSAE83mOb77F35rV4B3+9bZc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199015)(6486002)(122000001)(38100700002)(31686004)(2906002)(38070700005)(478600001)(2616005)(6506007)(5660300002)(186003)(107886003)(31696002)(86362001)(71200400001)(8676002)(6512007)(91956017)(53546011)(8936002)(7416002)(76116006)(66556008)(64756008)(4744005)(66446008)(66946007)(4326008)(66476007)(41300700001)(36756003)(966005)(83380400001)(54906003)(110136005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1BBZ0c4SUVPc3BKYzYzTlp0aHN3UXVqc0ZmekpYQnU3OFVwVjU0ckdLeGtZ?=
 =?utf-8?B?Wk9RNEFHY0E4bE4rTTBWbnVsQ1FRTytrVGxUNGNQYUZzd2QwK0RjVXY5KzFE?=
 =?utf-8?B?UC8yY01hYVhUWkFWQUMzcTdoWUFhSXh5Z2p3Yk02bitjRjMwRlZaRytRNkRC?=
 =?utf-8?B?R3U2d1o4U3FYbG1IZjlIUFh6MVdLVXg1TjNocGJMVmhJTTBYSWkyMGJtdGxy?=
 =?utf-8?B?aGZGUkZUS2tSTkhnckQvaURxWWZUZWFnTWUzdnhpYVE0TlBUKzJpRUM2dXF0?=
 =?utf-8?B?SnhBNG5xeTk3SjBaY0V3RGw2ZUFPajhhRmFTZWc5cmx3K3FSaW90K2hXS1cw?=
 =?utf-8?B?K1ZVaGZQQ2pwZjdxbTRKdFE4KytCOG92MGgwWFpWbTg4U2pIRWxvNFZDZlFK?=
 =?utf-8?B?azBNQ2NuSCtocWUzRk9aM0p4YVlBM0RQdm5jNmdXU1dobk5ZeHd5aGwrcWZp?=
 =?utf-8?B?cGZZa1pTNDNrWmIzQzErNFovek52eW9PeUxaZ2ZhWU9tR2g3TC80UG5PbUs2?=
 =?utf-8?B?b0h0SXVIZmxzR21zTUw3UGFmWGtLS2xOZDJpM0paSXBZMm1zeisxMW0vTTRO?=
 =?utf-8?B?SVF4Vm1NMEtmdWdsNjJNSXlBWStJdkJnQ2d0YmxmRDcra0FVK3ZUTGQvSlNJ?=
 =?utf-8?B?N2pJNlZuOVpIb0FhMWxscnBHbURMNEVxcWxDWjRnU0UzZGZXUnpFcEVUS3pH?=
 =?utf-8?B?WUR0Ym9XYTBQQmR2Yzc2R21WV1o4VXptM2lJa0xNM2owL0UrMEtWWUtTdVVs?=
 =?utf-8?B?ZUdoR2pmQjQwdU4xcDFXb2dKYzFvb1FKSXNkL1lOQW1XcXVyWW5lT3VrUmFU?=
 =?utf-8?B?RVlNYWcyME0rWVRUdXgzekw1c2Mwa2RDRkRyQlFkcUhJU1hxTDlWSmd0RzBS?=
 =?utf-8?B?U1FoNFNRVTZSOU1ZdDRWMXdyajNUWW91a3YybkdaTmx6Wm5GR1lNdEI3SlUx?=
 =?utf-8?B?NkVQbmxYV1Y4aXhRMmM0Tzh2SlFNcnJUdk1Ma1VZZkZVdVNtT2pNbkNucHpE?=
 =?utf-8?B?S2kzVnJXUDNSUjFOSFF1UDg5RnZDR1dlTDJFUUhVMXJYYm53dUxvLytOVDFz?=
 =?utf-8?B?NjltQ1J4VW5jWXpXWnpZRzVITGg4MG5KdkRLWWZ5cGdpdFd0V05TVnpPUUtX?=
 =?utf-8?B?clNiYTdrbEs2alRicTBISmp5Y1U4QTJwTG9TK1Nwby9pSEJtWEkzMDIxanVC?=
 =?utf-8?B?Qk5DNWt3dVRBQXFEWWNTUDVxQVptSzNFdzhIYVYrYlo1M0NTZHg0SjgyL0hp?=
 =?utf-8?B?a0tjak91WkszNHJuVWR2T1R3eXlLanFsNWhUdFJYZjM2YjlFSGZDcHRmOGll?=
 =?utf-8?B?MjY1Q0x5YU4wSFROclBhcTNZeVRiL1dKWS9qNG42OEZER0psVGJuZ2RZbmhF?=
 =?utf-8?B?T2xaRjFEKyt0QTlKYmNXMndMaDdaeGk5cDhEV0pkRU1XczFoeEVyR3ZlQ214?=
 =?utf-8?B?VktWVzF6TkxVSDNOWENKTHo2RGQ2RDZlbm8yM0E0bXl1blVxek50Q09waVFN?=
 =?utf-8?B?N1V5MFkzVzJjRGJpUnl3TWxxVXVscXUrN2JnYVZoRm8xNXp4czY1cEpMY3Q3?=
 =?utf-8?B?YTJWZnM2NXI0MkdlZGhLRFZCdnhBWGVYSG9XQmVQa1hqck1LWGZWMXFYbVZn?=
 =?utf-8?B?d2xvRzkwZ1B3eDUyNEg2YTFnUXpVaFVhWXVHOWxveFF4Qys3MUtJdHJReFAv?=
 =?utf-8?B?S0xMTWF4WUNyUlY4aC9NMjI5SGFxL0syOVJuczFNZU9aME1qYXRsbk9BWGpG?=
 =?utf-8?B?cEtmYmR5bGJBRlNKK3FoVXFweENuZ3AyMUxua1ZSSEpuR1VWQkhpQlhNcUNq?=
 =?utf-8?B?eEVsdmNnL0laVUFoYmtPVGZ4anlrRTVzQnR0UTFtWFB3YUJLYlNoa094bTdh?=
 =?utf-8?B?cy90dVl4TVNhVnB1eEkwR2l1QXNXZWdjeVB6QUl6cWdzWTZIS1NpM1RjektG?=
 =?utf-8?B?THZ6TGM0WW03QjZrWUFmNDBiMksvUm9RNXRDS3FjVEhDVWFwem5PQlVOQnZN?=
 =?utf-8?B?dFhzaHAzUk9RdEhRcmtaR3p3dmo3TXE3RGo3OFpybWJkR0RHdHpUcHBabHNw?=
 =?utf-8?B?cUYvL1NFOVlZZ0QzREZFRXJCVzdoSzFsVk5WMFIwMVFnZkNxbEtVZDhHNlRN?=
 =?utf-8?B?NE5VdC9TY3c5T2VPSUYxTmVJV25jbnJENTVLaWcwZDlHcVQ2bjJabFE0WDkv?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2650F1933E91094C8CDAA252BF0A3BF5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb735481-fe85-40ef-f6c4-08dad3299d0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 23:21:30.8051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XONIsVZEBM7/F/uxgCv4kWwOgUfyyLmWvbbMICPQL71eJwFmOFrIFajbMmxn5Hh9PwP4uTu1QOC5HRC3pYuU1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMzAvMjIgMTI6NTEsIFN0ZWZhbiBIYWpub2N6aSB3cm90ZToNCj4gT24gV2VkLCBOb3Yg
MzAsIDIwMjIgYXQgMDE6MzA6MDNQTSArMDEwMCwgUGFua2FqIFJhZ2hhdiB3cm90ZToNCj4+IGlk
YV9zaW1wbGVbZ2V0fHJlbW92ZV0gYXJlIGRlcHJlY2F0ZWQsIGFuZCBhcmUganVzdCB3cmFwcGVy
cyB0bw0KPj4gaWRhX1thbGxvY19yYW5nZXxmcmVlXS4gUmVwbGFjZSBpZGFfc2ltcGxlW2dldHxy
ZW1vdmVdIHdpdGggdGhlaXINCj4+IGNvcnJlc3BvbmRpbmcgY291bnRlcnBhcnRzLg0KPj4NCj4+
IE5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQYW5rYWogUmFn
aGF2IDxwLnJhZ2hhdkBzYW1zdW5nLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2Jsb2NrL3Zp
cnRpb19ibGsuYyB8IDggKysrKy0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IENoYWl0YW55YSBwcm9wb3NlZCBhIHNpbWlsYXIg
cGF0Y2ggaW4gdGhlIHBhc3Q6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDQy
MDA0MTA1My43OTI3LTUta2NoQG52aWRpYS5jb20vDQo+IA0KPiBZb3VyIHBhdGNoIGNhbGN1bGF0
ZXMgdGhlIG1heCBhcmd1bWVudCBjb3JyZWN0bHkuIExvb2tzIGdvb2QuDQo+IA0KPiBSZXZpZXdl
ZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPg0KDQpVZ2hoaCBJIGNv
bXBsZXRlbHkgZm9yZ290IGFib3V0IHRoaXMsIHRoYW5rcyBhIGxvdCBmb3IgZml4aW5nDQp0aGlz
IFBhbmthai4NCg0KLWNrDQoNCg==
