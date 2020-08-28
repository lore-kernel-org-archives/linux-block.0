Return-Path: <SRS0=Mrne=CG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB29C433E6
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 00:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5F3208C9
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 00:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgH1AHL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 20:07:11 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:36441 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgH1AHL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 20:07:11 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 8F40F824181;
        Fri, 28 Aug 2020 10:07:06 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kBRv7-0007aY-7s; Fri, 28 Aug 2020 10:07:05 +1000
Date:   Fri, 28 Aug 2020 10:07:05 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, yebin <yebin10@huawei.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC 2/2] block: Do not discard buffers under a mounted
 filesystem
Message-ID: <20200828000705.GC12096@dread.disaster.area>
References: <20200825120554.13070-1-jack@suse.cz>
 <20200825120554.13070-3-jack@suse.cz>
 <20200825121616.GA10294@infradead.org>
 <20200825145056.GC32298@quack2.suse.cz>
 <20200827071603.GA25305@infradead.org>
 <20200827213900.GG1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827213900.GG1236603@ZenIV.linux.org.uk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=XJ9OtjpE c=1 sm=1 tr=0 cx=a_idp_d
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=7-415B0cAAAA:8
        a=Zuxhg74iZb8wFQBIpPYA:9 a=9wW33gk-GpalGAZl:21 a=1o6rFZfVsUrZ5jbQ:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 27, 2020 at 10:39:00PM +0100, Al Viro wrote:
> On Thu, Aug 27, 2020 at 08:16:03AM +0100, Christoph Hellwig wrote:
> > On Tue, Aug 25, 2020 at 04:50:56PM +0200, Jan Kara wrote:
> > > Do you mean that address_space filesystem uses to access its metadata on
> > > /dev/sda will be different from the address_space you will see when reading
> > > say /dev/sda?  Thus these will be completely separate (and incoherent)
> > > caches?
> > 
> > Yes.
> > 
> > > Although this would be simple it will break userspace I'm afraid.
> > > There are situations where tools read e.g. superblock of a mounted
> > > filesystem from the block device and rely on the data to be reasonably
> > > recent. Even worse e.g. tune2fs or e2fsck can *modify* superblock of a
> > > mounted filesystem through the block device (e.g. to set 'fsck after X
> > > mounts' fields and similar).
> > 
> > We've not had any problems when XFS stopped using the block device
> > address space 9.5 years ago.
> 
> How much writes from fsck use does xfs see, again?

All of them, because xfs_repair uses direct IO and caches what it
needs in userspace.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
