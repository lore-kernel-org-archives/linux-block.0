Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755840AbdIGVyU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Sep 2017 17:54:20 -0400
Date: Thu, 7 Sep 2017 14:54:18 -0700
From: Shaohua Li <shli@kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 0/3] block/loop: handle discard/zeroout error
Message-ID: <20170907215418.32b7o4jfkvwx2w4g@kernel.org>
References: <CAOi1vP-vbr+wnQAP24p3RHuHaS_4s1kQ1p=h8CjHKd_EAtc4uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOi1vP-vbr+wnQAP24p3RHuHaS_4s1kQ1p=h8CjHKd_EAtc4uQ@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 07, 2017 at 03:20:01PM +0200, Ilya Dryomov wrote:
> Hi Shaohua,
> 
> You wrote:
> > BTW: blkdev_issue_zeroout retries if we immediately find the device doesn't
> > support zeroout, but it doesn't retry if submit_bio_wait returns -EOPNOTSUPP.
> > Is this correct behavior?
> 
> I sent a patch for that yesterday, see "[PATCH] block: cope with WRITE
> SAME failing in blkdev_issue_zeroout()" on linux-block.  It checks for
> -EREMOTEIO, because that's what I hit, but I wonder if it should check
> for -EOPNOTSUPP from submit_bio_wait() as well.  Can you think of
> a case where, given bdev_write_zeroes_sectors() != 0, submit_bio_wait()
> would fail with -EOPNOTSUPP and we would want to do explicit zeroing?

loop block device returns -EOPNOTSUPP before for zeroout. With the second
patch, it doesn't any more though.
