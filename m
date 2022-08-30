Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B59EECAAD4
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 13:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiH3NCH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiH3NCC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 09:02:02 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948D474CCD
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 06:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRCwGGRZAmt61QcuBczOSe0rWHawL51b5Bgj0huPBG3QBITXeicqDv2C0HkSOui/9zSSz9HP6AgluVAKWqxvYbJpR2qI4R+TUxbsRyzLrKh3hR6WKvQ2SdLDTRdfznfnsrHah44CRtX+YcVrqzHUHlUajAVTBknCSAbja2y/v/Dlx2zMOF4YZp3YeG1zZivS6KTe3KbYhcyBHl1hJWfLuwMS8EXz8CG2xwAW9IH3UEOiMMe6fwvLgCGm9MjScAy45mADTQJVmSIZmNNG8KGmcMGXsYSKpP7bK2fB+eRNUivZEFxS0wQxiHZbLBSPcB+cUPpMuxpcu9YgDQmJdF6/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zbp5vCvv56e6VE2T+eypbs84tcfSRQJLU2nhuuXv9qU=;
 b=kXQDK0ThELehEgfjsD4QpURx0A0waJ/XQFEssUWmKNdMnH1ZykC577MvO1eYuTq6KCb8EbsLbYHVqDF3Qq4ap7+NTQQt2MNQ/s0ebfvnaAjigK5j3nluMxAvb/jVuFDqFL+pxrv0lMKWD1PUJa8avYBDwS16C1r9w+IgFvJNehlG1XQ9kCXsTKXDJVINUVuVyJEuGQ7ocnims7V4VKo1Hy0c8Iu2Kb2nkotCWOKUY9CxrVGKQ3nZ2uBdTyAQQlJDT4aiW5iJ7uwdQEwO7S2P7Ijd2l+NlmWWvlI4k+J9x64RiIonwkCqEwMpY0sAAFK0CPd2anQTuXSFA9RMOdnISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zbp5vCvv56e6VE2T+eypbs84tcfSRQJLU2nhuuXv9qU=;
 b=lwdhveS0khH91PFwkg8YA70RYuBssfxPDP/cNiCysUQ0C3XZllQXLZRBIrHk/mKgFPt2pMfVqIAIONxfr9ANnSmKGkfnN9wzDq7Ug/rVOEHpDmFunG3zfqOCbPHlWf1q5H1fqMiuXOqbITIVZU34eIY9oFrkn2A9mrOzT3LJ+qb4BlB1lPwPWbSoXjCHDPNDU0sYwT/tvh9+PB1bSWTm2iDUeMo4r9EmTt6EMjGZIHWNFBnBve0dHllIGJIbUGkryAjUC0RBd5ClZ5R/zUJ+27XhIu2C1zgxt3aSZ9Kv0wMoJoYcflTo0//FDofC4pxBM0x6lTXuluuA1+Qjs1jvDw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN8PR12MB2882.namprd12.prod.outlook.com (2603:10b6:408:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 13:01:54 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 13:01:54 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/3] rnbd-srv: remove redundant setting of blk_open_flags
Thread-Topic: [PATCH 3/3] rnbd-srv: remove redundant setting of blk_open_flags
Thread-Index: AQHYvG2bM3XPUGKdgkSVvy/sfeJawq3HaH6A
Date:   Tue, 30 Aug 2022 13:01:54 +0000
Message-ID: <bb5863e8-35a8-9f47-c9a9-b3a8d45fa258@nvidia.com>
References: <20220830123904.26671-1-guoqing.jiang@linux.dev>
 <20220830123904.26671-4-guoqing.jiang@linux.dev>
