Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B3BC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F9661039
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbhJMEV2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 00:21:28 -0400
Received: from mail-bn8nam11on2080.outbound.protection.outlook.com ([40.107.236.80]:44712
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229453AbhJMEV2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 00:21:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYi7gtkaqRA4aQKrGTPH7qJbbUPJ23JuYIwFzN5/THMH/SH2KGI2Y96POUfp/ZqqzcY28pPQflCOmV/Xyy2iWvZ2zcdS4vlkTGTQOF/UHWE+0GxF3lMNgn/h4mYMxPTAADODdzyaYpELMLbk5fSby/pjdt39dWLqr8oQtRQspUMuvOZkBU21lwTa8wgxAuj9jM+c130Ma5Po9Mt2BDjFT6gorLAiF4+n6onh8YpGC8V+jwz0qwu2bObkJiv3WaZALBnX6iRaKafstNDxATwWKxPqYdrh5vPUWauIK7WDNs5CvN3vHTW4GNeJozb4aVTVt8G/AKaSjBnBtcAme3jzUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UIlRjETyFZaZQyIP5b/hxIiestGfq809A/F0Ayb0YM=;
 b=P8ODsNPkbg+8B7aJ2UhlZ/9hoVJBHyy/p45hHqhRVvkMxsHuG9PvBsBOTnBm1dXY8edga26RuZbqcyIoJITcMRu595GGizTqDtGOhefi/FFuHj1+oDza2dmEUAgm6t9BkLeyo2YDEUcChZfqWMvkLKcrLEA6RzewbCpF5M7HlqXmizw+XxWNqBV6blc6egqP89TkS/q/uUima6X/FHM5rkXPJ+bcp58jq/mzx3Wi2X/2qi6uw9ZIv1lAaxELqB2EfFzYkbtDC1dzmNkS3rG5RPgLpVMO6UHH1K2JTVQHoMxnBL3/4eJvGIEv8+yOPM2v0rLIKtyN5C4g+F7YgAdjMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UIlRjETyFZaZQyIP5b/hxIiestGfq809A/F0Ayb0YM=;
 b=VuBNE0I5rBxzlsNwfAYTv/6OVKU9cx/47aARs01z7idmuZo+JCc2ESApNMzKOwekcuaE2OuUtjUzJwVf64eMOUXn7E/czZJEoDcbg13kRQTMPegRInNvPp7JMmmP2bqnmw0pAnabohOhtMP3q7ThStJ6hmY7qNUtFsYbDA5DY81tQvOGUJOYbxJxzCE1/8DmFi8gn7zd1S6cIVWT81kwsVwLTOCHesYuqbQ8Wrd+3NnlaXxlFqukgRz2d4u+GLXEj5uj634/tTfonc792aNgiCiXia62668LfmBOyKKUUk6gN9EPGGPSRW90BmYfX7pPW07w0TRuvtTgAouVBxKf3A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 04:19:23 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 04:19:23 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/8] block: remove BIO_BUG_ON
Thread-Topic: [PATCH 1/8] block: remove BIO_BUG_ON
Thread-Index: AQHXv4UkYHZKwiZu5UeSWNyCPnfyYKvQU/iA
Date:   Wed, 13 Oct 2021 04:19:23 +0000
Message-ID: <9b6a51e9-2fb3-0cb2-56ff-426c0a470f71@nvidia.com>
References: <20211012161804.991559-1-hch@lst.de>
 <20211012161804.991559-2-hch@lst.de>
