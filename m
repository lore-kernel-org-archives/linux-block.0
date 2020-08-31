Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0317CC433E6
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 07:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2E320BED
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 07:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgHaHsr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:48:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:35688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgHaHsr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 03:48:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F1C0AD6B;
        Mon, 31 Aug 2020 07:49:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5C1F71E12CF; Mon, 31 Aug 2020 09:48:45 +0200 (CEST)
Date:   Mon, 31 Aug 2020 09:48:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        yebin <yebin10@huawei.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC 2/2] block: Do not discard buffers under a mounted
 filesystem
Message-ID: <20200831074845.GA23389@quack2.suse.cz>
References: <20200825120554.13070-1-jack@suse.cz>
 <20200825120554.13070-3-jack@suse.cz>
 <20200825121616.GA10294@infradead.org>
 <F9505A56-F07B-4308-BE42-F75ED76B4E3C@dilger.ca>
 <20200829064041.GA23205@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829064041.GA23205@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat 29-08-20 07:40:41, Christoph Hellwig wrote:
> On Fri, Aug 28, 2020 at 02:21:29AM -0600, Andreas Dilger wrote:
> > On Aug 25, 2020, at 6:16 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > > 
> > > On Tue, Aug 25, 2020 at 02:05:54PM +0200, Jan Kara wrote:
> > >> Discarding blocks and buffers under a mounted filesystem is hardly
> > >> anything admin wants to do. Usually it will confuse the filesystem and
> > >> sometimes the loss of buffer_head state (including b_private field) can
> > >> even cause crashes like:
> > > 
> > > Doesn't work if the file system uses multiple devices.
> > 
> > It's not _worse_ than the current situation of allowing the complete
> > destruction of the mounted filesystem.  It doesn't fix the problem
> > for XFS with realtime devices, or ext4 with a separate journal device,
> > but it fixes the problem for a majority of users with a single device
> > filesystem.
> > 
> > While BLKFLSBUF causing a crash is annoying, BLKDISCARD/BLKSECDISCARD
> > under a mounted filesystem is definitely dangerous and wrong.

Actually BLKFLSBUF won't cause a crash. That's using invalidate_bdev() -
i.e., page-reclaim style of eviction and that's fine with the filesystems.

> > What about checking for O_EXCL on the device, indicating that it is
> > currently in use by some higher level?
> 
> That actually seems like a much better idea.

OK, I'll rework the patch.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
