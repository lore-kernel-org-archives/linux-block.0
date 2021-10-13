Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760A5C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5952860FDC
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhJMEXR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 00:23:17 -0400
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:32705
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229880AbhJMEXN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 00:23:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvUXOSUUgDPLvhHAqMsg9w+9aVv62+MM0m4FeottkZPdJ1SDHg3vGdZeR3MVLHfAunxvDvMBRJsH1/ea74sufzyV0TgH3yFkhnqgjUStGRfL+Ynw4yErXOglaZKEZfZ687qGuEH0XZAbKQcS9hIAj5uVXz/PvZDaFWfAYrR0soJSvhHGwb1bLZMMA5sBcN3XpvikdvG8846lFJmcSqyFZ/nv9x5rOY1D3G3hvV+kBb7WsU2rlQUsxgrXsreojEXdlKCfdcNSwuxUrr2cr4zF0Ny56hEMJIpTwWV87vis1lxFKIJjSLFirwXv7k9zgupcsNbGQ5kNteaZoTCraAlk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8hfCbZxIJJU8l9Ark4TATyO60AVqMrKkdEE2oRt1V8=;
 b=UlDl8kKWM2Ri+AZOs4W0Fod4Ky4WRoaLKvVI/UK0m6NiTWRdVSLxliXcEXxpRIcQoKfx/mUrQWPAqEBrlkCDmXwq2+NeGLBU8bdQjNCR3j4gKyRkh3w8VqyNtf284IimBCjfS4VCxxcg7JIyYEl9zDAci/sD39ws+a53ZUmO4fp31EwIyMhH1urCzy+nQJcSf17LLoLjsViJ1O/3M6uROl3SywuyXm61sTsNzZhdrfwCpV7YAtIQu63SlAeNOz1smHAbyxG/O6Q+Cfhy/JLy1rE05grMCvbUI6r/RB5NgdLLLN6I6UZkUKBy6MJL1MpN9z9N/ehO3r983tvtvlXzRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8hfCbZxIJJU8l9Ark4TATyO60AVqMrKkdEE2oRt1V8=;
 b=tA5+2MmYHAX4Vg+a/ZYivg6qkE6ioyWcwd4075v5PgqXAnsk8fEGKqUZdzIXSHIXI/HR4CRozBYURuwT3D/+fPqTgnSL8Etb0JkgusX4NL/yQMyAqBfZ7oBuqm8131TCYJZKztQO3uHi2k2sba40XpvmZOqCeVUPdhR0eprNYn44dAiBnKAPYEpzxKy5U3yGqcQddH/Ijjciz5Eo9r4AgUTd+syIUBIAnv3Pa0kibwtGJaVuvM8gKsqxOZJl5QbxsO2z36tMWvjrMJC/hQiRwCqIHZKtmD515e7ygOnL94y1VDwpuywvdUz8F6rYpGQci3XhXSBmsgi7QjIS4apQ5w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 04:21:10 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 04:21:10 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 6/8] block: mark __bio_try_merge_page static
Thread-Topic: [PATCH 6/8] block: mark __bio_try_merge_page static
Thread-Index: AQHXv4Xbjf+ubhtRhUWjwRCjLavhY6vQVHYA
Date:   Wed, 13 Oct 2021 04:21:09 +0000
Message-ID: <f412c54b-a6b1-096d-ddf4-40e576c40baa@nvidia.com>
References: <20211012161804.991559-1-hch@lst.de>
 <20211012161804.991559-7-hch@lst.de>
