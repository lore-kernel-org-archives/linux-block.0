Return-Path: <SRS0=2XXV=ZD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC36C43331
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 10:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB97620674
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 10:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfKKKWH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Nov 2019 05:22:07 -0500
Received: from verein.lst.de ([213.95.11.211]:48568 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfKKKWH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 05:22:07 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 17E2E68BE1; Mon, 11 Nov 2019 11:22:00 +0100 (CET)
Date:   Mon, 11 Nov 2019 11:21:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 2/2] block: split bio if the only bvec's length is
 > SZ_4K
Message-ID: <20191111102159.GA12709@lst.de>
References: <20191108101528.31735-1-ming.lei@redhat.com> <20191108101528.31735-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108101528.31735-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 08, 2019 at 06:15:28PM +0800, Ming Lei wrote:
> 64K PAGE_SIZE is popular on ARM64 or other ARCHs, and 64K has been big
> enough to break some devices probably, so change the logic to split bio
> if the only bvec's length is > SZ_4K instead of PAGE_SIZE.

I don't think this makes sense as-is given that blk_queue_max_hw_sectors,
blk_queue_max_segment_size and co all check for a minimum of PAGE_SIZE
and warn otherwise, and blk_bio_segment_split uses PAGE_SIZE for
its short cut as well. So I don't think this has been a problem in
practice, and if it was this patch is not enough.

So either we leave things as is, or we need to do a real audit for
code using PAGE_SIZE as the minimum I/O granularity and replace it
everywhere a well as updating the documentation.  Which might be a good
thing given that variable sized limits are weird.
