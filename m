Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA14C433DB
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 08:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3B7561A45
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 08:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhCZIpB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Mar 2021 04:45:01 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:2570 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCZIpB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Mar 2021 04:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616748300; x=1648284300;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NMbtvQoWq+akUu5PGrOwwKLyxE2L8UGEkYpLCW5w03E=;
  b=HkbdW3w4tuLrYz4+bTpJH2/02HWOxz1YdHYfp7SPnVZSEXOuUzpaKPmG
   W7ihNnZEMRFbGlEwGUV3QFEvV57nzydN59PInuqpOHcXl+4TQdWIa3Oxm
   jg5WtJsP5k01R2eK/M49U8QTSw3R8OGBSia25G2gFgdPVwi/H+bEzeoc+
   XPLoMQd/Nm61ucGn8c0qhwhpcXPrk3f7R9wQcmF04QZ5EF0wKp35P4vMs
   mitXONUAro5pjvqIf5end3uy6G2iLEBce1seGC0OzplFlVXwOWw+kd8+g
   /f8R+2kljBzww+WVJ3vJieW00LzXpDdarOQcFOhJ9xGA/0UxIVz44JAbp
   Q==;
IronPort-SDR: JaBXdpjBO15cVs4AXhEjPABUKAMDaIpfkvWr+Z0KabAY4m/qdVqivjF+CpIzuFIU3PT7imal8R
 1EQ4YLg26W0qnCQdcHrLE4CTPkv7UPy2cNmRero3nPlb9U32I0HY2yo0n8T1AfK+qtOaKFNOav
 4aXUvFpCi9EpC8Sv0ruDY+dUhs/rGbLqwVyscb8zdZhI0CtMCcDn4RaqMeIi+A0rmTJEBcOGPP
 8Or2ixwmE4qCHQBhYZiLz+1meW5tFn/mngJy5nu7iFHZUkxwVaFuMj3JDPSA56vjdKaPsoLi0M
 rWA=
X-IronPort-AV: E=Sophos;i="5.81,280,1610380800"; 
   d="scan'208";a="163068898"
Received: from mail-sn1nam02lp2053.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.53])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2021 16:45:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1B+ZsOq58DoqSTiOEP8dTUFq+O+G3/hNiSR3gNv/RZfhhD9Zi9FpU2A4t4iYrLUJ3+0z4FDXZizcvJIxAKTxNGZbOpfNNyKM2VjJScNUwsMXgcm1S0G8dED7wt0TI59y3KqZf/BZjbF7cmOGBQTgkZSr/bf40Wy2ZaxyX6+VFjblJ5LjD2tr5uq/I94tYgU5jSow5PH6zv7ooJCA5i8jQGSWlAb6s7iNjGxtPiWnI62PQ5gSz957RiMKFRp2oCJnj6CAYGPwY2vJYj5TMYD7huSiWK2W/Xm+xGBsHVD1VzVPq6gHh4gXLe4eEYeGPZ7EyzyTo6wG7w/eVj14dQvhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FScU0brEPJlb+aadGpHCfkCtBQeofFONPPwcsrJhjEk=;
 b=RsNr5mowPNPNQVmZUyioEZU1Z1oJ91kkkWdvZ/QSZxlKVSpnh9W8F6ri5EkeBeO8PBUzcdis5xwFp7EmkfC6m+Zrgv3mSEEtTJ9RTCVQkJRmTQDC0m7epJxIyaQ8cPvy2CdPKpZCYRJA3abMZi+/yU/IIELLOfvoYXHOIVZxyxe1aI19hTl0eIKBniZlq6MjcfEEtHuF9dSmzeK0dFoKHPtd5q8AZ/kTIAZxZUHHjK/pSyNYJ6kEgyS/wXZUokkSyAML7LGlSiL6gegykiKcgq/c5dsoOviYe8iODUR68hAa8YVtvWTyGBrFdLNwe3FRyEKpn8b83T0896hxYK6oYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FScU0brEPJlb+aadGpHCfkCtBQeofFONPPwcsrJhjEk=;
 b=QzrFXkfJgx9gb/u7LRA/p5ownZ3vhvTQ0K4eLhgKdalpdIvG1A9XK4niBolR0VEhiN5+fM/p7lrKyQEauxODBToioa9m2Cf6iTmN8u9gKS5nw950Dn1rZkIHcXWUd4JsPPXIUnPS0lK9NvxKryVS2GFVHwK/b9gnBRva/r9l/0Q=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BYAPR04MB5160.namprd04.prod.outlook.com (2603:10b6:a03:51::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Fri, 26 Mar
 2021 08:44:58 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::61ad:9cbe:7867:6972]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::61ad:9cbe:7867:6972%7]) with mapi id 15.20.3890.041; Fri, 26 Mar 2021
 08:44:58 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Khazhy Kumykov <khazhy@google.com>
