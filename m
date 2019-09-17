Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A72C4CECD
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 16:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DDD21881
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 16:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfIQQR4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:17:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46592 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfIQQR4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 12:17:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so2430966pfg.13
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 09:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B45kdRJCtQcQYgi3G2dh4K37FST+My1K2Jd4V8V68nE=;
        b=lP5iZhDE5BvIvlj/pa2lkFZO9mio5IM7ThN4gjcXJrMIbHnOb2rAr6dZrctF+fk08s
         APIR20fn0OxRFcTdZQe2MC4TVIJNO1IOfwCRA1DuRKpTwQTMDl9eSnCRF1NyiHDy8pE+
         o+m69MUVmM2meB1zRqT0oKatrgy2fewDLinmlw8z/9HvlSmhetW38v2Lld/H2pBjr591
         WCbAWyYd8Bju50tKFOAV3zgW1fh+XW7UC1A+PiWYa686oy+3ZS9gpEuuZQBp/nW86pyp
         oUMnt/r0LcGWkodgc6lzEvfUuyc3u6DMCwb5HqerRQlidV/0ss+aJ1K4USOQyX2AEoGX
         /W1w==
X-Gm-Message-State: APjAAAUHbkKWA/m9VgM0Id3b6karWbWRPfuLS3WGENF7AI0I4huGjnuR
        MZA59niymahcP1eA3W+H25i3C6ZN
X-Google-Smtp-Source: APXvYqwAYsaHGAsCK0JbCuWYPvZY1AazeBhYl+zt+Oka0GR9ceNq8q2/gJ3N0s8fZgNNqiguTejvoQ==
X-Received: by 2002:aa7:8005:: with SMTP id j5mr5183070pfi.50.1568737075582;
        Tue, 17 Sep 2019 09:17:55 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id r30sm4008317pfl.42.2019.09.17.09.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 09:17:54 -0700 (PDT)
Subject: Re: [PATCH] block: track per requests type merged count
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, osandov@fb.com
References: <20190917003518.6219-1-chaitanya.kulkarni@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2083dd3e-cca9-a44c-7852-d6a74d35b29c@acm.org>
Date:   Tue, 17 Sep 2019 09:17:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917003518.6219-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/16/19 5:35 PM, Chaitanya Kulkarni wrote:
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index b3f2ba483992..1e46f2cbf84e 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -679,8 +679,21 @@ static ssize_t ctx_dispatched_write(void *data, const char __user *buf,
>   static int ctx_merged_show(void *data, struct seq_file *m)
>   {
>   	struct blk_mq_ctx *ctx = data;
> +	unsigned long *rm = ctx->rq_merged;
> +
> +	seq_printf(m, "READ             %8lu\n", rm[REQ_OP_READ]);
> +	seq_printf(m, "WRITE            %8lu\n", rm[REQ_OP_WRITE]);
> +	seq_printf(m, "FLUSH            %8lu\n", rm[REQ_OP_FLUSH]);
> +	seq_printf(m, "DISCARD          %8lu\n", rm[REQ_OP_DISCARD]);
> +	seq_printf(m, "SECURE_ERASE     %8lu\n", rm[REQ_OP_SECURE_ERASE]);
> +	seq_printf(m, "ZONE_RESET       %8lu\n", rm[REQ_OP_ZONE_RESET]);
> +	seq_printf(m, "ZONE_RESET_ALL   %8lu\n", rm[REQ_OP_ZONE_RESET_ALL]);
> +	seq_printf(m, "WRITE_ZEROES     %8lu\n", rm[REQ_OP_WRITE_ZEROES]);
> +	seq_printf(m, "SCSI_IN          %8lu\n", rm[REQ_OP_SCSI_IN]);
> +	seq_printf(m, "SCSI_OUT         %8lu\n", rm[REQ_OP_SCSI_OUT]);
> +	seq_printf(m, "DRV_IN           %8lu\n", rm[REQ_OP_DRV_IN]);
> +	seq_printf(m, "DRV_OUT          %8lu\n", rm[REQ_OP_DRV_OUT]);
>   
> -	seq_printf(m, "%lu\n", ctx->rq_merged);
>   	return 0;
>   }

Several request types shown above are never merged, e.g. FLUSH, 
WRITE_ZEROES, SCSI_IN, SCSI_OUT, DRV_IN and DRV_OUT (see also 
rq_mergeable()). Showing zero for these request types may confuse users. 
Can the body of this function be changed into a loop that does not print 
statistics for request types for which ctx->rq_merged[] is zero?

Thanks,

Bart.

