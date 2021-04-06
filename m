Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DA1C433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 01:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5829C613ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 01:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbhDFBGh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Apr 2021 21:06:37 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:43611 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbhDFBGf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Apr 2021 21:06:35 -0400
Received: by mail-pf1-f180.google.com with SMTP id q5so9246570pfh.10
        for <linux-block@vger.kernel.org>; Mon, 05 Apr 2021 18:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=igNT9D8YeF7E2iWuyfm7MFvc2XArR0IXMGftmPnzEx0=;
        b=qYyOXtr7k/ioqB24la8i5UOI6JjugdBScZVVNTFlPZvfmfWko4H7z7wtj1HXADu/lr
         /LBlIPz9xAVYrZk031JxtMNJCxIoRBvbYoPZFUAPG6mwd52iOUKKSKLscKwZLzswErGu
         RzLTq+C2eJ6zLHq+GVbWSSqRLYm+MuFi9BJpPVC0wOrTbIA6DzzM/A3ZRKdUNztdge1P
         5ZUkW84htT/Us7zTVQmRED4+X521VyzIDbN7INqZy4yPYEN+6bme7Ju1DE7EM/Tcm7/0
         pos4BhmPtEwhTMyGz0qmojbMCq+8nkN1v4u2Yc0DTnrCLT57YSLms3C/ebUDk6eJ5ekd
         8cJQ==
X-Gm-Message-State: AOAM532QQ7IIJaRxs8p0o9NIPL1B7dNbL1gG0VpSozC67BGuAXX1d+42
        s9V8+KbX0RVzyG0uUpTAyG47lmfg+ys5qw==
X-Google-Smtp-Source: ABdhPJxeMKqVGoCsuXw7ili7a1oxyNVUjiVZW9NX9iVQPCe4Bp2cTgpn9r1owAkqdEHNtkm/eJcrRA==
X-Received: by 2002:a63:1b5c:: with SMTP id b28mr25753626pgm.186.1617671188146;
        Mon, 05 Apr 2021 18:06:28 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:b918:89d2:aae7:e643? ([2601:647:4000:d7:b918:89d2:aae7:e643])
        by smtp.gmail.com with ESMTPSA id my18sm371885pjb.38.2021.04.05.18.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 18:06:27 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] blk-mq: Fix a race between iterating over requests
 and freeing requests
To:     Jens Axboe <axboe@kernel.dk>, Khazhy Kumykov <khazhy@google.com>,
        John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20210405002834.32339-1-bvanassche@acm.org>
 <20210405002834.32339-4-bvanassche@acm.org>
 <CACGdZYJh6ZvVekC8eBvz3SmN-TH8hTAmMQrvHtLJsKyL3R_fLw@mail.gmail.com>
 <54474b65-ffa4-9335-f7a2-5b49ccf169d4@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2e8e4954-5e28-5f04-52c0-5f48424b4532@acm.org>
Date:   Mon, 5 Apr 2021 18:06:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <54474b65-ffa4-9335-f7a2-5b49ccf169d4@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/5/21 2:34 PM, Jens Axboe wrote:
> For something out of left field, we can check if the page that the rq
> belongs to is still part of the tag set. If it isn't, then don't
> deref it.
> 
> Totally untested.
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index e5bfecf2940d..6209c465e884 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -196,9 +196,35 @@ struct bt_iter_data {
>  	struct blk_mq_hw_ctx *hctx;
>  	busy_iter_fn *fn;
>  	void *data;
> +	struct page *last_lookup;
>  	bool reserved;
>  };
>  
> +static bool rq_from_queue(struct bt_iter_data *iter_data, struct request *rq)
> +{
> +	struct blk_mq_hw_ctx *hctx = iter_data->hctx;
> +	struct page *rq_page, *page;
> +
> +	/*
> +	 * We can hit rq == NULL here, because the tagging functions
> +	 * test and set the bit before assigning ->rqs[].
> +	 */
> +	if (!rq)
> +		return false;
> +	rq_page = virt_to_page(rq);
> +	if (rq_page == iter_data->last_lookup)
> +		goto check_queue;
> +	list_for_each_entry(page, &hctx->tags->page_list, lru) {
> +		if (page == rq_page) {
> +			iter_data->last_lookup = page;
> +			goto check_queue;
> +		}
> +	}
> +	return false;
> +check_queue:
> +	return rq->q == hctx->queue && rq->mq_hctx == hctx;
> +}
> +
>  static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>  {
>  	struct bt_iter_data *iter_data = data;
> @@ -211,11 +237,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>  		bitnr += tags->nr_reserved_tags;
>  	rq = tags->rqs[bitnr];
>  
> -	/*
> -	 * We can hit rq == NULL here, because the tagging functions
> -	 * test and set the bit before assigning ->rqs[].
> -	 */
> -	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
> +	if (rq_from_queue(iter_data, rq))
>  		return iter_data->fn(hctx, rq, iter_data->data, reserved);
>  	return true;
>  }

Hi Jens,

That's a very interesting suggestion. However, it seems to me that Khazhy's
suggestion will result in shorter and faster code?

Khazhy pointed out another race to me off-list, namely a race between updating
the number of hardware queues and iterating over the tags in a tag set. I'm
currently analyzing how to fix that race too.

Thanks,

Bart.