Subject: Re: [PATCH v3 3/3] blk-mq: Fix a race between iterating over requests
 and freeing requests
Thread-Topic: [PATCH v3 3/3] blk-mq: Fix a race between iterating over
 requests and freeing requests
Thread-Index: AQHXIeffaluH7SnAsEaLlQkhzcmjVKqV9MgA
Date:   Fri, 26 Mar 2021 08:44:58 +0000
Message-ID: <20210326084456.tymobjbpy2oh7vx3@shindev.dhcp.fujisawa.hgst.com>
References: <20210326022919.19638-1-bvanassche@acm.org>
 <20210326022919.19638-4-bvanassche@acm.org>
In-Reply-To: <20210326022919.19638-4-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e34573e6-dd6f-4ec3-e266-08d8f0336fe2
x-ms-traffictypediagnostic: BYAPR04MB5160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB516056E5680546A3CCDE76A2ED619@BYAPR04MB5160.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DkkL7gOvrtxSgDnLJDsYqLd4Ji2Vtm8qRLpWFwHoDhJajWH8g9caep6IBFVLEkGgBiTwUEJIal2VoCQ8042csNP63XjkLEAzAUPLEwVYlpOO4zoS0Xho+eWmCTGw5doz7OhfeOidSUvtpf0gqtoZWBz5HJ3iDNiCfTR99nxKajDSFsxqi/C3uxKXE6lh0KGoebD+6PfZb6gVnFraW5gJv1LhahdIvPrjOQhY+IxGq8mYgjTdEiTFKOfhFeNsjX/O95OhOg0z3X85NWcNj//U0oWfo+oJJhCeftk0L3zAjuJSAi8+xj2fn+F6Kq3K6mRMRXXEYpTm6sWDzEnZPJT+pfAqcIsueoOvOsLrsosDDWTvmOA9YJSMegpLr+c/1M+8G6VN2rjJtYWzUwHj/wopRj07tH30An7s3M86OMpaesoxNuedvhRY2c6pFM6Af7blhKwUO0rlNjcu3/Se1+7G9WwTGIeuYqfcTdm+2AR3IFgxTRxIi9+u8iapsGJbzGnCF0fbQ933dK0ZOQFpMGfMbL8rM5Ib8P/qc+PuHxfuf5lJErdxEoV0UxD3DMWifrQ5QMdyLaBMpttR1Vjjo2ZDdfOkeJAygMIYUOHNj695LbAbCb8y+Lrho3GPxc+p1E5U4vboGSqUr7ZhcgQlU2GF/lVUKLXZCe1j7M/R5thsz3yftVQNI7rra6VjF0aCU9/clx6whW1wWSO/d+5YBnavKy0BmwdFtaZXla9eNxUq4yNIvW0DzEZrSw4ABL/IutSG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(76116006)(1076003)(91956017)(8676002)(38100700001)(4326008)(6916009)(8936002)(6506007)(45080400002)(66446008)(44832011)(478600001)(6486002)(316002)(30864003)(64756008)(66556008)(83380400001)(66476007)(26005)(9686003)(86362001)(2906002)(5660300002)(71200400001)(966005)(6512007)(54906003)(66946007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VI9+EpAOQPFXuFRyZ0MeM8lFXjuU4658Zd0vF2+41p/ZdY0x0anBWk/qwbRL?=
 =?us-ascii?Q?sYU8GdCbWr2peXQZHpLHByWo9+Uw+lsuIwUoTui7MEUDYthRxbhLeKeXsOc6?=
 =?us-ascii?Q?AfTdJBFmInEAzU+/hJO3rYWm+0ZmlSH95w3s35yGMZ0PFSC6sy0Ml3+Mvj8w?=
 =?us-ascii?Q?tJyxu/Fyuwzyjp+FAk5J4BqnxF3LrbvDqho043e3M6i5PfkdLYvC2zeIvhlV?=
 =?us-ascii?Q?FXArewhkMzh/uuE7OlBbVlGfQqmTTv3iZHcnVhgONvMnNkCc4aZ7H5FhD6ZF?=
 =?us-ascii?Q?H8z+eIxHzHmR0hid3Fl/GeWI6BDPiYmGqSm+VfnziLxjWPp6Vs8RZzgzt69I?=
 =?us-ascii?Q?bzYE4kI5bGYqed5ub15jja+/ATOPVSlc8I96gwhPu1slZEXck9bR7Wy0/FSR?=
 =?us-ascii?Q?T8PNA2aTiJPxnv7G8OBRBMXmibFJnyEe2MZvhsf1EvV5MsAwW8AD3idV/Sq2?=
 =?us-ascii?Q?kq/NRKoLC69KlRg6fkyMvhjyRxi98191qz2s+mnsJ+c3DuCT4EuwZw0JPi2m?=
 =?us-ascii?Q?nPHBXAVxJb9m71jnlXXRp8OREhOFXyrhHcx8g2TpPBvSd8KFiaBZtLxpoG8T?=
 =?us-ascii?Q?UMv8R5HFcqFVM/XAydFrX2G0bRpahvG+L5+bVxU63lhmWOsE3nbLkRDO9UZI?=
 =?us-ascii?Q?9K7EjY6ZpTU2OH9SEYn5seLjJH+QziRBz87ZQMtCGGNtsit+/jUr3AAVlLwU?=
 =?us-ascii?Q?RFfxKvjQvAOF1t7dQP5KkBHlPnRdLmBdcGobfo75mRaLca/oHMk3mU0+7tUx?=
 =?us-ascii?Q?ZfUlzrE+UreuONhq7M4RQowiDXLElpw46htCzVOdRQLDhEsxepy6dDIW/dqn?=
 =?us-ascii?Q?wCpxdxbrpSgaFLiQ+UwjjZVo+Km5JPjEe5efptwHBGZFEsuQFD3B8BSfAfHC?=
 =?us-ascii?Q?FcXo7Rf2AxH+te5QHVnIgUzvy5X6UBX2+wWaSZR2+oBGnKUdNUC+93KxfaXn?=
 =?us-ascii?Q?rcI8XJvX+hJuRW6f++wUtLtyVzHJGBe+PGMUqwN8HtCKUZQ7Btq+KWSq79km?=
 =?us-ascii?Q?LRQ0ieFFB22VlOHslJF67W/4xZQ8VpmwRWuuF2UBlJ8ULn1GtWe0nz1vcWPD?=
 =?us-ascii?Q?GXCoAjqQi7resTA6ayDjdsFICacYoyay+pCvFZnknUNkd/Q9J/vJqH0lPYnZ?=
 =?us-ascii?Q?4sbDjt+VI4WXNZ5sa4ew0HkGoe4UHY3Jj7W2moDrFff56gKb5x8CaIWARnZ6?=
 =?us-ascii?Q?H/IRihWfduEsIs+3g55xg7DZfsMlR5+Xcxkb8K+SbXlOfE9bNiOIOlZ9dQd+?=
 =?us-ascii?Q?WRBgPq5b60Ivoo9n0fIpTnJmJQ9P77p/ZoR1vFJetmD1GElknJ3iYOrW35uD?=
 =?us-ascii?Q?4zy438zSIrkdcoCCl40k5QaFOhr7UWRYJkqsP/X8+iYzCw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <967E77300BD6CC4499F950D807C959B1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34573e6-dd6f-4ec3-e266-08d8f0336fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 08:44:58.3144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3IHGWP56hFOTJyi6znw5fZ8xr7TjGx13UkqPv+VV5PXWoYRBNJ7nvNrfYYUsBYRgZDoL3XFFqOQkuRByfJbuQCNqnEAnsxnX0/mg05umII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5160
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 25, 2021 / 19:29, Bart Van Assche wrote:
> When multiple request queues share a tag set and when switching the I/O
> scheduler for one of the request queues associated with that tag set, the
> following race can happen:
> * blk_mq_tagset_busy_iter() calls bt_tags_iter() and bt_tags_iter() assig=
ns
>   a pointer to a scheduler request to the local variable 'rq'.
> * blk_mq_sched_free_requests() is called to free hctx->sched_tags.
> * blk_mq_tagset_busy_iter() dereferences 'rq' and triggers a use-after-fr=
ee.
>=20
> Fix this race as follows:
> * Use rcu_assign_pointer() and rcu_dereference() to access hctx->tags->rq=
s[].
>   The performance impact of the assignments added to the hot path is mini=
mal
>   (about 1% according to one particular test).
> * Protect hctx->tags->rqs[] reads with an RCU read-side lock or with a
>   semaphore. Which mechanism is used depends on whether or not it is allo=
wed
>   to sleep and also on whether or not the callback function may sleep.
> * Wait for all preexisting readers to finish before freeing scheduler
>   requests.
>=20
> Multiple users have reported use-after-free complaints similar to the
> following (from https://lore.kernel.org/linux-block/1545261885.185366.488=
.camel@acm.org/):
>=20
> BUG: KASAN: use-after-free in bt_iter+0x86/0xf0
> Read of size 8 at addr ffff88803b335240 by task fio/21412
>=20
> CPU: 0 PID: 21412 Comm: fio Tainted: G        W         4.20.0-rc6-dbg+ #=
3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/0=
1/2014
> Call Trace:
>  dump_stack+0x86/0xca
>  print_address_description+0x71/0x239
>  kasan_report.cold.5+0x242/0x301
>  __asan_load8+0x54/0x90
>  bt_iter+0x86/0xf0
>  blk_mq_queue_tag_busy_iter+0x373/0x5e0
>  blk_mq_in_flight+0x96/0xb0
>  part_in_flight+0x40/0x140
>  part_round_stats+0x18e/0x370
>  blk_account_io_start+0x3d7/0x670
>  blk_mq_bio_to_request+0x19c/0x3a0
>  blk_mq_make_request+0x7a9/0xcb0
>  generic_make_request+0x41d/0x960
>  submit_bio+0x9b/0x250
>  do_blockdev_direct_IO+0x435c/0x4c70
>  __blockdev_direct_IO+0x79/0x88
>  ext4_direct_IO+0x46c/0xc00
>  generic_file_direct_write+0x119/0x210
>  __generic_file_write_iter+0x11c/0x280
>  ext4_file_write_iter+0x1b8/0x6f0
>  aio_write+0x204/0x310
>  io_submit_one+0x9d3/0xe80
>  __x64_sys_io_submit+0x115/0x340
>  do_syscall_64+0x71/0x210
>=20
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Khazhy Kumykov <khazhy@google.com>
> Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-core.c   | 34 +++++++++++++++++++++++++++++++++-
>  block/blk-mq-tag.c | 43 +++++++++++++++++++++++++++++++++++++++----
>  block/blk-mq-tag.h |  4 +++-
>  block/blk-mq.c     | 21 +++++++++++++++++----
>  block/blk-mq.h     |  1 +
>  block/blk.h        |  2 ++
>  block/elevator.c   |  1 +
>  7 files changed, 96 insertions(+), 10 deletions(-)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fc60ff208497..fabb45ecd216 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -279,6 +279,36 @@ void blk_dump_rq_flags(struct request *rq, char *msg=
)
>  }
>  EXPORT_SYMBOL(blk_dump_rq_flags);
> =20
> +/**
> + * blk_mq_wait_for_tag_readers - wait for preexisting tag readers to fin=
ish
> + * @set: Tag set to wait on.
> + *
> + * Waits for preexisting __blk_mq_all_tag_iter() calls to finish accessi=
ng
> + * hctx->tags->rqs[]. New readers may start while this function is in pr=
ogress
> + * or after this function has returned. Use this function to make sure t=
hat
> + * hctx->tags->rqs[] changes have become globally visible.
> + *
> + * Accesses of hctx->tags->rqs[] by blk_mq_queue_tag_busy_iter() calls a=
re out
> + * of scope for this function. The caller can pause blk_mq_queue_tag_bus=
y_iter()
> + * calls for a request queue by freezing that request queue.
> + */
> +void blk_mq_wait_for_tag_readers(struct blk_mq_tag_set *set)
> +{
> +	struct blk_mq_tags *tags;
> +	int i;
> +
> +	if (set->tags) {
> +		for (i =3D 0; i < set->nr_hw_queues; i++) {
> +			tags =3D set->tags[i];
> +			if (!tags)
> +				continue;
> +			down_write(&tags->iter_rwsem);
> +			up_write(&tags->iter_rwsem);
> +		}
> +	}
> +	synchronize_rcu();
> +}
> +
>  /**
>   * blk_sync_queue - cancel any pending callbacks on a queue
>   * @q: the queue
> @@ -412,8 +442,10 @@ void blk_cleanup_queue(struct request_queue *q)
>  	 * it is safe to free requests now.
>  	 */
>  	mutex_lock(&q->sysfs_lock);
> -	if (q->elevator)
> +	if (q->elevator) {
> +		blk_mq_wait_for_tag_readers(q->tag_set);
>  		blk_mq_sched_free_requests(q);
> +	}
>  	mutex_unlock(&q->sysfs_lock);
> =20
>  	percpu_ref_exit(&q->q_usage_counter);
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 975626f755c2..c8722ce7c35c 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -209,7 +209,12 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned=
 int bitnr, void *data)