In-Reply-To: <20211012161804.991559-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 280bed62-79da-431f-9ebe-08d98e00a311
x-ms-traffictypediagnostic: MW3PR12MB4396:
x-microsoft-antispam-prvs: <MW3PR12MB43962664417E4EB0BB73C4E1A3B79@MW3PR12MB4396.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DMRfV2xczY4os5fPynpqcxgdIIrt5Ku+EJWCf3Gk5FBi/JxBiDAEaSZQDHKLlnk6pdjn1aYC8n/KLjwRQZNgnz9R+zqZV9U2ERMDjfd2kr1RoBYHjJZhk2/tiEMpvuOLthV2l+kSUNl/W6IOwXnb3WFx493a+DzMNROMcgpHIlaeaJNoFPbbjhnr5/IZFpHJl1Y/ddec5G+TMhn+dITuPGyaxwBi414mU9MfQdJ0Bg4IuYcO/Szr100WhvV9kMbBpd/4o8XilOAmy7KyQ6WYcBx+Gd55nf0Shdn2vbnVJ7LR57wY/knagC2Qc8zs1MrvDC9MyMxWXdT6A69k+YDCNKXa5PVwl2VNiKY3DmYsS2LjvBrDf/XBk42zqtfmpaS696fS+8UscZ2RdNZjH4Ku2sgkV21fslXEVrSPmEDJoMuq/sQevAk6XMjChAOXkYwZFt4PZpttKxqXsP9AVgac1jA/twXEhhTT2Q4FozkHDSUv9mAQeaCzzB6D40i+p6iU2xNlGc218zDggF4kIdCgQz6DSbY6Jal1jGLrk+CZyPIe/J1+Styi0IpdlrEFLspcsl9g/qk9NSgvlgrdBsin3r4Zx5nCETfwJee1rMilsG3u2pNIxCQNBBWy/n9fKqTFkp6L5Y0FfAy90OsQ4nM6XulzN0pkQBN5XCDutI/2gpQqqYw+atrUjMZFnoONh7DQ4mUwBdPxb144LfsMrXMCIhsgybcrfUj+WWScLck8lCi7U+VYrbPrHb6Kx9IF14qjhKzsFi0uS9eNPgIqUKGBuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66556008)(64756008)(76116006)(66476007)(4326008)(6486002)(36756003)(38070700005)(8936002)(86362001)(186003)(71200400001)(6506007)(91956017)(508600001)(53546011)(66946007)(2906002)(122000001)(110136005)(66446008)(316002)(31696002)(2616005)(38100700002)(558084003)(5660300002)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGhub1ZFSHI2OTNtZG9LZ3BpT0JqYWhLZHBQT1FyNDRGcFM5MWkrSUZXRHVs?=
 =?utf-8?B?SEQ4NklpNEhFTFVnVS90RXRHUFlRUUZveUs2OHpQejZKQzFvOEtZVTc4WU1U?=
 =?utf-8?B?enIyRnhmWVJsVEhKT1Zxc29ubVNSamY0R1NNZEtKM0tOdEwvakl3dmpEU2Zh?=
 =?utf-8?B?dk1rbkhlNjdNTjhVc2pkU1UxNWt2ZlhGdmJhMGY2NUpPRCtFTUVmTDFaSDQ3?=
 =?utf-8?B?TzZtaUdwTi9kMElENUkyWlNwSmtGbWhGUUc4bVlpSkwrWHFIQVVnRXJORnE5?=
 =?utf-8?B?R3c5MnZFR1QwOUNGSWkzeis5cC9YY0RUekFVR3N5UUJpb2NtNDEzaUt4MXlW?=
 =?utf-8?B?RXlYMEZxaXA4aTVEYWVHc3hrQmlKcDNWSDFaV3RFK2FpZzVlQzZwbmcrS1d4?=
 =?utf-8?B?bFFyeTlIaXNNZGFwNjVlKzdITkMvYmtkK0NLd1pNS1NIam1KRUhsa0FXK3Bp?=
 =?utf-8?B?cTkvQmVrbnEyWDNQNUN0WnNidjB1dkI3UHZCNTFPUjMrNjRLSTJBWHJ0N0Q1?=
 =?utf-8?B?UU9xLzhHQTQrRHZ5WnNCblFJN0xsbjR1NW5QUDF3OFAzaGlqanU3VWdZQlI3?=
 =?utf-8?B?anE5ZWt3SFNvOHFYQThxMFFQTUIvU3k2ZkNPZzVJZUtLYlRYSkc4bDczTHhC?=
 =?utf-8?B?UjVCVnI3Wm1HZis2R1BzWm15RFFSSkZVNk4yMVZKUWsyL1NtNlJIS1NOeTdx?=
 =?utf-8?B?YiswaitDOWo2dllhS0tzQlZWL2wwc3ZsQS9VaDB1SThDNWczcjN3cUFLV0kw?=
 =?utf-8?B?dFg1YUJyNXlScmJnbEhuQ0NmNERqcElyeXRmS0NxUnFMUWZXTVgvOXRkaHp6?=
 =?utf-8?B?QjRFbDUrTlhOdFhzQnFrTk5ZaXc3T0FhQWhOTTFIdmYwZnE3aFBKUWRGTWVs?=
 =?utf-8?B?VG8zdHEzTkZwblNYckhRc1gyc3g5WCtpdG1RUWRwV1Y2UW5aNFNSdjNKN0Vs?=
 =?utf-8?B?V1Qvc0U3YXlSWk02T3kvd3FYWTNLVFlvNHdZbTRJS09iN0ptdGRMWHdwYjl4?=
 =?utf-8?B?YkpJb0E4dFU2alRzNFNJQlJJOUMvVnp6c2RwL2IzR0EvWk54U1dGUVE0ZnM2?=
 =?utf-8?B?eGR5UHBWUGNuc2hQY05CRXlIWkVlSVNxbXgwQVoyTm8zWVBSalBtZ0VFcGJ1?=
 =?utf-8?B?dzJzLzFJL2hpK0l1RGd2UDlJcUViUG5JVDhNeGZRNG5MOEt2cWdjVlhWNk5T?=
 =?utf-8?B?YktPN0NUMHdLaCtxcU5lOXhiNlVEbkhlUWthdnNRZGdQMUxveU1pK0NVUW1D?=
 =?utf-8?B?WGVzUWV3VmR2TlVhOFFDQ0RSTnIvblNObm5VQ0lkNzc3QVZKLzl4K1lRNG1r?=
 =?utf-8?B?aU45WmVaM1ZSMkdlWHJSWmNNbForSkNlcVRodjdOZnpBWGZYR3R1bWRFZ2hD?=
 =?utf-8?B?OEtOMlJ0SWRxT2FSMURtQkRpaVp2czRjR0FxSkNJYXpFQzhzU2JRTFJHTUVQ?=
 =?utf-8?B?S1lGakM3VTNQdThnZHlYRGZoN283YTNRTXViUUZLZHJ1ZGgxM2JuNWo4d1l0?=
 =?utf-8?B?NmxWbDV2SStIZjk5RE5DL0Q5Q0MxOVBobHhFbi9DUVUrS2xwS3lrZ2VZeEQz?=
 =?utf-8?B?ejN2Zkx1eHVqSlRlaXpyaEJGUDhuV2JZbDZzbHBIb1dmaGcvOVFvQUEzWFBM?=
 =?utf-8?B?S1FVaVloN0pCUHFSNEp6b2NYdU81S0Z5akNDYW9EOGM3SWd0d0w3N3F4ejNm?=
 =?utf-8?B?b0pub25uc0wrUitxVTlnWU11U1VqdXMzeVVEcVFOUUEvdkp6dFJ0T3Rvb2JK?=
 =?utf-8?B?VVp5dXRLNXoybHdFYVVldnROeHRPaXpiZm9QbEFMc3A0cU8xRkVaN1NZa1V3?=
 =?utf-8?B?eEF2OVNJVERYM093MUw0WW5PdFJxWjdhamJGSC9PMXBScCtRNlBiUjNTQVpo?=
 =?utf-8?Q?FtJjPPAHrX1bF?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1ED72F7DA3D69418850719937A34BE2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280bed62-79da-431f-9ebe-08d98e00a311
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 04:19:23.5221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rEMbFJLxqNR9YU8Jnjub1lXFiC3nIkJHv7jvyZZ6qioZtWk6yP00G7X7EIJglmav42a3YeGTRbYGvzwy3t1RUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTIvMjAyMSA5OjE3IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gQklPX0RF
QlVHIGlzIGFsd2F5cyBkZWZpbmVkLCBzbyBqdXN0IHN3aXRjaCB0aGUgdHdvIGluc3RhbmNlcyB0
byB1c2UNCj4gQlVHX09OIGRpcmVjdGx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3Bo
IEhlbGx3aWcgPGhjaEBsc3QuZGU+DQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENo
YWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg0K
