Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2DEC433EF
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 23:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiCHXVC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 18:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiCHXVB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 18:21:01 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E259A650F
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 15:19:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbjqSYesZOLce4B66zzJb5VN2fB9gGV+oyyzx8orBWhUTOT4ud/8x4y1TzRa4uXVmEEwSBGVJ16prS2cemO8G+ydDZFM1unihYGkRim4E5fkxPKuXRDH6WJZWy1Q6j3aLNHbL1f7y2+WNZ3gfYRRtEBtxYloF+4qaooeu9hSyzuM94fquDHp5jf0OT9/0X9TikRlJdAOotIrApzE1HvCD3GQT2rVpPxwprwJ8S6bal5nRDT4es4C8MiYm9tS9Cp6jMnm+FFf3QTZZgrpfPkgE858YHy5Y89KitUHDKVTJ03uSNsjzzfMWEGDooGzsnAgoOQ6GngFkLGJBZa/msPgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ul68IRTgWXmeMmrZA/R9kz6QnqUwtfLSC81xYPwHSEk=;
 b=V3CKZuDue87BZ5tmDHd7YGVBzpzO1tMwFIJ9Pe26KCwGe9otJVprEoAvt171wtjwwnvP/QgVZekY3ReBLFsJMXn21dStDxpFiQvamKRTjlV+P4sh9V0MCrL6g7CbqOuHZdFanM4O/9rulCGpf09M7Ad2318ZiQ1mX0Cw2lOil5i4ZwiEJ99DCfCUuPDbc1eXqGWczagD1yw7mLKLkIKePsI5AQ0VbB0nrZsJosqhjmqWiTq6c29DIv6DbzwOnI6C1RnvcqAKakqDiR4gufU2qED/cxCoV7zBb+HmCAHNa/BA702MhrbFHSbjmb+fJIAl52O6o8s/ijL5qBTCVRLQbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ul68IRTgWXmeMmrZA/R9kz6QnqUwtfLSC81xYPwHSEk=;
 b=W/XMIvg9esZv5ik7F88o/X/fMN0PYWoS3+1c4ghQIWOY8d8Kzxdh4c8i57OAmQuCizxhfgfrcpLqEu8ZEwo7TJEAdIl5fBd0AeyawtLJsV1rPp0Oglz8ujYlmiXJu+KpnaZp0rXyktxLh6GYKlAVJuQP+5/uLvDH42uk/PDG6UyNG/I++37KQtoWjMkOEZbu7Ak5YAqypGizMettQJygKuIiE/FZ9DkYaWK+VqzgM+1jV1ORw/wVbwwLy6wQSue0LFlS001UrP66dELjUqDWPeuP7GLjoZg27rZMkTsyxISTgAofc1dQpUGVla3MDQNf4LZTWrEXpXSxkAPGZdWIWg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 23:19:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 23:19:01 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 1/1] block: move sector bio member into blk_next_bio()
Thread-Topic: [PATCH 1/1] block: move sector bio member into blk_next_bio()
Thread-Index: AQHYLRNexrBInizkIUao4pXhGfLhAKyqY/OAgAvHsIA=
Date:   Tue, 8 Mar 2022 23:19:01 +0000
Message-ID: <bf552863-ae22-e614-9abb-07a884a70130@nvidia.com>
References: <20220301022310.8579-1-kch@nvidia.com>
 <20220301022310.8579-2-kch@nvidia.com> <20220301112527.GA2567@lst.de>
