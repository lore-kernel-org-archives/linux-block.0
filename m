Return-Path: <SRS0=AIgI=CD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286A3C433DF
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 14:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC22B2075F
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 14:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHYOvA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:51:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:46774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgHYOu7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 10:50:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A251AB7D;
        Tue, 25 Aug 2020 14:51:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1C4E61E1316; Tue, 25 Aug 2020 16:50:56 +0200 (CEST)
Date:   Tue, 25 Aug 2020 16:50:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        yebin <yebin10@huawei.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC 2/2] block: Do not discard buffers under a mounted
 filesystem
Message-ID: <20200825145056.GC32298@quack2.suse.cz>
References: <20200825120554.13070-1-jack@suse.cz>
 <20200825120554.13070-3-jack@suse.cz>
 <20200825121616.GA10294@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825121616.GA10294@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 25-08-20 13:16:16, Christoph Hellwig wrote:
> On Tue, Aug 25, 2020 at 02:05:54PM +0200, Jan Kara wrote:
> > Discarding blocks and buffers under a mounted filesystem is hardly
> > anything admin wants to do. Usually it will confuse the filesystem and
> > sometimes the loss of buffer_head state (including b_private field) can
> > even cause crashes like:
> 
> Doesn't work if the file system uses multiple devices.

Hum, right.

> I think we just really need to split the fs buffer_head address space
> from the block device one.  Everything else is just going to cause a huge
> mess.

Do you mean that address_space filesystem uses to access its metadata on
/dev/sda will be different from the address_space you will see when reading
say /dev/sda?  Thus these will be completely separate (and incoherent)
caches? Although this would be simple it will break userspace I'm afraid.
There are situations where tools read e.g. superblock of a mounted
filesystem from the block device and rely on the data to be reasonably
recent. Even worse e.g. tune2fs or e2fsck can *modify* superblock of a
mounted filesystem through the block device (e.g. to set 'fsck after X
mounts' fields and similar).

So we would need to somehow maintain at least vague coherence between these
caches which would be ugly.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
