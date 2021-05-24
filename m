Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984E6C04FF3
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 15:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F27361090
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 15:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhEXPCF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 11:02:05 -0400
Received: from verein.lst.de ([213.95.11.211]:54883 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233090AbhEXO62 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 10:58:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9AC5068AFE; Mon, 24 May 2021 16:56:55 +0200 (CEST)
Date:   Mon, 24 May 2021 16:56:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Yury Kamenev <damtev@yandex-team.ru>, mst@redhat.com,
        jasowang@redhat.com, pbonzini@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Lauri Kasanen <cand@gmx.com>
Subject: Re: [PATCH 1/1] virtio: disable partitions scanning for no
 partitions block
Message-ID: <20210524145654.GA2632@lst.de>
References: <20210520133908.98891-1-damtev@yandex-team.ru> <20210520133908.98891-2-damtev@yandex-team.ru> <YKu4Qovv1KMplifY@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKu4Qovv1KMplifY@stefanha-x1.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 24, 2021 at 03:29:22PM +0100, Stefan Hajnoczi wrote:
> GENHD_FL_NO_PART_SCAN is not used much in other drivers. This makes me
> wonder if the same use case is addressed through other means with SCSI,
> NVMe, etc devices. Maybe Christoph or Jens can weigh in on whether
> adding a bit to disable partition scanning for a virtio-blk fits into
> the big picture?
> 
> Is your goal to avoid accidentally detecting partitions because it's
> confusing when that happens?

I'm really confused what the use case is here.  GENHD_FL_NO_PART_SCAN
has four users:

 - the block core setting it for hidden devices, for which the concept
   of paritions doesn't make sense.  Looking back this should have never
   used GENHD_FL_NO_PART_SCAN, and instead the partition scanning code
   should just check GENHD_FL_HIDDEN as well.
 - mmc uses it for boot partitions and rpmb.  I'm not even sure how
   these can be exposed as block devices as they don't require block
   granularity access IIRC, but if the allow block layer access there
   is no reason to ever set these flags.
 - loop is a bit of a mess.  IIRC the story is that originally the
   loop device did not support partitions, then in 2008 support for
   partitions was added by partitioning the minor number space, and
   then in 2011 support for partitions without that parameter was
   added using a new flag in the loop device creation ioctl that uses
   the extended dev_t space added since.  But even that might be
   something we can handled without that flag without breaking the
   userspace ABI
 - m64card sets it for no good reason at all

In other words: in a perfect would GENHD_FL_NO_PART_SCAN would not
exist, and it certainly should not be added to a new driver, never
mind a protocol.
