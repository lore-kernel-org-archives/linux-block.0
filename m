Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF4DC433F5
	for <linux-block@archiver.kernel.org>; Sun, 20 Feb 2022 17:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiBTRZH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Feb 2022 12:25:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBTRZG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Feb 2022 12:25:06 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614E831340
        for <linux-block@vger.kernel.org>; Sun, 20 Feb 2022 09:24:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwN/3vExX0iyj9M0jHo27kGy9Y/ZNUNVJm8tcT8xo8z9m1p/lCsvsC/r5t4w8IjBUDYggV10g1yL5wscJKlfh/vzAUDx7Dc9oSR9/cK9A7Wu1PVEnSW6jWrplC+2yETEC20o0sx9aLCUdTnS6sWvhzHlblIGhnIndJIn2Lx1YPuU1dZ80Vh31DoJtcJKEX+8RCee5NfW3at3hpVQpyzDyPZBWVorQz6epxopTtiJYgJMBxnTtRdTD4PesZLz25BgHyKlFAiM2x44RAGKYrcaa8RXZpgPdjfKIBxsMySc/aXzT/0NOXYuOTu+YoUpGYmWf0uFHRPNXNoS6qqf45cmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUAst3NdcVqvPvg9xWZjtrf5cJXFCKgqRrwekAugiig=;
 b=YHqlJNPc/h52ZD9kQlrEyCr321fXsYGAzewknhAy26VVGCW++EaOBjAvN/EFZZZ8my2DvL//LwA+R940o252y+NDDxzFNWwXV3FPm3e6bYPq/jV6i4PlaS6kcUobMp+SDbZX83Wm1m/SStBc1GajLXNzdGYQ9JEfdhMxg37uyqFJWTcTb12VQk9tMP3jbXuVgHToZAZ/x3eSH/lAYE1nIo3zdae9cNRittEJCoy6IAvYIKxSMgZYpOlm0YlM4ZG6qIrcEcB2Cd6Z5Hhw6zYQvyYF+I/ko9/0I8Nw+lmv8E+A7lPtPZ92PvynVIdKpU9+eV7HLOPCb2JxRox4SmOcYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUAst3NdcVqvPvg9xWZjtrf5cJXFCKgqRrwekAugiig=;
 b=ib2RldNdDa0YwcUpce+BSiu7/0OD1sp3TBp2T1IGnOmR5jpqBkM2b6c0cKDIMtnBjO5JMKkrCtQNaW4Ce4dhy4aPl1xFLWVY0a8usdiLULp4hpnrdW+YPN2JPs+F24NIbDooGS559bJrj7zWuKd5x5stwOx/lBn/8DfTSkjhPcfgb+JbdmnEH/KWo1TZ68bf2PGjokqMeltJWuKEat4Cqs/64iE9qzOyGcjCD7hSKQvIq5CnwsAPLwHdAPzsFm0TKsaN+Nwmw+w1j4BogDBDWj3EH2TVeU2Bv8Mt+brkLSDQOyq77rK1aOsdi5U0pOGYQjDGq9Lt7fLgQDRqujpGAg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB3502.namprd12.prod.outlook.com (2603:10b6:208:c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Sun, 20 Feb
 2022 17:24:39 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.4995.026; Sun, 20 Feb 2022
 17:24:39 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: block loopback driver possible regression since next-20220211
Thread-Topic: block loopback driver possible regression since next-20220211
Thread-Index: AQHYJT5Ur0AbgS9fjEi2Nb3t6WLy7KybDk4AgAAuf4CAAXYwgA==
Date:   Sun, 20 Feb 2022 17:24:39 +0000
Message-ID: <d3cd1f13-4c9d-3d75-483a-bb83b21ca20a@nvidia.com>
References: <YhBfsIqCNsi7D/st@bombadil.infradead.org>
 <cfce5ca9-e845-4b56-e33d-283fee37c3aa@kernel.dk>
 <YhE/c0K0FN9j8LFE@bombadil.infradead.org>
In-Reply-To: <YhE/c0K0FN9j8LFE@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bb5bce7-b9e8-4397-c974-08d9f495e019
x-ms-traffictypediagnostic: MN2PR12MB3502:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3502B5246E5405BD8D0AD096A3399@MN2PR12MB3502.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aDHD0kUv9JUvZAK2AXy9q3tJ3WA6hUFVOS3gobGwmtSXd1cYbkkAPiQewBnajUAzMdWWBfuwFyO2wugdWTYV0RDVgM5eLIo//aKO5ibkdi3WAMFEuH5HORga9ZIzwRygrG+9zf8wHPq/0JhrATLf/zZVDJRLKDSv4YNzdXMxrK0Rp7G28bTf3onoooCCtqZFQ4mkiEG0+g3CwbreMY5CbDrt73zpjsUXA+6247dnw5KIlzFIB3ngUOLVyb+EVfyDG4vHgsyxFKJ0cxJWYeUr96xACZ5lIQ17pqi514M6oHrbWOif9ekja5cBQ9ZWmovPI7csnj2kuZh3YnZYuTuiEX7SsAUjk3Ua0H2e5uDX5ZA5/fGRm8/8e8cRJ/m3CbDnkW62PN+F8Lgi577cA2Q5VP4gWkVrCnEGFXnNGozRLp5n4ITA7MhjKbh9SFse0GkbHNdgZF2aDtshJLctObYZKWvqgDTMC7v/UIfV9UUzSU79QPGya5e/y64kKRQJHR3OMZRGxuALAYbHROvnQtxZslvg1CYHBptoeqDjUDswNwWe8x8Sci3iUDnkG4bW5FimNZ1nAulDdK4EauAdm3QIjVHEnAEhURQnnKhddg98W4nellQnrEXebPSM5VRY7yat14cMfvkHdg16u4hpyQ0PUg68rooERI8T3jOEVQtrFXzuDBJQG6gT7yPK0p/7r0WvcW9BJRO+eBEQUABu9dA4Tfm3r/8vY8jDNSE/h03xjmATTfcAbqf097KxVzUAuQuOJIjqaaHTgeNQ0UXUX7f6QA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(2906002)(122000001)(31696002)(38070700005)(86362001)(2616005)(6512007)(31686004)(36756003)(54906003)(186003)(6486002)(508600001)(6506007)(53546011)(6916009)(4326008)(71200400001)(8676002)(66946007)(66556008)(66476007)(66446008)(64756008)(5660300002)(8936002)(83380400001)(316002)(76116006)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eStmUjlaLzJGRVY4bDZiUzRoZUlMV3UvVmV0Mm1sb0d0Q2dsMG5RbCtGbUZH?=
 =?utf-8?B?UEFrVWJ6RDF2TE9pZkV0YUZUY2E0RGZJdFEvMmkvWjdOMEhhWFBxWDhtMDNT?=
 =?utf-8?B?VkVJNExFZ2tJL2FpanBYblZXU2ZLTE5tdFlRQ2RsbnlSbTY3OFpGcDVhRWVK?=
 =?utf-8?B?Sm1OemovcVdzak53S0R3a0xST0R2K3JVa3FwdWYyZkhBc1B1cDQyRlp1Wm83?=
 =?utf-8?B?bEthbWFHM0xMcENLc1YrMHRXVnIxVGpmbmNFZmFFbE9mdVBiSWhxRkNnM3Jk?=
 =?utf-8?B?S3c0aXc5QVRld0Jua3F3RUl5OG5lMnN4U045YkhtLzB4aUJ0ZDdScjlFUFZ2?=
 =?utf-8?B?VlV0WXJtYkdLVXg4YUdNZWNtUHZuWDdhU2tjRkF4TlhvMVI5Y0pxVWtpRFc4?=
 =?utf-8?B?MWIzLzdjUm5YZzNQcUJGL1RNZ2FyRDR1Mk1HNDJXZ08wZ0lyd0MxWERaNzg2?=
 =?utf-8?B?ZmhVbUlzekh4aTdUZHpDVjZtaGdrUVgyck1zTGdacUg4cG93SXRhNUU5OFZM?=
 =?utf-8?B?c0xHaXFxM1o3VytrZWhrTzF0dFhSTVVMVVZ3VTF2SGp6V0tHUmdBdmNIK1dx?=
 =?utf-8?B?VlN3RlNnTCt1WUxjYUtsaGlqYmJFV2R2RE01UjIwdDBhTUE5T1AwVHBoUVhF?=
 =?utf-8?B?bHJLT3FHWHhZU05mSlZwZHloL0svWU4xQUc2ZC9Bc2xDYUNibW9YSGNpSWNq?=
 =?utf-8?B?WWwrTzZpTlBmajN3cXZ0bmVEdDBIbHFxK0dMcU9aQXRpZ0YyRVNZaGNhZzRI?=
 =?utf-8?B?cmtrOHA0SS92YkF6L2FOYzlQNm1nVkRsazEvOC9WbFN2dnR0ZFJsb1U1Y1Nq?=
 =?utf-8?B?bmRCNkhiNU8vZVVMK0pYUVhHYWg5NFFnUFVzSWVzSDBqUkNUMG1NQ3NkdHFE?=
 =?utf-8?B?aHkycGp5aStaVzBiN2ZrTW0wcjVnczFnYXg5UGkyWnhHMHp6Ri90M3oyc0tZ?=
 =?utf-8?B?MTVmT2c5OEorcjVjOVJzb2duQW9RUHZiWjhTSFM3WkV3SkpVdnRteEZaclha?=
 =?utf-8?B?bTgyLzNtcFdraTRFSHRRS3ZIb2tIaGM4VmlqdDdTRjBlUjhpOUZZTTRON0l6?=
 =?utf-8?B?dFhuRFI2OHpuUDhwSXdvRUtubEpzOC9FOUtxcWJLYVRnRjhWTWlRTlNFQXFV?=
 =?utf-8?B?d25CNTdGRUdVT0pMRkY3SVdZdmlBNDBaMCtYL1lOU0dVcFJkWG9mS1NCSTJ0?=
 =?utf-8?B?dDJQeWZLQWcxamt2aTQ4N2dHUlh6d1dOVnB2NFpTWDg0djVVdTU3c25YV0VP?=
 =?utf-8?B?WXBCdS9mUnFzQ0ppLzFCV0NLV3E0U2JvZ3B2cXhFRW5pcDB2SXJhSmZCWC9B?=
 =?utf-8?B?VzJLaEQrTnY3RmVaUmwyWVdCUGg1MzQ2RWU3SHZoWXZVMS8zdWxBeFM2aUh2?=
 =?utf-8?B?czlmZDN6MTN6SzEwMzlmQXhVRGlSb0RCdzg5K1c3OU16VlNVOGtibUs2SlNU?=
 =?utf-8?B?VkRGWTlib05aTUc3VnNST05iT1h0ODYyb0pHZ2VDdVR3N1VMdC94WnlJUSs5?=
 =?utf-8?B?ajVmdjFOY3lUbXZQcWNWcCtuUjZyd3BKTWxhSFQxeXFRck8rSUdTdm4ydXRQ?=
 =?utf-8?B?cml3M1lQeTJHSTRJcmh3WVZyM3pFVjdyQjhZWEwvUmY3aDFWVGRZL1F4VnU4?=
 =?utf-8?B?TDJRRVBCelcrTjc4R2FjWC9EdXRvY0ZWTEZyRnlpcW9EVC9HaTdlNUlVKzZn?=
 =?utf-8?B?UmJ2NzJyajA1YkFhR2RWZUFSL2xpU0RoNktYWFJITmloQk8rdEJwS01jMStm?=
 =?utf-8?B?ZFkxeXJGSlZ5YW5JNXR2VlFxWUo0QjErZmFPQmRZKzQxSkdsaW9ON21UU0c3?=
 =?utf-8?B?VldvTjNUSUlCT25jUEJuZXFBSTVHMHp1MHV0bTFSOVZnU0t1TGFBZzBsTDB5?=
 =?utf-8?B?b2lYWDB1STRrZDdkMEUvWloydXBHaTlYOWtwRTBTdkQzd29lV3EyZWgrK3F5?=
 =?utf-8?B?Q3lBWVpyMmZtZWlQd09vNGliVU1KN1NyWlBWcVJqR1krTldXWnRPNkNVQjBl?=
 =?utf-8?B?bE42dVZUY0Y5UHN6d1VoOUczRDBjQkZJbW0yYU1iWjFlSG44ekFJWTZQaEY3?=
 =?utf-8?B?K1JibE5LcDhvUjlRQUY0ZzVPZDRRaWtNQnR3YUgwYmZDc1hxbW5KVDFDbEQy?=
 =?utf-8?B?b29HQnlGdXRZbzV6eFpKMXh6VzZzNkFCZzdXV1RpNjBKOWMzQ3dIdFZrYnIy?=
 =?utf-8?Q?QTWGK/WJP3aGprxIW+4JgMNBUtZHgU+syCpwqnwN8gcE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAE9B3289B638D47A9C1F3E222E365F4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb5bce7-b9e8-4397-c974-08d9f495e019
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2022 17:24:39.6257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYXLIYahY1Q6lwACxUgDW5ddZFKZ2l5WGqqtf4+teGC5qH6IL1+jSeeq+b8JAv1uPJVBK2G2Dbag5wlh1a+ZNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3502
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8xOS8yMiAxMTowNSBBTSwgTHVpcyBDaGFtYmVybGFpbiB3cm90ZToNCj4gT24gU2F0LCBG
ZWIgMTksIDIwMjIgYXQgMDk6MTg6NThBTSAtMDcwMCwgSmVucyBBeGJvZSB3cm90ZToNCj4+IE9u
IDIvMTgvMjIgODoxMCBQTSwgTHVpcyBDaGFtYmVybGFpbiB3cm90ZToNCj4+PiBJIG5vdGljZWQg
dGhhdCBzaW5jZSBuZXh0LTIwMjIwMjExIGxvc2V0dXAgZmFpbHMgYXQgc29tZXRoaW5nIHN0dXBp
ZA0KPj4+IHNpbXBsZToNCj4+Pg0KPj4+IGxvc2V0dXAgJExPT1BERVYgJERJU0sNCj4+Pg0KPj4+
IEkgY2FuJ3Qgc2VlIGhvdyB0aGUgY2hhbmdlcyBvbiBkcml2ZXJzL2Jsb2NrL2xvb3AuYyB3b3Vs
ZCBjYXVzZSB0aGlzLA0KPj4+IEkgZXZlbiB0cmllZCB0byByZXZlcnQgd2hhdCBJIHRob3VnaHQg
d291bGQgYmUgdGhlIG9ubHkgY29tbWl0IHdoaWNoDQo+Pj4gd291bGQgc2VlbSB0byBkbyBhIGZ1
bmN0aW9uYWwgY2hhbmdlICJsb29wOiByZXZlcnQgIm1ha2UgYXV0b2NsZWFyDQo+Pj4gb3BlcmF0
aW9uIGFzeW5jaHJvbm91cyIgYnV0IHRoYXQgZGlkbid0IGZpeCBpdC4NCj4+Pg0KPj4+IEkgcHJv
Y2VlZGVkIHRvIGJpc2VjdGluZy4uLiBidXQgSSBkaWQgdGhpcyBvbiB0b2RheSdzIGxpbnV4LW5l
eHQsDQo+Pj4gYW5kIHdlbGwgdG9kYXkncyBsaW51eC1uZXh0IGlzIGhvc2VkIGV2ZW4gYXQgYm9v
dC4gTXkgYmlzZWN0aW9uIHRoZW4NCj4+PiB3YXMgY29tcGxldGxleSBpbmNvbmNsdXNpdmUgc2lu
Y2UgbGludXgtbmV4dCBpcyBwdXJlIHBvb3AgdG9kYXkuDQo+Pj4NCj4+PiBBbnkgaWRlYXMgdGhv
dWdoPw0KPj4+DQo+Pj4gRm9ydHVuYXRlbHkgTGludXMnIHRyZWUgaXMgZmluZS4NCj4+Pg0KPj4+
IEknbSBxdWl0IGFmcmFpZCB0aGF0IHdlIHdvdWxkbid0IGhhdmUgY2F1Z2h0IHRoaXMgaXNzdWUu
IFNlZW1zIHByZXR0eQ0KPj4+IHN0cmFpZ2h0IGZvcndhcmQuIEl0IHdvdWxkIHNlZW0gd2UgZG9u
J3QgaGF2ZSBzdWNoIGEgYmFzaWMgdGhpbmcgb24NCj4+PiBibGt0ZXN0cywgc28gSSdsbCBnbyBh
ZGQgdGhhdC4uLg0KPj4NCj4+IE15IGd1ZXNzIHdvdWxkIGJlIHRoYXQgaXQnczoNCj4+DQo+PiBj
b21taXQgZmJkZWU3MWJiNWQ4ZDA1NGUxYmRiNWFmNGM1NDBmMmNiODZmZTI5Ng0KPj4gQXV0aG9y
OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4+IERhdGU6ICAgVHVlIEphbiA0IDA4
OjE2OjQ3IDIwMjIgKzAxMDANCj4+DQo+PiAgICAgIGJsb2NrOiBkZXByZWNhdGUgYXV0b2xvYWRp
bmcgYmFzZWQgb24gZGV2X3QNCj4+DQo+IA0KPiBJbmRlZWQuIFRoZSBpc3N1ZSBpcyB0aGF0IGRy
b3BwaW5nIHRoYXQgYWxzbyBkb2VzIG5vdCBhbGxvdyB0aGUNCj4gYXNzb2NpYXRpb24gb2YgZXh0
cmEgY3VzdG9tIGhpZ2hlciBudW1iZXIgbG9vcCBibG9jayBub2RlcyBjcmVhdGVkIG1hbnVhbGx5
DQo+IGV2ZW4gaWYgeW91ICpkbyogbG9hZCBhIHJlc3BlY3RpdmUgbW9kdWxlIGJlZm9yZSB1c2Uu
IFRoYXQgaXMgYnkgZGVzaWduDQo+IGJ5IHRoZSBjb21taXQsIHNpbmNlIHdlJ3JlIHN0dWZmaW5n
IHRoZSBuYXN0eSBvbGQgcHJvYmUgbG9naWMgbm93IHVuZGVyIHRoZSBuZXcNCj4gQ09ORklHX0JM
T0NLX0xFR0FDWV9BVVRPTE9BRC4gU3VidGxlIGRpZmZlcmVuY2UsIGJ1dCBzYW1lIGRlcHJlY2F0
aW9uDQo+IGVmZmVjdC4NCj4gDQo+IEkgYWdyZWUgd2l0aCB0aGUgYXBwcm9hY2ggdG8gc3R1ZmYg
YWxsIHRoaXMgbmFzdHkgY3J1ZnQgdW5kZXINCj4gQkxPQ0tfTEVHQUNZX0FVVE9MT0FEIGhvd2V2
ZXIgSSBzdXNwZWN0IHY1LjE5IG1pZ2h0IGJlIHRvbyBzb29uIHRvIHRlbGwgaWYgd2UNCj4gY2Fu
IG51a2UgaXQgc2FmZWx5IGJ5IHRoZW4gdGhvdWdoLg0KPiANCj4gSSdkIGdvIHNvIGZhciBhcyB0
byBzYXkgdGhhdCB3ZSBzaG91bGQgc2FkbHkgbWFrZQ0KPiBCTE9DS19MRUdBQ1lfQVVUT0xPQUQ9
eSBmb3IgYSB3aGlsZSBiZWZvcmUgZ29pbmcgd2l0aCBhbiBheGUgdG8ga2lsbCBpdC4NCj4gSSB0
aGluayB3ZSBoYXZlIGEgZmV3IGhpZGRlbiBnZW1zIHdlJ2xsIHNvb24gZGlzY292ZXIgbWlnaHQg
bmVlZCBhIGJpdA0KPiBtb3JlIHRpbWUgdG8gYWRqdXN0Lg0KPiANCj4gRldJVyBiZWxvdyBpcyBh
IHNpbXBsZSB0ZXN0LCB3aGljaCBub3cgZmFpbHMgdG8gZXhwbGFpbiB3aGF0IEkgbWVhbiB3aXRo
DQo+IHRoZSBhYm92ZS4NCj4gDQo+IHJvb3RAa2Rldm9wcyB+ICMgY2F0IGxvb3AtaGlnaC1kZXZz
LnNoDQo+ICMhL2Jpbi9iYXNoDQo+IA0KPiBOVU09IjgiDQo+IExPT1BERVY9Ii9kZXYvbG9vcCR7
TlVNfSINCj4gDQo+IG1vZHByb2JlIGxvb3ANCj4gc2xlZXAgMg0KPiANCj4gaWYgW1sgISAtZSAk
TE9PUERFViBdXTsgdGhlbg0KPiAJbWtub2QgJExPT1BERVYgYiA3ICROVU0NCj4gZmkNCj4gDQo+
IGxvc2V0dXAgLWQgJExPT1BERVYgMj4vZGV2L251bGwNCj4gDQo+IERJU0s9InRlc3RfbG9vcF8k
e05VTX0uaW1nIg0KPiBybSAtZiAkRElTSw0KPiB0cnVuY2F0ZSAtcyAxME0gJERJU0sNCj4gbG9z
ZXR1cCAkTE9PUERFViAkRElTSw0KPiBpZiBbICQ/IC1lcSAwIF07IHRoZW4NCj4gCWVjaG8gIiRM
T09QREVWIHJlYWR5Ig0KPiBlbHNlDQo+IAllY2hvICIkTE9PUERFViBmYWlsZWQiDQo+IGZpDQo+
IA0KPiAgICBMdWlzDQo+IA0KDQoNCnRoYW5rcyBhIGxvZyBmb3IgYmlzZWN0aW5nLCBJJ2xsIHJl
dmlldyBpZiB5b3Ugc2VuZCBvdXQgYmxrdGVzdHMgZm9yDQpsb29wLCBpdCBpcyBiZWVuIG9uIG15
IHRvZG8gbGlzdCBmb3IgYSB3aGlsZSwgSSBjYW4gYWxzbyBzZW5kIHlvdSBmZXcNCnNjcmlwdHMg
dGhhdCBJJ3ZlIHdyaXR0ZW4gb24gdGhlIHRvcCBvZiB5b3VyIGxpc3QgYW5kIHdlIGNhbiBhZGQg
dGhlbSBpbg0KdGhlIGZpbmFsIHNlcmllcy4uLg0KDQotY2sNCg0K
