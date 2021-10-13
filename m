Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFA6C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816E660EDF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhJMEYL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 00:24:11 -0400
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com ([40.107.236.59]:50368
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229455AbhJMEYK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 00:24:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bny7Q9Hi+rze5+PXBueMOLeNNMx5Ut+5/LtDor0u+ijITgFlcGxPrYCgRESv2NhVl1nzy2J3SILwyHX61gQzPms4p1GSqOC7Vdn8Uyr1JS35clf7OfonAxBXehwX20LtIAtH+90SoJtOrshmIKRbgfUluQtEkh4SSg7Wc/aKmfI9AIqzOEKwAACMXwDpmKW6vkcq3L4dM8CWlJUO3NcKXm2UIMhp0x4e4MjWPVSx73FQDp4kIiVBphIAZDgpRVNy4XLCAJbBtq+cxdOIsHFFeOHtNDZbDjhbVqEd5U7ep33EbAuhP8TgztCC3hGoJuE/WlLDKH9qlhUusR2lcrSfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XxxoSneSCojodYjlf5oO9KssUENe+hfRjBduqxkCUk=;
 b=lUpgtAxXY0axzy1BxsWXJ2MMZq1ELKeEKxV8Piu/kHeoa+/e35ENyJtXNwbEmX9/ZwMgPFKSf0bgS+yNKADAhVEEiXKW0fyovyxk5ck4L4bA3U9GsC8KXm6qFJUd4pZ3vr0HFjSIHhqfdwPoSbCf94K2fRRpqRAoZqkVTyCDKOf+URywK4OIfntVe/jDETLqVgmAsZN0q4GrKwUvrPGwIDMdpXV5S0aJjeXEyyOSy0f0A/+6UH262nsmIm5t/2EVlmJj4oK3ls90HxH7ER9lykoFMym7D17YuOwIaH41++BrhILa0kt6F3SviRPSZWfrcTJ3mHl372kNjGzHYNT17A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XxxoSneSCojodYjlf5oO9KssUENe+hfRjBduqxkCUk=;
 b=IVuTOyG8Jn+rD6BP/p7zyLwikkzd183yP53AI4555L92xxWmdxJLy10eJokFdTjCvBwdzyqL2CTzo5vziWd//i1vYgUJLX+a7a3naYY4p2eGEx5TcWHmmoMlNz3fRog01Fvp4xKQRN0OpO5ZbkEcbZlbN3iEkjaKozILrChBQrAke2oVI2K+0ewUsmNbwT/a1WgSlsm+vTUUinlB3+3yFI37qzrHP6xhE+y32QK54AKEZ+VwLuhQeLMUb3F6Oya7MFQhg773XOYRmL73hQ+b8I/8xyzL3guwhViUElCVjcQUJl165kEdWaSTR7jJ0spyQR2lQUHlIwM1CXvS5t+iUg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 04:22:06 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 04:22:06 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 8/8] block: mark bio_truncate static
Thread-Topic: [PATCH 8/8] block: mark bio_truncate static
Thread-Index: AQHXv4YcG7738g1/WECDKuvT1MCI0avQVLgA
Date:   Wed, 13 Oct 2021 04:22:06 +0000
Message-ID: <299df001-a674-f365-fd37-25e47dfe4a68@nvidia.com>
References: <20211012161804.991559-1-hch@lst.de>
 <20211012161804.991559-9-hch@lst.de>
In-Reply-To: <20211012161804.991559-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54365eac-13d9-4e3e-5865-08d98e0103f1
x-ms-traffictypediagnostic: MW3PR12MB4396:
x-microsoft-antispam-prvs: <MW3PR12MB43962732B57E50F4377A4FFBA3B79@MW3PR12MB4396.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:534;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ttd1nZ3MFp5p1ZBbAeFy/X5UXprFLQ7j0HrBkNnVe3fvnlciZmRGKCu7YqaWgN4l4PswBasElBzu1SxfWoI12alt2WSHmC8q5DuBTQugbEfZ0cE0gcq/WA6l4dM+ak7dv77kSXLAnI700xyLq2HRbDcpV3Ld/BIKo8ZJOWRHsMlNiql7i1iqMiognIdIwdPR6BI1YUnr08hCtmQNmgnNRADc4AhxOQRTeca0Zj9Liho8ghTF82M1I4nCxv7xrisnq83v3EXGNx87iGkb5ArXT78wevA4zr3rTZEWpsqNDk1Lu+NSd8PkVIkp0zdjiBbO/fwM/h//IFBBL5cNsfyX45oCIPv+nxhSSjRf+qHVrd/BA0I+Xn/1a1qFDuiMkug4Lr0t1Z7CZXFRFFwu2NoBioFCOU/zF6NVwA6X+LBnCqkr3wU9jLJteDZMsBeaSx5OCqe1UzXegccfN4kELg+DFPNAtdGArj639jdaCpK3z6H13YVC1Rg87fG93lriG0ZOtTM1otsjqYkDdTks/Gvtb2xcdzG+Zpx3kvtj4Cw5AgIe+WLMNv9RQCvVWNj7eAPQ0+LN+3tB/HBdENpimhn5xKCQ1PAqYn1UHZZJBJQXJy8fNVdnlr146k7R3DV633G2UHdH9HK4zmIQwZCrkQGWEsCDT9Ac0d7D+Ps7W6qOwT1ryEg9WG5VsXAJSpgDr7mSW+R4c5BN1eGm0VouZ2l7YlMrZs83sWy0MbAYt8iAATYCH+H/bbPCQXCHzJ8+q6E8fcxgGsvcE/gmHQJ/XMwAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66556008)(64756008)(76116006)(66476007)(4326008)(6486002)(36756003)(38070700005)(8936002)(86362001)(186003)(71200400001)(6506007)(91956017)(508600001)(53546011)(66946007)(2906002)(122000001)(110136005)(66446008)(316002)(31696002)(2616005)(38100700002)(558084003)(5660300002)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3Zlckk5Qkd1UFJ5VXpGK2tGQTcxdmN6U0txT1JGUThVMnMzWXBaa3hhTTg2?=
 =?utf-8?B?ekI4NkVIZ1l2Sk1tbDZkZTJlYUVUaFdyWGtGNTFiVkFjaTdlck9tSTFOYTRI?=
 =?utf-8?B?MmtOZy9zOE9VRkNxRVpqWFRUYnhkSWRDdUVNODVJYzNOdFVQSzlWelRiN1d5?=
 =?utf-8?B?SFhWd3pVVElSN1FJTksrb3BFWS84YnJBYmdOTHNCV0U0bWlJVjNqTUFzdGsy?=
 =?utf-8?B?NGlWQ0laYzZRUGZZbU8rZ0I0NzFJb3RlaEgzejZ4NkYzTFdjWmtDVUQ3Mnlm?=
 =?utf-8?B?V25iQkFwRDRpTnhRdlBjNytKVXJWK0toRnlvbExIMFhDOE50dzV2QjRGMm4w?=
 =?utf-8?B?V1BZTlZZMTVMOXRoWjB4eGVXSDk0YjQvY0xBT3ZaL0hiempnWEpDZEVRUmw5?=
 =?utf-8?B?K0dyMzZLTGkyYWhCaXN2OGQ3WW1ZRUJENWVPekVQb3VTaThhUGxIVUZFY1B5?=
 =?utf-8?B?RUlTMlg5MXZoSUV3cDk2anBJRSt6NUpYRDM4QmxrTlNQT1ZmMkd4ejBnZTNH?=
 =?utf-8?B?NkowczZ0ZWxEbVJpazdEZHRSVEx5VHAxNExsOHZ0d2ZKNjlZL05nN240bFNR?=
 =?utf-8?B?USthekx5MVFOVyttcStvRGhIaCtmV1BNRUJ5UFpZMnU3clRib1drRVV5ZDkv?=
 =?utf-8?B?OGZYWERsQ2x0a3NyZmJ3d3FTVEFsSTF5cU1PNkF5eS90c0RBazVEeHBUQmxm?=
 =?utf-8?B?RG5hWC9ab05qQ3NXTElSZ2VLMlgyQXFyVEFDck80dmt6UVU4VHdQalZUeE9J?=
 =?utf-8?B?WjZVK3U1blZzRExJeTBOMW81VURHTkc3WThFTEt0Wmg3RDVqcUxqUEVXTktD?=
 =?utf-8?B?cmx6dzRzOGpZenFRQS9QMHI5cXhnY0hhSmlkSHRJbVVmYkxYUkNqRVcvZHgz?=
 =?utf-8?B?azhMZ3RXdklXYmIzKzVvSnN5UDVJMFBJVklEaTV1ODVFVVdIdGRjNVhHNXVh?=
 =?utf-8?B?elUxSVNKalFJajVxUFMyd1hhRlpRTGx0UFdualZTT3ZCS0NzenFxNENuYW1l?=
 =?utf-8?B?bHRqdEQ1VDBPL2ZLNlNHRzhzOUxuM2JjRGxWQVNYeEVkdWFMRzV4OUVzNldS?=
 =?utf-8?B?RGZ1OVZ3TE9CbURac0tpSVppdyt4dFJmVUpRNWRRNmZTWUFKK1ZhYVpMUXpB?=
 =?utf-8?B?WWsyZXhxTjVlSHY0em1wbGFRaUpNUFZmSlBjMEZ5blVCNjFoT1JhTmtaakNS?=
 =?utf-8?B?a0t6L0hZWENid1p1ei85Z21hVGFKZ1h1dkFBdW5oeEFUL2FmMFh1aFJIR0JL?=
 =?utf-8?B?L25HTy9ORmYrdXNWRXltWWZCdVVTUFF4bUE5VXRndlc0ZTNZSTZBWXJxMWc3?=
 =?utf-8?B?Ly9HU2MxeVBNVTJJeVFwTVc5U0EzdW5MUEFuempneklod3NsbTZoMG4zc1d1?=
 =?utf-8?B?ZStwT1V2d0ZNZUFWVS9SdWtSVkVGcHEvWU1qRUpRVmU0NW1FWk4wMmtvRUxF?=
 =?utf-8?B?dGJ1T0JqUzVLa0ZpQ2p6akZDSUhjbytTN090VnJBaFU2MDRwczZ3R2daMUlx?=
 =?utf-8?B?b0tNRGRQNzBiWW5NN28vcVJKTC9BdHEvQy9PeUVSR1lPZ084SWV5bmt5MnBa?=
 =?utf-8?B?M1FSbWpYSDN6YTJ4bGhERXdnSktQZ3Y3ejNvblJ1Zno3TFEra0tRUHMzTXN1?=
 =?utf-8?B?Nm5CbzRJMFh5cXdxS0M2YmlheHU3YmVOdkZZVE8zQkdXNEZlQmhpS3RJNFRv?=
 =?utf-8?B?YnZ1aE5YTVdIL091T3FNT3JuWVpzVUFGMEVTYjhRQlZ4djhrQlFna2cxbUZL?=
 =?utf-8?B?SGxISWZKYlRNczU4Y1c0SlZRT0NUMUZabnJZcloraTRuYVdhZUpnTEYyQTZT?=
 =?utf-8?B?dkIxMS9hOWxUWWtJeGtteU94M0tGdHpKc3d5VEp4dmJ1SncvaTJKR2RrZzdG?=
 =?utf-8?Q?mBS0a8wy1gqRF?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <10659D01B7274E4BBF85A4A2060E743A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54365eac-13d9-4e3e-5865-08d98e0103f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 04:22:06.1086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ib8QkaVlN5nEe90gMQxR2l+9YzXxAfS1y0zKS2UWsRIBvBn4sSxUfyqji+e3wgwXHCfoZbNDxSxlcf1AcbK8XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTIvMjAyMSA5OjE4IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gYmlvX3Ry
dW5jYXRlIGlzIG9ubHkgdXNlZCBpbiBiaW8uYywgc28gbWFyayBpdCBzdGF0aWMuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCg0KDQpMb29rcyBn
b29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4N
Cg0KDQo=