In-Reply-To: <20211012161804.991559-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0028c571-ce9a-45a0-b684-08d98e00e281
x-ms-traffictypediagnostic: MW3PR12MB4396:
x-microsoft-antispam-prvs: <MW3PR12MB43961998B8C021E4495A631DA3B79@MW3PR12MB4396.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +4ZQ4yMeWEE21tkcVM/ojpT+PalyUolAiWWovsqLU/BqTWLbd7l84NF8rb3dXee6Rn5UJWSEUXw/WketaNEf/V5dqurJXv1pJnZgxZmPQObLJada1a+a9O/zOBpOC6c3fsmYS0fs2zvt3CPZxOycUGPX4bv6Z8oWromXrh9LtzM715Hq1Qyo7e+9tURmQzVQPMrOaoVt96KgMXHIc3HSjUwSTGKeW/pqAht0ljfEHF5xe3ejkYdSFIPsNO4+CDsVb7NTe3sB8FIsop9UfHKPPkZeFHchW+h6D8EZkdoVDS7lQvSVieyQVlUJ1fm+LV3Q4wkPvvv/+Ndpjzc8JkPp8DDxI29DFTUTFuoCqMpIHhfxv5fVV2DcpzYS8ECWIOCe8L3giz00PFeEPNst0UOpy05GD3ZNwOUPCZyEj3+c4CNLbYcWSuxbphKHLbsHO5Tz5R5OtNPZkl5vd5fF9kBesC9PMax3a1cz//nb0X+OyZvr/RNftLenX7wLm7x+Xa+h8u5aQjrjkXUds2cmXiS4H7xZy3JH8UZqrrd268AHKZ8zqMlxj5QAarAeY0tHNKvoevR6LQr+X0e2zCP4cV6PS7IWsxIGBciIn9CkvhmtF+udGRhZvJAZt+R3AXnuql1HWxdfJU+bVQHNTaWKsgzPlg+54xnUAo44m6oYxC2uJyKS0IoJT1jfwpgyjFFkZ4TqnyUY9J8YB1v/mWv16Ns2FdkDJP+Oh7LPhV6Tx1o4txcnQUpxwEQjuSCIHZGJ+nGNTh5j4OIjJofmv9CAAIz+Bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66556008)(64756008)(76116006)(66476007)(4326008)(6486002)(36756003)(38070700005)(8936002)(86362001)(186003)(71200400001)(6506007)(91956017)(508600001)(53546011)(66946007)(2906002)(122000001)(110136005)(66446008)(316002)(31696002)(2616005)(38100700002)(558084003)(5660300002)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkwxcG1rQ2d6K3Qxa3c0RW1NaEhBTFZ6V1dwejFTYVFZeWZEU3I3d2ZIY1J2?=
 =?utf-8?B?MjVIMG0wMjJJN1VOMHUvdklJL091TGtSZ2d3UGJ0WnhkS05XUExvTndKN3JZ?=
 =?utf-8?B?SkhQZWxHYU1XRkh2TEtxSFBYcnZFWFdmVlFNdStiMmdUTVlKTXpZY1pHekpj?=
 =?utf-8?B?S1MxSUFRdzdKdlVtL0FLZkprMkMvdWpQSGNoUGNidXh4MUgzNVlYc0w2dEN3?=
 =?utf-8?B?aDdpS2M2Q3JNNlRoNzJPdlVoa1A3MUFaU3R0T3lpb2tDZklYMjN1VldjVjZx?=
 =?utf-8?B?V1g0S3dEUHN2Rkd2a0VlRnNoTmFLbTBFVXBCK3REYStjU0VXUVg0Q3F6VmJi?=
 =?utf-8?B?MGNYazByWHlFdVk4T2pJUUNuQitTNDMzUHFUUHAzTUpQYm5DcHUxdmRUc1hE?=
 =?utf-8?B?V3NPNE01aVNyNTVvY3ZYQlh4dDRhOWt5bEZvV0dCelVNbVFhdzhrYW9LUEhT?=
 =?utf-8?B?aGs4UlhBZUZ1bWo2SW96WkptYWxobUNvRTQ4S1hLWWZ0VEVqZFdXMG9lR2Nu?=
 =?utf-8?B?RzZzVmR6LzBDTEJyMFhEYSs1NFIwNDFSbEtQUXBlUXdnZWpCUW1MVXc5aHlK?=
 =?utf-8?B?R0MrenpsaE9wa2U2ejdNajIyZVM5N0U4a2pOSG5rR1NZblNJVGI1ck9yL1Nl?=
 =?utf-8?B?WUxSTXhvMlczdiswb1QxR2p4eFVjSGFKQmZFYWozcjdnZWdMRVVyZ2dVNXN2?=
 =?utf-8?B?Z1hEUmxneUZxU1JJSjhleXlOb09tQ0lUbnJIdndPL3RTa3pxNkttZnhsQVdC?=
 =?utf-8?B?SWtLZi9tL3BRU2dSSk56eEpmU00zTzBibUxjNmdualVKNkhqU3Z5allycEpp?=
 =?utf-8?B?YkZKMCtmeXRSM1djYnFaa295M1orOHhPd2xVK2hBeVIxUGppb202MjFsQjRP?=
 =?utf-8?B?UU8rY0xld1lITzZaYndabVE5NG5xTm9IRlEyTXdaMkVkWnBMR1pCU1Z2TGtF?=
 =?utf-8?B?NUwySlpWQmFaczlLL0RIOEJaRFFVZXpSS0VUaHJHL2pCSENOcUlXSU5qdlp6?=
 =?utf-8?B?MkZ4YTA5VnNEZEN1b2dGd3lpOWRsQ050alcwUnFWZ0pYbHYyelBFTExrOHAy?=
 =?utf-8?B?aUdWS3VEd2VSZWJPNUJaQWQ5K0pvSHd2QUFIQVBreGxFMWYwRS91MCt2cExm?=
 =?utf-8?B?dXJGTERQTDltK3plbTdHblZMZ25ld1ZNL3hXNlJrRnd4VFQwYXU3amVBVXo4?=
 =?utf-8?B?VjZQR3RiSkVYQlFXQjNRcGVtbE9PVEQwYTM1SnpKR3J3VU5LbHJaL3YwSmM2?=
 =?utf-8?B?dmVBbnZqeUdiTnNrcG1JdDBqNGxNYmNkaTJKYWkxbEk4TzlOYWlxenJlWXV4?=
 =?utf-8?B?L2NkV2xvVHZyVFROc1dLVGllWmZ0NVZXRUxpU0twZG5MVk9LZUNDZXhqWXRy?=
 =?utf-8?B?SHV0LzdHVHNHRnJ5bzFqdUZ6MGlNTGdGVWhYcUJDV2hqU1RSaDc5OE9kZVF2?=
 =?utf-8?B?OG1aNGwzS0ZpbDAwcHJlbGJTU2NzYXd6a0dZc1F4RTJYY2NCa3ZlK2MzNm1D?=
 =?utf-8?B?SFl2OGVHSkdDdFNENHVWL1JvbU4xaUxwRlNTeGdGYXdpUkNmaUNET1RoYWM4?=
 =?utf-8?B?NDRyUjBaT2lIdysvWmU2blM2RjN4aUdJbzJnanVZejFSbU84N0kvUTNDQXdD?=
 =?utf-8?B?RUNBdit0UG9HYVpzMHVaMFVNMysrRjlaSk5MTUgzdjllM0pPRTcyS3NKWktp?=
 =?utf-8?B?REhtVHcwNjZXMkZVZUpwaUVOQjc1Z1pRTWRHV0JzK3VOZ3RGK0Rhc1pwenFH?=
 =?utf-8?B?b0dFVzM2c2VSUDk5RVgzNW1GckdHbU5xam1zWWFHbUk2akQvZDNWYVJOcmZZ?=
 =?utf-8?B?VjBYaHNhNUJOQzFsdmc3bkhjd1RHeklPcTEwTUZiR2NTTUhLenNGRllGUGdm?=
 =?utf-8?Q?BaCqU+vQx5d5i?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB20C3E164A0E9499A6836F84B738D0C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0028c571-ce9a-45a0-b684-08d98e00e281
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 04:21:09.9822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GN0ZZshQ+bSZciQJjo3N/VzMJ+qv5bawcd+bBlfUpadFRUlodgbKfLInGp2OT0KigfGXeznGZKZiswbPJWz1Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTIvMjAyMSA5OjE4IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gTWFyayBf
X2Jpb190cnlfbWVyZ2VfcGFnZSBzdGF0aWMgYW5kIG1vdmUgaXQgdXAgYSBiaXQgdG8gYXZvaWQg
dGhlIG5lZWQNCj4gZm9yIGEgZm9yd2FyZCBkZWNsYXJhdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KDQpMb29rcyBnb29kLg0KDQpSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KDQo=