In-Reply-To: <20220301112527.GA2567@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a145776-1093-43b6-a5e7-08da015a07e7
x-ms-traffictypediagnostic: PH0PR12MB5403:EE_
x-microsoft-antispam-prvs: <PH0PR12MB5403FE4BC354A19F33525310A3099@PH0PR12MB5403.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HZJXHQ9lfYfOdDnLzKIR6KTU198+v6h3oqwsrtq6d/yydWkbPfxTa52a8QlX9XzY3ZNvJonmMbA02kcSWI0GE8oLmei74G+G517yW+zWtT6mEIWG4Y47KwPPyJlq56jjGlQWKiyi1XxTrWxEpumiCvg6RNoGXp6H5GAP9SPZ3GZtmhXcFhX8HXILijggv9GLgjQqgqkbmM30MvttCZUOW8IHW2jqJOnPgIvHp9JbaEVfVhFpQKRv1arbtmrBmODiI0hpQE71VxO11AibTmpg/7VgNPPGvbMZEFGYnBpP1fiNTriixdcoBmRGGZIQzu6nVbJI51OznyMJ6+jgg+BD4R++Jvh57Hm06Y2nyitfJyqGJ3xRash4RoOBy0p2sL4qOynI0sYaZJ7vQpB5+OIW+aH49ub2YVN38u2tGUaNz+SMquCA7U4/92D70yC/RYhyIJmrJNo7h+lvyutZf11Y7LF3ln/l3YVoiF7hGHcmh3G3fbhbGkiUj2lyYbcNgmB56KSF5YZcgn4eXvjO/R3sQW+pWql4rS2fmHX7o+8V82c9YixpMYswltulaa6fAHM8rzEW933LLPEx2h9XemgwRWwC/ogWMp6BfxQUAhf74zQssMcik7r93Tl4Qd4OQgH78yZxcMClmfswU1uF4XfCsDrpJpdRVtbn47hRwdFZDsosJfheP/Ym7KsQhBoYW4ivTSVjOK2yihxxQ18qtodzAuaCf2TKeAD8q8P4WDrZfUtbwyIYXogmG6Lz7/JKf6UBgRaeaB4oB0NTXzsJJsLkrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(508600001)(6916009)(6486002)(54906003)(26005)(316002)(31696002)(86362001)(38070700005)(91956017)(8676002)(4326008)(36756003)(186003)(5660300002)(8936002)(38100700002)(66946007)(66556008)(64756008)(66446008)(66476007)(2906002)(6506007)(76116006)(71200400001)(6512007)(4744005)(122000001)(2616005)(107886003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHE5UjZYbVZlWFArNFN2VTZZUHN5OHh2TzJxQlVoYmhvTFp2RlFCZ1ZIeTV3?=
 =?utf-8?B?VlkreWlZbHl2QlRhakVOMzJzS0lDUXd2SjNlU0RCZHBYZTU2dFZjSWw5czUw?=
 =?utf-8?B?bWNiMTN4WTE3QWZ5b0lkUTJmbVVxY2pTTWNlaW1wS0tydjUrMGkyaGE0dUFz?=
 =?utf-8?B?R3lmSjlWS1hGd0ZpL3lJc08wMG5ORXc2bW1wdHdyaDNQNGpJNDRhRUgwM1ZG?=
 =?utf-8?B?dWFjV3IzWnFKUjFmOWxsTUZJalM0MXV6RkliYlp0WW0zbWVrc1U3Z0tZYVB5?=
 =?utf-8?B?bXU4aS9GcmJuSmFldzBxZHp0WjMwQ0F3Z0NvUWVscVpwVXVqNGNDMzRDYy9z?=
 =?utf-8?B?bE84cG42TEJHRUZrQ25YOFliNGV5TVdUVDJJcFRHQitBNXpYZkJhR285NDdV?=
 =?utf-8?B?Z1NPWkZWQjZzTjZURFpDNExKSEZMdXgyZ3BKQjV3aGkweUV4MUhESmNGMzVl?=
 =?utf-8?B?cUdEK1FPUnZqTzR6SURENXJaZzFCcmlOTlg3QUxjaVNNRXk3SEM3b0NqVFE4?=
 =?utf-8?B?ZURCMUdpK25QR1QxS3FpY0dtak9UV1JJQWdjL2Nka3VRNFdPN2tEbU5hcHFV?=
 =?utf-8?B?NWIrQU1wKysrMlYyV2pwdkFDZW1XWWIzcVQxMmlIZTlsVlpkbjlCRElqZmVy?=
 =?utf-8?B?QnQ3TGx3V0pIbEF2Y3Vqc3BBODZxMzNNQ2xpbG1IV0o1YXFmRHZGZ2tqbnZC?=
 =?utf-8?B?QkEyenM4VmtGU3RRaCtDYzhhWm9Lek93cEMxYXJjSGJMdTc1WVpHalMxazQ5?=
 =?utf-8?B?eEZJdC82b0tvT3pCMWNSYnR5b3loRWN2ZUllOTV5eWRhRUV0d2txTEJFbG53?=
 =?utf-8?B?dm1NOU5IWW1XSjQ0bCtVbjNicDZwT2FLcGpHNS9CY1JmS1NEWkVhRlNDdFNu?=
 =?utf-8?B?U0x4Qmkzb3lWams1QzFPamNnZThtSThkNEJta1ZkK1oyalQ3OGQ5ZDg2bE1o?=
 =?utf-8?B?UzZkMnF2U2xvZTE2NlR2M2tuUTk4Vktlbjdyd0twVUwwMUI2d2d2RjZDL2xS?=
 =?utf-8?B?S1YxbVdxYnRLdjdLM1FHUS9XdDhIUkxqREorbm9iVWpzUFlaM2puYjYvL3I3?=
 =?utf-8?B?bFoyTnhQNXg2TE1LdndOMFF1RlZuQWxtSDFzWFRjZkI3d1JWUnROc1YwdnMy?=
 =?utf-8?B?SjFUTURPYytEMU5YazBZK1ZOaWJTNmI2NlFHQU9pS212cytzNmpLVHYvSnBl?=
 =?utf-8?B?NEdEV3NzNzZmUXJCSDl5Uk5ER2k4L1hyVDdrdXJRYTJ0Y0p5bFI0Z3g1TUFX?=
 =?utf-8?B?d2hZcW50L1pSN0tLZVhqUTdwN01Eb1NNZjlWYTNFYVNvb2ZRbDZZaUdCY0Y5?=
 =?utf-8?B?TGNENEZzOXBtLzVma2lndFNGZ1BLUUxsWjV6Ymd0amQyMlJ0Y1NtVjN3VmhM?=
 =?utf-8?B?WVRVa3owbTNjelU5RU1MVTEvRklBaTdmN0luQVFqRGlZUXM1dlhsZVdDY1gz?=
 =?utf-8?B?OXRDRkQ2YTZydlZ6OTMwN0FpQ2UyQ0dpRld2eGhyY1duVXFyQnc0SnBlVjIv?=
 =?utf-8?B?SjE4ZVZ5SFVhenpKVm93b254RTdnMVFtbjBCWTBpZ3pBSldLU0w3dVJvVDRo?=
 =?utf-8?B?Zyt2OUJMQVZ4SGgwK2lvQjJCWE5XVS9GZlk1dkhtcnFyeG1pQUpnWm93MUhm?=
 =?utf-8?B?TmhuNXNsSGFsTklXNVZCVFNUYjQwOGppRGE2cm03VEIraDJBbUZneXQ4VXNO?=
 =?utf-8?B?Rjh0Q3RJSHl2VEd3TDd3SXRMUjgyYjh4WnY3T2FIS1hodTBVNmlWTFpWQVRk?=
 =?utf-8?B?ZHplT2YxNUVIL2ljdlNQRWwwRWtiYkluYWhJeVJuSG5PeVFhNjZTTFFFT3BK?=
 =?utf-8?B?dkNmeThad3RwVVBFR3Z5NnJveXhZUVF6Ry9wb3c5OVFTNW1RbEJrS2NUdlNU?=
 =?utf-8?B?UXZFU1ZGd1lubldOQWhzd1A1RG9DTzYweE45QlhBMU1Kd28yb2hLbDhsOEhn?=
 =?utf-8?B?MG1ac2xVcFRwK2JtVnFyNVRVd0hDTzNJMDFGL0ZxMnNWMWtyQ24ySzkwejVw?=
 =?utf-8?B?RzJNbmZZQ2l3ekVCNnpBWWNwTW8xNzZNUGhIQUZBcU15cmZpL0hIc2d4WXNt?=
 =?utf-8?B?VDBFMGRLRDliaExaZmVHeUpVdkZES3NiSzE0akFVTWw1SUh6WW1jeUo1VjhX?=
 =?utf-8?B?V3JJM2xQOHdKSy9RODVGUXh6bk5lRHFtRTRYbmVRMTM1a3djdGg2RXFnaTY4?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD856F6BE93C3545A32A6D2ECCC56D71@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a145776-1093-43b6-a5e7-08da015a07e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 23:19:01.6402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PU6eNsRuzYjKDkTh1o6i6UGDjDZsKaxxAyN6ouay9z7Zm3EEYzVx1to1Pcy96Q/sKmHUbbxKOXi3Y3uUsG8Xlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8xLzIyIDAzOjI1LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gSXQgd291bGQgYmUg
bmljZSB0byBqdXN0IGNhbGN1bGF0ZSB0aGUgc2VjdG9yIGZyb20gdGhlIHByZXZpb3VzDQo+IGJp
byB1c2luZyBiaW9fZW5kX3NlY3RvciwgYnV0IHRoYXQgZG9lc24ndCByZWFsbHkgd29yayB3aXRo
IHRoZQ0KPiBjdXJyZW50IGJsa19uZXh0X2JpbyBwYXR0ZXJuLiAgSXQgbWlnaHQgbWFrZSBzZW5z
ZSB0byBqdXN0IHRha2UgdGhlDQo+IGluaXRpYWwgYWxsb2NhdGlvbiBjYXNlIG91dCBvZiBibGtf
bmV4dF9iaW8gYW5kIGRvIHRoYXQgbWFudWFsbHkgbm93DQo+IHRoYXQgdGhlIGJpb19hbGxvYyBp
bnRlcmZhY2UgbWFrZXMgYSBsb3QgbW9yZSBzZW5zZS4NCj4gDQoNCkkgZm91bmQgZXhpc3Rpbmcg
cGF0dGVybiBlYXNpZXIgdG8gcmVhZCB3aXRoIGJsa19uZXh0X2JpbygpLA0KYXMgcmVtb3ZhbCBv
ZiBibGtfbmV4dF9iaW8oKSB3aWxsIHJlc3VsdCBpbiB0aGUgZHVwbGljYXRpb24gb2YgY29kZSBm
b3INCmFsbG9jYXRpb24gd2hpY2ggYmxrX25leHRfYmlvKCkgYXZvaWRzLCB1bmxlc3MgSSBkaWRu
J3QgdW5kZXJzdGFuZCB5b3VyDQpjb21tZW50Lg0KDQotY2sNCg0KDQo=
