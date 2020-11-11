Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFCBC388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 06:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D1920786
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 06:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PCsTJZci";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kmH8fLcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgKKGEr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 01:04:47 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:52688 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKGEq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 01:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605074686; x=1636610686;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=abVaMwYm2ChxBaoIUX15KQ7XFZr3k84TuxHYqFBsWR4=;
  b=PCsTJZcizaneySqC1LPMGs05wX5BKf1NZib4EUs20AvN6D1KbJX6nL0w
   UHY12YzHKVeE36I/uDKMDkoGwwO6rzhCT4nlexv2ViL40Jd9zv97OdXJs
   +LDXzpBQxvXbuDghYRV9alF9fSA4O9Wu8T/9jFHl7tphfr8TZYi2zPPmq
   Hab0d43C2Kd24JVtrpx+wRuTq72AzP7LlNBPE1rX3ii+ULmU9sJAk0/VZ
   srDcQ2KNkJtk7ooMvPOKu8T58+PKh/cp5O+JXcuIhwOJM3gFqWLmw+ses
   cQLEEBD3O+LEhGvOnqwlOQ+kKs0s1/3eyKZq1m1FtOtqA/C2syO4IYvPP
   Q==;
IronPort-SDR: 3PbYSY0awXwEj6kdilJUe4ADaNODKqaEfhCHe+cQp0xK7F+9YuqBv4g08xWuHirS9Ih9mVFVTN
 AzRYRx0Sn5wqn8wunGn70ju3Vp2sc3XZSxL3hiH19ZX+2/xd5YlKFrPmceyTojcPzWqHnr6ivM
 9vrFgX0SvfOupBOYhdME1lLpsksh0xaSbeMHMBruWVwx++vVFGPiTSIdUz/Ika/Y9UhUDsGUhj
 56f1QR83/p86JOh8GiDwecNbPQIqyjYq41hxXgPUJcY9F/DUMVuTc7anR5Lxj8zSVX4Vux0nAh
 KEs=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="262364333"
Received: from mail-bl2nam02lp2054.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.54])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 14:04:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEChmD9o2MtPXW5uZYyqYW50rbxrdUZ9XOVvPLIgzobCdHMy/sjX3GvbYgH1ugeIFQvvRKHkFLouiMudUeKYMpOJnCypWPMvqgFvxWvCQ4xT7W5KQhl5tLuwwf3sMnkZ9o01HHGlLAsXpaCJCNMcCJ5z79mkfUEUnTa5ByWQ/3muiyTo7q7v8m/S0d+l4v8/4NVOgqVTdvuRtMBmoQKVFRC1kzipHWwJrF3L2NuaZsVmUs8Q9SYPa3dmhJjmr+ltXb7J5Gk24tq2wW7JUFZnpU0M/A3PYnOfQ/8nz4JBoYShIhg5XMZcOYHGF8OPUCWrNs3sSXgaOTwdY+LefTUzBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VicoC4onhTDblD6tSEd82UyN5lU+FtCiEj5aq0Mqvo=;
 b=oVBnb55bp0t6PtNEa879iZhK09c9f6X/ZahlxTwbBSXmfXX4B2yKI55nuAy1DUchiGlP39JJDvpmRiEne9/alsfxtVfIE6UDs5uEXWd7fK50QhQ4XxU+n1WB4W4G/Iyyqje17eqkZ9CR/ayatKZzpTrixh94MrPgBJAUZCkP8Wu3IJFNu4pESatWHvQGiNIs4i/xoY501MF+LqBYUunHf9CG0yZPiRnwAHuNe0nZoRdtR0d7KvNRrtpXjRUdogCAB3m4j6Wc0TsjMLFwPh5UErYfJlUdVVwnhMx/g2r8Y2sBQRCLoPXjdojHA5fvHKGqGGpr+lpFa6s5Ojzv+oGXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VicoC4onhTDblD6tSEd82UyN5lU+FtCiEj5aq0Mqvo=;
 b=kmH8fLcqRxfaImScrhDQI9CLKpzzg5UT0RsdK/dhtSg/sIr+pjo8STPCXXeYI+x/bRIQIxzjNuPYdSgxwbO77/prd3Bu1AJpuL86owI5ezvCRBEagPbbgU+QPjDsaNv3h8I5E+KNaxm2jU00uem4kP+nLSGIQd4I6hX/yAqN5l4=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6352.namprd04.prod.outlook.com (2603:10b6:208:1ab::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Wed, 11 Nov
 2020 06:04:44 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Wed, 11 Nov 2020
 06:04:44 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 0/9] null_blk fixes, improvements and cleanup