> =20
>  	if (!reserved)
>  		bitnr +=3D tags->nr_reserved_tags;
> -	rq =3D tags->rqs[bitnr];
> +	/*
> +	 * See also the percpu_ref_tryget() and blk_queue_exit() calls in
> +	 * blk_mq_queue_tag_busy_iter().
> +	 */
> +	rq =3D rcu_dereference_check(tags->rqs[bitnr],
> +			!percpu_ref_is_zero(&hctx->queue->q_usage_counter));
> =20
>  	/*
>  	 * We can hit rq =3D=3D NULL here, because the tagging functions
> @@ -254,11 +259,17 @@ struct bt_tags_iter_data {
>  	unsigned int flags;
>  };
> =20
> +/* Include reserved tags. */
>  #define BT_TAG_ITER_RESERVED		(1 << 0)
> +/* Only include started requests. */
>  #define BT_TAG_ITER_STARTED		(1 << 1)
> +/* Iterate over tags->static_rqs[] instead of tags->rqs[]. */
>  #define BT_TAG_ITER_STATIC_RQS		(1 << 2)
> +/* The callback function may sleep. */
> +#define BT_TAG_ITER_MAY_SLEEP		(1 << 3)
> =20
> -static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, voi=
d *data)
> +static bool __bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr,
> +			   void *data)
>  {
>  	struct bt_tags_iter_data *iter_data =3D data;
>  	struct blk_mq_tags *tags =3D iter_data->tags;
> @@ -275,7 +286,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsi=
gned int bitnr, void *data)
>  	if (iter_data->flags & BT_TAG_ITER_STATIC_RQS)
>  		rq =3D tags->static_rqs[bitnr];
>  	else
> -		rq =3D tags->rqs[bitnr];
> +		rq =3D rcu_dereference_check(tags->rqs[bitnr], true);
>  	if (!rq)
>  		return true;
>  	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
> @@ -284,6 +295,25 @@ static bool bt_tags_iter(struct sbitmap *bitmap, uns=
igned int bitnr, void *data)
>  	return iter_data->fn(rq, iter_data->data, reserved);
>  }
> =20
> +static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, voi=
d *data)
> +{
> +	struct bt_tags_iter_data *iter_data =3D data;
> +	struct blk_mq_tags *tags =3D iter_data->tags;
> +	bool res;
> +
> +	if (iter_data->flags & BT_TAG_ITER_MAY_SLEEP) {
> +		down_read(&tags->iter_rwsem);
> +		res =3D __bt_tags_iter(bitmap, bitnr, data);
> +		up_read(&tags->iter_rwsem);
> +	} else {
> +		rcu_read_lock();
> +		res =3D __bt_tags_iter(bitmap, bitnr, data);
> +		rcu_read_unlock();
> +	}
> +
> +	return res;
> +}
> +
>  /**
>   * bt_tags_for_each - iterate over the requests in a tag map
>   * @tags:	Tag map to iterate over.
> @@ -357,10 +387,12 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set =
*tagset,
>  {
>  	int i;
> =20
> +	might_sleep();
> +
>  	for (i =3D 0; i < tagset->nr_hw_queues; i++) {
>  		if (tagset->tags && tagset->tags[i])
>  			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
> -					      BT_TAG_ITER_STARTED);
> +				BT_TAG_ITER_STARTED | BT_TAG_ITER_MAY_SLEEP);
>  	}
>  }
>  EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
> @@ -554,6 +586,9 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int tot=
al_tags,
>  		kfree(tags);
>  		return NULL;
>  	}
> +
> +	init_rwsem(&tags->iter_rwsem);
> +
>  	return tags;
>  }
> =20

Hi Bart, thank you for your effort on this problem.

I applied this series on v5.12-rc4 and ran blktests block/005 with a HDD be=
hind
SAS-HBA, and I observed kernel INFO and WARNING [1]. It looks like that
tags->iter_rwsem is not initialized. I found blk_mq_init_tags() has two pat=
hs
to "return tags". I think when blk_mq_init_tags() returns at the first path=
 to
"return tags", tags->iter_rwsem misses the initialization. To confirm it, I
moved the init_rwsem() before the first "return tags", then saw the kernel
messages disappeared (use-after-free disappeared also).

Could you relook the hunk?

[1]

[   80.079549] run blktests block/005 at 2021-03-26 17:21:49
[   80.183881] INFO: trying to register non-static key.
[   80.189545] the code is fine but needs lockdep annotation.
[   80.195725] turning off the locking correctness validator.
[   80.201906] CPU: 3 PID: 1229 Comm: check Not tainted 5.12.0-rc4+ #8
[   80.208863] Hardware name: Supermicro Super Server/X10SRL-F, BIOS 2.0 12=
/17/2015
[   80.216949] Call Trace:
[   80.220091]  dump_stack+0x93/0xc2
[   80.224111]  register_lock_class+0x1b58/0x1b60
[   80.229248]  ? lock_chain_count+0x20/0x20
[   80.233953]  ? __kasan_slab_free+0xe5/0x110
[   80.238833]  ? slab_free_freelist_hook+0x4b/0x140
[   80.244231]  ? kmem_cache_free+0xf4/0x5b0
[   80.248937]  ? is_dynamic_key+0x1b0/0x1b0
[   80.253643]  ? mark_lock+0xe4/0x2fd0
[   80.257918]  ? queue_attr_store+0x8b/0xd0
[   80.262625]  ? kernfs_fop_write_iter+0x2cb/0x460
[   80.267937]  ? new_sync_write+0x355/0x5e0
[   80.272642]  ? vfs_write+0x5b2/0x860
[   80.276917]  ? ksys_write+0xe9/0x1b0
[   80.281190]  __lock_acquire+0xe3/0x58b0
[   80.285725]  ? __lock_acquire+0xbb0/0x58b0
[   80.290514]  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
[   80.296348]  lock_acquire+0x181/0x6a0
[   80.300707]  ? blk_mq_wait_for_tag_readers+0xdd/0x150
[   80.306453]  ? lock_release+0x680/0x680
[   80.310983]  ? find_held_lock+0x2c/0x110
[   80.315604]  ? lock_is_held_type+0x98/0x110
[   80.320484]  down_write+0x84/0x130
[   80.324586]  ? blk_mq_wait_for_tag_readers+0xdd/0x150
[   80.330330]  ? down_write_killable_nested+0x150/0x150
[   80.336076]  blk_mq_wait_for_tag_readers+0xdd/0x150
[   80.341650]  elevator_exit+0x75/0xe0
[   80.345924]  elevator_switch_mq+0xda/0x4d0
[   80.350717]  elevator_switch+0x5d/0xa0
[   80.355161]  elv_iosched_store+0x31b/0x3c0
[   80.359956]  ? elevator_init_mq+0x350/0x350
[   80.364834]  ? lock_is_held_type+0x98/0x110
[   80.369714]  queue_attr_store+0x8b/0xd0
[   80.374248]  ? sysfs_file_ops+0x170/0x170
[   80.378951]  kernfs_fop_write_iter+0x2cb/0x460
[   80.384094]  new_sync_write+0x355/0x5e0
[   80.388627]  ? new_sync_read+0x5d0/0x5d0
[   80.393243]  ? ksys_write+0xe9/0x1b0
[   80.397517]  ? lock_release+0x680/0x680
[   80.402047]  ? __cond_resched+0x15/0x30
[   80.406580]  ? inode_security+0x56/0xf0
[   80.411115]  ? lock_is_held_type+0x98/0x110
[   80.415999]  vfs_write+0x5b2/0x860
[   80.420096]  ksys_write+0xe9/0x1b0
[   80.424193]  ? __ia32_sys_read+0xb0/0xb0
[   80.428811]  ? syscall_enter_from_user_mode+0x27/0x70
[   80.434556]  ? trace_hardirqs_on+0x1c/0x110
[   80.439438]  do_syscall_64+0x33/0x40
[   80.443709]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   80.449458] RIP: 0033:0x7fad1b2794e7
[   80.453733] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f =
00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[   80.473169] RSP: 002b:00007ffd987bdc38 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[   80.481429] RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007fad1b2=
794e7
[   80.489253] RDX: 000000000000000c RSI: 000055a049b83d30 RDI: 00000000000=
00001
[   80.497071] RBP: 000055a049b83d30 R08: 000000000000000a R09: 00007fad1b3=
100c0
[   80.504890] R10: 00007fad1b30ffc0 R11: 0000000000000246 R12: 00000000000=
0000c
[   80.512715] R13: 00007fad1b34c520 R14: 000000000000000c R15: 00007fad1b3=
4c720
[   80.520576] ------------[ cut here ]------------
[   80.525896] DEBUG_RWSEMS_WARN_ON(sem->magic !=3D sem): count =3D 0x1, ma=
gic =3D 0x0, owner =3D 0xffff8881251cb240, curr 0xffff8881251cb240, list no=
t empty
[   80.539706] WARNING: CPU: 3 PID: 1229 at kernel/locking/rwsem.c:1311 up_=
write+0x365/0x530
[   80.548579] Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ip=
t_REJECT nf_nat_tftp nf_conntrack_tftp tun bridge stp llc nft_objref nf_con=
ntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_=
ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_c=
t nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_=
mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_de=
frag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_set=
 nfnetlink rfkill target_core_user ebtable_filter ebtables target_core_mod =
ip6table_filter ip6_tables iptable_filter sunrpc intel_rapl_msr intel_rapl_=
common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypa=
ss rapl intel_cstate iTCO_wdt intel_uncore intel_pmc_bxt pcspkr iTCO_vendor=
_support joydev i2c_i801 i2c_smbus lpc_ich ses enclosure mei_me ipmi_ssif m=
ei ioatdma wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_me=
ter acpi_pad
[   80.548690]  zram ip_tables ast drm_vram_helper drm_kms_helper syscopyar=
ea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm crct10dif_pclmu=
l crc32_pclmul crc32c_intel drm ghash_clmulni_intel igb mpt3sas dca i2c_alg=
o_bit xhci_pci raid_class xhci_pci_renesas scsi_transport_sas fuse
[   80.661295] CPU: 3 PID: 1229 Comm: check Not tainted 5.12.0-rc4+ #8
[   80.668258] Hardware name: Supermicro Super Server/X10SRL-F, BIOS 2.0 12=
/17/2015
[   80.676345] RIP: 0010:up_write+0x365/0x530
[   80.681155] Code: 02 00 0f 85 73 01 00 00 ff 34 24 48 8b 55 00 4d 89 f0 =
48 c7 c6 c0 45 69 a0 4c 8b 4c 24 10 48 c7 c7 00 46 69 a0 e8 65 e2 e2 01 <0f=
> 0b 59 e9 c3 fe ff ff 4c 8d 75 58 c6 05 cd ef 67 03 01 48 b8 00
[   80.700595] RSP: 0018:ffff888125affb08 EFLAGS: 00010286
[   80.706513] RAX: 0000000000000000 RBX: 1ffff11024b5ff65 RCX: 00000000000=
00000
[   80.714339] RDX: 0000000000000004 RSI: 0000000000000008 RDI: ffffed1024b=
5ff57
[   80.722169] RBP: ffff888144da20c0 R08: 0000000000000001 R09: ffff8888114=
ee4a7
[   80.730000] R10: ffffed110229dc94 R11: 0000000000000001 R12: ffff888144d=
a20c8
[   80.737826] R13: ffff888144da2128 R14: ffff8881251cb240 R15: ffffffffa19=
a5668
[   80.745653] FS:  00007fad1b184740(0000) GS:ffff8888114c0000(0000) knlGS:=
0000000000000000
[   80.754432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   80.760872] CR2: 00007fad1b34c5b0 CR3: 000000015e552003 CR4: 00000000001=
706e0
[   80.768700] Call Trace:
[   80.771849]  ? downgrade_write+0x370/0x370
[   80.776645]  ? down_write_killable_nested+0x150/0x150
[   80.782393]  blk_mq_wait_for_tag_readers+0xe5/0x150
[   80.787977]  elevator_exit+0x75/0xe0
[   80.792255]  elevator_switch_mq+0xda/0x4d0
[   80.797051]  elevator_switch+0x5d/0xa0
[   80.801503]  elv_iosched_store+0x31b/0x3c0
[   80.806295]  ? elevator_init_mq+0x350/0x350
[   80.811177]  ? lock_is_held_type+0x98/0x110
[   80.816064]  queue_attr_store+0x8b/0xd0
[   80.820605]  ? sysfs_file_ops+0x170/0x170
[   80.825310]  kernfs_fop_write_iter+0x2cb/0x460
[   80.830452]  new_sync_write+0x355/0x5e0
[   80.834994]  ? new_sync_read+0x5d0/0x5d0
[   80.839621]  ? ksys_write+0xe9/0x1b0
[   80.843893]  ? lock_release+0x680/0x680
[   80.848427]  ? __cond_resched+0x15/0x30
[   80.852967]  ? inode_security+0x56/0xf0
[   80.857510]  ? lock_is_held_type+0x98/0x110
[   80.862398]  vfs_write+0x5b2/0x860
[   80.866497]  ksys_write+0xe9/0x1b0
[   80.870596]  ? __ia32_sys_read+0xb0/0xb0
[   80.875214]  ? syscall_enter_from_user_mode+0x27/0x70
[   80.880962]  ? trace_hardirqs_on+0x1c/0x110
[   80.885850]  do_syscall_64+0x33/0x40
[   80.890132]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   80.895886] RIP: 0033:0x7fad1b2794e7
[   80.900160] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f =
00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[   80.919598] RSP: 002b:00007ffd987bdc38 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[   80.927856] RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007fad1b2=
794e7
[   80.935684] RDX: 000000000000000c RSI: 000055a049b83d30 RDI: 00000000000=
00001
[   80.943512] RBP: 000055a049b83d30 R08: 000000000000000a R09: 00007fad1b3=
100c0
[   80.951335] R10: 00007fad1b30ffc0 R11: 0000000000000246 R12: 00000000000=
0000c
[   80.959163] R13: 00007fad1b34c520 R14: 000000000000000c R15: 00007fad1b3=
4c720
[   80.966993] irq event stamp: 34619
[   80.971096] hardirqs last  enabled at (34619): [<ffffffffa01e3044>] _raw=
_spin_unlock_irq+0x24/0x30
[   80.980753] hardirqs last disabled at (34618): [<ffffffffa01e2e33>] _raw=
_spin_lock_irq+0x43/0x50
[   80.990233] softirqs last  enabled at (34494): [<ffffffff9e1af289>] __ir=
q_exit_rcu+0x1b9/0x270
[   80.999542] softirqs last disabled at (34487): [<ffffffff9e1af289>] __ir=
q_exit_rcu+0x1b9/0x270
[   81.008841] ---[ end trace c154275a45048f81 ]---

--=20
Best Regards,
Shin'ichiro Kawasaki=
