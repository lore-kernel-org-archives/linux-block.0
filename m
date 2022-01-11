Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E464C433EF
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 08:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbiAKImh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 03:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236634AbiAKImg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 03:42:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E944C06173F
        for <linux-block@vger.kernel.org>; Tue, 11 Jan 2022 00:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7qZX6hvm5ziW8GRsk+ZliUdB9JwLkkmHCllout0d3Ak=; b=FAxjww3SPK55sDiOjnRyaqVF+n
        Fhm4zhoHYULk4eJGQgMSS0dqlx+FBIdgu9KjA6KVeq3vlMFoogaMn9kJZS+lZrPG+BSbNpl45IuA7
        nYxR0MgK26Lw6btwPNQBykkIwJ0eH3gRXYxlxUrqQbTICTYhBbAiHoua5luSFm1r+oN+GRxtQn5Tb
        ECeCH3gKIL7yhwhzd7it66/xKSqRiZGLVTGoplIvpd4jdiWH+IBuGxcI27bsrRXGV9WN+vCDeiL3r
        2trSXkj+PAHwSHlsUQZ1I2vd4JsC+RuAhsmGQ4e0mBz9hfoktVmpEAjdbXP2I0gMkRqcu3Eb1Sbyn
        7EpEqIGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7CjZ-00FO7F-Gg; Tue, 11 Jan 2022 08:42:25 +0000
Date:   Tue, 11 Jan 2022 00:42:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, lining <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>
Subject: Re: [dm-devel] [PATCH 1/2] block: add resubmit_bio_noacct()
Message-ID: <Yd1C8Y6H7ZDhWY2k@infradead.org>
References: <20220110075141.389532-1-ming.lei@redhat.com>
 <20220110075141.389532-2-ming.lei@redhat.com>
 <YdxuWlZAPJkPyr3h@infradead.org>
 <Ydzj1JSoRGz+9g8B@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydzj1JSoRGz+9g8B@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 11, 2022 at 09:56:36AM +0800, Ming Lei wrote:
> 2) block throttle is block layer internal stuff, and we shouldn't expose
> blk_throtl_charge_bio_split() to driver.
> 
> Maybe rename the new API as submit_split_bio_noacct(), but we can't
> reuse submit_bio_noacct() simply, otherwise blk_throtl_charge_bio_split()
> needs to be exported.

submit_bio_noacct should only ever be used for resubmitting bios that
came up from the upper layer, although they might not always be "split".
blk_throtl_charge_bio_split

> Another ides is to clearing BIO_THROTTLED before calling submit_bio_noacct(),
> meantime blk-throttle code needs to change to avoid double accounting of bio
> bytes, so the caller of submit_bio_noacct() still needs some change.
> This way can get smooth IOPS throttle, but needs to call __blk_throtl_bio
> for split bio one more time.
> 
> Or other idea for this bio split vs. iops limit issue?

Well, if you want a helper specificly for splits, add one that actally
specifically handles splits and makes the callers life easier, something
like:

void bio_submit_splice(struct bio *split, struct bio *orig)
{
	split->bi_opf |= REQ_NOMERGE;
	trace_block_split(split, orig->bi_iter.bi_sector);
	submit_bio_noacct(orig);
	blk_throtl_charge_bio_split(orig);
}

including a proper kerneldoc comment.

But I still fail to grasp how a split is so different from just
resubmitting a not split bio.
