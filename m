Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CCEC433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 00:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbiF1ATS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 20:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242522AbiF1ATR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 20:19:17 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384CA12748
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 17:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyEdEpaI14MjUYE9sARb4RgLQUPJtDdjgC4UDYED4r/NCTflyP3LPxOMxLo7hHdfG5yYJbIRXLDOl6PDwrSLjvsE9hnCF6tbEzVMnZedbSqgckyeZA1V5SY3A4HQoxfyrSJBeSKZRTRbljE376jyQgQKSYHNbSYaMkBVqBgK5/+VXQ4JAoYMIa+UhmSFwi2tioIMz+462YkuX1V9KvkZzP1nYDW41DK1JjqQw5pICpXdvkFXC+wwYnR0mAZCmbUDLPmLRL90l4HbSYPB7VUKQPQ5Mac1u2AMWpOf6OF1PRSZAFSwVr0aUskhn5mEcwbJC82UkYGMFaz1fmvyYd4nGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIYUq2No7zBuXPBHKmIb0rgoq1dlDtfLfew0u84x8a8=;
 b=bEz09zy/GWbWPDnUF9O9PakRv12ZznDycuXZwcKRGhtfP1erz1lqVBbH2ZPLBcYYdV0xP3yGAzKEWBjb7svTSIMNudQqbcbkWnn3hjDzUPu4rB49pjf5ZDb+TMQnM5xKjTcRjsJLdOhWqhQNnMRuXAK0Acep7FHa3JCUjtBPf7spUAI5G3tEsXozjD/kLbMpxA0Y9uasZYJlBZ38+00pMdaJJb0VRrYaUwnV4v22DS5tZoecW6p9I3r4eA6vx8D6u+bAu1kO2sogi9V+s64J0dYtUlAPMVkxbhcLerlM7a6gGRrLoXA+frThBPDnlnf/AEn68xTi9Adbf5u+ARbIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIYUq2No7zBuXPBHKmIb0rgoq1dlDtfLfew0u84x8a8=;
 b=nEyUdsATjo9SNJFKaceCTP0WiwzT/EbJW3Vnu8rJ1jzYZOS9EmDoTOQfjROyBQYURF5xeJ7TrJ2JwrU8kVLs5jvnblcAuSy8XbJQieVIV74xGnr+6cd5cmJluDS5UUE2aF5hvc5mqB20RDCk3rUPp7bA0YEQTsXVYILf8RjeBAnnf4R4+W2mDoOjWlXjsTmB9broEAxejsWFiqqKaPccQP9gNj0Uk2FUroSkTCLO402Ih1XpWlxeItWUIZeFZJh3tNhcodUh04/UoHYuNqQ/2iASDPxioACNj9dxAc0lSOqMYWLx4RMtPf7Cc41/JUhYBWV9qFC7TIfvk9tVaX19pA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN6PR12MB2671.namprd12.prod.outlook.com (2603:10b6:805:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 00:19:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 00:19:13 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v3 1/8] block: Document blk_queue_zone_is_seq() and
 blk_rq_zone_is_seq()
Thread-Topic: [PATCH v3 1/8] block: Document blk_queue_zone_is_seq() and
 blk_rq_zone_is_seq()
Thread-Index: AQHYioSxTVL+3hRGokOojuOrzciFnA==
Date:   Tue, 28 Jun 2022 00:19:13 +0000
Message-ID: <30ceb31d-37f4-ab2a-54f1-221c0ef097f6@nvidia.com>
References: <20220627234335.1714393-1-bvanassche@acm.org>
 <20220627234335.1714393-2-bvanassche@acm.org>
