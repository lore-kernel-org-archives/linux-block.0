Return-Path: <SRS0=uUnX=Y5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBB2C47E49
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 08:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA11E2084D
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 08:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfKEI7T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Nov 2019 03:59:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:54326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727925AbfKEI7S (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Nov 2019 03:59:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50C7FB1A4;
        Tue,  5 Nov 2019 08:59:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E993B1E4407; Tue,  5 Nov 2019 09:59:16 +0100 (CET)
Date:   Tue, 5 Nov 2019 09:59:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] bdev: Refresh bdev size for disks without
 partitioning
Message-ID: <20191105085916.GH22379@quack2.suse.cz>
References: <20191021083132.5351-1-jack@suse.cz>
 <bdc9f71e-09ea-9a4c-08fd-d5b60263f11d@kernel.dk>
 <20191104080847.GA22379@quack2.suse.cz>
 <20191104234841.GA7593@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104234841.GA7593@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 04-11-19 15:48:41, Christoph Hellwig wrote:
> On Mon, Nov 04, 2019 at 09:08:47AM +0100, Jan Kara wrote:
> > Thanks Jens! I'll look into refactoring the size change / revalidation code
> > so that it's easier to understand what's going on...
> 
> I actualy have a series for this.  I've started rebasing it on top
> of you work and will need to do some testing.  My current WIP is here:
> 
> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/partition-cleanup

Cool. Thanks for that! Skimming over the series it looks good to me. The
only remaining thing I wanted to look into is bdev->bd_invalidated
handling. Because the only thing it actually indicates in practice is that
DISK_EVENT_MEDIA_CHANGE was set in check_disk_change(). All the other call
chains end up clearing bdev->bd_invalidated before it has any effect. And
that just looks very cryptic to me... So my plan was to at least move the
setting of bdev->bd_invalidated to check_disk_change() and rename it to
something saner if I cannot come up with anything better for propagating
the information from check_disk_change() to __blkdev_get().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
