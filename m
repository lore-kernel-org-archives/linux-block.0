Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC77CC4332F
	for <linux-block@archiver.kernel.org>; Wed, 23 Feb 2022 03:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbiBWDPX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 22:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbiBWDPW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 22:15:22 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3E71B7A0
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 19:14:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hExhQwz4L4m2EGJrL5WBYwO1p7tPDsKSEgPuESqxPATyH+fiXcFlisF0aSRi1hDimRbfIeuUmBHfKBVnOs9PZRxj/iNCE2/mxoPwv3JKSYg9jzWgIAHcVdSZJ18oojHlQ6UYfGow0zFXqqHOBw8V8EqpSl1LpRMPVdIr/je6oOK9XODojncd6RVWDqSsL81B2mSEr34EOI7ooVnxxWZE80BgRKt6JXHONDGh5t9q8PzafMhwSN+RyNXGLoTEs2HBbJ/p5iKpEvXq+/0CKbasCa2QVb29/A8yu0EgYfqrxmWZ7ndrf8D7tLRmYe41l4D5VfHP6dbxEJG54OhRVMJ8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/2MUKxmghIOQEIj/NKIempg9HZBV+z5yEMOD6hYzq8=;
 b=GbBnkLTY4J4AlZo1L0feZQz9mVJuVvIqxzC95UGFUMAtvQgVcdTzVgubd6B5v4FqH/JDzQEWHONR4vXaAE3Glt5li7kP72MpXWQ6XE854Z//Zhog3Ys4jSylDgl2jA+/YjWSs6TImGJ9bCCpM1P/TM83emWABVwuh8v8eGHzdOAhoiuayx1jc96DBS2BczLIx3aOXldPqvrdyCTA4KFrw/YChHy3Yod+osWXrSeGFkY0Lbjam7Z+Ny/heo/sm5Oh82uMdJqM41pLZ/Zi/TNNNKaHQ3lPdUZayZmku31Zg7YA/71xfW2Qrk9M0bcbTXtOAELAmKt1XA20eJO7qm+qAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/2MUKxmghIOQEIj/NKIempg9HZBV+z5yEMOD6hYzq8=;
 b=fWts99/BLmTBwfNtGRBfhqmHKnjNWtDJhnZpHDIT9/mLNbU5ByVpiCp16IpJMF5tZP0BTFNhqxEaj9OijtPyryKLfAU1h53WcUrEuilwPJaOKTaUzHB8vQdx5dsitgHQ+1DuSDf6ktsiVtnUsummZeFpuHOdVJ7Kqgx61+TDhTB9tP9eGnt7l5aOoNqjD+s4hmwuZCdxzh/191caHF3dhkFcfVr23jT7opKy+JTDntNqaUYVKCSKyos/2pBZH0MMhmij6MwJgLLMXWoN3jwGA0x7tNdOmkHGjp5xXu7N6bsPUEPT4aVn6vHpftdag5ZY11Bx6xWOWOWDj7PiF6a6zA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB1625.namprd12.prod.outlook.com (2603:10b6:4:b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Wed, 23 Feb 2022 03:14:52 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 03:14:52 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: block: potential bug on linux-block/for-next
Thread-Topic: block: potential bug on linux-block/for-next
Thread-Index: AQHYKF/wWr/jVoD/50Sb8ktq/+TGzKygcdKAgAAEeQA=
Date:   Wed, 23 Feb 2022 03:14:52 +0000
Message-ID: <3386f561-604f-ff9d-51ca-77ff90835376@nvidia.com>
References: <ecc72e5f-dd71-d940-d50d-0347631a7933@nvidia.com>
 <3610d58a-ef1d-a460-4bb7-de3d0297dae2@kernel.dk>
In-Reply-To: <3610d58a-ef1d-a460-4bb7-de3d0297dae2@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b078c144-788b-42bc-869c-08d9f67aa8ad
x-ms-traffictypediagnostic: DM5PR12MB1625:EE_
x-microsoft-antispam-prvs: <DM5PR12MB162509B435CE39A233AA5318A33C9@DM5PR12MB1625.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J7zgeWzmBD51F+gPG3AQwqfD1bFB8+9XEdSVUJy8oFGsmDj5OnXAZpZXwHQxbQiR5Uv0HBXWJOROdyQSpQnJrcaOngix5hiJ15tLtIylq1gNyRBuzdcU0sKJ4GblfiUDrOgqY4wq4bbMxR1c9WQp4VFndbxh4Rr9qE8VGaEFEQMgrQ0ehDxPBwh46PpAy9LbKO0eOdshAEzE65KUFyPivN9fQRsijIoeROZ3Putdd4xCAFmrT1xx16PkewvLffDD04ZGm7SGbhf9rwmpH9GGkQgRPljWhJThUIkpWJy2D47WBVx8lCukniwp1zs+YQihYS5+iJ4cHChdXVE9n3u+LuUQjkbL2sPHEggBQweUc+q+SG9iGMm+E9YZYppMRoEPN5MulsrOP1Yk/fTwoxs4OGlpEPQ/MhpZTN7vDUgiC5dUwS1pB5VYG6w0hYZMAiY8ynYmarztsu7+wJmDY5RX4lVtuD1uad6R512ktg4pQGAvR7L+JdsZ/Bnq/BUoVsS88ozu9eKId1fDb2iT/si070WWKCigW8xnmSFpg+IdcgiKAQahc97S8fFBh6DoTjWW9YXIVPG1XY5jZMQuK87BKX2nFifXytqpuyL0oAi485FM7EPmd32qivAMq4EPxCrVYj73q0kS9wwhLanHC2GJo+PrvMtxhi2HQr1KPMfXbf7jrmLPq8plIzb+HZBjXLot8QueTiXer+TIQive+FjuF9baED0GRk8maEB2rfn0AoqFG5RyXB+8hd1TJFmKCoOeO8MPiDGq/L3L2zFE6pgQ+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6916009)(71200400001)(2616005)(86362001)(36756003)(5660300002)(83380400001)(31696002)(186003)(31686004)(66946007)(8676002)(122000001)(6506007)(66556008)(66476007)(66446008)(64756008)(91956017)(76116006)(2906002)(8936002)(508600001)(38070700005)(4744005)(4326008)(38100700002)(6486002)(53546011)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXBIazFnbFJGNnJIWmxlZFB2WHpQYzR5VlFCa1ZMdjJidW1JOXgvZFlreTNr?=
 =?utf-8?B?UXJQK0U2R3hwdnhOUXVyM09yVUtRYllsRXZROTRKNzhZMHJ5UUwrQWhOYWdq?=
 =?utf-8?B?Y1ByalcyOU8zVk4wSC8reEtTZDE2UjhiSW56R25NWElqcXBZai9uZUhzQlk4?=
 =?utf-8?B?bjBVTTQ1MW80RjYxazVaWGFtUmQrYmlqempRMmdvV0hTdk84aTgxaXAzT1pz?=
 =?utf-8?B?SDJUV1BjeDBlRnVwMHhJdFNrNzV4TFRWNWdOVklsT3RwZzdKOXNhcm0wTG1m?=
 =?utf-8?B?SDhTQkx5UWl2N2VRU2lqVmkrSVphbENrVGdlL1lDdlA5Yk5PWDZkdEdiNlhU?=
 =?utf-8?B?Z2JRc3JxcWtTdjNXMkd6d0Z6N2o2NkZtWGE5NlE4WFUyZ2kycHFNVlUzbVJM?=
 =?utf-8?B?aGU3empORmh1ZFd6SFNtdHdkZndKSklIVEJLR05wZFUrTWxwbjhNT2lma3B6?=
 =?utf-8?B?d1dzQ3FiZEVSUzByVUVHRC90QzVHdVpTUy9UVi9DYVU5SlRIWEpzcUVvaWdq?=
 =?utf-8?B?MUN6YkNGVmhwZ1dubjRHSCtkcTBrMEVaLy9HbEJhSWdGeFJsb0xtSHFzWWdB?=
 =?utf-8?B?Y3l1YVBUcHFpTzVNQS9TTzFMc0JucldrRFFib1VaNllQUkMxb0NuU1Vta1ZE?=
 =?utf-8?B?blZCamxzWE1TN2hoWnkwRCszaHdIcGN2bWZ5dDVTMzdTZW5OYU1ZSTBQQklM?=
 =?utf-8?B?Q29TUktmeU85Z0ZUai92QzVJT2lCOG1SRDlCMUNwaGQrc0NDeEs4d1Q4bERx?=
 =?utf-8?B?d0ZjMFUzd2FDNEwraGZUNzViL0VHcEZ0UCtBWWVzTUpVdFE3RkRaQjM0U1pl?=
 =?utf-8?B?UjFPOW1yL3FtUEFGaW1hRVhoeGpsTkxGT2hYVlZwa1lHQ2VQRE5lNUpONWRF?=
 =?utf-8?B?YVRTUVFPK2x1czZyMDRmMlNGY1dhUGtBVlRKQ0xiREt2K1M0WGlMdFRmUUF1?=
 =?utf-8?B?WDFOK3lJV0FKS1ZONE1iRVhvZkFYRWRUdDhmZkV4eG91TkpRZzhsTkt2azZB?=
 =?utf-8?B?MklQQjhEM1BXbnF3NUxZQkZTNUFtZWFQc3lZZTE3Z3NyMGpDemxoMHhkc0pi?=
 =?utf-8?B?bEVGN1FTRjdpMC95R2U2ZW5ZTHAySGw1TFhIVW81VG5Zc0k3Vm84ZFZXVEY5?=
 =?utf-8?B?Z2Y5WUFpYmxwNVVSaEFpZXFrZjNnSzY5amZQZ1ZQTHVEbDN1dzJkclJ2UDY5?=
 =?utf-8?B?OHNpMWs4UjNiUndFVk15TVR6ODFScEJaVW1TVkh3elNIa3ZLQ1oycENSS1hj?=
 =?utf-8?B?bGViZWhzVndaRS9FZEdmVjlKK1hMc2xZK04ydEVsUEh5a1lnL1EzM01GdG1q?=
 =?utf-8?B?bHpTVGRuSUtMdkFCZHVwcG0wVGNsais2QXArZk5qeTdaS25IZlIzUXEybnA0?=
 =?utf-8?B?Yi9YSFV6R0tpSitMZjJHOWh5eFNKVnhzRzNwUTNlQzRUR1pWd05HMUllVklk?=
 =?utf-8?B?WHdBbnpvQ2xVQ2ZZUy92TkFQN1VpN09IbitpczZpWkhiSjNJODRGWWtZM1hQ?=
 =?utf-8?B?Z2lTVG5SMDl5aDJ2ZUNoR2EwY1d5RlRJaU9nN3VEazFYK1JmcHhnbzFza1ZR?=
 =?utf-8?B?cmdmb2QzMFlZUnluVi9PZm02UHlGdzFSUkw4ZlN6RHhSak1SMTNTV3U1WVh6?=
 =?utf-8?B?Y01YN2JnM05NUUFGU0Nka2tmYmZMamxGS0Z3L1BONG9Jc1JJOEYxdHlRTHZ2?=
 =?utf-8?B?Q2NUTkM1bkQzRlhZSFpCUHVJVTIrNUkrNnFKbnNTeE5nWktSbmlET0hDQVdX?=
 =?utf-8?B?NkJlaS9ET0lBSkdabFBiQ0ltczFIMmdOdnVYZFJjQ25DQXB6ZjlWSjI5V1o1?=
 =?utf-8?B?clhjNUk2TmZSb2VzWlJBOXpDTkIzR1hJRnByNDlJYTRreUtyd3hWdmxWSDJV?=
 =?utf-8?B?eTcyNUozUkJqY1h5cWJ3eS8yay9IemZla2Y5dnEvMkxPemFpZGhZam0rT2Jm?=
 =?utf-8?B?bVcvelZrcG1TVFpYblM1czlpdjJqTGVGUTNiNHBnek9scnZkOGdTMW5tK3FH?=
 =?utf-8?B?QXNWVHp4Q2htNnk3emdYUlZpZ3JIVU5FcTBUbDZWaktpL3RKa2ZHeFhYWGFV?=
 =?utf-8?B?bXRNVXZZSFFBSXJuTjBKRElMOVZaTmRLSHlzT1Y0bHN4WWtVcFZqRlQyWVFM?=
 =?utf-8?B?RlhaT3lZYTZhVDdBMXpyN250bzNIdHVYeERlMGpjNEpTVXhGN2h3c00yUjVs?=
 =?utf-8?B?eGtocXBoSmFlYUMxcUFwUTFtdi9WYkZ5RFlrUnpFd0NMYTJyUFBFL05RMXFm?=
 =?utf-8?Q?9wS+x8KY73p8UfE7XF8w2jvgeD5aFR/UfiDRRp2cMM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D4E36D399C1F14EB9913E03B9523529@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b078c144-788b-42bc-869c-08d9f67aa8ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 03:14:52.3367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uyatpJlS7lLhjCrHgP++dB53nA/ocLX/N9l6O4yZbvf0/d+3DjTt96rEHa/QunVmZQN5fGolldtjtIm5fUqm+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1625
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8yMi8yMiAxODo1OCwgSmVucyBBeGJvZSB3cm90ZToNCj4gT24gMi8yMi8yMiA3OjQ5IFBN
LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBBZnRlciB0b2RheSdz
IHB1bGwgb24gbGludXgtYmxvY2svZm9yLW5leHQgdGVzdCBRRU1VIGlzIG5vdCBhYmxlIHRvDQo+
PiBib290LCBhbnkgaW5mb3JtYXRpb24gYWJvdXQgaG93IHRvIHNvbHZlIHRoaXMgd2lsbCBiZSBo
ZWxwZnVsIGFzDQo+PiBpdCBpcyBibG9ja2luZyBibGt0ZXN0IHRlc3RpbmcsIGhlcmUgaXMgZG1z
ZyA6LQ0KPj4NCj4+IFsgICAgMS4zMDQ2OThdIGF0YTEuMDA6IFJlYWQgbG9nIDB4MDAgcGFnZSAw
eDAwIGZhaWxlZCwgRW1hc2sgMHgxDQo+PiBbICAgIDEuMzA1NTg3XSBhdGExLjAxOiBSZWFkIGxv
ZyAweDAwIHBhZ2UgMHgwMCBmYWlsZWQsIEVtYXNrIDB4MQ0KPj4gWyAgICAxLjQ1NTk1OV0gc3lz
dGVtZFsxXTogQ2Fubm90IGJlIHJ1biBpbiBhIGNocm9vdCgpIGVudmlyb25tZW50Lg0KPj4gWyAg
ICAxLjQ1Njc0M10gc3lzdGVtZFsxXTogRnJlZXppbmcgZXhlY3V0aW9uLg0KPiANCj4gV2hhdCB3
YXMgdGhlIHByZXZpb3VzIG9uZSB5b3UgdHJpZWQ/IFdoYXQgYXJlIHRoZSBjaGFuZ2VzIGJldHdl
ZW4gdGhlDQo+IHR3bz8NCj4gDQoNClRoaXMgaXMgdGhlIG9uZSB0cmllZCBhbmQgY2FuIGJvb3Qg
bm9ybWFsbHk6LQ0KDQpyb290QGRldiBsaW51eC1ibG9jayAoKEhFQUQgZGV0YWNoZWQgYXQgMDM1
NDZkNDNlYjg0KSkgIyBnaXQgbG9nIC0xDQpjb21taXQgMDM1NDZkNDNlYjg0MWQ1ZmQ2NjIwMzgy
MmMyYmIyOTBhNDY0NjRjOSAoSEVBRCkNCk1lcmdlOiBhMTAyY2QzODNjNGEgNTUxNDNhNzgzZjA3
DQpBdXRob3I6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4NCkRhdGU6ICAgV2VkIEZlYiAx
NiAxOTozODozNSAyMDIyIC0wNzAwDQoNCiAgICAgTWVyZ2UgYnJhbmNoICdmb3ItNS4xOC9kcml2
ZXJzJyBpbnRvIGZvci1uZXh0DQoNCiAgICAgKiBmb3ItNS4xOC9kcml2ZXJzOg0KICAgICAgIG51
bGxfYmxrOiByZW1vdmUgaGFyZGNvZGVkIGFsbG9jX2NtZCgpIHBhcmFtZXRlcg0KDQotY2sNCg0K
DQo=
