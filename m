Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4D8C433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 03:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2FA64E2E
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 03:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhBWDwf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 22:52:35 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12252 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhBWDwd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 22:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614052351; x=1645588351;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qHumi863sYoH26CUanBGXSCqGoZpnp0TUapVkWwjBgE=;
  b=BfC1Btjr7iz6ddQZdRhdocOYQBnLxVAPimVDesk2ae16+0Fr1HoeqV3I
   uDS2FECwF4zE3q/sZpPjmqLoO61N1540U4HE4QfLUJnUlyNM9dyACo09r
   +IYzdbihYCB5mASOeMwotyS7H+61vzuYbw0vaC13fpS+nWanSLmDWgjmC
   ppFptOeeBGdw+UWteoHYD/PZXbTQKO+3JEnKiYBohPI/cVLYbLZAc6yGH
   bVk7iHi6GUHE2HODgXHT3xmBSOkW/JzUFRnb3a9zt7612HranQM3UkG4n
   asME54TRjEGVWelwcMdUC4oPoq3INw4Bb1HRaPBgJcVQUo3QicLh4fX/i
   g==;
IronPort-SDR: N3Fy8o9TJLxKDuMUbwkv4OjzSSph7S+BRjE2V7zdYJn2adzJzcDBX4SXLycv6y4LyEt2OWbWmW
 SeOrR5VmGOzopy5R8mMTDabUxSymKFUeTFGdNFRrGBF6ii6o2tDclRjaDHlHPNKe21umYjo+lN
 frOHI9k1nNlfhID9DIQe+gaQTNS5QQ/xxAz4Tn1SM9567fQN+LIxD97pxmcj6zBAZ6OOd5rxxJ
 7Rd6ejDzGJ3ZLjUyZQ9EsOVMKmgTogvJVbCV8TNUAGea48SmPWQUv3ZP0EdbEO77nPCAxmmBR8
 dyc=
