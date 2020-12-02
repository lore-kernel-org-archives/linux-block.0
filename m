Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D6CC64E7C
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 16:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D5D2053B
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 16:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgLBQsv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 11:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgLBQsv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 11:48:51 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96510C0613CF
        for <linux-block@vger.kernel.org>; Wed,  2 Dec 2020 08:48:05 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id z5so2567825iob.11
        for <linux-block@vger.kernel.org>; Wed, 02 Dec 2020 08:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ol3Q5QFZA81+FhWWolOBgRbxm5fm9KZ2929mrul4800=;
        b=BoCledKWaE4uuWSuHxn7Nuq86OCaGvhfDI1EEfXMcC2DePc137vNpAk8abiVnkuOrY
         rWyQ4D4wD1HYzBbXFlnno2sgWo8MxMIpARVR1WQj9zwkncbydKVLIKHwFBIaNNu/BJ3D
         UjOdaGTW3SCweTxjUBWamX4twLy3aENgXGFmWpXQdCIQm9beqjXP4d367sgk5aiyViQk
         Yl7lbeWEartwPFWcCzL/ELQVaXO8R9i4KIENoxWkn7z9JSztW2UFK0jxHEn9ExwukiBY
         VaW9KriE+HraYutVs5NKM9zlocjP3mc2Hp7UBVOwSRez6H0uUDN0mMIm608080OdwdGu
         ECiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ol3Q5QFZA81+FhWWolOBgRbxm5fm9KZ2929mrul4800=;
        b=J29d5OAgei4dMJ5yPuwOZaU1mTTtAQ0ks9jFwrJaAuZhtwLyL/SdeQ1IVb/Bj6p2eH
         l4twytnMDE56wGM2aRTd6bjC9YR0mWzsUAyR8m3rVoXeEyt28pmwF5WyCW3aSBflvihK
         yPW2nG4KCV9xRNBf3BruRdt1HzGDut1cxObbZXEgnXN5oIoYkkE0zvzyDMCziEglu3t+
         VoAM2zWll9lyTc5CqlJydN0RrxBdcpbMsW6kGHeebm63D7SFew1oxKV3LETfxRksTyLN
         jViXBpw9prKu9Rkl5kZVsTvR6UT7gvtOAT3fAXmIFIfQqPG4DQmXXD36IoQ2jgaukKXR
         d7NA==
X-Gm-Message-State: AOAM531VNCcNi1K8e+XyQhk9gAAa+v0PR5JWjPzPINV7t61WjKWpd7+F
        egmXqLKlPUXXilp8yG8sYxrngNuXvCSB+w==
X-Google-Smtp-Source: ABdhPJyN/Ic9hBtZ9Qob32Y7t9aP65fWqFYkt9iyQjzHWnd3WK7XCGtZIfVHe01RMVADGy5w5AmPeg==
X-Received: by 2002:a02:9002:: with SMTP id w2mr2916580jaf.111.1606927684780;
        Wed, 02 Dec 2020 08:48:04 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a13sm1389371ilh.0.2020.12.02.08.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 08:48:04 -0800 (PST)
Subject: Re: [PATCH v2] block: fix inflight statistics of part0
To:     Christoph Hellwig <hch@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Cc:     joseph.qi@linux.alibaba.com, linux-block@vger.kernel.org
References: <20201202111145.36000-1-jefflexu@linux.alibaba.com>
 <4317c6c9-886f-c921-70c1-ccc12ba6ae79@linux.alibaba.com>
 <20201202112050.GA2201@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <699798e0-6b38-105f-aacc-938f3ecd6ce4@kernel.dk>
Date:   Wed, 2 Dec 2020 09:48:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202112050.GA2201@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/2/20 4:20 AM, Christoph Hellwig wrote:
> On Wed, Dec 02, 2020 at 07:17:55PM +0800, JeffleXu wrote:
>>> Fixes: bf0ddaba65dd ("blk-mq: fix sysfs inflight counter")
>>> Fixes: f299b7c7a9de ("blk-mq: provide internal in-flight variant")
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>>> ---
>>> v2: update the commit log, adding 'Fixes' tag
>>
>> Forgot to add 'stable' tag.
> 
> The fixes tags take care of that automatically.
> 
> Note that this patch will cause a merge conflict with my work in
> linux-next, but the resolution is pretty trivial.

Might be better to handle on the stable side, and just apply this to
5.11. It's not a new regression.

-- 
Jens Axboe