Thread-Topic: [PATCH v2 0/9] null_blk fixes, improvements and cleanup
Thread-Index: AQHWt+ngKFKt0vfBY0GegdojxIqEaw==
Date:   Wed, 11 Nov 2020 06:04:44 +0000
Message-ID: <BL0PR04MB6514A5FA5CF8BED9AF4EB1F7E7E80@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:c005:87c5:ced7:ce31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 368b305d-5ed9-402a-ccd6-08d88607afdd
x-ms-traffictypediagnostic: MN2PR04MB6352:
x-microsoft-antispam-prvs: <MN2PR04MB6352818D5A8DFC0F4B725E95E7E80@MN2PR04MB6352.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:51;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b4twt4nre7pAImGwFRPVIgB5wRrvp27JsY30qg1xiIjxPsZTqIANReL3l2ZM8cq7VN43eGhau5cSrzistCuEHewEgkL5p79KFOEZKoTdYzLPuu13ApMEDd3t0IxYFeC69Q4ZMrw5Bny19v7qT7TvEVXTrohWsGSGSE8CI894JH5vUaCpL4Ng244QaZwkCrgYyhtHP6y9i0oMfzxbtJuBlwRqHVVYJxIq2ijQ14Lm4iBFgbaDEBJbiDvcBAcrNEJsyHXqWblKfXw9bd1I25La2EdFwp4a7rdT2yQ90YxcBVACsiLPAgMZ0y3EV8k05lGF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(86362001)(55016002)(110136005)(53546011)(5660300002)(9686003)(316002)(6506007)(66446008)(186003)(76116006)(71200400001)(91956017)(52536014)(33656002)(83380400001)(66556008)(66946007)(2906002)(66476007)(478600001)(8936002)(64756008)(8676002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: r2BaLR0ECtytBCQ8ga545t1xQ9z+EnFdPrPJ+U6NyXb2Mxk19JqhvRWxh3513dfmYd2gcqiKcShJPvK8PG6iT/gwrtB8P2twA7jPFBQpA+th0DyBXt3N90AJMwk0gIY9Y3/uNNju0mhFHq9Bzlq+83DabNgvE8Sfap/Yi/Tg2tMemPe2CBxMrrfeBoivpOJ3tIvbip5ig1zCjIcqmxKf3MF376RrUHuGUtmoK9XbVl0yxg2fS4sH9zs67TYB5usfEr0UJQrfyHhAIML3b774eUAtONIdJj/ptZDApd0nS57+FRRCY0uj17ABjVVofIbr4AOgWY5unPIAa7lnJWTYFt/Rhve/KM8d3dAkgDoU5mnmZySz4Zp3ieU9HuL4BXUTsBwp7kDXv71q5uAqSvdIc6jdSmIXE0dZYz7pVswMktv5EkZ9gNsFPvjqyFfprMB94kJ5SFaf+5qYSRwxchXlZMPNNDdXVrEx2jkBjy639priEDy01yCj27iGDfsbblF3qQuMBi5aua36a4+B6EYkjuRkcmx+nJIQXH0Rw2Awj1tPLhT4+S7zo0QMCmNf+rs5DvqPN/P9n9Bfnkg1bZXp3BjsR1Y+KpnE/bQ8Tvv6vcPzWRfH3e6Qp1i7R2838waTw4188U/YMY6Gm4jNHsW9kUuRds/pOx+z25VXwxLvFnx4E1Ffw/QoSCkvNJokoMy9rr9SdBkfQStmIiil5OAuIQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368b305d-5ed9-402a-ccd6-08d88607afdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 06:04:44.5197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ps8US+2DFl0yPveXsWTEwdBLGJkQxFnn4FKhAmM4m37T42SpENKJTbXEjSId+GcpMk1mSdVQOiiW77xUNn5Riw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6352
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/11 14:16, Damien Le Moal wrote:=0A=
> Jens,=0A=
> =0A=
> This series provides fixes and improvements for null_blk.=0A=
> =0A=
> The first two patches are bug fixes which likely should go into 5.10.=0A=
> The first patch fixes a problem with zone initialization when the=0A=
> device capacity is not a multiple of the zone size and the second=0A=
> patch fixes zone append handling.=0A=
> =0A=
> The following patches are improvements and cleanups:=0A=
> * Patch 3 makes sure that the device max_sectors limit is aligned to the=
=0A=
>   block size.=0A=
> * Patch 4 improves zone locking overall, and especially the memory=0A=
>   backing disabled case by introducing a spinlock array to implement a=0A=
>   per zone lock in place of a global lock. With this patch, write=0A=
>   performance remains mostly unchanged, but read performance with a=0A=
>   multi-queue setup more than double from 1.3 MIOPS to 3.3 MIOPS (4K=0A=
>   random reads to zones with fio zonemode=3Dzbd).=0A=
> * Patch 5 improves implicit zone close=0A=
> * Patch 6 and 7 cleanup discard handling code and use that code to free=
=0A=
>   the memory backing a zone that is being reset.=0A=
> * Patch 8 adds the max_sectors configuration option to allow changing=0A=
>   the max_sectors/max_hw_sectors of the device.=0A=
> * Finally, patch 9 moves nullblk into its own directory under=0A=
>   drivers/block/null_blk/=0A=
> =0A=
> Comments are as always welcome.=0A=
=0A=
I forgot to add the changelog. Here it is:=0A=
=0A=
Changes from V1:=0A=
* Added patch 2, 3 and 8.=0A=
* Fix the last patch as suggested by Bart (file names under=0A=
  driver/block/null_blk/)=0A=
* Reworded patch 1 commit message to more correctly describe the problem.=
=0A=
=0A=
Note that I also just sent a patch to improve blk_revalidate_disk_zones() t=
o=0A=
catch problems such as what patch 1 here fixes. C.f. "[PATCH] block: Improv=
e=0A=
blk_revalidate_disk_zones() checks".=0A=
=0A=
> =0A=
> Damien Le Moal (9):=0A=
>   null_blk: Fix zone size initialization=0A=
>   null_blk: Fail zone append to conventional zones=0A=
>   null_blk: Align max_hw_sectors to blocksize=0A=
>   null_blk: improve zone locking=0A=
>   null_blk: Improve implicit zone close=0A=
>   null_blk: cleanup discard handling=0A=
>   null_blk: discard zones on reset=0A=
>   null_blk: Allow controlling max_hw_sectors limit=0A=
>   null_blk: Move driver into its own directory=0A=
> =0A=
>  drivers/block/Kconfig                         |   8 +-=0A=
>  drivers/block/Makefile                        |   7 +-=0A=
>  drivers/block/null_blk/Kconfig                |  12 +=0A=
>  drivers/block/null_blk/Makefile               |  11 +=0A=
>  .../{null_blk_main.c =3D> null_blk/main.c}      |  65 +++--=0A=
>  drivers/block/{ =3D> null_blk}/null_blk.h       |   9 +-=0A=
>  .../{null_blk_trace.c =3D> null_blk/trace.c}    |   2 +-=0A=
>  .../{null_blk_trace.h =3D> null_blk/trace.h}    |   2 +-=0A=
>  .../{null_blk_zoned.c =3D> null_blk/zoned.c}    | 245 ++++++++++++------=
=0A=
>  9 files changed, 239 insertions(+), 122 deletions(-)=0A=
>  create mode 100644 drivers/block/null_blk/Kconfig=0A=
>  create mode 100644 drivers/block/null_blk/Makefile=0A=
>  rename drivers/block/{null_blk_main.c =3D> null_blk/main.c} (97%)=0A=
>  rename drivers/block/{ =3D> null_blk}/null_blk.h (94%)=0A=
>  rename drivers/block/{null_blk_trace.c =3D> null_blk/trace.c} (93%)=0A=
>  rename drivers/block/{null_blk_trace.h =3D> null_blk/trace.h} (97%)=0A=
>  rename drivers/block/{null_blk_zoned.c =3D> null_blk/zoned.c} (76%)=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
