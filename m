Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285E4C3A5A2
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 20:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2E02173B
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 20:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbfHWUcQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 16:32:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43964 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbfHWUcP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 16:32:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so6171773pld.10
        for <linux-block@vger.kernel.org>; Fri, 23 Aug 2019 13:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iFNi05hNfjtYC2cK8GFZfXhYO7ME5KhMMVx27AW9BmE=;
        b=Q5xRCHNBU0K2YiXCzyGf0H/iGWzbpTEfmqxNy5zH89HA9JvpvhGMX8wz+qIDc3nfAg
         SDcKOQGbN4jJ0iCv+2wRTEYbrkKkLzFvct7tG0u9Kja3R6lCfgA6YkWQJIMca3ITHD1+
         54+PIperc8m8qw57NrHBAtVg5Ya+nKvYDFk65Wa84BgJ3zQ8uQ8oUX6LbXG2/45byPfX
         ByWuSVKXbzUw0cdJdswxEqhX/U2y4WPN1c3KuX3M1J99Y70c+QPJHy2UZo4dU/+KqIc4
         ArD9+TXzSG8YWYi9w40l35ue1SwuGuY/+0Ol1pEqsL6y/mrevvI+1itf7XaCU8Whm1ML
         vvPQ==
X-Gm-Message-State: APjAAAXDMmyMv0uz7VsxiAXA09EYdbsSlCUao5l9J29tBIuYYmNLQDnR
        8WwO0G1EqQ+6S8U0v/cJAYY=
X-Google-Smtp-Source: APXvYqzggwtEp3cNkvEdHN+47NFVYHIU1QyTJTHTbco7r1ZA1fdjlr9Bq/pe1+Vkwek9osQCNroT/Q==
X-Received: by 2002:a17:902:1122:: with SMTP id d31mr6948443pla.254.1566592334964;
        Fri, 23 Aug 2019 13:32:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:1349:7025:52c4:ad19:e88c? ([2601:647:4000:1349:7025:52c4:ad19:e88c])
        by smtp.gmail.com with ESMTPSA id g2sm3623404pfi.26.2019.08.23.13.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2019 13:32:14 -0700 (PDT)
Subject: Re: [PATCH 3/7] block: Remove sysfs lock from elevator_init_rq()
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20190823001528.5673-1-damien.lemoal@wdc.com>
 <20190823001528.5673-4-damien.lemoal@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <206a2a26-c8a8-f8ac-4841-071d0bd3396e@acm.org>
Date:   Fri, 23 Aug 2019 13:32:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823001528.5673-4-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/22/19 5:15 PM, Damien Le Moal wrote:
> Since elevator_init_rq() is called before the device queue is registered
> in sysfs, there is no possible conflict with elevator_switch(). Remove
> the unnecessary locking of q->sysfs_lock mutex.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  block/elevator.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 7fff06751633..6208ddc334ef 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -617,17 +617,12 @@ void elevator_init_mq(struct request_queue *q)
>  	if (q->nr_hw_queues != 1)
>  		return;
>  
> -	/*
> -	 * q->sysfs_lock must be held to provide mutual exclusion between
> -	 * elevator_switch() and here.
> -	 */
> -	mutex_lock(&q->sysfs_lock);
>  	if (unlikely(q->elevator))
> -		goto out_unlock;
> +		return;
>  
>  	e = elevator_get(q, "mq-deadline", false);
>  	if (!e)
> -		goto out_unlock;
> +		return;
>  
>  	err = blk_mq_init_sched(q, e);
>  	if (err) {
> @@ -635,9 +630,6 @@ void elevator_init_mq(struct request_queue *q)
>  			"falling back to \"none\"\n", e->elevator_name);
>  		elevator_put(e);
>  	}
> -
> -out_unlock:
> -	mutex_unlock(&q->sysfs_lock);
>  }

Please consider to add a WARN_ON_ONCE() statement that triggers a
warning if this function is called for a request queue that has already
been registered.

Thanks,

Bart.


