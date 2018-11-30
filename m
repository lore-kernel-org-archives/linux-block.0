Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DD2C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 09:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA6D2146F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 09:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NuXkr1HN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA6D2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeK3VBG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:01:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51698 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeK3VBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 16:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6q7jY9M3Xxr98uF8PXjB8K4B1EQ3wKAhciyGEAcP45I=; b=NuXkr1HNdwTZYBGmox5iKZ5Ou
        O5Ma6ijWm7rEaCXJ540DexIl8KDjQrS81yjU2lgr3+eCcSD7oXwnai/iof3ozxYA0Qlusj9xNIrAO
        /cczBNoLVDYv9rK8tezQccZMlXLmqDUlmtl+sQNDZS0nuoEG9Cqflp8j4sI6Q/Q2CeN8a1qLGOKsc
        g9YjzP3YR31b7lwsW72NYVBMA4HVLnH4ykDqplDTq2jLuVVh4cYVEaRvqwQZbsw9TIlaerbpJyTDf
        T3Y+7R12Hsl2HguZgh34JSzdSUSAcvFgZ1fuqH1USz4vFO+jzxdqN1pvenYV/4qlWjpgIXz8eNQKT
        ICTvFN78w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSfT0-0006Bv-1E; Fri, 30 Nov 2018 09:52:10 +0000
Date:   Fri, 30 Nov 2018 01:52:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] blkcg: introduce common blkg association logic
Message-ID: <20181130095209.GA17103@infradead.org>
References: <20181126211946.77067-1-dennis@kernel.org>
 <20181126211946.77067-5-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126211946.77067-5-dennis@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  EXPORT_SYMBOL_GPL(bio_associate_blkcg);
>  
>  /**
> - * bio_associate_blkg - associate a bio with the a blkg
> + * bio_has_queue - required check for blkg association
> + * @bio: target bio
> + *
> + * A blkg represents the relationship between a blkcg and a request_queue.
> + * If there is no request_queue, there is no blkg and therefore nothing to
> + * associate with.
> + */
> +static inline bool bio_has_queue(struct bio *bio)
> +{
> +	return bio->bi_disk && bio->bi_disk->queue;
> +}

How do you ever see a bio without a queue?  We can't even do I/O in
that case.
