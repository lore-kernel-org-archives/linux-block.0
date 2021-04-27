Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E28FC433ED
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 02:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B800613C0
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 02:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhD0C3G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 22:29:06 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:37618 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhD0C3F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 22:29:05 -0400
Received: by mail-pl1-f172.google.com with SMTP id h20so30021235plr.4
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 19:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yc9dfoNtccjws4uwAzolGBZYI6IUt1PUsQYYIRyuYNQ=;
        b=P9cG4ZN4eqoSbcjV5S1K3y+cA0rZmAeBuF5msgDEntxb0QgF1HIgqGOzODae7d+IQu
         1lUJZj6lhyHUJXRUoYnlxYlcLGT+2i18QH4AoezlGEAl+rb7ZPbf3o7peQmEuRqMp3oX
         oFr8koqMJS/gI3iZngssZVzxY28AQjhZwvKL1ErFWC/GGqGslzzJaJyTVlC4EfaE+EQe
         sML8Bxcy7Kv/bm1fUIzWp+6b2YpFBekJxBtvHIJbil+7H0z5q6Q7cx93wmKYoLA4Ttpq
         SQkyVtEzfVpXXYZER81+H8nQYKRwjnNNOPqURRXiyTP4XXsCsnShD+raurf1c67vkNer
         xZfg==
X-Gm-Message-State: AOAM5324BvECrPkZGLuZcwSNhguh4ZMrwf76BQySZ230CG0+R9mcbQSR
        XUFJOJUOfOyMng/qnwd5CkE=
X-Google-Smtp-Source: ABdhPJyhvs7fub1nYUMBrf8yC3izFJOlOHTQ6FyvqLh8bG+YyHREIjmxRfFE1k0zJ0/S16q1scuMRA==
X-Received: by 2002:a17:90b:1c0f:: with SMTP id oc15mr25500881pjb.228.1619490502469;
        Mon, 26 Apr 2021 19:28:22 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id i22sm12696718pgj.90.2021.04.26.19.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 19:28:21 -0700 (PDT)
Subject: Re: [PATCH V2 1/3] blk-mq: grab rq->refcount before calling ->fn in
 blk_mq_tagset_busy_iter
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
References: <20210427014540.2747282-1-ming.lei@redhat.com>
 <20210427014540.2747282-2-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e0cd9c25-60e1-507d-4fc3-f6ea4ac4ca86@acm.org>
Date:   Mon, 26 Apr 2021 19:28:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210427014540.2747282-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/26/21 6:45 PM, Ming Lei wrote:
> + * We grab one request reference before calling @fn and release it after
> + * @fn returns. So far we don't support to pass the request reference to
> + * one new conetxt in @fn.
              ^^^^^^^
              context?

> +void blk_mq_put_rq_ref(struct request *rq)
> +{
> +	if (is_flush_rq(rq, rq->mq_hctx))
> +		rq->end_io(rq, 0);
> +	else if (refcount_dec_and_test(&rq->ref))
> +		__blk_mq_free_request(rq);
> +}

Will rq->end_io() be called twice when a tag iteration function
encounters a flush request?

Thanks,

Bart.
