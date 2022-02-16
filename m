Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF215C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 09:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiBPJQo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:16:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiBPJQn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 04:16:43 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABF42AF92C
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 01:16:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7QDUZHgouLkLBJR0Nijvx16/s79GeALbxj2U62iPAqdE0ZfTbIwUFIIgsbrmOjBkQGpc4PfmuBV2nb+t4+kIpJri4NAjBVo6H0tH2yTKAYWoaNmdd4QeDioq6eIdjDjC+UFBuiTYCLgXX01UvVFVFTObkqntoNescfv3L7ESajeKH0ujeNE6G2BkeQsihYF7NPS0ViH4ycoW4FDHWYJygTjLOnDTL5NnSijE/vIJG/G2J5xuz+M3qrYpzxP1mpjVERsaH+uKBIaHaDLEv30k1bX8KHOl+39iddSNdoWmhopvuUfSLkVzYTAn1s13N42Pti08eGcSMBQr1ivPA/aNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIBy3mN3ZNPBaJgzdIxOiPIRGdSU4wP3a/NEqhaQroQ=;
 b=AYZFQoDo2mz8sJWUKlbKukqkPzG1tl5pldp1So9DkAIkZUVgJi0C4Wdv5YevA6d4t0+8ngWdi6XyfhEdM3+NCrmPDO+vKRODy3fMv5icX85WgJwRq9a1laP28VHdqGC1U8KrIBAasGO83qhgj9TLUx5P1iQh+7NBsegSjvOCwMhXT2QDJFsiuaDE7in2MrxMkwTToekB1bj1rF8otrIDFt230PIhvgeKYYphv8kmYLOma10Nq/dJv6Cy7eXd8txRx829KDjQR6kO+cT6ZzYAnDBrdUvaObFJPKtKowHeI6CPvbHKZ0l8UIaqOS+jFeOUWOV3LxofxkZL1RaiNkhnEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIBy3mN3ZNPBaJgzdIxOiPIRGdSU4wP3a/NEqhaQroQ=;
 b=q8WKeNXSj9OyFTpQnjS/ZUluR+n/TSR7RMZWsxgsHO62SH35WqbGYPzSuf/koFR7VeBlndDkpq9kA7nn1dIp4gGWAq3+VExyt+8khRDKiD+Uf/Qb/+3Q9H9xNG4ysW6m+KFxkayFKK84PXdVITXROKaJu3yiN4Ns6z7x45Q0QwAhRe4fR3msYj1/knOjfZtiymBHfQwnQhh1RkWpv5Zdox/3aIBfTNJO5/+o3i8QT8a4OXMA/Kuoj8HxiNwKX5Oa/SBoLX0s3Moor6k4wir64QakrYTRNTEGrZ9nBPyoOMBweDZWe4jeSfm4I2EBNZbdKFBMhNWpgEPfE06lFL8+cw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA0PR12MB4575.namprd12.prod.outlook.com (2603:10b6:806:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 09:16:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Wed, 16 Feb 2022
 09:16:20 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ning Li <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 3/8] block: don't declare submit_bio_checks in local
 header
Thread-Topic: [PATCH V4 3/8] block: don't declare submit_bio_checks in local
 header
Thread-Index: AQHYIvAvK5h1kW0iQk6uXglT2nIYZ6yV5dcA
Date:   Wed, 16 Feb 2022 09:16:20 +0000
Message-ID: <8566315a-cec9-20d9-8c06-fdcf08af89c9@nvidia.com>
References: <20220216044514.2903784-1-ming.lei@redhat.com>
 <20220216044514.2903784-4-ming.lei@redhat.com>
