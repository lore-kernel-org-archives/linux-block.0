Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DBEEB64D9
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 07:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjF2Hl1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 03:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjF2Hko (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 03:40:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7853A96
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 00:40:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b7e6512973so2515925ad.3
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 00:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688024408; x=1690616408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=znG/5fKsp7zP0K967Ka3PZWUHHbz6JhxQhqkHda3fz4=;
        b=aPku/yElDU6Y56e/5mcC0d0xyzr1ju20OM0F1AvRqtw1qJ8Qquw9ETM2Do6w4Q93m2
         ZXyGdZJDEHzmAN0kcZFgdgjh5DtVxDoBpxaFzLnlFx7j6G5hwbWn9CYzNkFfihI4xwKF
         q6sSFBf/TOeV3CUiibr54sFGTaXC7F3roRC+W7CA12M+dajiAa5Fqx3x+UHEzYU2lnrm
         2U6KL8TNSTBBqeo5XBX2qRtvO36Rc5uJU3XMfSnPyJQlxdN755lb+cW9YRmiavEJRzft
         CszW8kRQsVI/crQ9GxOvWtiTSwHbWIC9d0BZKOSkQY3wr8dGdHjpvwkPEEE0/HDKjhoo
         iBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688024408; x=1690616408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znG/5fKsp7zP0K967Ka3PZWUHHbz6JhxQhqkHda3fz4=;
        b=aBfkfvuIvipQv0SR+f3VUTChlNjQGGF4+mDUjb2/NKvxF1sKQo1/4lbNuYp7FfjAoy
         RK8Y8F2/qG717IN2NVtsXEC03kdXAKTk4gyfhHrFyemeGJQEi9YC/M0G0X0+S0Gwr9sl
         cpIlm+9NLZcvSL1fLP+3cGP+PfRH7/QICCmFtKWxxPL2tlKrnwZq1ITfJZ7GIHg7YQWP
         u3UhE6bJ6DrWPwwqjl+XoeKjHcHPvDvAoSp6EQ7Bg51Qb5hhS/0R5wbj3qYDczkz3Xxz
         fz28ZgOFLskDsozy9EafwbW/NIikU1mTSMmKQ9tud39H4QwcdhO4d3mIy394n3M73mMx
         vq6Q==
X-Gm-Message-State: ABy/qLZob3U8JBEMD2zx2tPW7wy1sBov/FuFIM1wnYlQT7hAo/LO/hw6
        JatUNQ0HCa3VaDO1alEuhzLszA==
X-Google-Smtp-Source: APBJJlHTZJMVL8B7voVCbfWF57x/0SFaycRBr621haIGld+SPudSvo0LmrAZy1LpWvPLalFIGrrLAw==
X-Received: by 2002:a17:902:ea10:b0:1b8:5aba:509d with SMTP id s16-20020a170902ea1000b001b85aba509dmr306954plg.21.1688024408022;
        Thu, 29 Jun 2023 00:40:08 -0700 (PDT)
Received: from [10.254.62.122] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b001b50b933febsm8583418plb.238.2023.06.29.00.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 00:40:07 -0700 (PDT)
Message-ID: <f91c32b3-1d3b-b28c-40cb-2edf02448f22@bytedance.com>
Date:   Thu, 29 Jun 2023 15:40:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/3] blk-mq: always use __blk_mq_alloc_requests() to
 alloc and init rq
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com
References: <20230628124546.1056698-1-chengming.zhou@linux.dev>
 <20230628124546.1056698-2-chengming.zhou@linux.dev>
 <20230629052828.GD16819@lst.de>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20230629052828.GD16819@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/6/29 13:28, Christoph Hellwig wrote:
> On Wed, Jun 28, 2023 at 08:45:44PM +0800, chengming.zhou@linux.dev wrote:
>> After these cleanup, __blk_mq_alloc_requests() is the only entry to
>> alloc and init rq.
> 
> I find the code a little hard to follow now, due to the optional
> setting of the ctx.  We also introduce really odd behavior here
> if the caller for a hctx-specific allocation doesn't have free
> tags, as we'll now run into the normal retry path.
> 
> Is this really needed for your timestamp changes?  If not I'd prefer
> to skip it.
> 

Thanks for your review!

Since hctx-specific allocation path always has BLK_MQ_REQ_NOWAIT flag,
it won't retry.

But I agree, this makes the general __blk_mq_alloc_requests() more complex.

The reason is blk_mq_rq_ctx_init() has some data->rq_flags initialization:

```
if (data->flags & BLK_MQ_REQ_PM)
	data->rq_flags |= RQF_PM;
if (blk_queue_io_stat(q))
	data->rq_flags |= RQF_IO_STAT;
rq->rq_flags = data->rq_flags;
```

Because we need this data->rq_flags to tell if we need start_time_ns,
we need to put these initialization in the callers of blk_mq_rq_ctx_init().

Now we basically have two callers, the 1st is general __blk_mq_alloc_requests(),
the 2nd is the special blk_mq_alloc_request_hctx(). So I change the 2nd caller
to reuse the 1st __blk_mq_alloc_requests().

Or we put these data->rq_flags initialization in blk_mq_alloc_request_hctx() too?

Thanks.

