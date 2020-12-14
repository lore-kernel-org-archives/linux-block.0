Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FACC4361B
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 18:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFA82246B
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 18:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408643AbgLNSC6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Dec 2020 13:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbgLNSC4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Dec 2020 13:02:56 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F00AC0613D6
        for <linux-block@vger.kernel.org>; Mon, 14 Dec 2020 10:02:16 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id t16so17350031wra.3
        for <linux-block@vger.kernel.org>; Mon, 14 Dec 2020 10:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N2uFLsrYwjctmKW3C5dZ+8Zmh9SDQkVVSl2VRVelruw=;
        b=h21kNr4xGsn1AmXu4AxAoZvEXzJKBs14gri0mv9WAt5iVj5TCSDo9xTQ5qnEdlrxLu
         xY12kK0ubbxVaC01u3JVWAap7+BPiIQNossqg75vhQoVXzLvZxVloKARgCgCg/ZuynUn
         3j3Rx+gqEa6tOK5EATyVAxUvYLZx3eSrZgUxNq315Ho8De8sUm7rDvv0wlI2H7Gx/k4Q
         pK0eCaerPw2Wwv+iRQzbfPlAWFTwus+J/E1EPtobiMm9Da5ZkWW6/LpoZLe0ld26ZZev
         NkNvcOm+Y5PJK6vIqsoe9x8ScAMSdXoXyEqdiDWNwM6zew/2epmgynfyp5yDkWSujp41
         Biqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=N2uFLsrYwjctmKW3C5dZ+8Zmh9SDQkVVSl2VRVelruw=;
        b=WMwTJ+jbbEj6YEXTCJM+A1F5DptkkHMcQobkZdT2Hc3/MT2w5001Bb9/gs6OJxX0Tk
         Qd94u9Sz8dgFOUeXXoawoEpfw5O10402/6XRalxltkl0pjh6Rp1RZECUnM4nPyJxABPn
         JgzfuldPKOCzcRGpSl12Ni22bhkmXcp1uS2ESuyUupfXZjPux0na78gbd5GZcxh9IqFC
         n8LwrzURmdydcfz1+YlO2YvQIv2C0kW3togD59PKqdyeX88I/sug6yl3+mlAZOlAO/k9
         9OeZ4GvBPmBB8toSzgNoTLWaaTrEgceNa4pIyN9U7J32DtznZkSeLmLr9hVYo7MI0LCO
         e4OA==
X-Gm-Message-State: AOAM533fMlbBsiI3kP1RbKOakWTYCOeYFj46Xt0mJV2FN4A9GlCdZkKh
        gd/lLAc4m2SHk5HpGTko+TY=
X-Google-Smtp-Source: ABdhPJyyY2e21TSS9RVZPUgjf5QPySMLctFUkjGDAy0UF3Jjrdt6CC7ZiwjEr97mVlzwfLdTVPo/Hw==
X-Received: by 2002:adf:ca0c:: with SMTP id o12mr3798460wrh.154.1607968935027;
        Mon, 14 Dec 2020 10:02:15 -0800 (PST)
Received: from [192.168.8.128] ([85.255.232.163])
        by smtp.gmail.com with ESMTPSA id e16sm36786492wra.94.2020.12.14.10.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 10:02:14 -0800 (PST)
To:     Keith Busch <kbusch@kernel.org>
Cc:     Andres Freund <andres@anarazel.de>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20201210205141.px7suygfrl2lhdkr@alap3.anarazel.de>
 <73c43682-10f2-0bc9-5aa5-e433abd4f3c3@gmail.com>
 <aa735173-fad1-b7d4-1c90-4fccc90c562d@gmail.com>
 <20201211011940.ouc4k3am5gg2ithp@alap3.anarazel.de>
 <de0b46d2-d053-a7a8-23e7-fc954807c70d@gmail.com>
 <20201211033719.GA6414@redsun51.ssa.fujisawa.hgst.com>
 <2b26eaca-d143-6951-3bed-ce29df4dd07d@gmail.com>
 <20201213181927.GA3909519@dhcp-10-100-145-180.wdc.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: hybrid polling on an nvme doesn't seem to work with iodepth > 1
 on 5.10.0-rc5
Message-ID: <55ec2183-2b3a-7660-a7fa-3f063872845e@gmail.com>
Date:   Mon, 14 Dec 2020 17:58:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201213181927.GA3909519@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13/12/2020 18:19, Keith Busch wrote:
> On Fri, Dec 11, 2020 at 12:38:43PM +0000, Pavel Begunkov wrote:
>> On 11/12/2020 03:37, Keith Busch wrote:
>>> It sounds like the statistic is using the wrong criteria. It ought to
>>> use the average time for the next available completion for any request
>>> rather than the average latency of a specific IO. It might work at high
>>> depth if the hybrid poll knew the hctx's depth when calculating the
>>> sleep time, but that information doesn't appear to be readily available.
>>
>> It polls (and so sleeps) from submission of a request to its completion,
>> not from request to request. 
> 
> Right, but the polling thread is responsible for completing all
> requests, not just the most recent cookie. If the sleep timer uses the
> round trip of a single request when you have a high queue depth, there
> are likely to be many completions in the pipeline that aren't getting
> polled on time. This feeds back to the mean latency, pushing the sleep
> timer further out.

It rather polls for a particular request and completes others by the way,
and that's the problem. Completion-to-completion would make much more
sense if we'd have a separate from waiters poll task.

Or if the semantics would be not "poll for a request", but poll a file.
And since io_uring IMHO that actually makes more sense even for
non-hybrid polling.

> 
>> Looks like the other scheme doesn't suit well
>> when you don't have a constant-ish flow of requests, e.g. QD=1 and with
>> different latency in the userspace.
> 
> The idea I'm trying to convey shouldn't affect QD1. The following patch
> seems to test "ok", but I know of at least a few scenarios where it
> falls apart...
> 
> ---
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e9799fed98c7..cab2dafcd3a9 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3727,6 +3727,7 @@ static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb)
>  static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
>  				       struct request *rq)
>  {
> +	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>  	unsigned long ret = 0;
>  	int bucket;
>  
> @@ -3753,6 +3754,15 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
>  	if (q->poll_stat[bucket].nr_samples)
>  		ret = (q->poll_stat[bucket].mean + 1) / 2;
>  
> +	/*
> +	 * Finding completions on the first poll indicates we're sleeping too
> +	 * long and pushing the latency statistic in the wrong direction for
> +	 * future sleep consideration. Poll immediately until the average time
> +	 * becomes more useful.
> +	 */
> +	if (hctx->poll_invoked < 3 * hctx->poll_considered)
> +		return 0;
> +
>  	return ret;
>  }
>  
> ---
> 

-- 
Pavel Begunkov
