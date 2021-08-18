Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96283C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 02:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BEB560FE6
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 02:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbhHRCTW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Aug 2021 22:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbhHRCTP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Aug 2021 22:19:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7D9C061764
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 19:18:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so7877735pjn.4
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 19:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R2Rb8+f6V4Yl+/X0vjvl6D7lXBjuNJKL2gHArF3YRqg=;
        b=AMA2Z6cmcrBfZgAYCoPcj9EzNAGX3R/WEjnnvwUUWHcAnwIb2QTBEr+Y9UTReNB1//
         t9HJavD4yt6Sez7IgawO0dTR/QMTAoZ10vqF5tvDYy7ADLqRSeRFIF2yzBXdA2gnrEBM
         QMI32ttoNa6PwnAGdwuU9oPXcM1RJhTtqb2xETGZIKDuO61zTY2RL4oX/QEvLGK+2OfR
         hF1pY35rt2iuaXrgqmooaCVRdgexqoX4Kf07mmT9JngNMsGiRfTTB0A0Lf5OA8LbArQ9
         8bVfE4F/hucT6P4sDC/qdYyRL4kn3YcVtcDoSnjdMSvXBfdfVogZ/1o43ZwEQOHdGCIo
         nTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R2Rb8+f6V4Yl+/X0vjvl6D7lXBjuNJKL2gHArF3YRqg=;
        b=dFtKqiHHj1XlD3/7IO4T6mDMPFps7wDNTrOlYlqbfAbVMSgnfoqFSZzKUIbZuDAXFu
         DkDz6U2+XNG34WfMZlscPOcG5nYp/01yRUEbORVs9ycSdm8evqfwLgbhRh0ePfdz5yoF
         5FP9QaEjpzA2vp4z5aprnZVkxmme5jUCJw4W8XfQlfOQ1x3TAmdEoCDaLVWjw1lHBuB5
         Jd21HSkAjOWtcnh3nm9cM/XEJnPZlkDZ2s+xASx1CaXkuSmDqJ4fIgDd7aLacQMNSxb5
         qlPFBE1h0U3LQY8wuL1WvM2IZmUFBRZzp3eAwMqMXjktYvVFJs49fUK+5K4HCYEUMTlg
         ui/Q==
X-Gm-Message-State: AOAM532/2yRqCUvwshJRd1BrOZTg9MDLDXUSGurTpHzyVqBaJzlUIU8h
        J5kkC2ar3Vyx0J3m1oxy4i7t0Q==
X-Google-Smtp-Source: ABdhPJyKEKuiyCF76R35EmVxMSY6UEjlRkurvzCNX8GeArsCtuPvVX1NNvcOZwArtaQ1zrGaGtpnzA==
X-Received: by 2002:a17:902:c94c:b0:12d:905f:d80d with SMTP id i12-20020a170902c94c00b0012d905fd80dmr5334087pla.21.1629253120636;
        Tue, 17 Aug 2021 19:18:40 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id gg6sm3288077pjb.46.2021.08.17.19.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 19:18:40 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: fix is_flush_rq
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>,
        Yufen Yu <yuyufen@huawei.com>
References: <20210818010925.607383-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <db7a8a1d-3c46-6ead-82b8-ab134b9cfb42@kernel.dk>
Date:   Tue, 17 Aug 2021 20:18:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210818010925.607383-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/17/21 7:09 PM, Ming Lei wrote:
> is_flush_rq() is called from bt_iter()/bt_tags_iter(), and runs the
> following check:
> 
> 	hctx->fq->flush_rq == req
> 
> but the passed hctx from bt_iter()/bt_tags_iter() may be NULL because:
> 
> 1) memory re-order in blk_mq_rq_ctx_init():
> 
> 	rq->mq_hctx = data->hctx;
> 	...
> 	refcount_set(&rq->ref, 1);
> 
> OR
> 
> 2) tag re-use and ->rqs[] isn't updated with new request.
> 
> Fix the issue by re-writing is_flush_rq() as:
> 
> 	return rq->end_io == flush_end_io;
> 
> which turns out simpler to follow and immune to data race since we have
> ordered WRITE rq->end_io and refcount_set(&rq->ref, 1).

That is way better, applied thanks.

> Fixes: 2e315dc07df0 ("blk-mq: grab rq->refcount before calling ->fn in
>     blk_mq_tagset_busy_iter")

I think your mailer was a bit too eager to split lines here. I fixed it up.

-- 
Jens Axboe

