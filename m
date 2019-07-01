Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F108C4646D
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 06:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7263C214AF
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 06:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfGAGgR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 02:36:17 -0400
Received: from verein.lst.de ([213.95.11.211]:58608 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfGAGgR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Jul 2019 02:36:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E4C2C68C4E; Mon,  1 Jul 2019 08:36:13 +0200 (CEST)
Date:   Mon, 1 Jul 2019 08:36:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>,
        kernel test robot <rong.a.chen@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
Subject: Re: [PATCH] block: fix .bi_size overflow
Message-ID: <20190701063613.GA20733@lst.de>
References: <20190701041644.16052-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701041644.16052-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 01, 2019 at 12:16:44PM +0800, Ming Lei wrote:
> 'bio->bi_iter.bi_size' is 'unsigned int', which at most hold 4G - 1
> bytes.
> 
> Before 07173c3ec276 ("block: enable multipage bvecs"), one bio can
> include very limited pages, and usually at most 256, so the fs bio
> size won't be bigger than 1M bytes most of times.
> 
> Since we support multi-page bvec, in theory one fs bio really can
> be added > 1M pages, especially in case of hugepage, or big writeback
> in case of huge dirty pages. Then there is chance in which .bi_size
> is overflowed.
> 
> Fixes this issue by adding bio_will_full() which checks if the added
> segment may overflow .bi_size.

Can you please just add the argument to bio_full?  bio_will_full sounds
rather odd.

Maybe also add a kerneldoc comment to the new bio_full to explain
it.  Otherwise this looks fine to me.
