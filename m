Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB162C4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 17:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B23561040
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 17:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhHDRn0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 13:43:26 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:44918 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237454AbhHDRnZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 13:43:25 -0400
Received: by mail-pj1-f51.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so4609061pjh.3
        for <linux-block@vger.kernel.org>; Wed, 04 Aug 2021 10:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pXItJuhcXznkQN2dHpC7pclMz+MY9DZLeArM3n5ZRoo=;
        b=E4qLlCdEiSvQsItKU6nGTsKh9Qd+q0qTyF1eRIeIFxPx+mltl1iXrHSV1tQftq9Q8+
         cEqxXxocCTkaWw9NoDjUESI4/fll++MmOwFttl8IulhtiApsvmSsKtnIW4z3juu95zcr
         3U5FZRG1oi3KgpR9/OT4AWXCiK1cFw1MDjMK5NiCV62xRgag4DZamaOaBK/1I59mwqa4
         BMXeL3cuFbop0uXs5MMMKsvj/zFwFI+YuMWy3itpAmddmOJVOA1lbcpFxNtbqc03AGQ8
         00blVCE81rGMVmMiKi2FMz6oyMobjRQ+UBdviUm6kBATZetKRIPW9Afh6e7sShqKabiB
         S7tQ==
X-Gm-Message-State: AOAM532a/0DNWt3w7IXo7Ezn47t7L4i9/Afe0FbehHDiMLzj+2v8+SCA
        REGzfyJcW8sEa+lB2ZDPsao=
X-Google-Smtp-Source: ABdhPJzwKmu/AkSn1J7QFC/7G4mn1dCXhnQnKFgnjjqO13JRlLlysiGqwGH3cn2SS7cupWeDoZO5tA==
X-Received: by 2002:a63:550c:: with SMTP id j12mr280040pgb.31.1628098990997;
        Wed, 04 Aug 2021 10:43:10 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:8587:b3fe:5419:1ed7])
        by smtp.gmail.com with ESMTPSA id b5sm3141575pjq.2.2021.08.04.10.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 10:43:09 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] loop: Select I/O scheduler 'none' from inside
 add_disk()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Martijn Coenen <maco@android.com>
References: <20210803182304.365053-1-bvanassche@acm.org>
 <20210803182304.365053-3-bvanassche@acm.org> <YQn924DHk4axOUso@T590>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <bbecb701-48d6-bdfa-2d41-afb6c48a8254@acm.org>
Date:   Wed, 4 Aug 2021 10:43:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQn924DHk4axOUso@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/3/21 7:39 PM, Ming Lei wrote:
> On Tue, Aug 03, 2021 at 11:23:03AM -0700, Bart Van Assche wrote:
>> We noticed that the user interface of Android devices becomes very slow
>> under memory pressure. This is because Android uses the zram driver on top
>> of the loop driver for swapping, because under memory pressure the swap
>> code alternates reads and writes quickly, because mq-deadline is the
>> default scheduler for loop devices and because mq-deadline delays writes by
> 
> Maybe we can bypass io scheduler always for request with REQ_SWAP, such as:
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 0f006cabfd91..d86709ac9d1f 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -420,7 +420,8 @@ static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
>   	 * passthrough request is added to scheduler queue, there isn't any
>   	 * chance to dispatch it given we prioritize requests in hctx->dispatch.
>   	 */
> -	if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq))
> +	if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq) ||
> +			blk_rq_is_swap(rq))
>   		return true;
>   
>   	return false;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index d3afea47ade6..71aaa99614ab 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -251,6 +251,11 @@ static inline bool blk_rq_is_passthrough(struct request *rq)
>   	return blk_op_is_passthrough(req_op(rq));
>   }
>   
> +static inline bool blk_rq_is_swap(struct request *rq)
> +{
> +	return rq->cmd_flags & REQ_SWAP;
> +}
> +
>   static inline unsigned short req_get_ioprio(struct request *req)
>   {
>   	return req->ioprio;

Hi Ming,

Thanks for having suggested an alternative. However, isn't the above a 
policy? Shouldn't a kernel provide mechanisms instead of policies?

Additionally, the above patch does not address all Android loop driver 
use cases. Reading APEX files is regular I/O and hence REQ_SWAP is not 
set while reading from APEX files.

Thanks,

Bart.
