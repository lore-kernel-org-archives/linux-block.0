Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A02C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 13:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083462084B
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 13:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfCZNnb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:43:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43988 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfCZNnb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 09:43:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id m10so1658807plt.10
        for <linux-block@vger.kernel.org>; Tue, 26 Mar 2019 06:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bJTRqlCMbfxrd+i//pZgAwnFcR9A97e6fSSwc+/PD0k=;
        b=qWlWjkYQjr/N5kxeMShHS6KQS4gJ3ebaw7E5kpa8aN9Un0lle0YG/za72GVF4hwEro
         xhL/nHxrCbPwcFt19QbyI+WOYPqwNT+VOow1gdp6XryKC5QramYxMxZbKgvlv1i54hO/
         2/6Tdj+4idNRalourupBF4ZKoZPFwrAEl41yCquIYDUuXnwhxatkzVznccBjS1jkevA0
         YZNl8Skbczmw6m0HiqvAnkkg+43VMTvRbjI/koZVRbGLk+mQlNkI0SdiP0Yb65IwtqCB
         KmyxZnoN/wfgYXBdbRl97RZ0Wu3MkqZuzWZ7sMBRutYSl2JFlTfVpRonzDZXIKE3lgvk
         AEfw==
X-Gm-Message-State: APjAAAUn0F9W+0p3n6hVqFQz/Qu1wgFcPkOD8YkweNgJxKai3l4vN9SD
        OSIYdVtCJlLsUDGOvh/EqLg=
X-Google-Smtp-Source: APXvYqzKJI2C8Jz1p0JGNqjr7zbWbE0Ur0RB5Km4f7mI9GS1O8ZcaPvbkl1TXeXlXOf2FFZqX+/dLw==
X-Received: by 2002:a17:902:bd96:: with SMTP id q22mr22898562pls.322.1553607809988;
        Tue, 26 Mar 2019 06:43:29 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id 16sm31156771pfz.106.2019.03.26.06.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 06:43:29 -0700 (PDT)
Subject: Re: [PATCH] block: don't call blk_mq_run_hw_queues() for dead or
 dying queues
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <tom.leiming@gmail.com>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20190326120712.41657-1-hare@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <82fca840-bce0-938e-abc5-1faff5c255d0@acm.org>
Date:   Tue, 26 Mar 2019 06:43:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190326120712.41657-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/19 5:07 AM, Hannes Reinecke wrote:
> When a queue is dying or dead there is no point in calling
> blk_mq_run_hw_queues() in blk_mq_unquiesce_queue(); in fact, doing
> so might crash the machine as the queue structures are in the
> process of being deleted.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>   block/blk-mq.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a9c181603cbd..b1eeba38bc79 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -258,7 +258,8 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>   	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
>   
>   	/* dispatch requests which are inserted during quiescing */
> -	blk_mq_run_hw_queues(q, true);
> +	if (!blk_queue_dying(q) && !blk_queue_dead(q))
> +		blk_mq_run_hw_queues(q, true);
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);

Hi Hannes,

Please provide more context information. In the "dead" state the queue 
must be run to make sure that all requests that were queued before the 
"dead" state get processed. The blk_cleanup_queue() function is 
responsible for stopping all code that can run the queue after all 
requests have finished and before destruction of the data structures 
needed for request processing starts.

Bart.