In-Reply-To: <20220830123904.26671-4-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 935bd003-c223-491f-9909-08da8a87d011
x-ms-traffictypediagnostic: BN8PR12MB2882:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0XaX9rJOOQ/kuz+SdsCNdZe1Sxtko7o5Vg7QuYVy6LCjxiZkMRnagZzF3bqa6DkM5Lep5PR2kx7RVbymBHY+/UYk8i//1S8/EHpcRVp9DeUOrcXclVL7hrN5NXTtIzVB7bSAykZ8qa90nwerkCCRz2ftrN2d2pyQ8ajVQ+rVTfgDatH7dbwar3Xe/qXNyQ/uHQpsdo669f3D2ZSSllefFB78EIt4Cy2eDtdF68E/pDbBE/mD32grUi6bwfln78JsuAWd3j1Fb4+lDjMOif+626yg0MDZc7jmnf3uV79YM79Cy+h397UYpe8ipWpWy62mnMks83okpE47qPvp/9daGgR/59ydH6TtzfQ2oPmWSML3S++r5MRzxqKsFAxyI/F1ANDLmTjyPiG+kCSA2FGVB+7nWAR7OTcmjj8B7UrrveakwtigLPgWI2sOM0/T6VpYri1IMt9mEVkgqvzg1prUmNQf5kvOwojBRay0Wg4aNRudI9oHloAGQDpHygJ/2T3WpNIPfdhG2tpjg1NWwHfETJ0hyS4T7KUOwrSFr5DAX6Tk2Ox4kPcWYCEzhOqKANEwUZwU7HBBtnel1puP+CnGcnmv+R80CuhgNmgm08uvsEFIEB67BCvceot29IBDnDL1J6JoZEZcKVRXSe7Nmcqos9oEUvfLXUnAEEyNdBwxH0qNjGvagFEkqn3iWgFwYCqrdieAq2G/20/gqzk1NMrlkMOqp4QImkfPZ8SCNLW2oWGWQO/7YuVjfttcblfL2gxiO5s7l+VMi3g3FrhJww/JUP5XG4hVrQAyaWh5tEkHlkR+mBryV+BD1IwF1VHOuUvzXjhPiZfkaj35lpgNgx1jOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(31696002)(71200400001)(2616005)(316002)(31686004)(36756003)(6506007)(2906002)(6512007)(53546011)(186003)(122000001)(38070700005)(8936002)(41300700001)(478600001)(5660300002)(6486002)(91956017)(558084003)(76116006)(110136005)(86362001)(38100700002)(66556008)(66446008)(66476007)(8676002)(66946007)(64756008)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVk2QjZlQ3Q4UnJzSFRORUpYcWw3Yk5FQUt5S0pLVWlNMlJydWd5QkRxVzRh?=
 =?utf-8?B?TTZ2SHRsanBjTEpORElxZHNjdHZXTTEyYkJqRGsvT2lna2NocDU3YXEwamJR?=
 =?utf-8?B?Y1B0bkJPUWhNVEFMd1paVUFFZnBKT3BCMGpUZlh0Qm9DZ2xFSWRGUE1vNnFI?=
 =?utf-8?B?UjdRYUk1a0ZleHJyMnpaV1BPZGI5VGhpaDVhWjVXUi80ZXRGdW5BK3FUU2Fs?=
 =?utf-8?B?TTRGUE9RRm9sY013L2k4dFpHSzUxQ1FwZ1dLM2lzbmVnWURvKzdvQnpkdkk5?=
 =?utf-8?B?NjFhVHRMakRzVFdwS09FMXBTcDMwVnU4bEhCM0JmN1dtamJpR0RhdFBqSDk2?=
 =?utf-8?B?YzFzTnpMNUsxdjZUa241NFVmcHIwbzkwTVlyTEFNU0FRWW1KSzBxRDcyOUxK?=
 =?utf-8?B?Zmk5cjdKdHA3dDYxUnpqNmxzSUw1czNXak5hS3A3K2xlZW5oWjhDV1JLYlhH?=
 =?utf-8?B?ZVQ5dHRKeHNETlZjajQwQzNGZGUrL3luemZyN0JDMURPRmtTcUpyOWZHVlZt?=
 =?utf-8?B?a3NPdm0wYnFCOWZNV3VabzNmQzF1SmpzZURZOUZnOTJ1aVFxbGxzUTNpWE5R?=
 =?utf-8?B?ektvdzVaZTMxV0czZmFjcWxHcFJJUU02SnlITVUzeTExdXBsSlpjc2pJUkc4?=
 =?utf-8?B?ZVIxQWpsQ0o2bWFkUll1YlBINitsckl0djU4clBocXM0L1ZhTzdHM25WQkdi?=
 =?utf-8?B?STlsbzZYVXhFdlZVUTNleGU5Z2MxOGZtaXZLM2E0eGIwN0FDSUFkN3dtOFV5?=
 =?utf-8?B?SHl1YlN5ZXRlNXVnUGRUUnp1Z0VuSHY1SXlsWEY2RVI2RXhKaXNwZ3VPRHVF?=
 =?utf-8?B?K3lkcUpad09HK3pSZGpsZkJvQ3pRTzRJSnZrSGp2RlBVV2drMXNFcFFxS0Ja?=
 =?utf-8?B?ZlJSTis0ZDdXYzNMdWNLcXBGc25kTzUvR1hJZHNEKzY5Z3VQWEpacU05eFMw?=
 =?utf-8?B?MVRxOGd4cElFRW9Oam95NGZlOHpCQTBVR25HR3dwZGtvQ05GZFNzbzJ3YzJi?=
 =?utf-8?B?bzM0NFBjWDFsSWxRTGJKR3JsWVhPQlB2MVoxeGVETmd0K21XZ2pMVDVuMzhS?=
 =?utf-8?B?L1V3OHdYVGRaOHpyNEpZMG8vbXUzNzRMdW55VnVhS0Z3N0wxeHBvZGFKODJ6?=
 =?utf-8?B?TENyaG14VUd6UUNYQzFkRzZMTUNDN2h2VGgxd3p3dkU2dGpRZ25xZ2RPaW1H?=
 =?utf-8?B?MGNEcnhnMEVOMDRXWlBna0FPSWhFWWRCQkhRRGF0SG9lSU42c2FKQktWVDZt?=
 =?utf-8?B?a1RsSFN5V2R2dEtQQVNhcThqbkpzM3BranV0T1VlWkdCWEtEcEN3YWYvRTJY?=
 =?utf-8?B?MHBYU2ptVjJmd3krWlZyNVZPdlQxUlpJSm5mY2VPcWQyOUt3ZHVyZGh5dUQ4?=
 =?utf-8?B?cDVUNDJVeUJreDVuRXA5N1RXSDM2ZEkweG11Wi9oNEN6UWphOGtpckJTTUtX?=
 =?utf-8?B?UThNYk9Zamh6M0FMcU1HSkJtalNOTmNhbGE0eUQxVEtYQXU1Zm14SUdBemxM?=
 =?utf-8?B?VTQ3emwxRm5UVjFvRHRYU2lRWlNuaDVRQVhtaVpjdFA5WEJVcWJEazczZUc2?=
 =?utf-8?B?MSsvZlBHTWZxWWJCdmFMRURzM3dUTWIzbnVHMXp4eVErRnozRzY1K3hMZERv?=
 =?utf-8?B?MGlBK0hERC9sVU5IbWpkcXV4Q1h6KzVpSjFxeUQyTS9mOWZWSXhKcFZKOEQ2?=
 =?utf-8?B?eWd2NEFHTGdBN0VsM3Z5ekVvbjcyNnVnZ1BtRnZoZStDN1dzUDBzYVJBZTFW?=
 =?utf-8?B?MGNRTThyUExjdWdzUVhzb0t1eC8wSWh6M2tXblZmK0JUdmJlU25QVVF0UHYw?=
 =?utf-8?B?cG1JdVQ2bnR5Q1BIbi84aFBFVUFaeGtuZEppdWRNYkRiK3E4VUVXS0VtUWUz?=
 =?utf-8?B?azhmK09YZEVGbCtOZ2NwUGh2U3c5Qlo0S0luemdmMjJpMHU4VkZzc1BNRlFa?=
 =?utf-8?B?RWNmM3J5eUNkdGxhczlKcTdqOTJReGZmaVA5QWZRUkNzSG5NNXpHSjlzVTRG?=
 =?utf-8?B?V3d3M3J1RGpRQUx6RDVIT3RjM3k1OWlnaVY0UGhvdGhFbHUxV0FoUmhNZUM1?=
 =?utf-8?B?cmMraEZvamZyY1RyVVV3RDZjK3hFd1hmQzZtTEdWTVZSdXpJVno2QW15STRo?=
 =?utf-8?B?eDVOMHBLZEFTMkxZOC9iemJFaW55TXJyWUZiSzY1Y3ZjNHJUSzV3TXZSZU04?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8FABFB37111DC41A51B8B72A0195BD4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935bd003-c223-491f-9909-08da8a87d011
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 13:01:54.2066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hG9ia66wTfodN2zsQF+7Gn6MQtiTaqEM6YGbRAl+3b3AvITgEx1HuYLSLAO4JsIIXTKjP03P9sRar0OgwW5ajQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2882
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC8zMC8yMiAwNTozOSwgR3VvcWluZyBKaWFuZyB3cm90ZToNCj4gSXQgaXMgbm90IG5lY2Vz
c2FyeSBzaW5jZSBpdCBpcyBzZXQgbGF0ZXIganVzdCBiZWZvcmUgZnVuY3Rpb24NCj4gcmV0dXJu
IHN1Y2Nlc3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBHdW9xaW5nIEppYW5nIDxndW9xaW5nLmpp
YW5nQGxpbnV4LmRldj4NCj4gLS0tDQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENo
YWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg0K
