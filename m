Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:39217 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965165AbcKJTqh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2016 14:46:37 -0500
Date: Thu, 10 Nov 2016 11:46:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-raid@vger.kernel.org, linux-block@vger.kernel.org
Subject: "creative" bio usage in the RAID code
Message-ID: <20161110194636.GA32241@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Shaohua,

one of the major issues with Ming Lei's multipage biovec works
is that we can't easily enabled the MD RAID code for it.  I had
a quick chat on that with Chris and Jens and they suggested talking
to you about it.

It's mostly about the RAID1 and RAID10 code which does a lot of funny
things with the bi_iov_vec and bi_vcnt fields, which we'd prefer that
drivers don't touch.  One example is the r1buf_pool_alloc code,
which I think should simply use bio_clone for the MD_RECOVERY_REQUESTED
case, which would also take care of r1buf_pool_free.  I'm not sure
about all the others cases, as some bits don't fully make sense to me,
e.g. why we're trying to do single page I/O out of a bigger bio.

Maybe you have some better ideas what's going on there?

Another not quite as urgent issue is how the RAID5 code abuses
->bi_phys_segments as and outstanding I/O counter, and I have no
really good answer to that either.
