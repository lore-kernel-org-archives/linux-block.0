Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A095C4742C
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00299206E3
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TgIGBzEe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WOSAyVVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgKKISb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:18:31 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40174 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgKKISa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 03:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605082710; x=1636618710;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Ry7h1SLxNwqDJczS3G+r/ESN8gr3LpKXwyuwHut9rjs=;
  b=TgIGBzEeHRCwBb7WUdr43OVuoS6HZoMzbiy/Uvj5Vqp6Vj7OO5qJ1RVH
   qKfVlj7gHE8InTpAWMzOesn+dn1pKId4rBBtSYPUaPmorp7Amrp8bloJv
   eLfoQEUXPH/gNTjg3f6zI49+0g0gkTEtReQWoBtaiQrgBZF9LRzkfJpiM
   k9aK/PxGGhuc+paFdpyq393Kmvq97VAULKDhO0Zu+ep5I7LovgKnx4rOw
   +kTCoF85xkQu9UazjFQadHicMVuFzPO9SQ81evGsoSzhr0YTPdwjxmz6x
   GNCPpDZ2ls32HINJOxLnn4IrVWHp/LFLjEPYsMuN/Ai1ytMBZ20ZVcY2z
   Q==;
IronPort-SDR: BsffLcH079wayb/UPvGipdKbj3zg6ed9JiPnyPcpqQryXI6NtlNVtgcVUNyBtK7wUo5NnSzUoJ
 xzO6/usU7BQvN+hmAyeWpEgOUW1VS1jF2IP4OMj38ubCIv9yS4Ieg+aAF2WDw2JyQZIoAP+bUQ
 ePBXc2RHldqKnxJyqu2+mgheccfOOsgtoGQZjBdWSt+yjIt5ITn1P8M8MVHWA1svw1LnXCV7KJ
 Y/I7h6h9kyDwNOzMCcAhmLcdGtTJp965ENHI0mhFZkT7gAD2YxBoyYECRdsAVrAhH19wWrdHSN
 +SI=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="156850926"
Received: from mail-dm6nam08lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 16:18:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cI4xD7ifroXAeoFlnv1yVUfwWHWoMwxZZkCPdnd8w36I/4U6iv+X6sDaqojQspe/gF0fmBdl6QjUuQMKvWIWa5+cBTJkglU0BD1xqOx0A5kwfNU5yQDo2ZlnN+3s6gP+JJJquNzJIaJHCcQjy+QNak2ICxkU+RtzgWWiYc8fc1D/SyMzmb5k4bX30NNEJS1BUtQzVxXjtgQ0+uYZ0qSFqxUmk44bXmKueVLAD0xXCtNWpNDDOeLv9AE65xaiyIIWTcMLRAdDEKoOVhHpsCdgKqXDIyieMkN4OtVLvHp21Gyak3RCx7YGWCOjBp7JJsiWArFluxlKrlqg/RJzGINJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTSJT5j1eGp/pvddIvUAflD+dbeasJJtMDiaWKLWCFI=;
 b=VSHdN1Ltacnyic2upBpsLrhFz0IR5xpsFlOi3QgODB3LaRArqKPEqXvkCOHZ4qKB9+7M4c4BcC53e3bTAyIstqnSr92crlh5f70glxWqZy1DTst6BisKqE8xho60+dARnTR7OcbF3tiIpB4fK4Fvf34uQIRFR3MinaS9IQtfyVivNLojARuR35dOE6GO2KzHsolM4gT7ZK/9IbXjWk80xYNR6FZKyeRwtGBiy7P5OGmWVEk88QaqSPb6JmW42jW7swmYms2PgjIHdo95/sdQy4kO4Ea/enHNXrAkKvcU/bvwmhuX4LUUevpTI6m2pZl9YpM7WL3OwqvtA++oqOkJQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTSJT5j1eGp/pvddIvUAflD+dbeasJJtMDiaWKLWCFI=;
 b=WOSAyVVaz1DoKtfF4wkmUilZ4GDByDbe9996UJbhnfqp2mKm7U5iudPIwYD4NuFfe6wNnql2MjxULQP/M3Npiq7KPmPWRLc0x9PfYuZVN4kntOZVrg2wNmZno3BGwCxBoxHr8PnmuJ4GgAx25A02lNz/cEZdA6UVbp3KAWKfC5c=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5165.namprd04.prod.outlook.com
 (2603:10b6:805:9b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 08:18:28 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 08:18:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 4/9] null_blk: improve zone locking
Thread-Topic: [PATCH v2 4/9] null_blk: improve zone locking
Thread-Index: AQHWt+niLr+94pcTSESGywS+a0stCw==
Date:   Wed, 11 Nov 2020 08:18:28 +0000
Message-ID: <SN4PR0401MB3598C3E5CE00ECF9771D62699BE80@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
 <20201111051648.635300-5-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40a104a4-172e-49f5-1d09-08d8861a5e8c
