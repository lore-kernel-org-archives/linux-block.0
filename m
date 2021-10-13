Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900DBC433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67DA160FDC
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhJMEW1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 00:22:27 -0400
Received: from mail-bn8nam11on2063.outbound.protection.outlook.com ([40.107.236.63]:24800
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229453AbhJMEWZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 00:22:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NR7bhEz7oIdhXJ7Au78GMTY308nxGev5WTiS8lm7/Hu+M6oWWtOPk+yjtmGOxcaOiZzCds2e9zgNhoWI8NAEPma9DqLDaYn+8OiUu/toyKGr5DQeP+cDqnZ00q1RmkBqebK0N3c1x4MPiHiOKZQucL6d1jsP1TKSvnEyfhEUaQPu9PkMII1jd3gGFbeFPrlCaa49gNif95K6XtdRkkCPVO2sIZ0f+l9KMHObJ+D8sFPrNyW8XEaYhGEB2/Nzh1pj1PgSttZdyxgdsCuWZ7xfrWzj+KRGROfAf970qVsy4f/7QkPkdTX5qq90GomNiq0lRyoDDr+4lc+N8U+U2fCiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7yEfrnRN5JfqqIk6iEP4uO3Bsy2WlsEwdCEKaFvJP4=;
 b=LOeVDVzV6GQywnW+djLWOy2kW1TVnLv/vQ+7rrIsG14S6Ieye+b0HeOwxxAzZ6mU2a+WJNkqjnbtnA3xKBeOb/zvErak0rBNmCEsuVz6Tcn5WPlFSS3GeZKEndCvmU83GmU1bOiR+EtjqNIt4w/a5y7MZMEVcXpaaXWyMQUs8nxDyw4g7zJKaMNNMljxJU9Qt2/V0ZUTRY4j1VAu2OJ39fHoNGx12BgE1c2LVPYFy0LLBhtrE5KeBeyn8m/X/EEGQxF+3I4IDX9wyd8zjiL8jVkOljuvETvT4Hu1snixueX0xeVRcaI5vb0GA0dhZzvRgfP5mAdDLJm1HVtfvSAjRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7yEfrnRN5JfqqIk6iEP4uO3Bsy2WlsEwdCEKaFvJP4=;
 b=OSQLabKQnjbo3PBsp2mOqdKZKsQbcY2ziNEbPnG5eKSP1kXNnnJfXfXjpV41MDM3joD3ylyVa3TkTM9J3FdP9nEMEokMMuj6qK+Irh/miTqxx7W+5PZdVfMqBHLIoDkElGAg6JIB5kv27yICpGpU52aIJmenwS3r/qZIbZHBfLK3H64sErjwSOcU/2vsYnGyR9CuXpEiixcO77A/DXc5J/uVKZINvqoN9A95Q5oS4vrWLtOjJ/PDgMSwqVIokwhG6PAt5oh6Cbc87yZtxEhnFf92guPFxn3bpr/r2wQvIs3bCYJXKrfuNFEzOjQ6jQHnkqI5NoP91OY5Gfie71t/Yw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 04:20:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 04:20:21 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/8] block: fold bio_cur_bytes into blk_rq_cur_bytes
Thread-Topic: [PATCH 4/8] block: fold bio_cur_bytes into blk_rq_cur_bytes
Thread-Index: AQHXv4WUfUluB55D2kW4o4qGM38xR6vQVDyA
Date:   Wed, 13 Oct 2021 04:20:21 +0000
Message-ID: <24117c02-85c6-8013-dbf2-f3e0a0c10b9d@nvidia.com>
References: <20211012161804.991559-1-hch@lst.de>
 <20211012161804.991559-5-hch@lst.de>
