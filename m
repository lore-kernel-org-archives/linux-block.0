Return-Path: <SRS0=4wZT=BB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DCBC433E0
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 11:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7BE020771
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 11:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgGVLYC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jul 2020 07:24:02 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:39892 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgGVLYC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jul 2020 07:24:02 -0400
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jul 2020 07:24:00 EDT
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 319D462D8C69;
        Wed, 22 Jul 2020 13:15:44 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Zc9TNu-wkYTl; Wed, 22 Jul 2020 13:15:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9006B62D8C68;
        Wed, 22 Jul 2020 13:15:43 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ze2yEkGTJ1nH; Wed, 22 Jul 2020 13:15:43 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5BAE56071A74;
        Wed, 22 Jul 2020 13:15:43 +0200 (CEST)
Date:   Wed, 22 Jul 2020 13:15:43 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     hch <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, cgroups@vger.kernel.org
Message-ID: <1212963412.160863.1595416543195.JavaMail.zimbra@nod.at>
In-Reply-To: <20200722062552.212200-5-hch@lst.de>
References: <20200722062552.212200-1-hch@lst.de> <20200722062552.212200-5-hch@lst.de>
Subject: Re: [PATCH 04/14] bdi: initialize ->ra_pages in bdi_init
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: initialize ->ra_pages in bdi_init
Thread-Index: SEPLczWq50DYtFrGpPhckNZ8Awj6bw==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

----- Ursprüngliche Mail -----
> Set up a readahead size by default, as very few users have a good
> reason to change it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> block/blk-core.c      | 1 -
> drivers/mtd/mtdcore.c | 1 +
> fs/9p/vfs_super.c     | 4 ++--
> fs/afs/super.c        | 1 -
> fs/btrfs/disk-io.c    | 1 -
> fs/fuse/inode.c       | 1 -
> fs/nfs/super.c        | 9 +--------
> fs/ubifs/super.c      | 1 +

For ubifs and mtd:

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