In-Reply-To: <20220627234335.1714393-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43c82a93-de92-4a7a-60f2-08da589bd455
x-ms-traffictypediagnostic: SN6PR12MB2671:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /bLc7S3MnWsYZRAc/jE8RdqvmY78tT6v6WDPA12RaZp5qmlJi92By+L5zSAayZrbioaaqBau66GZfB0suKL3qbaxDrjegY3qJqQnR7qmXMXatLZVGb8nMXd8P2N/iNkWYH5IyrjDS56/f23+VcMg3yWdDIVjbi7z7mBLZSHgyR7nvrQnFIzzTfBTbSpF1Z+mJxWAHgR1RUl70SyBaMdMz0i5v6wWXfibnBFAaHKehkWeLsdLQVj+5Z8xbJ851XGcqEmp2+J/YNXBR5SWxocQCKLoG1XAwHqH7IP7lglED4AhdFswZL3jywkIGRok7WpCtN6hC3/aSt/GH/NC6LiE1zDM9T7RX8wWjSEZMy/omZjyvs1vbhHEOg2nFbokghFB0qpv51xVKhuCdE21Qd4ENqqeIOih4QkPXgyX9/tf0pTXcAFVa+PV6MXyGwbleDXu1R5wKkqQGz1HWNQQ8Iic7HSx/dxfkUqndtTHkDjM0xr0qatO4huit3zTS4zJXxGuXY04g7at1ZNbTVcfRNQTHd1x35SLJgKqhKQ4iy8x20GqtsyX8gMsHBKf9pemsg9cFuYHaFTqa+vmLMHvcAEqVFa1j2j42Oa0BLxdypWGJEbyoL6v0O90RqZbGZ5W+JUdnGHVjAfCAvq4qCEj7bmHDfp0ZoZdth8e7NhkIY9dFFiaSnPmQ/t/uNoFulpxQ4PFBTqv3GfUijF1tK0VSzHovvqOJ7ByLopHg6J5Pa/y0wPWXekINfiyiXZ+I46oWcdWeQjf2mfCkAbEX2MtZom9lXSeGO8xwik+4JZ+ZG333yLmCy1OpVQfmQbQ84Tdbzpq2Cn7HmxkLVoaaUXYAGW/arCgNkakaazi9n37WPENnII=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(186003)(8676002)(2616005)(54906003)(41300700001)(91956017)(53546011)(6506007)(66946007)(31696002)(6512007)(38070700005)(66446008)(4326008)(5660300002)(38100700002)(31686004)(66476007)(36756003)(2906002)(86362001)(316002)(4744005)(76116006)(71200400001)(110136005)(8936002)(478600001)(6486002)(64756008)(122000001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUVRMnRwOGc1dzVmcTRHSVRiZEdVTUFKcXNUUHpJbUhCWElIZmtvblZHNWVW?=
 =?utf-8?B?ZFZoOE1rTGQ0UjlvcEtSSmh5UlRLWndaZEx3UEdRVS9GS2RoZWRENkd4ZUxI?=
 =?utf-8?B?NDJzOW9xZzhUa3NtdTBucXFoTXBiT1FwUEdtcWZzQnJxekw5ZU9MWGtvS212?=
 =?utf-8?B?WE1ET1BqZXNxWEF1VXdZUFpHUklDc3kxZWYxWTljazRnN2gxOTJOem91cTNo?=
 =?utf-8?B?OWVGVlpIWGJVT3RjSld1UTRQcUZTZzB0eXRsR3NvZUFCZXNOd0Q2L1lRY2Jq?=
 =?utf-8?B?SDJIblpaY0ZPb3QwQ0pRbTV5UlhtdHJWTFVDWCsxQ0dPdFJ3TGd5RWI4VGZy?=
 =?utf-8?B?REZHd0xxa0QzVHBTV3JJc3FRaEQxeVlITWRJTEdwc2JZRm82T3h3ZVlKK0VN?=
 =?utf-8?B?SmpZZGZpa2RHMCs4ZVJTRE1HUVVRUHNBZXFGZDVqMUJkdzRXT0lnTHlScXVr?=
 =?utf-8?B?dWM4OVFFZTY4U1FpampDM08zUnJjQWxJK1BjbGFYWlJsdkxJZ0Rwb2l1QWlX?=
 =?utf-8?B?QTl3emx3bUFYUkxzcktwSHVXcFFzb3ZSNkxmczZBazZOZ09JbldJVUV3b0Yz?=
 =?utf-8?B?WG80ditiNzh1OVVxeXJvVEpkeSsraVdLZmlWd0p1N2xvQzg5azNVRGx0SWdH?=
 =?utf-8?B?OFlOM0hZUGYvSmRJbzBST0prdmVRV3VJNTYvaU1NTjBoUzQ1U3Qrc2x0K0V5?=
 =?utf-8?B?Zi85bVpmQTQ1U0VPRWtRRHllSWtIR255WjJMOGN6ZlRNZEsyaG51ZjR2NWls?=
 =?utf-8?B?L0t4eXY0WU0vM25jYlA1YjBHVGRSaG82RS90bkxrY3ErRHlmWEtwdDJoVDY2?=
 =?utf-8?B?WHZ3cS9TM0x4RGRmSzRFR3htc1JBalluSzJUZjlMc0Z4OEFCNGY3VkhZandE?=
 =?utf-8?B?WU0vWmdaRDJoL20zSXIxZWp0NFNCaUNWcU9SOE9YSUxEbUpjOEx6c0NpOThK?=
 =?utf-8?B?MzdqbkJuZy9xd2dmYlZ3aWl5OXBHWUJUamtUZmI1U0ZOMktiMUNreXZRQXg3?=
 =?utf-8?B?ZzFFb3UxYS9xYXdkL2R1Rld1QXVUOGZ4dXA3eXg5U2R2SE95MklTUUM1N0No?=
 =?utf-8?B?NUxvN2szV085djlHdkNkaU8xWkJ6UFBrY2FLSU10ZXF6VWZ5S2ZpZXdZVVNF?=
 =?utf-8?B?NkNHWnFiZnFkMnNKSHNaMFRPeW5rbGgvdGtWOXR1RDd4S3UyMzNhbi8ySW5Q?=
 =?utf-8?B?RTYyaElLR25zUlExRElRTEJOSlpOMTJaa2dXWVNYUndJNE5LVCtMOURBNVc0?=
 =?utf-8?B?SFBXdkZlaUNuZzhMN1d3bXdYODhWTEtQcGF3b1l5M0IvU2pEcmVuOWxseUQz?=
 =?utf-8?B?Uml0R3VBc3lpQWdLalJPdElzOG8xNjNPajYzaVBSUW94VGhXV21RN3c0QzdI?=
 =?utf-8?B?UHd2M0FkbFUxM0ppQVZ1UGU5a1VCM25BeEdvUWUxbGxiSE9qN3FjeE9VVVp0?=
 =?utf-8?B?czU0UnNINGs1YTFwdGtWZHZLaHpmR2srbEFtQzRuNUM5eXJoU3N5ak1LWGs1?=
 =?utf-8?B?TGo2Tjcyak1QOEE2cFZRNEdsem1hNlBTYThLbXU0TlVqVmlIWThOSEtFd3FK?=
 =?utf-8?B?bTRNT3c4N2NDbFQwRVZaU2FKTERaNSt5aWx0Uk5MM3d4SkRjOXU5U0hONmtT?=
 =?utf-8?B?UVliNEE5YzdEaXUyRThqZFdJRThNbk9XK1phUGQyMVVWVkpGL2J3b3EyTDFz?=
 =?utf-8?B?bi9LOXdsTFlJcWUwcVVYRHpEZU5vQjdiZWdETnNaSnZyRjl2VitSenZvZUNn?=
 =?utf-8?B?bjBWRW5UdmVrMFpZeCtldnM2dVQ0aGF3TUwxTDhLQndhZGk3Ly90NkJ2eTVE?=
 =?utf-8?B?UWtST3N1UGF5ZXY4Y1dtdmpXL2Fucko4eU9jdnFxV2UxWGJ3ZzVDZkkwMW8v?=
 =?utf-8?B?RzhKM3BWT0NZSG1ZQnA3MkNTYnJmSXg1ZzNFUFhGOWtjdU9NVVVxdXQ2N3VO?=
 =?utf-8?B?ZzVnRGxHazBPVUNHNUtxVDBxZHhzVFo3djBFUGhjMjAwTWZRZkNRcU91QWIx?=
 =?utf-8?B?NzlRRFJPK2JJZVg1dS9EMmdoM0k1N3c0NHdYU1I5cmJkYjNzeWFjYmtiYStC?=
 =?utf-8?B?VVRUOU5WcWdjZ3JDT0pyTGVsYTc5R3pjSkg0b01Jc0xxM2xOMm45Slc0V2lL?=
 =?utf-8?B?eWkwcDBXUytWN1lGUHpQN1JCWERiVk5Gd0ZJNFFGeEk0YWFvYnYxMCtDcXFx?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A5428EEB21FE24AB5ED2359216B62DD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c82a93-de92-4a7a-60f2-08da589bd455
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 00:19:13.1574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P8gNBae9vMAMNumQnzHT2W0OD/sofYOz9fedvTABygjU0wtWXtJqM93aVT13WJm3kQJqRur4H6wZsrKsKaZifg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2671
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNi8yNy8yMiAxNjo0MywgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiBTaW5jZSBpdCBpcyBu
b250cml2aWFsIHRvIGZpZ3VyZSBvdXQgaG93IGJsa19xdWV1ZV96b25lX2lzX3NlcSgpIGFuZA0K
PiBibGtfcnFfem9uZV9pc19zZXEoKSBoYW5kbGUgc2VxdWVudGlhbCB3cml0ZSBwcmVmZXJyZWQg
em9uZXMsIGRvY3VtZW50DQo+IHRoaXMuDQo+IA0KPiBSZXZpZXdlZC1ieTogRGFtaWVuIExlIE1v
YWw8ZGFtaWVuLmxlbW9hbEBvcGVuc291cmNlLndkYy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEJh
cnQgVmFuIEFzc2NoZTxidmFuYXNzY2hlQGFjbS5vcmc+DQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2
aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQo=