In-Reply-To: <20220216044514.2903784-4-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d98f911c-1aed-4356-1284-08d9f12cfec1
x-ms-traffictypediagnostic: SA0PR12MB4575:EE_
x-microsoft-antispam-prvs: <SA0PR12MB45757DC7568C7B6CC399F0B1A3359@SA0PR12MB4575.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:115;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: foWKac85xmTEdkDYCt9iUdRfcgQGyBOYxBRUMAUzIb66wxpWFBCMra+rz0FUu6uywxaiL+OydI0TvZlbfztWRWNgg5RGVOUlgVNG2vUPaSv2Kfp3fEwaXxLxYDaq7O8uw3V8EGuZRRNw/C1SkqVeqrOW4XUw71aBapGo/AxFuQMcQlImR7NvEU8vJkh8aF6+S2FFFbQL6JE6sC9s9TABJ3bGh+SkV8dwIOt+HlsWFW5U/IMnkbPNVkikvBCgm00G5DPBusdUjNDDvtjYckdJ1NeHcvwTTGWwWmx/oPxExd4d/ZObDfD9Mrr9CuONIQ/S+82Xv/OAfrcWvB7npnnMpG9y95Xm0wnxhwR14rFtj+0nSASmwBmzIMye1VC39CwKczH5cZohmD2LxH0eRFvnl2iraL+PDSFON1qXHvONrXtp2kvaeBeKaloU4tAvJVnIdmu2j+TAVqvhOT9R2sla9TkJclET4T40NvDQYFBiAescnTjmmKAD8KUHzO4j4OD3JSalJQF4w5m2BwMjsZKoI0wRAiWXp9kR5+VhcKklFZ49jTCkXInr8C57q/P7jS4Ne2lFEbWX9BsVOqwxGqkzsFw0xSF0xTkdm5meGH+9dCB0e7zJY3Y2rz8ss2S018pkKL+9X+EvF3zB8Q/VCDawefzEwEG9fTR1chiwQyMqtTo3ZdGKCpTdPsioOz1omRawq81vyYNc1gu+ZPWWY5bJJ21WQTFfKrwJW3C2E3TvVkqt6psB2aUv9IwIvn++r/mLU2GmWqNEp8HtBnxvWEzvfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(186003)(2616005)(83380400001)(122000001)(36756003)(71200400001)(66946007)(316002)(91956017)(76116006)(508600001)(6506007)(54906003)(110136005)(6486002)(2906002)(66556008)(66446008)(31696002)(53546011)(6512007)(66476007)(4326008)(64756008)(8676002)(4744005)(5660300002)(31686004)(8936002)(38070700005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3BHVnV1RmtWTEwyUHd0a2ttcGR3OHk0SUorckhabEVhYnkyNGU0aGdXZHBV?=
 =?utf-8?B?NEhQMTNYMXZIeVNtOGQ4OU5weUgxRjI3RWtKTWQ2N1lXZHBJQWFBMWp3ODdH?=
 =?utf-8?B?UFkxOU8yTW0vRE5BaG1CZ0tmWS9hbjVrTWJ1MERxaytRL0pHRExOSzlOcDVH?=
 =?utf-8?B?aW4wc3JzSGNBc3kwNDRmM1JCQm9ZclJRZVhLK2xFVHM3aDBGRlJncGZOeGxD?=
 =?utf-8?B?QS9XQW9UMGxCeGJzT0JhS1AyeHZJYUFtbVhNOTAvWUVockY4ajdVbTExb1I4?=
 =?utf-8?B?TjhRTkQ3eDBMcmZNR1BXRnkzSzEzUjF4blk0MzJES29uVUpFZ1ZUbnNHbzVu?=
 =?utf-8?B?Z0JKWTlOSVJWb2tUcUczRFZYU2xYY0lVNTNwZWhWSGVkSmdycFdyZE0wd2Y2?=
 =?utf-8?B?RlY2Y1NDVHp0clE3OVE0Y1JqUEV5cjNnMDlGL21BbENFUHFEUHdzZHpGdkdu?=
 =?utf-8?B?NWl2SWhBN3Jxc1dnRDZiMndrY1pEUnJhckVuYzNuSVN3VDQwOElpNitvTmpp?=
 =?utf-8?B?NmJjalFaVEdjV2tOQ29ZcjlHcHBQYmFwYnFjbjNQMWp5ekZxRnZtNUo2WkZp?=
 =?utf-8?B?SDhKclpwc0pCTEZoTTFHS1ZMNzZkZEdWWGptNUNSZmorSEg3bThqNi92UVJE?=
 =?utf-8?B?THMxY3RwK0RjbGJnajJ0dXRmMU9UUWdCcHhaNnd5NktZYVh5Y0hGWXp3UUxw?=
 =?utf-8?B?UFdVWHNKYUI5Zzk1aGphV2tHMGwyTnhwTy9TVVNFTjRiMGdaaFUzbmV3MFhC?=
 =?utf-8?B?ZWFWNmlFd3FkMUtkU0swY3ZRQnZWMk1ad01haS83MFFHVUVURDhIRnc1ZTJz?=
 =?utf-8?B?cXVaMkZuMjdZQkxjNlhTNUJDSk9GR1B1c0JqL2hlM2FjUW1jQ1hHTW9TMnZI?=
 =?utf-8?B?aUZ6UEM5eHRaNjRtRE1xemlyRDJBd08zOW5EdFVyK1E4WDBuelZPZzNVMW50?=
 =?utf-8?B?VllNb0xzM0xqRlNYWGpzM3M2RlJFTWRCZ0czTHN5RVhHVkRwYjFIOXJnc3FW?=
 =?utf-8?B?V29oRXB3S2RpdGxKRzlCTlVrUUFhZVlSbndHQkJlTGdJVFpnZWZKdFpBUVdq?=
 =?utf-8?B?V1V2U3lvbE4xS0FPVmtITWk2Q1VSNTJ6cm9zWFdCdE9ma3ZFNTMyVmdmRXc4?=
 =?utf-8?B?cThYd0QycUJmdHRkSEM2WnI2Z2lEZnB4OWgrZ0dyNUxNb2ZPelZpQW5LU2dS?=
 =?utf-8?B?RmlGMVhtWUpFZFpFRk1BYi95MkVYQ3RmREpUNGw5aGxOR1NTTjVHdU9lNXRX?=
 =?utf-8?B?VHFiOU42OGl5Wnc3d2laaTkrZDhIQXFMcHJxOU0zQ2l1Y0V5ZUJBdGxyWnZY?=
 =?utf-8?B?OXQzZVc0Nm90OGFCczA5bVorc0FkZ3dMT2Y2Q0kxSEN5ZThIMHBHWVhxVExH?=
 =?utf-8?B?V2J6d1NIRldpTC9sb2dMc2tia0h4aVNHTnN6bWFNQ2EyWm5mbkpLUVhQc1BK?=
 =?utf-8?B?eXVNbTlSNHZOR3JZdE5mNFRtZ1AwNnZTTy9JSUoxa2doczFyUkZCUGZSaFZB?=
 =?utf-8?B?T2l1RlZMbXErZUx6VFpsTDVkRWJ6TTNSbndDVFFmQ3c3TDVnYmVTUTkwTnZS?=
 =?utf-8?B?ckpzSFhNV2NBN1RKb0l6MVJrMEdUSU5YTE00M0RiTkdtR3V1S3FDYWpMeVR5?=
 =?utf-8?B?Zld6akMvQzNwc0J2RXNvVCtndGZFejQyQThJcFhqY2tacmF0YTBZUVY4MGIx?=
 =?utf-8?B?SHJHVG5BVEN4OFRkeHozc1dUNkZtK3V3OU5kMWtBbXBZZWZXRnJXbndWNFBH?=
 =?utf-8?B?OGFkRnJ3Tk9YN3VrTmpSZXRwMytGSVNxM0VXYUNFbVNTMXc5eUg0cUloTHAz?=
 =?utf-8?B?QmZDdlluUE1qSmtKVFROZXdKOVRzbTVic1VQdUl4M0VjeVc4ZEwxZzlEYkZN?=
 =?utf-8?B?aDFmNkFHR0tyRHRZK3FhUlRxN2dESk5KNXhTc3JISzl3NzdKcVg2ZVh0dDlW?=
 =?utf-8?B?Rzk0OTMrM3VHL1BvdUNiZG5FeDdvOW1jR1JBS3BpNXN6QUVnZUVvQ2xyZ3Rs?=
 =?utf-8?B?TWxDSXFLOUZ5czBySU4rWG04cmQ1NStNRmdrbk56Kzcvb051YkVnbUswNjlH?=
 =?utf-8?B?WTZkbmZWMlI4MUxrWHlPOENadS9yMllyUW1PVUxOa01TakxqTjd0TkFLTkRp?=
 =?utf-8?B?c2dqTncrcmkzWU5BbjVQNUdUbFdkeWJkSmFDQ2FnUHFacnVRcUtGY1pNWWJz?=
 =?utf-8?B?NDJMbUpSY2k3dXVUUmh2TkdvODlkZ2s1UDJHK0xtL2tNeElmT3dhUkVvd1RV?=
 =?utf-8?Q?dEer/J/bRHuV0IrLhiQ9tv2EvPHn0vPxG/62bX4rCQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E42625F77C1A75459E2115DBDDA9D582@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98f911c-1aed-4356-1284-08d9f12cfec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 09:16:20.3307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 08vm6ozm9bjjia1+sqTtSnXTNYXxjkj6NhtTNuZgKNM0CRiLgMTBFmahH3JEc+QGSCVfsct6+GKht2U1TWo5xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4575
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8xNS8yMiAyMDo0NSwgTWluZyBMZWkgd3JvdGU6DQo+IHN1Ym1pdF9iaW9fY2hlY2tzKCkg
d29uJ3QgYmUgY2FsbGVkIG91dHNpZGUgb2YgYmxvY2svYmxrLWNvcmUuYyBhbnkgbW9yZQ0KPiBz
aW5jZSBjb21taXQgOWQ0OTdlMjk0MWMzICgiYmxvY2s6IGRvbid0IHByb3RlY3Qgc3VibWl0X2Jp
b19jaGVja3MgYnkNCj4gcV91c2FnZV9jb3VudGVyIiksIHNvIG1hcmsgaXQgYXMgb25lIGxvY2Fs
IGhlbHBlci4NCj4gDQo+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5k
ZT4NCj4gU2lnbmVkLW9mZi1ieTogTWluZyBMZWkgPG1pbmcubGVpQHJlZGhhdC5jb20+DQoNCkxv
b2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQoNCg==
