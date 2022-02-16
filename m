Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B11C4332F
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 17:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbiBPRMd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 12:12:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiBPRMc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 12:12:32 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66203EA770
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 09:12:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hD9j/sB287craJ1y3ds25ZDenwrdacaHU/CH6vxUR6f9iVB9uR564Z/TrpSXHIya1cacHz4Sc6/1IMKNK1bx7mC5KdAgBsxP1Ud1b+d624ecJfyRptkmd7MHoGUVuofyvFcSg51l+33E9LE23GiE3G25jD1AYnWaRje92Wh3tiV+d3JXPFH+SCGnsJQ4gZkDauQeO4HT4sPpQ6cti+8rCv2iOJOIR4Ddl5eJy5N0pEFJ7rGhHUb9C8cOZgXYXAPr0ccn1jSMVkcy/h2CiKty2TNL7jZFyx1302r8FJ55g1xZi40vmjfYcY6EZWCG+aV257CWYFqHQLHNoBl6nQ8nFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieQcnfFXsw2y+O21sB5/t4uXhp75/L4EI66w4r4tW18=;
 b=MaYvOZ6v5ibyRAulTfK5umIIIDokWIsYmgYwf2iPPxl/795mwfHt3paFCEM4pHPS6wNWe/bzjbJCvknWhk1kpiBD8WSl0NB+hkgm1U3v8kl1Y5oAKWyrIf6tGVXD9nANd+faNXvXjVpWCs5JwN3UsVWTRZCmLcO0zS4mSz7D9quWi4DR9ytYbsWqrzNvRiTZYF1b0xyu0ndEGU7ZGuRblB46a9GlVftfF4o2ZDLSUUFbUAicKNv+Ci7zLsHdji26G+a4KhjdKZgcf0uyFmFvtqQH9NbdMbEpIg5l92tT/s1FN1lH5jzJcScE5tM2YFk/mS+7ZmTOQy3s9gX3/HdodA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieQcnfFXsw2y+O21sB5/t4uXhp75/L4EI66w4r4tW18=;
 b=RmHrDMfESkHVjH/zUrO/i2naNsolecMk/HCHrGdCjNDvdxpj8qWFrnvEGhOYFSGkAEoLDcdlfum8cPZJyyZ7M9c53ydMVDsf6AgJDdquGZ0WFi0/0nwKFzNAhk9apDtXwbhDi/+9QHlov+DpMTf2hGAzn8Ut76zA/V4HaVGjfakibpPXXPcmNC258WhOvlLLQ8p81ZW4a2zozH0VqQjsNkRsDqasR3xh9+sYkt3n+MH2ryi5Dokp+t0xxMoq95nqSfVNNycBjU6vg+vxthalDj9LML4Oi8140X8Iciuq+a4DGM+RYZNIPwn4rPhyT0ZKDr0CbvwUh2o+klt7ld/nuA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 17:12:16 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Wed, 16 Feb 2022
 17:12:16 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Haimin Zhang <tcs.kernel@gmail.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block-map: add __GFP_ZERO flag for alloc_page in function
 bio_copy_kern
Thread-Topic: [PATCH] block-map: add __GFP_ZERO flag for alloc_page in
 function bio_copy_kern
Thread-Index: AQHYIxE0/IIgYxhY8EW3m7YIWmu8s6yV5HiAgACEEQCAAAIGAA==
Date:   Wed, 16 Feb 2022 17:12:16 +0000
Message-ID: <a362be94-3b25-bd41-6576-cd8699711615@nvidia.com>
References: <20220216084038.15635-1-tcs.kernel@gmail.com>
 <47002290-3064-7de1-25e6-0716a89b94c0@nvidia.com>
 <Yg0uvqBK/n6fdDfL@infradead.org>
