Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84066C56201
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 11:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB53F2075A
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 11:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BVHiKpKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbgKXLVE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732536AbgKXLVE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 06:21:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CDFC0613D6
        for <linux-block@vger.kernel.org>; Tue, 24 Nov 2020 03:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i6gcvypKnI2Hq8+uEd1XDukgAydy+lSlzI9eyWM/qbI=; b=BVHiKpKbrOnn6r6rJnGjdSH48Z
        ABbKcObPbf3RAtYfxbcXDoImhwj3PSqcZe4M1jL/kKN9ykJnq2ZABuleeQAE8wc4e0K/5VS3Mdotz
        V/aTckgonzXl5XiCbY2fntkSd6bFDEW5ga6oKHPtoUJpSJGRDhAI170QdE12zKIQyfrzbBBl3sloR
        dfROfxHm8zfAFENuKuUzD1pQzq7D93aT7U4GV5Ac/C0Q9EWl5fsJjqUvyFtx8yUdVDVkzW78qMJqX
        WcyuExZRed0oPiQ64mATA+nVdKmrK/pjuw/pQpfh6nAu9OZjGTZ+wcChSsFWyc4zsXLr/XNxHbCxJ
        69s/9JLw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khWNY-0006r1-Ik; Tue, 24 Nov 2020 11:21:00 +0000
Date:   Tue, 24 Nov 2020 11:21:00 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com, ming.lei@redhat.com, hch@infradead.org
Subject: Re: [PATCH v5] block: disable iopoll for split bio
Message-ID: <20201124112100.GA25573@infradead.org>
References: <20201123080020.64667-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123080020.64667-1-jefflexu@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This looks generally food:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Some cosmetic nitpicks below:

> +	/*
> +	 * Bio splitting may cause subtle trouble such as hang
> +	 * when doing sync iopoll in direct IO routine. Given
> +	 * performance gain of iopoll for big IO can be trival,
> +	 * disable iopoll when split needed.
> +	 */

You can use up all 80 characters for comments, and doing so generally
helps readability.

> -	return cookie;
> +	return bio_flagged(bio, BIO_NONE_COOKIE) ? BLK_QC_T_NONE : cookie;

I'd write this a little more easily flowing as:

	if (bio_flagged(bio, BIO_NONE_COOKIE))
		return BLK_QC_T_NONE;
	return cookie;

>  queue_exit:
>  	blk_queue_exit(q);
>  	return BLK_QC_T_NONE;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index d9b69bbde5cc..938fd25d2c68 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -284,6 +284,7 @@ enum {
>  				 * of this bio. */
>  	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
>  	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
> +	BIO_NONE_COOKIE,	/* disable iopoll for split bio */

I'd rename this to BIO_SPLIT and update the comment.  The rationale
is BIO_SPLIT is what happened to the bio.  The fact that
blk_mq_submit_bio doesn't return the cookie is just one good use of
such information.
