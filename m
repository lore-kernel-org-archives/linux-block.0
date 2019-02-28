Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAC3C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 15:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2C8206B8
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 15:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbfB1PVJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:21:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:13302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730215AbfB1PVI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 10:21:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAC8E362ADF;
        Thu, 28 Feb 2019 15:21:08 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9279F57980;
        Thu, 28 Feb 2019 15:21:03 +0000 (UTC)
Date:   Thu, 28 Feb 2019 23:20:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: advance by bvec's length for bio_for_each_bvec
Message-ID: <20190228151918.GA4535@ming.t460p>
References: <20190228032421.23161-1-ming.lei@redhat.com>
 <20190228135832.GA3182@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228135832.GA3182@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 28 Feb 2019 15:21:08 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 28, 2019 at 05:58:32AM -0800, Christoph Hellwig wrote:
> On Thu, Feb 28, 2019 at 11:24:21AM +0800, Ming Lei wrote:
> > bio_for_each_bvec is used in fast path of bio splitting and sg mapping,
> > and what we want to do is to iterate over multi-page bvecs, instead of pages.
> > However, bvec_iter_advance() is invisble for this requirement, and
> > always advance by page size.
> > 
> > This way isn't efficient for multipage bvec iterator, also bvec_iter_len()
> > isn't as fast as mp_bvec_iter_len().
> > 
> > So advance by multi-page bvec's length instead of page size for bio_for_each_bvec().
> > 
> > More than 1% IOPS improvement can be observed in io_uring test on null_blk.
> 
> We've been there before, and I still insist that there is not good
> reason ever to clamp the iteration to page size in bvec_iter_advance.
> Callers that iterate over it already do that in the callers.
> 
> So here is a resurretion and rebase of my patch from back then to
> just do the right thing:
> 
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index 2c32e3e151a0..cf06c0647c4f 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -112,14 +112,15 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
>  	}
>  
>  	while (bytes) {
> -		unsigned iter_len = bvec_iter_len(bv, *iter);
> -		unsigned len = min(bytes, iter_len);
> +		const struct bio_vec *cur = bv + iter->bi_idx;
> +		unsigned len = min3(bytes, iter->bi_size,
> +				    cur->bv_len - iter->bi_bvec_done);
>  
>  		bytes -= len;
>  		iter->bi_size -= len;
>  		iter->bi_bvec_done += len;
>  
> -		if (iter->bi_bvec_done == __bvec_iter_bvec(bv, *iter)->bv_len) {
> +		if (iter->bi_bvec_done == cur->bv_len) {
>  			iter->bi_bvec_done = 0;
>  			iter->bi_idx++;
>  		}

Yeah, this change is the correct thing to do, and there shouldn't be
performance drop with this patch for Jens' test case, I guess.

Thanks,
Ming
