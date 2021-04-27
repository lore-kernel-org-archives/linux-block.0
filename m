Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5CEC433B4
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 02:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642D6613AB
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 02:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhD0Cbg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 22:31:36 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:46897 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhD0Cbg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 22:31:36 -0400
Received: by mail-pf1-f173.google.com with SMTP id d124so40294657pfa.13
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 19:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LJA1yOzb+q/+XGDMqMY0VHrn7H5BxTlo1jTB2Ieq84E=;
        b=H4vUFOEv7cry+FdX7JEFBgWc7FHqLSnvLc3wPaB7nR0Eo47BEwgXq0virecsrEBBnR
         3wCrx2VoOVZkGInlfT/ClmLG5DLr7WjYdMkkFOpcLNKpg25n2ZREFANrAEWNBDr9l0nx
         DQqrouoGu2qG5nhIn8ddqeE4qnhzzDqi0DRfmsL+F/OSyyh26leRKL7tjs+bmyymEL5H
         p/Q0ASiZkMeGLOibH58BLYOrRExZ9lKDm2d7yhbd6XmjOQRTP0bPns67u+E04CESVhH2
         BZRKVcJObagvTtD4MbQeiIx7lTNNFmSol/Q6Uo2j87HGP5QdBRw1OeLNJpDxjh4i1U7a
         C/9w==
X-Gm-Message-State: AOAM5316GSC1zqHrGwj0sxt44QW3Tigb4glJvnkUqjtohyIQn9lQhGlv
        t9ra3iyn1zjrJT2f4fJSPgyfUHOb+GGISw==
X-Google-Smtp-Source: ABdhPJyHI/+rnJtX1i8QOY4xgh3MhJPwIywAfRL5uAGS2p9ZZIQSCZ2l2H4WpkxRt7ous6ee9xiDDQ==
X-Received: by 2002:a05:6a00:1494:b029:278:a4bc:957f with SMTP id v20-20020a056a001494b0290278a4bc957fmr4583079pfu.55.1619490653865;
        Mon, 26 Apr 2021 19:30:53 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id gw19sm800303pjb.4.2021.04.26.19.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 19:30:53 -0700 (PDT)
Subject: Re: [PATCH V2 2/3] blk-mq: complete request locally if the completion
 is from tagset iterator
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
References: <20210427014540.2747282-1-ming.lei@redhat.com>
 <20210427014540.2747282-3-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c122e2bc-2e03-3890-bc7a-be1470bee1d5@acm.org>
Date:   Mon, 26 Apr 2021 19:30:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210427014540.2747282-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/26/21 6:45 PM, Ming Lei wrote:
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 100fa44d52a6..773aea4db90c 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -284,8 +284,11 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>  	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
>  	    !blk_mq_request_started(rq))
>  		ret = true;
> -	else
> +	else {
> +		rq->rq_flags |= RQF_ITERATING;
>  		ret = iter_data->fn(rq, iter_data->data, reserved);
> +		rq->rq_flags &= ~RQF_ITERATING;
> +	}
>  	if (!iter_static_rqs)
>  		blk_mq_put_rq_ref(rq);
>  	return ret;

All existing rq->rq_flags modifications are serialized. The above change
adds code that may change rq_flags concurrently with regular request
processing. I think that counts as a race condition. Additionally, the
RQF_ITERATING flag won't be set correctly in the (unlikely) case that
two concurrent bt_tags_iter() calls examine the same request at the same
time.

Thanks,

Bart.