In-Reply-To: <20211012161804.991559-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acd55105-4ced-41e8-8c91-08d98e00c565
x-ms-traffictypediagnostic: MW3PR12MB4396:
x-microsoft-antispam-prvs: <MW3PR12MB4396F5E492EC4FAFC7EE2AC5A3B79@MW3PR12MB4396.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:287;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2EQz6CQs2tpjI4Djh642lwx/F65jKnoE7vvV+pSFU+WKUFKO3IfxAmB/ZApMosNJk18IAuBRhHm9XQx01HGcQAcczEsXiKnJ8baikz7yO6PJY3rMJzZvFQW1cQ63oijXbl1VJ2WMBpYncRF5fo/lX1QZzm3k+uJUwCkDI2bgkG5pyvbuAPN8z/GJyswuyKXP1eUP/oyKsH2vKAr88QvHCUmDpSuRYeazYQD0t9TvKg77oI3QAqIO/+L9HxzF9u0tcPrTTjWNU0jevejlXbhXP6ZLw6TdXbzWkoo59Nq+/DcrxU6EhWD96EfjWTgPdTSFh7NGsViwe5WR0dqXAxT4THnQ8jFxV6fHSgKjOLezNU0cLgOuh9OxYhvtwcgxM7LO+L8oTky2YrEwmRP4lhFNjpDlDYJLgp35Tys2Jbip4XJF9Ei5aXMvx9V2ryabaolJ4PpdS3XU+GXL+YHIVhatXgp1Ql8VYq4k3ptsDLVA1Us6j3jqVn7ljGEUOsjVPxedqcpwa52CMdwkYLhR2w9ADXgtmSrKgkrTW7AIQNLmDpVyEooVzrQIRdSb7fKQfVg5mX2mIVlR+f+ONV2PU6QO7dFhvUmf4RNJENZaHfJMrNojMD6EetOkBTqAQ6gxqXs6LfXehJ8o5olYlMLip91aob7+MnmSj+6Z5VC8N9gVQLdZbO5rhETgzeciSvsXcBcht3TLEalZntSze4LTFygvAMCvIByxuS8oeeNf4/oI2P0lTm2fMDPX6p4bSRXUPggbwvlLPhBba6N+067UoPCdAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66556008)(64756008)(76116006)(66476007)(4326008)(6486002)(36756003)(38070700005)(8936002)(86362001)(186003)(71200400001)(6506007)(91956017)(508600001)(53546011)(66946007)(2906002)(122000001)(110136005)(66446008)(316002)(31696002)(2616005)(38100700002)(558084003)(5660300002)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2w1VVI3SUdmMXlsZzMyeXNkV3VHYmZyNk5wbURPUWtIVVZEemN1Q2xuVXR3?=
 =?utf-8?B?MHUzYm5VaW83ck9BNFNidG5tY09uRzJwQTFsN2ZUOThTVncwejR6dWFzVDdn?=
 =?utf-8?B?djUwTkxiMG9IV2VhUWEwQ1lGcmt5eEtVNy90THVwMkVEVHlNYzlIL0RZSGR1?=
 =?utf-8?B?SWpsRHVtVkpiSksyZnlNZG96YW1IUUtvS21Oemh2RjI2OUZ2Ti9ReDRXbEdr?=
 =?utf-8?B?dkdiMWlza2tWelFRMVdPdmZPZVNzVC8zM2s4TTVQT0VyUlV4Q3gyQVcyK2RF?=
 =?utf-8?B?Q1pzNld2Rk0xTEgzWExYd3lWS1FCcURURVRXUXZvdU5hbEVONEtJZ1NJYnFP?=
 =?utf-8?B?alBzUXpmMUJLOTczS0lQQmg4TVpnV1p3TWpWOVk1L1JPalFsOHlTZjhFSzVS?=
 =?utf-8?B?WkVqdFhOa0prLzUxZG5yQ1h2K3gvMEdVQS9zeGhzWXI3R2tvc09udEhwaU1T?=
 =?utf-8?B?WmZEc08rRXRFTkxDMDl0Q0hJRUVTcHUwWlBFN0ZjbTFBOUd5Qk5HZmhES1RP?=
 =?utf-8?B?SldVNWhMY3JFbzBOazJZSjBuZlUra0lQLzlwK0NicTJLWUJIMWZyaDVDZmZk?=
 =?utf-8?B?TFlkVTM4MDZxcHFJVmVFb0RjeHZUamVaUGdNODkwdjRQUU95U1hIeTc0MzA2?=
 =?utf-8?B?R0d3WjBRSE9UQ1N6WFhiNzBpaEFFVUpGT1ZGU28wRGhqMHpoWnR0Ukl0eHJJ?=
 =?utf-8?B?cVUxVjZINUlOK0E2aXpCYTAxKy83d2xEZTNiZjJGdEcxNHJMZEhtU3d1YVZz?=
 =?utf-8?B?Yk1BM3g2clRCakVNVlZmdVVZblY4MkhjSlB6S1VNZkJCTzZnd3NBUU1ZSGZm?=
 =?utf-8?B?b080cGlQeXVTSUl0ZkxoMHJJRDF0MDk4azRhaFNUT1FYZjFjTXhlaytiZTdw?=
 =?utf-8?B?ZTRHOFJId0FWemRKRjZPSUlZYW13YjlvYXF3YUYwRStPc0wzWWFTNmFWZ2lC?=
 =?utf-8?B?bUpHZEdYTGhUUWIrY21mYk9wSmdPNjh2cFZSM0xjZ004ZnVGZ3NmYi9OdnU1?=
 =?utf-8?B?cXhvTVF4b041T0Y0cjJrMUxEWkdoYUNHd2F5a04raWljbkdIMDdKUmNvNFk2?=
 =?utf-8?B?QUdxQnhxbUpPVTA5WjJuSkpySUhWTWFzS0k4TDR3aVh3NC9QazhiRkxmUVd5?=
 =?utf-8?B?SDRvMkFRZGxIRExDZHdkdGRIYlRjM09pOW1VSGNkcDMycEd2Q2Y3MG51TC9D?=
 =?utf-8?B?dWZpU1BrSXp5TkFvejNQQTJ4QWRnZ25MemtpUFpoc1RoS1RGSDQ2QUphbUFl?=
 =?utf-8?B?ZUdGQTBEK2xpcVl2aWdGRjlOSGMrYkxLRHIybHRtQXJyTTI4US9MY0F1eUM2?=
 =?utf-8?B?NVhEeHpGTzE2ZUYxeFYxeVRpNk4wOFZ0M1FyY0ZKQktzdHN6LzgvRDZFbEhy?=
 =?utf-8?B?RnBteFNvRkQ3WjBCczN2YlpnbTNpekpaUGpPeDUyQnkwbnpYcVpWbzI5eGFk?=
 =?utf-8?B?a1NXd0Zaa3p4anJDTEllVWpOZ2FFMFhGZUJYZDhTODNDZUgydXFwYUNyZVB1?=
 =?utf-8?B?bkUwcGozbXZlb1o4NXRwQXp4QTh6b0dadnd5b1VMekdRbnRvYXc4SUlsdTU2?=
 =?utf-8?B?REFYcmN2ZXBpRjAxQ042V0pYUnNEaTRWd21MbjZHbmZqYzBHRkprVGk5UlRu?=
 =?utf-8?B?djFXYmZxenN5TGZwR1BWTjFsMnhlNm1naHVBUDdXZ1RnVVdLRWNmWm5uSk8y?=
 =?utf-8?B?R243ZEEzTkV2OUp2bkhwcUNRVGduWk1HMjYyblFGZDJiV1E3MEk0bjdtUWFu?=
 =?utf-8?B?Und4Z0h2MXJZOTVPZVVuVE5SUlpNOHByemZvWXN3NlBvcWE0aERBNE1ZVFhn?=
 =?utf-8?B?ZUROd3RTTXh5bnV0SHZGQ1JVL0tKUVJjdGJyeXBNL1cwWDdQeWZwNVcyOFpk?=
 =?utf-8?Q?YBASjrWYsL0Vl?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E6AAE4C37F06348A5C0B4F0EBD752DC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd55105-4ced-41e8-8c91-08d98e00c565
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 04:20:21.1007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0TKdndR3YLPoOeV/+S5gVDiAXhb6bF0Goq8p2FV4JNa810xrNbqVUfgbKnjxb9Qca+39uRzS3LdSzuGPIbarRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTIvMjAyMSA5OjE4IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gRm9sZCBi
aW9fY3VyX2J5dGVzIGludG8gdGhlIG9ubHkgY2FsbGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
Q2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpS
ZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KDQoNCg==
