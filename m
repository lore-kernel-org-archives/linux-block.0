Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E74C433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 23:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhKWXNd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 18:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhKWXNc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 18:13:32 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCACC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 15:10:23 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id r2so642022ilb.10
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 15:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eQlW1m7dYAO2QOxbibpBsG9HIqx8JU8W8P0aT2JPVdA=;
        b=RkrQqkhEA99guCkuR2sH2hFlGif0NcOnYwCkOpxdqg5GH2kuXZWZCNwnVzT/1lUWHM
         Srb3scWRoInwSmNnocPFsmf7jOwNo/0uhJYz7Q8JCyCmcdJxQuVGD3Valc2Ezp564aj0
         /kBdSpcPJm3OYkI/1nlAwMl/bRP/ZrzkZu5x4qzt4BYmGkI2lWlTVpBkJ1OoGjT+cDEN
         i0CwwvWi7vN5HdphI3thYHqPjz04s8cMaN38USgkr5DnxphvGyJLXG76mfI42q/2db5Z
         zDoUYJRKNtPfLDL3ySSi3ztTyojqpu2rWAUBKiqgJZna6ROCOFTJz2eDne4Mqz/BzpIz
         uZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eQlW1m7dYAO2QOxbibpBsG9HIqx8JU8W8P0aT2JPVdA=;
        b=M9eyoHLa9cgmK8KLI3ec/BgyaQbM6rn31oKHhythc+dB2ASgS53R0Dh9G16FPzCGND
         RBRHLBzoHr1U8ORJk/TsPimsnAWpoxAa1K1CiD4F7zbyeYdOzL+tTL4RC3UTgH37ltnP
         qHnkG7bplRTH7bWt+L7XV4S7qngSney9mUlBH5wTNEZRgkHwlG1Km7Wd6VBqG7a+IZOr
         1/kI3/ly+BSwzX8Hh0wGx31tTqF4i5IlF2wdMrHUIIPP4tdXmoApa5P0V6piZobL4nbu
         2Doi2FgIe6vI1vsK6dJbDvv6tDa9+vdoTLFxlypGm8unGQySSooOigdrE7/vKe5pu0Zf
         H6Ug==
X-Gm-Message-State: AOAM533JkLFWB08XGrujm4GU+idtc1qh37gQDxD6zxi1vj6i+GkT049G
        2cqnA/+3EJ279LQc1XUJHkgpAA==
X-Google-Smtp-Source: ABdhPJw8f1SZYxb8UuynxBcQPnJr3fIAEa3tzIGFdlvc8X6PWuAmMUsvMZUwPLL3FG2uB7xNmZBBsQ==
X-Received: by 2002:a05:6e02:1b09:: with SMTP id i9mr9475768ilv.156.1637709023042;
        Tue, 23 Nov 2021 15:10:23 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b8sm6363862ilj.0.2021.11.23.15.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 15:10:22 -0800 (PST)
Subject: Re: [PATCH 1/8] block: Provide icq in request allocation data
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
References: <20211123101109.20879-1-jack@suse.cz>
 <20211123103158.17284-1-jack@suse.cz>
 <4cae86cc-e484-cb91-7189-0afbe84f69b9@kernel.dk>
 <20211123223045.GC8583@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f4bb858a-bb9e-fec3-4ac6-16960879783e@kernel.dk>
Date:   Tue, 23 Nov 2021 16:10:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211123223045.GC8583@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/21 3:30 PM, Jan Kara wrote:
> On Tue 23-11-21 09:06:47, Jens Axboe wrote:
>> On 11/23/21 3:29 AM, Jan Kara wrote:
>>> Currently we lookup ICQ only after the request is allocated. However BFQ
>>> will want to decide how many scheduler tags it allows a given bfq queue
>>> (effectively a process) to consume based on cgroup weight. So lookup ICQ
>>> earlier and provide it in struct blk_mq_alloc_data so that BFQ can use
>>> it.
>>
>> I've been trying to clean this path up a bit, since I don't like having
>> something that just one scheduler needs in the fast path. See:
>>
>> https://git.kernel.dk/cgit/linux-block/commit/?h=perf-wip&id=f1f8191a8f9a0cdcd5ad99dfd7e551e8f444bec5
>>
>> Would be better if we could avoid adding io_cq to blk_mq_alloc_data for
>> that reason, would it be possible to hide this away in the sched code
>> instead on top of the above?
> 
> Understood. We could certainly handle ICQ allocation & assignment only
> inside BFQ. Just this would mean we would need to lookup ICQ once in
> bfq_limit_depth() and then second time in bfq_prepare_request(). I
> guess not a huge deal given the amount of work BFQ does for each
> request anyway.

Exactly, it's noise there, but would not be in the general core.

> So can I pull the above commit into the series and
> rebase this patch on top of it?

It's in my for-5.17/block, but might get rebased... For a series of
patches like this, basing on it would be fine though, and you should
just do that.

-- 
Jens Axboe

