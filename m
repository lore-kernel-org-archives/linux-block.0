Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB925C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F2B208E4
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="MqAb6Yts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F2B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeK1KqL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:46:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36471 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeK1KqL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 05:46:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so9197559pfc.3
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 15:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HBdA9hsa7lNPz7OwY84Q8lIxi9mNHm3lVWFTX6HQ9qQ=;
        b=MqAb6YtsekGyt1JPhOL5qjN/YZz2OIMzciUxZx+W1iLRnd4nEvrTx0NTBIUu/6w/Tg
         BIW1q4mXTj/5mU7cDklg7r3FVEL3G5edtnn6+7J52n8VUeFVg9uT2+Xt509xYPRLAmN1
         ysSkojJQEKIN8apfztsHQ5EPOFqoyn6PimmbC0HcToJT2t8uwQbqLwU+vA2CLK2btLVk
         om9nxtIrZukxBON489b9nnLfOv5dP8XXC/MPjwzSSlPASF/Yyp8pRoMbBV2SbcNuk0an
         ijWN+isHZu/egFZyaBA83CfrLIjjnoLoQg7DJJOCftaEQNd8243LtXtkbaUVQD5M8MIV
         EcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HBdA9hsa7lNPz7OwY84Q8lIxi9mNHm3lVWFTX6HQ9qQ=;
        b=YGRHs6xXgYPCQutVygY/GHGMsOK+kYsHSuRIxexd1aTl92nxOip8YSqscTwarBGeBM
         ZYRwJdtRMYvofwEkxMbLNQSIyWOR+Ky3Y5l9gbFXYmXfCBaiO0S50mvCZgBtNhxaBVtw
         /KVDXQfI6BHllYGKzHiwv8E14QU0ZUBFhjfUjDVki+d4DC0ecRj0oCCQikopEBRefI3o
         clVFGhwtz65IYc+HlT/BqIhzZLq7LPZHaJlBOB5jMHZhVSpltsxLq1uuua4louHzN6ea
         ImA5ydXfCs3cVoKFcc56CZiQQU8C9jYWk67zbZGVWcWxSnoC27gSWF8j4Q2fjmQ1HexH
         ZtLQ==
X-Gm-Message-State: AA+aEWbFB/CuySExU6lmkd7XCw63RS1evkwXyJ4X5QeOqhqp0jT9ZcKI
        /RJFxmEfdno89t/bAsf2YtczCQ==
X-Google-Smtp-Source: AFSGD/WgfIkF5pT9ZTcPbrSpLina1W9CqP6psAOUmzsM0p7CcXqJW//uaNP1k6979wL64/M4RqRrRw==
X-Received: by 2002:a63:2a4a:: with SMTP id q71mr30940787pgq.374.1543362397687;
        Tue, 27 Nov 2018 15:46:37 -0800 (PST)
Received: from vader ([2620:10d:c090:200::5:71bd])
        by smtp.gmail.com with ESMTPSA id n68sm8466045pfb.62.2018.11.27.15.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 15:46:37 -0800 (PST)
Date:   Tue, 27 Nov 2018 15:46:36 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/8] ataflop: implement mq_ops->commit_rqs() hook
Message-ID: <20181127234636.GE846@vader>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-7-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126163556.5181-7-axboe@kernel.dk>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 09:35:54AM -0700, Jens Axboe wrote:
> We need this for blk-mq to kick things into gear, if we told it that
> we had more IO coming, but then failed to deliver on that promise.

Who converted this one? Oh yeah, it was me...

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/block/ataflop.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
> index f88b4c26d422..475cb972f324 100644
> --- a/drivers/block/ataflop.c
> +++ b/drivers/block/ataflop.c
> @@ -1471,6 +1471,13 @@ static void setup_req_params( int drive )
>  			ReqTrack, ReqSector, (unsigned long)ReqData ));
>  }
>  
> +static void ataflop_commit_rqs(struct blk_mq_hw_ctx *hctx)
> +{
> +	spin_lock_irq(&ataflop_lock);
> +	finish_fdc();
> +	spin_unlock_irq(&ataflop_lock);
> +}
> +
>  static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
>  				     const struct blk_mq_queue_data *bd)
>  {
> @@ -1947,6 +1954,7 @@ static const struct block_device_operations floppy_fops = {
>  
>  static const struct blk_mq_ops ataflop_mq_ops = {
>  	.queue_rq = ataflop_queue_rq,
> +	.commit_rqs = ataflop_commit_rqs,
>  };
>  
>  static struct kobject *floppy_find(dev_t dev, int *part, void *data)
> -- 
> 2.17.1
> 
