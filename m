Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF4CC5B57D
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 00:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63BC218EA
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 00:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ6E73LE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfGCAu1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:50:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43283 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfGCAu0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 20:50:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so237179pgv.10
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2019 17:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZWwYr6O3tiOc5lWF56ulDA9pRcqusbdisVXTs1Pb+fs=;
        b=AJ6E73LEeTQ60TV7MqG9ZbNeGcL4+ODQxlqYw4uUto0c+0517Yn2sQISVpvOuAKjKG
         k4rZc8JHnRB6kovJ4Q00fQ3s4gNGPyINsFLXbxaLkjLmfTZsXp+5kchVnq8MWEhOdpSe
         Q48nybcCkEM2t81fSakAiP4KZY0HlEqX3hLzpUo0SwCW9pGlMzFTDXAsDVQXvzzZ1DHU
         bh1ND71xLdwlKq9TnJbELh+V7jMv58EWvh1+gL11mwFcPlzsG+imoOt4aXSJRMuxRaOm
         svfP2tTuQa4btswl0Iccc/BeFY0zhBnHIwKvyQ7iG6ct4k+Tfm13IEfDd9ySAuFQY3hz
         ZFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZWwYr6O3tiOc5lWF56ulDA9pRcqusbdisVXTs1Pb+fs=;
        b=cIRtt1u5HWFbFRbeaHTcLmU22Z6YQhpTrlWKLDHAu6sG4Hp5qwZ8ZQwuuEycTIxMWe
         hZiSlX0br5u/+KPEWieHf/iTTM926edOvwrFdcTIgmg02qGvN3ugqS/TArbT8LFmN/MR
         BhOICtcbjHjhmIG1ncRj2yjZsPXi0scwMwRg/z/R1ETkr4F2lDIxbHbMxVXhTZYm2gGc
         MP5qWYy8UmPXZnUoQnaQy+633NVVdQKHY6kLU8RqrTZYeoGa+SmxewrmUJzUCdZEqzfx
         yvZdI3vPpjW1lqMMpl2+20is9ttudcT1h5nCJExcmGDBkqdwRJedaZntHSV9qXwcUx9i
         0OIQ==
X-Gm-Message-State: APjAAAXVo9Rj70sSgvT4NOyhUhKBul7H4BbVCLqhLLSussMjLMOYfdeO
        VujheDbtgwHjhtG27MnHtzAROKMjdrU=
X-Google-Smtp-Source: APXvYqwibmteSvxZ9mD4EXO7JscIFVbqKdIk9aRiaNZQCILYiLSOPZ2KqB/kEdXsbFRLgbjZFj32tg==
X-Received: by 2002:a17:90a:cf0d:: with SMTP id h13mr8805697pju.63.1562115026302;
        Tue, 02 Jul 2019 17:50:26 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id d6sm279276pgf.55.2019.07.02.17.50.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 17:50:25 -0700 (PDT)
Date:   Wed, 3 Jul 2019 09:50:23 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        bvanassche@acm.org, axboe@kernel.dk,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 3/5] block: allow block_dump to print all REQ_OP_XXX
Message-ID: <20190703005023.GC19081@minwoo-desktop>
References: <20190701215726.27601-1-chaitanya.kulkarni@wdc.com>
 <20190701215726.27601-4-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701215726.27601-4-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> diff --git a/block/blk-core.c b/block/blk-core.c
> index 5143a8e19b63..9855c5d5027d 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1127,17 +1127,15 @@ EXPORT_SYMBOL_GPL(direct_make_request);
>   */
>  blk_qc_t submit_bio(struct bio *bio)
>  {
> +	unsigned int count = bio_sectors(bio);

Chaitanya,

Could it have a single empty line right after this just like you have
for the if-statement below for the block_dump.  It's just a nitpick.

>  	/*
>  	 * If it's a regular read/write or a barrier with data attached,
>  	 * go through the normal accounting stuff before submission.
>  	 */
>  	if (bio_has_data(bio)) {
> -		unsigned int count;
>  
>  		if (unlikely(bio_op(bio) == REQ_OP_WRITE_SAME))
>  			count = queue_logical_block_size(bio->bi_disk->queue) >> 9;
> -		else
> -			count = bio_sectors(bio);
>  
>  		if (op_is_write(bio_op(bio))) {
>  			count_vm_events(PGPGOUT, count);
> @@ -1145,15 +1143,16 @@ blk_qc_t submit_bio(struct bio *bio)
>  			task_io_account_read(bio->bi_iter.bi_size);
>  			count_vm_events(PGPGIN, count);
>  		}
> +	}
>  
> -		if (unlikely(block_dump)) {
> -			char b[BDEVNAME_SIZE];
> -			printk(KERN_DEBUG "%s(%d): %s block %Lu on %s (%u sectors)\n",
> -			current->comm, task_pid_nr(current),
> -				blk_op_str(bio_op(bio)),
> -				(unsigned long long)bio->bi_iter.bi_sector,
> -				bio_devname(bio, b), count);
> -		}
> +	if (unlikely(block_dump)) {
> +		char b[BDEVNAME_SIZE];
> +
> +		printk(KERN_DEBUG "%s(%d): %s block %Lu on %s (%u sectors)\n",
> +		current->comm, task_pid_nr(current),
> +			blk_op_str(bio_op(bio)),
> +			(unsigned long long)bio->bi_iter.bi_sector,
> +			bio_devname(bio, b), count);

It would be great if non-data command is traced, I think.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
