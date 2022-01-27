Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAD1C433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 20:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbiA0UBd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 15:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbiA0UBc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 15:01:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E31EC061714
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 12:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YfYqh5AXegFPSYmmpGCNINSsy5Jd2eg32j3jvkQd3As=; b=csFk+qUpLHubPzNbGwN1Gol4Rx
        e2B3p5i0RvKmyUIyrLJyNypMGMNDO1iq1L2NG8SZXHsfdAER60M62//P+cOoxyy7e1EODx+/oa8XC
        caVxdHKeU2kVXf76dSqi7bfNjJ+QsaSyJcw7QD7wVvm1dpCU3HwlwJ525G2IO0koNw9PYxSZam+6y
        TJleGZFS7H8NrQWL3V1vOK8ChwZ5o5W/UdVp6pUNiig4HEi/mjZVKv7Rj0pOvARc3xe3hLbHRp1nQ
        xcbqPBk/A9O6WrfYmBvToei1UlI8OXb5Z3r2HxJzvZbLR17DHDAzBLUGXpXgzrMw8sjjH0dqjulyl
        0I6rY0EA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDAxW-00H0Y1-CQ; Thu, 27 Jan 2022 20:01:30 +0000
Date:   Thu, 27 Jan 2022 12:01:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH 1/3] block: add __bio_start_io_acct() to
 control start_time
Message-ID: <YfL6GgqQPqj7jxbF@infradead.org>
References: <20220127190742.12776-1-snitzer@redhat.com>
 <20220127190742.12776-2-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127190742.12776-2-snitzer@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -static unsigned long __part_start_io_acct(struct block_device *part,
> -					  unsigned int sectors, unsigned int op)
> +static void __part_start_io_acct(struct block_device *part, unsigned int sectors,
> +				 unsigned int op, unsigned long start_time)

Please avoid the overly long line.

> +/**
> + * __bio_start_io_acct - start I/O accounting for bio based drivers
> + * @bio:	bio to start account for
> + * @start_time:	start time that should be passed back to bio_end_io_acct().
> + */
> +void __bio_start_io_acct(struct bio *bio, unsigned long start_time)

I'd name this something like bio_start_io_acct_time to be a little more
descriptive

> +	unsigned long now = READ_ONCE(jiffies);
> +	__bio_start_io_acct(bio, now);
> +	return now;

Plase add an empty line after the variable declaration.

>  }
>  EXPORT_SYMBOL_GPL(bio_start_io_acct);
>  
>  unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
>  				 unsigned int op)
>  {
> -	return __part_start_io_acct(disk->part0, sectors, op);
> +	unsigned long now = READ_ONCE(jiffies);
> +	__part_start_io_acct(disk->part0, sectors, op, now);
> +	return now;

I wonder if just returning the passed in time from __part_start_io_acct
wouldn't be a bit cleaner to avoid all the extra local variables.