x-ms-traffictypediagnostic: SN6PR04MB5165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB51659FC496EEA98DCA92F2539BE80@SN6PR04MB5165.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bb3k3SX6nHM8EYsNsS1hxa76WQ9S5MjJXCD+11h3LT7KJRDqcSXViNH7LKMO9Ma9tmfu6F6dXMH9ssD4o6lEqZSpt8Bm6lLp4lnllvGwQ32x70N9T6i9mGXIETNufQRz4QDQSNZpBdUhZZKyGcjqjfIVpZyvD2s7MUrPQSfB0gf5wKQzLuvZxGprowODnkI2Wqj/+ZEqyb4M8cZYCz8XzFXX11Ur3XCdK/KtR9vWdXPBQFunpxdhtOsCWD6Qu0Q6V1dsboF4leWy6Ph/XzNUnb2ZpRrqAXFFVS9WEEkpbvkRjK/b2gNRrs1HRtlsdsvXgT7sn8cYkhta0/pNC3bXqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(478600001)(26005)(186003)(110136005)(83380400001)(71200400001)(53546011)(6506007)(55016002)(33656002)(9686003)(8676002)(2906002)(52536014)(8936002)(86362001)(7696005)(66476007)(66446008)(5660300002)(66946007)(66556008)(76116006)(91956017)(64756008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7LMn7WYnJnna1ZiU5Xd6knJIA3wLuw3G8NjUpqFrTCcEuVlTSMLmUNlY/GG4fsxZFsOVZflFwmuwq6qO7uIUYjmKFGf0QD5bWOtKUDFR0+dtIXrHKFD+hMVpLzqm0zGTxpn+DEgczx99YvTQF28T7dSshv0fXceW5HiOx2Gbfgb0bZZqrpBijAlp17p9npfxice6jr/9Vijt2ygbbXReFp7KT7JMSqe9Eg5nXeiJzmveObsKyj6etAO6pCTs2dK0n2/ol3pvigphBPurJGlTv2NPyXVHj9myu5+FPwtlld09fmehqnb7Oy/7q82E6cfI6I5qfGbrc9nVp1ua49b2aWghjCsw6PNOVhcEJ2/tz7vDqwzo8uufUOWRr9bsMAim7jBvwUzM3Tnu5EiEUXDXt82qLA7D7xAx4O5A8YdU6IWsmtZwjSFU6v5xPOovVOhFKa7Fy7h2CyiZGJsbHeNO5GAgoqjZobgMJR5uCjiCFUpB0o7h1BdlnqrZwiu1vMqUVUUcIyIxHAGrg8fvYTBncbo6hl7sOyowbY/E3WxwaMqN6CejRoYbPihmxVnrYvXREgfZJM1FhVtHGqBXDGaU6Vx3FH1muQtiLmUHPXZuebEun3M3E/oMb29JoFx9AY9DmvED9sble8d1GJmVeba/Ew==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a104a4-172e-49f5-1d09-08d8861a5e8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 08:18:28.5140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBVRFIsVjBgg321xPczrXJeRDsSY771NcWOKlWQHodFMoItUvpPHiwxob3mfqVYjD/lCvtVp/D7+L/6kGCGuxWwcmMzAJbLet956As7aMPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5165
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/11/2020 06:17, Damien Le Moal wrote:=0A=
> With memory backing disabled, using a single spinlock for protecting=0A=
> zone information and zone resource management prevent the parallel=0A=
> execution on multiple queue of IO requests to different zones.=0A=
> Furthermore, regardless of the use of memory backing, if a null_blk=0A=
> device is created without limits on the number of opn and active zone    =
                                          open ~^        zones ~^=0A=
=0A=
> accounting for zone resource management is not necessary.=0A=
> =0A=
> From these observations, zone locking is changed as follow to improve=0A=
                                             follows? ~^=0A=
> performance:=0A=
> 1) the zone_lock spinlock is renamed zone_res_lock and used only if zone=
=0A=
>    resource management is necessary, that is, if either zone_max_open or=
=0A=
>    zone_max_active are not 0. This is indicated using the new boolean=0A=
>    need_zone_res_mgmt in the nullb_device structure. null_zone_write()=0A=
>    is modified to reduce the amount of code executed with the=0A=
>    zone_res_lock spinlock held. null_zone_valid_read_len() is also=0A=
>    modified to avoid taking the zone lock before calling=0A=
>    null_process_cmd() for read operations in null_process_zoned_cmd().=0A=
> 2) With memory backing disabled, per zone locking is changed to a=0A=
>    spinlock per zone.=0A=
> =0A=
> With these changes, fio performance with zonemode=3Dzbd for 4K random=0A=
> read and random write on a dual socket (24 cores per socket) machine=0A=
> using the none schedulder is as follows:         scheduler ~^=0A=
=0A=
> =0A=
> before patch:=0A=
> 	write (psync x 96 jobs) =3D 465 KIOPS=0A=
> 	read (libaio@qd=3D8 x 96 jobs) =3D 1361 KIOPS=0A=
> after patch:=0A=
> 	write (psync x 96 jobs) =3D 468 KIOPS=0A=
> 	read (libaio@qd=3D8 x 96 jobs) =3D 3340 KIOPS=0A=
> =0A=
> Write performance remains mostly unchanged but read performance more=0A=
> than double. Performance when using the mq-deadline scheduler is not=0A=
doubles ~^=0A=
