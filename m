Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118E6C433ED
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 20:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D006761090
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 20:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhD0URx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Apr 2021 16:17:53 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:40867 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbhD0URx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Apr 2021 16:17:53 -0400
Received: by mail-pl1-f177.google.com with SMTP id 20so27572278pll.7
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 13:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RwyS0OE8O/XhnKVlLdX+CmxbC4EJ3y83Wu4DIBgOirE=;
        b=fSq/wsVcai8kNKwdJheL9YHR5om7hCckNwbUB43PWketZ/IdT4QXpfV7MEc9sz0aPS
         5UdRFrh/3rK5CslW/ER6TsmJpI249e/G8lamXItHINn6q5Yw+hSdPQ17W9REaRLwAt4e
         C21GVBhahC3rE9aKqba7ISZ1vjiTucmpKKIjelh9jFe4OO0nBynnpTAlmbfDWCwFmzW1
         JEnssr1NsG5WaVtvQJefpwncENmjuy+pnyy7TKP3eSCl4GIPBeN6CZuWQzYuuoLKqWHE
         mdvDJrC7TltbgQ1nLC5WplEx6diZndrf8MfdQCB5t3XhhljeggToaziobPj2CQ/jZJof
         efHA==
X-Gm-Message-State: AOAM530VcX12lD7yjxuHjWdyg83xNj8G79yB07D20146gwDfYa7GUmbI
        lZuQHGPtFc6Qt6Cagd3rd8U=
X-Google-Smtp-Source: ABdhPJxKMNIP3d0kZ6j5xV8/vrRYE5bvJzL8fuJStdw3sQp4z11uDHdU01/NU8T05kfBXDr9euLtZA==
X-Received: by 2002:a17:902:ce83:b029:ed:5750:bef8 with SMTP id f3-20020a170902ce83b02900ed5750bef8mr5284211plg.31.1619554629490;
        Tue, 27 Apr 2021 13:17:09 -0700 (PDT)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id ch14sm3042542pjb.55.2021.04.27.13.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 13:17:08 -0700 (PDT)
Subject: Re: [PATCH V3 2/3] blk-mq: grab rq->refcount before calling ->fn in
 blk_mq_tagset_busy_iter
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
References: <20210427151058.2833168-1-ming.lei@redhat.com>
 <20210427151058.2833168-3-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ce2f315d-ffa8-8327-0633-01c06a2c23fe@acm.org>
Date:   Tue, 27 Apr 2021 13:17:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427151058.2833168-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/21 8:10 AM, Ming Lei wrote:
> +void blk_mq_put_rq_ref(struct request *rq)
> +{
> +	if (is_flush_rq(rq, rq->mq_hctx))
> +		rq->end_io(rq, 0);
> +	else if (refcount_dec_and_test(&rq->ref))
> +		__blk_mq_free_request(rq);
> +}

The above function needs more work. blk_mq_put_rq_ref() may be called 
from multiple CPUs concurrently and hence must handle concurrent calls 
safely. The flush .end_io callbacks have not been designed to handle 
concurrent calls.

Bart.
