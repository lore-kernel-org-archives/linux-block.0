Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AF6C56201
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 07:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B11120B80
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 07:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="suODfAFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgKYHsv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 02:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgKYHsv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 02:48:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B887C0613D4
        for <linux-block@vger.kernel.org>; Tue, 24 Nov 2020 23:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V27jXFGxlNUv/4KmUVO00yN387mJK9NJLiZmy8l7klk=; b=suODfAFjlqAAP/vWE1d/bdKPpT
        +yJXHXQqg1T6CzOsKP1sHyqKb31PZYSKim6XLR7EWM4ya2azAej+spSooDdJEb6EJgt0eHUYoYUIw
        7INTmugBfqMuu2MRn3TFPRNryRk/lbP+vVDofr6IWjy6V1GLuHMe4U8YLdCQewPEiaAy5mJSYIyID
        kfsDDn9gIOTtS4hUwcZXar/sy740RmGpsuojS+tqVFNsLt9w7bDxDWQaBy9t8opGYmSZ1nsGjuySZ
        4gScbQWvqmp+WBAYOGg1XvEksovMdEUWE333GvZOCPxPyCoOyTiQRBi219eYh0OeWlklT8QC7qF2v
        Ehs9bVQA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khpXf-0003NB-UT; Wed, 25 Nov 2020 07:48:43 +0000
Date:   Wed, 25 Nov 2020 07:48:43 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com,
        hch@infradead.org
Subject: Re: [PATCH v6] block: disable iopoll for split bio
Message-ID: <20201125074843.GA12180@infradead.org>
References: <20201125064147.25389-1-jefflexu@linux.alibaba.com>
 <20201125071944.GA24725@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125071944.GA24725@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 25, 2020 at 03:19:44PM +0800, Ming Lei wrote:
> Not sure the new bio flag is really required for this case, just wondering
> why not take the following simple way? BTW we are really going to run
> out of bio flag.
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 55bcee5dc032..1139b1efd712 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2157,6 +2157,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>  	unsigned int nr_segs;
>  	blk_qc_t cookie;
>  	blk_status_t ret;
> +	struct bio *orig_bio = bio;
>  
>  	blk_queue_bounce(q, &bio);
>  	__blk_queue_split(&bio, &nr_segs);
> @@ -2265,6 +2266,10 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>  		blk_mq_sched_insert_request(rq, false, true, true);
>  	}
>  
> +	/* don't poll splitted bio */
> +	if (orig_bio != bio)
> +		return BLK_QC_T_NONE;
> +
>  	return cookie;
>  queue_exit:
>  	blk_queue_exit(q);

Yeah, this looks simpler and more obvious, and it also catches the
bounce buffering case (not that polling + bounce buffering should ever
happen).
