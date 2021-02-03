Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D9FC433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 02:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7772064F68
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 02:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhBCCkj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 21:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhBCCkj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 21:40:39 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDE7C06174A
        for <linux-block@vger.kernel.org>; Tue,  2 Feb 2021 18:39:59 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id q131so15674384pfq.10
        for <linux-block@vger.kernel.org>; Tue, 02 Feb 2021 18:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yWP4cdhQQweoyndiS9c4M1AVjAXnxjPoB9KeWmOMmd0=;
        b=YhdhHNOAJfIB5ajzxSX4nQ2/S7adZ70eeKOtJclKmWaUaR5oRNh/7flEeu++EznJ3g
         MtXdFSLbnC+CYPEbiVxPFhIdMsoMrVOJQtWpPE6QAPL6BNKUyUf01TRAiu4XWpLL1B14
         sTx5JLpl6n9rgX9XrlfOtP/uksKsp6Yf882yrZ0C39f9Ywdf70+cSke4LsFqFDZ6ej/p
         BgmPPCovdj8x2DjAv0yZFQHjDO49JVXjNF79noc2XHAhE+3YQykeyEoxWiTDLsnbRmSO
         vfvWOVc6ZvHM25ApK40DC6wV4TBXr4qBlrLN9/P/FXNaxpIjmZ98PjG8HwQJqXriY3sE
         Y7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yWP4cdhQQweoyndiS9c4M1AVjAXnxjPoB9KeWmOMmd0=;
        b=HpnUHn/l9lEjJlB3YLlxX86lRtXMzJJFPKlGzJ2dZfi3UD+vck0FXXP0qCEN4QAVON
         2ZTTkLh62+qQIhT5bE2Agu9o7BRONmGGciWa3/Ra6JSp5IX3yFj0/iA3axJsXt2HeevQ
         +H7EhEDLqfJsTkGhCMh9o0N88T/1oRBUV16PwvWAWnRr23CywCLUAnyRjgYF7B8jILDi
         SumFw2GQiecNgtMj3bpAginLn9tVdsz4by+UT5qPfGhGk2mQ02/Ys3MtBrVVHwJw5VlU
         jg1T74poZ3skAdyQztUSLRGMZQhn003KjbPdQgHmIrzSQjl1PqtqBLVfFfyGMQGa/s8b
         KoCA==
X-Gm-Message-State: AOAM531BMFHLHCVl+rlB5F91HQolxzIzyfY+MjUwXFANBJhQie6azLTZ
        +2Eeb822vSUPC/RKEP1RNYZ2RqUip2/3SA==
X-Google-Smtp-Source: ABdhPJyt1Y8+PphilGn11YXoYu7s2dlGvUUbY04VxO6hflBy03z/KFS+ibd9mlV/jGQm1UF4OFq7jQ==
X-Received: by 2002:a05:6a00:2353:b029:1ba:d824:f1dc with SMTP id j19-20020a056a002353b02901bad824f1dcmr988611pfj.9.1612319998350;
        Tue, 02 Feb 2021 18:39:58 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id t206sm282772pgb.84.2021.02.02.18.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 18:39:57 -0800 (PST)
Subject: Re: [PATCH] Revert "bfq: Fix computation of shallow depth"
To:     Lin Feng <linf@wangsu.com>, Jan Kara <jack@suse.cz>
Cc:     paolo.valente@linaro.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20210129111808.45796-1-linf@wangsu.com>
 <20210202122836.GC17147@quack2.suse.cz>
 <f92a55b4-0743-a700-8296-e739f4fcf093@kernel.dk>
 <9747bada-05f8-b08a-ced6-f14874b89024@wangsu.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <54fb0427-b1f0-7005-60a8-021237fbe19a@kernel.dk>
Date:   Tue, 2 Feb 2021 19:39:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9747bada-05f8-b08a-ced6-f14874b89024@wangsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/2/21 7:36 PM, Lin Feng wrote:
> Hi all,
> 
> On 2/2/21 22:20, Jens Axboe wrote:
>> On 2/2/21 5:28 AM, Jan Kara wrote:
>>> Hello!
>>>
>>> On Fri 29-01-21 19:18:08, Lin Feng wrote:
>>>> This reverts commit 6d4d273588378c65915acaf7b2ee74e9dd9c130a.
>>>>
>>>> bfq.limit_depth passes word_depths[] as shallow_depth down to sbitmap core
>>>> sbitmap_get_shallow, which uses just the number to limit the scan depth of
>>>> each bitmap word, formula:
>>>> scan_percentage_for_each_word = shallow_depth / (1 << sbimap->shift) * 100%
>>>
>>> Looking at sbitmap_get_shallow() again more carefully, I agree that I
>>> misunderstood how shallow_depth argument gets used and the original code
>>> was correct and I broke it. Thanks for spotting this!
>>>
>>> What I didn't notice is that shallow_depth indeed gets used for each bitmap
>>> word separately and not for bitmap as a whole. I'd say this could use some
>>> more documentation but that's unrelated to your revert. So feel free to add:
>>>
>>> Reviewed-by: Jan Kara <jack@suse.cz>
>>
>> I don't have the original patch (neither directly nor in the archive), so
>> I had to hand-apply it. In any case, applied for 5.11, thanks.
>>
> 
> Take a look at linux-block.git tree, the hand-applied commit for this patch
> is broken, the following changing line is left out:
> -	bfqd->word_depths[0][1] = max((bt->sb.depth * 3) >> 2, 1U);
> +	bfqd->word_depths[0][1] = max(((1U << bt->sb.shift) * 3) >> 2, 1U);
> 
> Sorry for making troubles to you, I will resend this patch with tiny commit
> log typo fix(sbimap -> sbitmap) and attaching Jan's Reviewed-by, also thanks
> his time for reviewing.
> 
> Hope this time lkml server will not block my patch.

Thanks for checking - just send me an incremental and I'll fold it in.

-- 
Jens Axboe

