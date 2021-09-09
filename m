Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA15C433EF
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 16:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207326113A
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 16:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbhIIQRX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 12:17:23 -0400
Received: from mail-bn8nam11on2049.outbound.protection.outlook.com ([40.107.236.49]:7521
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235070AbhIIQRW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Sep 2021 12:17:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZj+k9X5rxVt+SA72bT4G6fLeYc3wVDhaXCe5rlDruGKIzdkAtTw1iQkSa3G2tz43LdbdBftl6J5I+PzQ7VYqkAS41nVxJWoSraJmQwWbUbIM8YJjzNp/CrwdCzFk90lsG3eXNkwy5uqtvDU+QJriQEdK+7Zt8QSJKi2sI0UF0lj5dWX5drB2rTXAeVJIkL/jaTkh9FtM0maZY/ZWI6/+GowBVMtTyjPgoGU6t63F/0DHU0JIk5W0yRa8eec8z+uchuHTWJMDDAfPwPnOCRBxClL5sPqQfCemDLRZuz/2PRQnAlinTC2e6krGNz0Gg5WH0l8YlnMBmHnBrNGDjUbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5L1X5gxEUVhdbi0uSgFEx8bzpg28FAwpxB0uYGgz3bc=;
 b=HYDWuDU0lIENclwcl+RgFWiBF7FSnrcW2l0fZi9LBe8pFB/YkxLLPKc54SjDqCWacwwvqKBytg9kpq4FlxktJf/2faLHnE6oBtYY2HqUaHXjB9hdvkHsalnOQVQZX+vUg75vsmWy4SxYIKLOQhRzeR4b926k225zCU4BaTSns2/sdEJAwxo5TOr5g3zy/X1sEHlHM+Ikjme6Xj35zGGrXQSIQ++sncLJ4tbPiYe8BfKmS8w2VytN7oE1zNRrGeHjZ9MMxlbRXHVm4PhQLf9zSOApijQHIT+ZMA1hMp11w5WfBH8lamg2mk17d8fpoMcbEdAePCTcqls79kpVjFtxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L1X5gxEUVhdbi0uSgFEx8bzpg28FAwpxB0uYGgz3bc=;
 b=MJp/YN7XPG6hxlf/0ziqe7s+HXjfjxZt8NDP8q/ttf3nm11xrddm4tTIM84Ir3o3MkWKWa/91l/nvjPmbto9vrOqUTg1dCzINeSzn0M6fnaL/2S/dxETkn44csc10wNlx36zugYdOP0iuQ8H43RPWPh7uXOlNz/KtJgmVlG866Kwq4g4lY8BcNtJVHi+a92haNGytWB+FqnwUMUoZiFEl0P52S/Ozue+QWq9K3Dc1bcV9dWFD1P6038KmMZOL4+FSRlh2cpMV8JY8/8yXw+LDK0Gi3lHOd+lMJPalrgdwi7LQRqT/v3NKvd14BuJ+xtpqm/9LURN0jRzan5FpPd87g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0221.namprd12.prod.outlook.com (2603:10b6:301:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 16:16:10 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 16:16:10 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: export blk_mq_submit_bio symbol
Thread-Topic: [PATCH] blk-mq: export blk_mq_submit_bio symbol
Thread-Index: AQHXpTzKDPVrIJupQ0+ewmun+nT2equb4YcA
Date:   Thu, 9 Sep 2021 16:16:10 +0000
Message-ID: <7e80b65b-51a4-3ca1-da43-e87612b8ca5f@nvidia.com>
References: <20210909053653.144360-1-kumarpraveen@linux.microsoft.com>
In-Reply-To: <20210909053653.144360-1-kumarpraveen@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a5a85cc-a991-455b-6ae8-08d973ad233f
x-ms-traffictypediagnostic: MWHPR1201MB0221:
x-microsoft-antispam-prvs: <MWHPR1201MB0221B13459B1A83361607A18A3D59@MWHPR1201MB0221.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6bs/bCYyviDHCpxMHG5uj4ugYrhso0MsT3AJSd1qFq3o7y/F5PH6i4R3C+zECFgkHBy4aDFafQg7OSjKy0gPUa3loSJU1w2hXQtFWudx2HbZrh+1O/S7EPGvi0CWAniCVhO+qBKwetpazAZmaKw0VvgnPyqGNvR9GLRzt5zqv73OtvhAN9Ubmv4w4tdzd442+ityvnrmL3xEZYXh39gVbqDnKTZi4Dg6fpD7ezJ6zpg1oFQ7ISTZiM6bFXx20KyEfaBVKLvM+CHAay2zSB3wWHTiH9p+ovFzBsyOCFHB8LfQjVzhz0V8Iks6Stp6ofiuYjT/GaoV++PYoaZSf64Hp5HIwTFK6kyR2rsf5lPccaSqWQYDNTxZenbOc5tlMDAZpwoa0/M9mX3AQ3llaYWS9L450rR227ZgAcdqCxPRhKGHjx6jHQtuK+N7x4rGMTrldchER7wrZtSV5nChiDt/D0yqnGOJ4ya59CAtt+r07pyGhU3deWlb8qYfCOjA2jYYJkFv1/B9bRdaRTFXUxZjVExGhO3V9VGF1Nkx+8qHMv9ctWGQUmI2TGUjCZ07aNxi4wPegRCdZFa5n5lwIKQhUD8MfBbh3f18aS4Cx/7CpG+Gk+UWBCvT6tB6m36ZXiH2JCn0C36rSNKTQR3fqn91bsjnJor788wwwvyrfvlLvJClw18xTgzEB4bh0t+R+CjSbZTMiUGR+cTt4QbYZ6f6d2DQnLigUD3k3RjqwSN8tGSpg9l3yerGj3X9CWpDThQNaR9HXAnsC1GMF2MLOLL5Bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(8936002)(83380400001)(6506007)(110136005)(122000001)(76116006)(64756008)(66946007)(91956017)(6512007)(86362001)(5660300002)(478600001)(8676002)(66556008)(36756003)(71200400001)(2906002)(4744005)(6486002)(186003)(66446008)(38070700005)(31686004)(4326008)(38100700002)(316002)(31696002)(66476007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emRidWt5ZndUeGg4SUp1Y1orSEpYUzUzcHlycGczaXpOa041RVFrMWRlY2h2?=
 =?utf-8?B?UFp5Zit3U1dXYXhuWmQxbXMydzk2THN1OEZub2MwL2dSRnpybUljT2ROMkZ4?=
 =?utf-8?B?U3ViZXE4SG1INjIvMmxIT2RLR0liUTd2MUl2M0gvZ20xdEdzMlNhTzRBUzEw?=
 =?utf-8?B?bUUzdWpDMmNVLzhteVVySnNraUxKV2lNWGwvOFhNMWoycnhydGRZYjdJb0Zj?=
 =?utf-8?B?d3FYWXozenR5UUo3eUNrY0RFN2YrZ2t4NmMraGFxM3VQL2loU0N4THFuaHI2?=
 =?utf-8?B?R3Z5dnptVndLTGsyUk1oRUVoZmFrdysxUFpJc3ZrU3BibTg4U1grbUVRSVlR?=
 =?utf-8?B?VHdMSUFJaGsvQlg3eUJzK3htd1J6cTZVR014WmVvbVozUG5mUDh0VFhQOSt4?=
 =?utf-8?B?Q0FlZjFuK2U4MzFOY2lpb09YY3ZMREt6SmVHU05QWUxialI3Rm0xZXVQbDJF?=
 =?utf-8?B?cWNVS3NiR0N0U1Z6V2ZpVzYzVDdNQmphM2FTcVZNSWw2SktMSFp3VG9OVmlU?=
 =?utf-8?B?YStMTEw4d2tUdG5uRHBQY05xdklaaDZhdUwyREJPQ1U1bW1CRDBOS2trT0JY?=
 =?utf-8?B?cDB3TzFIeFZRUG1VWFJTcWgxeWwva3lPcXdFZDk2aG1ydlEvZHhhanFZOVRj?=
 =?utf-8?B?UlpYVzczakFvREwxdzBpMVpUcUdSNForejZXdDcyU0dNU3hmbDk0aHQzd1ZD?=
 =?utf-8?B?Z2ptM29IdHgvQldNbGc3S2hoYy9pV3daNkVFbmd5cUlFdWNORU5MNWZqb0Qz?=
 =?utf-8?B?VStmb2RiaUZUV3FtYTE0WG9LYisvUld4RVQ0WlFnQXJZSkg4SGw4NHhDL3hU?=
 =?utf-8?B?dUpydlp5K0FCNHlRNk55TmsvNHRtQ2xJQW1uUGFkNmhjWDJLWE1XS0toOVd1?=
 =?utf-8?B?MlZkZzF4TG5rc0JwejNlc24rbzdLMjROTFBoWnoyUU9DT3dnYzRIenRDdFJM?=
 =?utf-8?B?V3JCWXJtcEN5SDN5YlVidUh2QmxmNjdUcDdKVkRGeDdmZ2Z1VXNQMHl1dXVs?=
 =?utf-8?B?OVY0c1kwSm14eGdjY0d6d1NCVTdGaEtiVjFlQ2ttdUNCd00zN0tKVGtSY242?=
 =?utf-8?B?QTl3WkpDTmJTMEhwSzh5eTc1TnU1VHNIWHplY3lRQWJIcTRXU3JWazFGbDZt?=
 =?utf-8?B?UkozZnQ5MGcwK3hLUnpnVzlVajcyV1FsaXQ5RXhJdkoxNnBjeWs5ajVzc0Fn?=
 =?utf-8?B?TGNsUkE2bFZsUlhNU3k1OGpQSy9yeGtnUTF6d09IOTVKTS9Nb2dvZ0haUjJC?=
 =?utf-8?B?dEM1cm1GUDJjUzVIVGJ1b25vMHRDMzNhSDZxbmdBOGs0Y1R1UThoNm5jeEx0?=
 =?utf-8?B?NHNZc3VGaklTMUJFSXcrWjBhNHNWU0h6K1hhVHBFV1F3RXowQUNYM1IvRFRQ?=
 =?utf-8?B?eGFhSkdJYVFzZTJOL2ZCQnZhWGVpd2RDZ1NGdmdZTlZEckJ0Uk93WGl6ZGVP?=
 =?utf-8?B?bFZ6dVRFa29Ld2d1SVhRakdVcmI0Y1pxUElKaFljMVYvcXR5YTZWeDFuRHdM?=
 =?utf-8?B?cUQ0SmZUOTBnZkVNeU5weFpScGNjL2FoODlKUVp5Yk0rR3lHRjYrZndSOHJh?=
 =?utf-8?B?Q25rUkhHY2NJSU1hdGh1Y0s2UmpkRlprRlNkbGp1by9mVGQ3Q3VHWC82NWpZ?=
 =?utf-8?B?cXU5UGh3ZjhOWXpjKzFENGtUZ3RoazhTUEU2YzBSR3ZpZmlQRS9sZlZYaDl1?=
 =?utf-8?B?UTVrcVd5aXkxSEdHdWh0RFM5NFcxVnc4TWJmdDZZc3pDODRZNDhxYkhiVUlC?=
 =?utf-8?B?UjQrQ244RHB3eFY3Yk5ubUJhUVY1Zzg0TTNwV0NaY1g2RzZ3b2ZITnkxcEJa?=
 =?utf-8?Q?rGa6Zy6hdqVlBS1/wnN+LR+qreV0yRmxTr3+I=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <07C16C0FEEB3D647B7D4807D8943A57F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5a85cc-a991-455b-6ae8-08d973ad233f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 16:16:10.6571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BaBA3zMyBVI0lJignso/b11QbOogzfdpRg/g12Po2dwVtszm9fai+ilBmkUuEPaIBtjQbNFbvMXnmlAJCBO6tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0221
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+IGRpZmYgLS1naXQgYS9ibG9jay9ibGstbXEuYyBiL2Jsb2NrL2Jsay1tcS5jDQo+IGluZGV4
IDY1ZDNhNjNhZWNjNi4uNDBhOWIwODVmMDI5IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9ibGstbXEu
Yw0KPiArKysgYi9ibG9jay9ibGstbXEuYw0KPiBAQCAtMjI4Myw2ICsyMjgzLDcgQEAgYmxrX3Fj
X3QgYmxrX21xX3N1Ym1pdF9iaW8oc3RydWN0IGJpbyAqYmlvKQ0KPiAgICAgICAgICBibGtfcXVl
dWVfZXhpdChxKTsNCj4gICAgICAgICAgcmV0dXJuIEJMS19RQ19UX05PTkU7DQo+ICAgfQ0KPiAr
RVhQT1JUX1NZTUJPTF9HUEwoYmxrX21xX3N1Ym1pdF9iaW8pOw0KPg0KDQpXaGVyZSBpcyB0aGUg
Y29kZSB0aGF0IHVzZWQgdGhpcyBBUEkgPw0KDQo+ICAgc3RhdGljIHNpemVfdCBvcmRlcl90b19z
aXplKHVuc2lnbmVkIGludCBvcmRlcikNCj4gICB7DQo+IC0tDQo+IDIuMjUuMQ0KPiANCg==
