Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2198C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 03:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4647564E32
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 03:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhBWDku (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 22:40:50 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11357 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhBWDkt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 22:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614051648; x=1645587648;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mU1RlxJ1eUWE77ap/XOgS+fbuViS9zx+kVoM7BrCMJA=;
  b=hHs/2I9HBH3Yu6lZoyUtT30DVwzIzqsIEDF02eWyPvqNB2GohAIfOsoI
   S9/7GpVhTBenpGfeX+MBZd0UuILHfCXdCuWvYuA9oJug1+tfehGWAG5wl
   6FUJZyiQiacYIqZCbUSwf6g6RnURkaQjPlCI5UlmeiTelQIJRRIxDZxXA
   BAVW4A3GoUtMVrERL75AXYje5Mwrt/UmLflo8PYCWUH5PHnfpGho/HueJ
   cNvxzZQs/vJ2tQg/d82iu7OZrMst3WC6DIIiIqjgmXKUAA+vHzQVqbEug
   UId933XRmym9rwsllLG3LqAe53Fxg49FzYdHBytiCWKQb9a6X34FACuIA
   A==;
IronPort-SDR: 7x0kNH2OIMiknK8HfJuHpqdTkhLUqYfsu8YQVE1xm+1Pex6E3ENfFp/2LgzJCCu62atYKPgvDh
 36yFSRqcsOSSd2WSINJwcF2RtDT0nDtzB/O5GhyqRwDOk2tctjz3VWn+jqfZ2DU6td9dJBtnmS
 UoNdvdTWrtcM+nLOr2RpO7ZT0+3Ju/0dKuFXQRIkprxmsD6EyAhs7xfIo5np9tKG11w3ZJnuCF
 hAt34oXX7okk+OptVHeTqBk6k18JOte37PqBTEaMiJBom7uJ9icUt24qaVN4t+2V18PO0NwNqE
 yl8=
X-IronPort-AV: E=Sophos;i="5.81,199,1610380800"; 
   d="scan'208";a="271101760"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2021 11:39:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAyMc2G7ll9J2MesUU+x3sCllsBbs9/i/ch8rYUFG3Qv7v63ecz+y+jAUTeFRkIQSx0kG27YS9BGP6FlMu/NevQ3jJIKH1Qj5AEs0i/f+umySb2a9JbcgQbjMUFJpdTsbZfHMBfe4kZOWHP4rXEyPFN+zi7KQPlOKNJ25TegTuEl+ytrS1WL0ggQ3oTyqBC5mWigzj1XDlbOoa6I09uMUpQYtKI++tKiysCWsRZe759ETpubwEq2fW/yE3Hd/eUZjUpa9HaAlYg6aB/vOTqc+JWZySz5mObRSS8qix+PZhQvj9yjxwC1KmUxOpCtKgIS60U2YMZVnclCPl4qmq7I6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJkgUZXUsXzUL5U9wY3WXENETLcr0XGH3/5hemi2zps=;
 b=QcSt2GFNoJW9567LftByitDctvd+JLtMo7YdmM5VczO5lSRwmv4CQBxSFT52o5o9prWQWB3X8SRY3w+Un4Fd23kN+CGgpdGbzEjgumPjB/a9OKfv+fCA1TCwttuE1Qp17/hHP8RKaxjAzW4zkk+3vCoGHz8l+Xdpa8qMCKi7S3XGE3zqn3+pgdS8asfyhtHNTVPHfnsJGTWBli1epa0z9/8gL8oFhOGaMx77rgGxuQPQDIGG/i5jpqiGt2w7zw3hJDYCFYE91tFYMbn41h2nBU0Z3vrpTbphvN2PMi1PAIDupvSSm1yoCEHln7VOcRpLq5DDKK13ccwwYupuGgAF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJkgUZXUsXzUL5U9wY3WXENETLcr0XGH3/5hemi2zps=;
 b=DEM4GxU6J+pAaqM+6t7PNsOYYaYim+u9cRFK2JDLjI1jKrj35UJxtYgCNWd6/23z9eIQLuwCdjn0RzV6TbfBgagH8WuZixxvnd7P7ARM3+y9iVivsPnefQwthx5i5rcUW5sb5u2KO4e2Byybht9pwHSeZZN2LunTbmKmtxgrwO8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7262.namprd04.prod.outlook.com (2603:10b6:a03:292::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Tue, 23 Feb
 2021 03:39:39 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 03:39:39 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     John Stultz <john.stultz@linaro.org>,
        David Anderson <dvander@google.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alistair Delva <adelva@google.com>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing
 crash shortly after bootup
Thread-Topic: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing
 crash shortly after bootup
Thread-Index: AQHXCZD3vAo2wh9jek+o1gtQqbdo1w==
Date:   Tue, 23 Feb 2021 03:39:38 +0000
Message-ID: <BYAPR04MB496566A72BC5641BAC7D279F86809@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <CALAqxLUWjr2oR=5XxyGQ2HcC-TLARvboHRHHaAOUFq6_TsKXyw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 772d88eb-6a14-48a6-70de-08d8d7aca5dd
x-ms-traffictypediagnostic: SJ0PR04MB7262:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7262A919117123A7B04147D286809@SJ0PR04MB7262.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pe4VRBMMcTK6M8RO6WrDxdmylL9X2Gchh5L6HR9GB2Ww7QEV7rOUPprAU8YIDga8zjnok8dAAZFdxtceVf0shZCm+JPqx+F5WzfzUmemIl1M7tduUM2pI06QmOIhh87oEKYQrUkjcXI8eRh/3g0YsGebD1HfApeGWacTjUTEMhj54TBMWoapQNG0Rzxpt2yPTgpddTkwKLO48xvZkDim8npg81tNb+BOBYyTRDjUPRcvV7fqLYD27NQHGNCsLdiYJOtFGo6PCz/ULwz5KZ69cvcc4G+fXsok8Q/OQpzSAlqggEYBanpQ/b+vK1wLKW9xHdcp8+WQ1qkG/H+eBal8Q5orHvrT4Brv2bgNPTffXDBpezgWlNHMrCCk+ifKh+QBENBnyv34mGTJ/GqEy2HoQrsTbmLL9CkwO/n88NSuG2TGAAu37LDeOKpxSLZgfz1SLNhC3bJXRg+TwoleNaN16itWEtuXn2OPVig0M11Vrkm/k5+yT8xnbVW65NVNTRUQIYkbiU9Whp1bJzR1zRW22g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(316002)(8936002)(54906003)(110136005)(7416002)(2906002)(66476007)(7696005)(478600001)(91956017)(186003)(71200400001)(53546011)(4326008)(8676002)(26005)(9686003)(55016002)(83380400001)(6506007)(33656002)(5660300002)(66446008)(86362001)(76116006)(52536014)(66556008)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BTl0gkTcO5rtwAvSCfikkKi0hra8X3akBNjBvGsYhk2zv+7TLWlGtRtmRhXw?=
 =?us-ascii?Q?UUzcdjL0DVDNEm/ywuIB1gb/54iJHFmKgLjwqQA39D1Wq8rrTTKEtNNskE+H?=
 =?us-ascii?Q?fHgTx6UUBgKkYgne3D1+wIMOyb/A+gSH1s2h37toNnHmO7ETvriQymt8oanf?=
 =?us-ascii?Q?2HVOGZ72VXbpLhJalQl6lh1bIPHUoMsZQTeUX/BRgCLASVohr/b7sX4U6hrK?=
 =?us-ascii?Q?n2sjuFG0ti2MmNz70Gd0DNm8j9xx/pTeiIO4Bp26s17oujzIdxCP4k7Ev0Sq?=
 =?us-ascii?Q?pxUTFBGUKOGVj7g3iDM35Hx5EN7tt5nEFKOVIPUDzZmODorhTRgzzo1ujoZ5?=
 =?us-ascii?Q?U9rrPsgQczhdB/dThDLb0WxAjy6JRnwSzcCFzAc5Y7spG4rPJbN/soaleOe2?=
 =?us-ascii?Q?qJ+T3tyklxeu12MFj3VutsSWiH61D1GfaTo1LsbEJn+728U0VB7yIH5SQyzF?=
 =?us-ascii?Q?ME2VGqarRKM+3LZ0mF7wgILthNjwgfhLmlS88xSeWxm2lMnRLgAETLBx8h3B?=
 =?us-ascii?Q?JwWwUuRifY+eqzxvPV1cDNsBLwhK96S7rBOAT+Pwe4pJuiIAUddim8xS8YiR?=
 =?us-ascii?Q?zmlfeqIjT6eZh+MyE5kim9szfXjlZiHi54aPhPXi3qWUo8+qfwmWerpuAwPQ?=
 =?us-ascii?Q?E9ZWvB5I2dOVzU/mRGXmJhiMvXR8UKXjJ47xE63iNmwNCp0SwQI9ILtCHbP9?=
 =?us-ascii?Q?IAyJCqr0iTWrXFQsVRLHokusJ4WXQM2hJCKhek61vhRpbn5i81wbvAd5nkcr?=
 =?us-ascii?Q?sjIud3bQOrzK6E6D1WNml8Mv150cvcbadbcarEqWv8OikaLxBoAcEqA7d83o?=
 =?us-ascii?Q?y2xGUxVB9vxvLJQdiTdHgTATYZwjZ9AR6w0oijTliN5VeEAImz4BvMt+ZMex?=
 =?us-ascii?Q?uwCTrCxc7y3g145C485ICpzZA6R6HfS6VuGd0qqxx2gQx7s47XO0HyAmsDuO?=
 =?us-ascii?Q?zRVlPZvnRE5ocOieiG98IgWMRNbzOMtG9XoxujnB47xY+irDBuxSXjPc0TbU?=
 =?us-ascii?Q?Z6AIXS48XlZFIwWiRKxhW9odUt+vqXuazPHGf+ywEP52x4y8EAvHyCTR0QUH?=
 =?us-ascii?Q?M99l7/zzs1tn4GJQ8Heg9eyadvrIRq06kvbrjh/dz7SCUIXbgzOQuEDDww4o?=
 =?us-ascii?Q?bzAIVh/9wen3XaffYOi7/S9OuWltFnsxyt2SuATxf6lIQAuZ1uXcTxNHVZUc?=
 =?us-ascii?Q?ZV9pgWSmi9Azq3Ka3FQ11x7ZG2pLeqikdh/X6o/5Ci+5UHuSzFAoAXQndszo?=
 =?us-ascii?Q?4Hey9b3U6T/7v2cmLcGBURJID434iJDz69CFFe8cKqwpKKeXxu69Ww4PHB0I?=
 =?us-ascii?Q?P+fobe8mQECbk5YoDJN4vJIh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772d88eb-6a14-48a6-70de-08d8d7aca5dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 03:39:38.9465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rgi9mUAXvEeUwVZ2vveGaPjBNeu+fN6NXD7b28sOWHFK6vhRByXzVHD3KWezWi1k3sqVRBwFrt8+xu1PAgmYUABEY8lG/8CU2U92G/douio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7262
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/21 19:07, John Stultz wrote:=0A=
> [   34.784901] ueventd: LoadWithAliases was unable to load platform:regul=
atory=0A=
> [   34.785313]  bio_alloc_bioset+0x14/0x230=0A=
> [   34.796189]  bio_clone_fast+0x28/0x80=0A=
> [   34.799848]  bio_split+0x50/0xd0=0A=
> [   34.803072]  blk_crypto_fallback_encrypt_bio+0x2ec/0x5e8=0A=
> [   34.808384]  blk_crypto_fallback_bio_prep+0xfc/0x140=0A=
> [   34.813345]  __blk_crypto_bio_prep+0x13c/0x150=0A=
> [   34.817784]  submit_bio_noacct+0x3c0/0x548=0A=
> [   34.821880]  submit_bio+0x48/0x200=0A=
> [   34.825278]  ext4_io_submit+0x50/0x68=0A=
> [   34.828939]  ext4_writepages+0x558/0xca8=0A=
> [   34.832860]  do_writepages+0x58/0x108=0A=
> [   34.836522]  __writeback_single_inode+0x44/0x510=0A=
> [   34.841137]  writeback_sb_inodes+0x1e0/0x4a8=0A=
> [   34.845404]  __writeback_inodes_wb+0x78/0xe8=0A=
> [   34.849670]  wb_writeback+0x274/0x3e8=0A=
> [   34.853328]  wb_workfn+0x308/0x5f0=0A=
> [   34.856726]  process_one_work+0x1ec/0x4d0=0A=
> [   34.860734]  worker_thread+0x44/0x478=0A=
> [   34.864392]  kthread+0x140/0x150=0A=
> [   34.867618]  ret_from_fork+0x10/0x30=0A=
> [   34.871197] Code: a9ba7bfd 910003fd f9000bf3 7900bfa1 (f9403441)=0A=
> [   34.877289] ---[ end trace e6c2a3ab108278f0 ]---=0A=
> [   34.893636] Kernel panic - not syncing: Oops: Fatal exception=0A=
>=0A=
=0A=
If you have time then until you get the reply from others, can you try=0A=
following patch ?=0A=
=0A=
diff --git a/block/bio.c b/block/bio.c=0A=
index a1c4d2900c7a..9976400ec66a 100644=0A=
--- a/block/bio.c=0A=
+++ b/block/bio.c=0A=
@@ -663,7 +663,10 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t=0A=
gfp_mask, struct bio_set *bs)=0A=
 {=0A=
        struct bio *b;=0A=
 =0A=
-       b =3D bio_alloc_bioset(gfp_mask, 0, bs);=0A=
+       if (bs)=0A=
+               b =3D bio_alloc_bioset(gfp_mask, 0, bs);=0A=
+       else=0A=
+               b =3D bio_kmalloc(gfp_mask, 0);=0A=
        if (!b)=0A=
                return NULL;=0A=
=0A=
P.S.This is purely based on the code inspection and it may not solve your=
=0A=
issue. Proceed with the caution as it may *break* your system.=0A=
=0A=