In-Reply-To: <Yg0uvqBK/n6fdDfL@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 185cc2ab-9489-4953-6641-08d9f16f7b9f
x-ms-traffictypediagnostic: DM5PR12MB1705:EE_
x-microsoft-antispam-prvs: <DM5PR12MB17050F5ED17F7E94F111641DA3359@DM5PR12MB1705.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Img1sxN6+ZhMgbbyn5rG7dFGfTXh66K58LPQw81vSqxddiocW4oy75OiOuw4dXSNkx6YpqOFbZNn3/+9WcmIs7XZBOPUSndc66MS4ntf58OLvhEO5sjFNZJEijknGpxq5hFlo8bW+iK1elxgfXq1/k67pKTJWr/SNEGfddFGk75bzpp9wTpyF9VBjA2lebj8jvxueRg+mMXBlfkRheQxqp0UzMvwiiJvUsB6w6aqadpA3f6kp0dKlMkukDpVAmgJwpMS6+TH1q1/AevXshMluT5j/NLdIazyo+Nr0/hlwyeLtymfxWSz3i6JkqhZ5NtjKq8oApbQeyJM+GB5YTWVpGUP6mEDLKQMw6mmmD6yedowQGLZFTIb3yKEIq9daM0Zh8m1JnKrX7EIX1yRY1uTsNb5cX58oCkaauBEp+bQ6qR4ghffIe7M5z+Dhu33hnQspIa4puX8LGHQN7P8S/Kf2Kn13IKwWxx1CWMpredp2fu0hoxji1ZLJE0viJFSu5wN6q1OJBO7eRNcZeSrQq5/bhyIw84gJek4FD2eYG7DqhIBb/xfoydGkgXuIUjOxFvtQtKNxljt5VqVaYbSTw8mJGJyBvKZjQOHK7/MhWRHHfg3Pdd80n9Lz71uGSfXEpIsKtEquAVV+DjPBmeMs3EwhTB3iKsnkGvkvtcmqMmfpdtJQI8nuPaOxoDCa9D2n7b8IRr1ovsSEQKrQmeZixP6WMIN+nKXMYNK8Z+j7DNJxwLpiiB7L/mD+ZKRW5AHzMbajmGZFl60seNB6Gjw9iPRIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(64756008)(91956017)(76116006)(66476007)(66446008)(66946007)(508600001)(86362001)(54906003)(53546011)(38070700005)(316002)(6916009)(31696002)(6486002)(122000001)(2616005)(186003)(36756003)(6512007)(6506007)(31686004)(8936002)(4744005)(5660300002)(71200400001)(2906002)(38100700002)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmdlUU5yZ1d3eHhNVU9PSGtKSzduRU5ueEREZ0pNMkFyMW5jZE0wbGhjSmFW?=
 =?utf-8?B?REdBQ2hEdVlBcHRaRS9XMDAyRmN6M3NRaExyKzNUeVZPSXpZaWwyRGdUb3d2?=
 =?utf-8?B?STU5bmJwZGZpTEpzYytEOGFudzlrSzBOVUVwdWVZRlAxOFZSdFFuKzl6N285?=
 =?utf-8?B?UzRZVnV1N3JYYjdjY0lkQnFnbGZYWlhFcHpESjlxbjlrTW42c3VmYkk3VFZ0?=
 =?utf-8?B?UTlLZFZONjQwNXovTDFxYlZVNm1FZmRHUlZTQ0hYSWcxY1VXMmY4eE53a3Rp?=
 =?utf-8?B?aVNieUFEbm95VzdQUUtTY0dZNzZsYTk2R3I5c3U3NWE4WTdIcXdLWVZiNGdp?=
 =?utf-8?B?Szk1VW1BT0IyY2RpcVk4Z001UXBxNkRIaTBiK1lSZkU0aFhCbnV2NHdUbEtW?=
 =?utf-8?B?ZTd3eDFzN1ZXVWNGUmQrTWZIbG15WXBqNFFPVkJxdzkwSEtGWTFibzFZTEtT?=
 =?utf-8?B?VmVFMGc4VCtoMGtFRkQwZGR5MXFpWDNhc0ptQ2dIaU1yOUNnemZGNmpNYkE0?=
 =?utf-8?B?UDJtRlJrZnBsckMyK1ptbE9MRXg1cjJZK0pwVlNON1hFNHJUZDIvU1J1L3Fi?=
 =?utf-8?B?aHUzWFpsUkQ4Y2hUNmtmLysvQU40TXVnV1VFV2RQUVdScC92cTNPSXR0S3dJ?=
 =?utf-8?B?Y0F0WG1mZHp1eTl0bzlDRlFxSTRlYzBrMDhXSnZqQmxuakNNc1NsRndHQ2Zo?=
 =?utf-8?B?R2FJbVFqb2xkaythNUZWOVlncVMrc2cxVXRCbTRxNDd5SGRQaE04RUV4aDdp?=
 =?utf-8?B?Lzd1aDhJeGRFQnZzdXpocGxCYndEYS9seUJlcnBYWlVCTGttS1A0dS9QR3lB?=
 =?utf-8?B?UTA2N1JsaGZ4WTBKdmljOFhXY0JhRnViS2p1cVJZc0JkNFQ4djNuVTFkM2JI?=
 =?utf-8?B?YTltajRRNmVQYjIxV1VOYTJyRmVvei9YdVFMOUtKVjBOTFUxamJVTXNlYldj?=
 =?utf-8?B?RTJKNHhHYTQ1UnZpdnJ4Y0dwSjRnVUszNHpqeHlzR21sK1hHUFVFaVJHVzZP?=
 =?utf-8?B?R09OYWczQXlYRERvQlRwL2FsY1YvZWJadDMvUEt0NWJSRnRab0RjSWE5WWZD?=
 =?utf-8?B?eTZ4WlljdDVRbW5uY29Qcm5YbHJJdU8yTXNpTWw5d2xTazdQbmVMc1VxTEda?=
 =?utf-8?B?dDgvTHE2MjNvSjFXSVpVcnFYbWN4VFovU1RWVUUwRG1CU2szV0I5azZRR2hq?=
 =?utf-8?B?MWwxanFEL0VVdU1JcWR2dnpJVWZORmFuTjNSNldOSDlOb0ZFUUtoTldGMDBT?=
 =?utf-8?B?cjBHRGtMTFY4ZTcveExENFZ1ZlVwWDQyMFpaWWc2anI5OHloZFliR251K095?=
 =?utf-8?B?aDVLWVllaHpESmR5YktVTXBkdG8xMzhZVWZwbUFWSDRnMjNBMDJodXlVVklM?=
 =?utf-8?B?Q0Z6TFUrSTQ1bDQ3U21IWWx0M1FCWmlTR0ZsSVZHZlVFVEdmdXRqakdnelhV?=
 =?utf-8?B?QklvWHhwdmtnNHZDcGlKQjVKdWJwU0RtRWZ5ejhFT3JHM0gxTENscnhxWVNo?=
 =?utf-8?B?ODhpOFB0WUJFNDUyRnpXajRiR0g5QXRMMytyRkQ5dGpIK0FYRHdQZTBnRzFp?=
 =?utf-8?B?UDVEaHpVa3Z1WGtLa21lYjgzamRmSTEzQVN2b1BBN3RCaWVsNUtPUDNoR3hn?=
 =?utf-8?B?bVRuL09BTnhLZmJ2VkswdTd3ZkFvQ1h6RlNYSHh5NGtqUEVXRkVIRENWY3c0?=
 =?utf-8?B?dlZuS3Y1NVVYZzcrak42OG12aTh6TnlacE1Sc3JsaXVwRVRkb1BvK0haUG4y?=
 =?utf-8?B?dHVLcnNKTUV2dllraHg3WWptci9IMzNaNlA2a3FyUUZUMWxya0kwSVI0N1RT?=
 =?utf-8?B?dVo0Mm43SUczMFFtcHAxZDZMQUJHSjZzMHRRY3o1Qi9xYXF3Q1VORHd0QXpT?=
 =?utf-8?B?V2hLSHU1V1FVWjhPTVZqbFg2aHh3Y1hKalBXWUlta0FZK2RHT2MyZStoa29H?=
 =?utf-8?B?ZC9zeXlwYlZ2SzkzVmQrazFFT25SMERJcHRqU0d1M3pLZGtCUEh5TmpEaHB0?=
 =?utf-8?B?bm9nRmNUdm9ZbE5QSVBpMmNVWXpuYnFudm1WWmp0V1Z2TFVnQ2dLbFRMVGNh?=
 =?utf-8?B?YUdobnJjcm1mZ3Bmd1ZLZ0grZVc2YVEvTW5FYkxhbFMxZzBGRm42Y01vcGV4?=
 =?utf-8?B?WDlVWmVsVkVzZEoxeVZ6dVpwRnlpMXV5TDh6WHR4Q3o1alVBcFZvYUZwM1lE?=
 =?utf-8?B?aVZtNjVFdnA0UUJSVVhVTDYzT09QMHIvWVNCb0dRL3JTeGhzOGZ1RUpaTzY2?=
 =?utf-8?Q?348wU2a6Xl55p12VG9YRGddlTtZiLlW7dPaatufLrY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE014B42175E7A4B9C4A2FC74F664BC7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185cc2ab-9489-4953-6641-08d9f16f7b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 17:12:16.6406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KU1Gx6V2NDPtxx0wvVFIAhfq0gDPsQJnv+9vcP/e9xfy0dfE/KdtZaj2XXFRAFyil3+waVH9ybyW6RhRMMGvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1705
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8xNi8yMiAwOTowNSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIFdlZCwgRmVi
IDE2LCAyMDIyIGF0IDA5OjEyOjIxQU0gKzAwMDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToN
Cj4+IGJ1dCBibGtfcnFfbWFwX2tlcm4oKSBkb2VzIGFjY2VwdCBnZnBfbWFzayBmb3IgZXhhY3Rs
eSB0aGlzIHNhbWUgY2FzZQ0KPj4gYW5kIHRoYXQgaXMgcGFzc2VkIG9uIHRvIHRoZSBiaW9fY29w
eV9rZXJuKCkgdW5sZXNzIEknbSB3cm9uZyBoZXJlLA0KPj4gc28geW91IG5lZWQgdG8gcGFzcyB0
aGUgX19HRlBfWkVSTyBmbGFnIGluIHRoZSBzdGVwIDMgYWJvdmUNCj4+IChzZ19zY3NpX2lvY3Rs
KSBhbmQgbm90IGZvcmNlIHp6ZXJvZWQgYWxsb2NhdGlvbiB0aGUgZ2VuZXJpYyBBUEkuLg0KPiAN
Cj4gV2Ugb25seSB3YW50IHRoZSB6ZXJvaW5nIGZvciB0aGUgcGF5bG9hZCwgYW5kIG90aGVyIGNh
bGxlcnMgaGF2ZSB0aGUNCj4gc2FtZSBpc3N1ZSwgc28gSSB0aGluayB0aGlzIHBhdGNoIGlzIHRo
ZSByaWdodCB0aGluZyB0byBkby4NCj4gDQoNCm9rYXksIGluIHRoYXQgY2FzZSBsb29rcyBnb29k
Li4uDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQoNCg==