X-IronPort-AV: E=Sophos;i="5.81,199,1610380800"; 
   d="scan'208";a="160544919"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2021 11:51:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSkMbnHM8woltSGCNkutE3sn0If4k8VtaMBqsz6vcrcx6clqZmBMQFVoYp9tnePH1QdSHYGFlwFSFkV4d0XCQYHmLCYVhJVKCOKriMo3FFZfeCBxORWMR7GgXLxNG5idTApafJYILJ2T+qPElIicMzdh79KV7njsHvruI4ATU1VAsNydBV4wMCFRFVpEdgNL5Qu9Ts/zR4C5Hv05/zC/MpUqWwRhIqweLlIARSL6U/iZr8CRwzWSn1wkC2yhS06xJvDrZ3/BkDh4BqhATFpIiWlmX2mozCcuDtr/2AJL3QhbvkjTTorpXRQ7NSxQXfcDIDiEM0oy18zRdaUk+VVzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VhaD21BQNfKbnHVIpPpnR+6fkaM66NsALLAyXWL10s=;
 b=MlTeHzG71q4RRHqLu9xVgfKpTp2QpDSe4eqD7N1ZChY/oMD58hbeUXfr2tBnhcPHahPmeRwUw9VbxCLF7tQv9JzwVfn95ES9u1tvNH8ziqC+8YUFwFHW5KbHsI6aJIFXszonUMcKNYrZi4gvrRlckPUhNjLuFk7Yg6f5Gq1OYE/magMDklw2ExaeAcagRqYgMPj76DrYtPZAPSe0hKDI/oYvt3dT8zAKpeeZ/RJ1AvKNGVlCH92djFJ2xS1Zvm2YNYHJ1WicZROm9ooRzGLeGI9BMSvjpgd+isYohnMLaeto152yiYMUjjC9u1aAfeAJD+TM8xQAWsqx/+gIRYSikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VhaD21BQNfKbnHVIpPpnR+6fkaM66NsALLAyXWL10s=;
 b=GOlIC3Pww4sBTNgvc+vDVAwwgdVGXuEMqZKDeS5SHkaXYv7249gAJw80Zww1TrTQxUU4bdJMjibA5xI90SSrYDd7T4pERt9aJvBj6K/D1mZbhF9iYlhuT7X/d22RvVDGM6H9RqpMfG8mIowABRJr+/w2HAccDBURfY9eaqm40P4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6103.namprd04.prod.outlook.com (2603:10b6:a03:e6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Tue, 23 Feb
 2021 03:51:23 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 03:51:23 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     John Stultz <john.stultz@linaro.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Anderson <dvander@google.com>,
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
Date:   Tue, 23 Feb 2021 03:51:23 +0000
Message-ID: <BYAPR04MB4965F0B60169371A25CD423E86809@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <CALAqxLUWjr2oR=5XxyGQ2HcC-TLARvboHRHHaAOUFq6_TsKXyw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6814ea6b-1cfb-43f3-7a3e-08d8d7ae49ac
x-ms-traffictypediagnostic: BYAPR04MB6103:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB61031928F0502E4E701BEDE886809@BYAPR04MB6103.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cCy6xnz1d4/k3kQzxQkpngXSyUTraxjxjLN+024f5TNigvE3FlYaEl9lVFwJMpHkWBsvIA4wA3VXh/k7seLvJ/8cFjOfhnkqmMA7l1zJnSRNGXKxcRb2RD5Kh1/gMLH2ZTBautUYq743KAHa1AxeRhAWiXHvZDL2w+bQGuACnvf8PMi9BbVE9RCJiFSe6zkVueEKlOCchdzyIOuvS/QEJH4jtGkcHSnrAEARQdnFrAuO1lp8JKbgn+9/npWmTrN+typEJfD4Xc4SjvSmCxpNjJAke1tImx0gsSJMGk+QA+rE3tMUvKuCTzQZn0t+sLylboNSebhxryMzKPGZ9RJFNsevS0RiKvr/R9NJzUzIuq6iYktuIyULqHhEAyIsZrCnPYMUzrqHLtJ5mYp4zlSE2iPjlBng/vdQfqA3VA/FNUagDItoKJKtUu6/x5Sn3UaCzn8UFMXXwxPYcjR9D9L/D/CqGy4o2kVKBTgtaT3U+p4BxR0eUivkVUFh1o6XBPf+3FWY2dbXNdqDhD7ETLVg/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(6916009)(53546011)(2906002)(64756008)(83380400001)(186003)(33656002)(316002)(7416002)(8936002)(9686003)(86362001)(7696005)(91956017)(54906003)(76116006)(4326008)(5660300002)(26005)(66476007)(6506007)(55016002)(478600001)(66946007)(8676002)(71200400001)(66556008)(66446008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NWzywEJSfuafnJrhkTpuDkEvV34XsFUZ7j8cIbPIFCbaTq7e3Ph6LUnuOOhg?=
 =?us-ascii?Q?FOCg9QruFL1BdUNIhcAJYlKqgiw/S8sDB0DMKQBkhKyRPq/ORbrAFIHvEY3i?=
 =?us-ascii?Q?fSyrzAMXnCHB5rO66MeODmfUF9wdHKevMpWiogA0H88neW9gsyreNa5DLOV5?=
 =?us-ascii?Q?5Tuz/2/x9bGOBpnteFSRJsfgy3Fd1s+GtRprMx572tpbQAvTrAjx3EXlSUjf?=
 =?us-ascii?Q?QHKrkNgF9pb/Ep7cV3DlRgfjVz02VevoR6scZEQxqfIPNIGpRpUxgCJOVaq1?=
 =?us-ascii?Q?s3EaoNHMtnsFjnMXbj9XU7qH79EqTix20mKa/oxDQpwdTkuP8b/BZ7A3wWje?=
 =?us-ascii?Q?36w9fGssFEuXSV7ChlyT/tSpdqMbFh/0/8jyB9H6ZSSQjhzHftZVN6VdUG+J?=
 =?us-ascii?Q?wG+192i8v30SR/Qb6FXPgflAJDVISpqqYDW/VzwXgz2DsCA5vswNwTx61vd9?=
 =?us-ascii?Q?eikWSp6/k3URJqVV8bA4zsLuQrv+q/3y1/6oogOaw7N9Hjs0zBB7bHZ33KaQ?=
 =?us-ascii?Q?n6RP4YELTM9VTfb3O3hxbGai7exGkWUR2i7BVcum/npKlxk/ox5jhhQHdwMT?=
 =?us-ascii?Q?nM0PtJWCuSdh1nfSlpXfVUbHHxUKZ4imZUCq/YV/iUwQwU7fBh2qg3mIYTGq?=
 =?us-ascii?Q?4GPl4+8VUA3EuqEsEBrrngxONidWXKispnGOfyhyX397YyCbpiFkhudQueaW?=
 =?us-ascii?Q?A2yY+G8iVBnr1rH5wuN4Wonu9h9LFeLk+s1o3YNjDZIj6pAO9Ypf2XodoTkW?=
 =?us-ascii?Q?OXFRo3tL+WF8XdKVKIXbE8aYxI7LFgtfJCXhY6bvDtFjHyjFhco4I2nbfltu?=
 =?us-ascii?Q?7Su2s40z9L6ewG2YiOVTAs90GfmUfgKbKyJohV7T63HH8WTWUfQqCuRlkKDi?=
 =?us-ascii?Q?Cf/LJ3bEmXLs4K88y3/zy2l3z6127ME8hV6oX3OxOYdrolllJywonekH7BiP?=
 =?us-ascii?Q?G+bhKOKC7t900AF7or/M1xhN/eeEWjIAngmc0/Ivw+EMxqucUEdKfabNaq53?=
 =?us-ascii?Q?BJDs5rcx2PFB3Og2vcfM6a8/Mvf4/+RPjoenxefmWsJuKlZzSrC/8mhYRmxL?=
 =?us-ascii?Q?bAnEOoco3fU8wDaHkmGnd2b08Z7iz6G9xcwhRKo3XMUytAlr32my7HcTdrU9?=
 =?us-ascii?Q?k1PQayOZ6S6rEeLwKKwPvtTdlvQtLqAm2XkRCwouCj9DfT8ofBpz+kibvjYB?=
 =?us-ascii?Q?Ag0upDYbgxS2WeRhhhI5Gn/4MIKyivmtATmdxi/KD3SygFpKN9xMlRZCyDDN?=
 =?us-ascii?Q?dMyKFgAZqR4Tb5LilReY/jjk3mragPCVmh2R3Rft+svC92dZqt9xmA93CXF0?=
 =?us-ascii?Q?NQ9i8VpTULJuK9shUvrcYhZC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6814ea6b-1cfb-43f3-7a3e-08d8d7ae49ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 03:51:23.1747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Rl6iC7yCaYRodFPzsUjjJk8q0CcVtrJXvT42DDs0KlAPy8LCphrJJouLoT4NnwBXhVUdf+e09ExKtrJ7hmm0EHOsWLAKnxKuIUrQwltWlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6103
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph,=0A=
=0A=
On 2/22/21 19:07, John Stultz wrote:=0A=
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
Looking at the other call sites do we need something like following ?=0A=
=0A=
diff --git a/block/bounce.c b/block/bounce.c=0A=
index fc55314aa426..f8a3656e89c3 100644=0A=
--- a/block/bounce.c=0A=
+++ b/block/bounce.c=0A=
@@ -217,6 +217,7 @@ static void bounce_end_io_read_isa(struct bio *bio)=0A=
 static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,=
=0A=
                struct bio_set *bs)=0A=
 {=0A=
+       unsigned int nr_iovecs =3D bio_segments(bio_src);=0A=
        struct bvec_iter iter;=0A=
        struct bio_vec bv;=0A=
        struct bio *bio;=0A=
@@ -243,7 +244,11 @@ static struct bio *bounce_clone_bio(struct bio=0A=
*bio_src, gfp_t gfp_mask,=0A=
         *    __bio_clone_fast() anyways.=0A=
         */=0A=
 =0A=
-       bio =3D bio_alloc_bioset(gfp_mask, bio_segments(bio_src), bs);=0A=
+       if (bs)=0A=
+               bio =3D bio_alloc_bioset(gfp_mask, nr_iovecs, bs);=0A=
+       else=0A=
+               bio =3D bio_kmalloc(gfp_mask, nr_iovecs);=0A=
+=0A=
        if (!bio)=0A=
                return NULL;=0A=
        bio->bi_bdev            =3D bio_src->bi_bdev;=0A=
=0A=
Since __blk_queue_bounce() passes the NULL for the passthru case as a=0A=
bio_set value ?=0A=
=0A=
