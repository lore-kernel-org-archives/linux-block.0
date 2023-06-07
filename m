Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4A4C7EE2F
	for <linux-block@archiver.kernel.org>; Wed,  7 Jun 2023 02:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbjFGCyl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jun 2023 22:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjFGCyk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jun 2023 22:54:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD06173B
        for <linux-block@vger.kernel.org>; Tue,  6 Jun 2023 19:54:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52803635C3
        for <linux-block@vger.kernel.org>; Wed,  7 Jun 2023 02:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0E1C433EF;
        Wed,  7 Jun 2023 02:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686106478;
        bh=ILgU1UxJPPw2U0e8MJPoERmpdDm5/OX9dTwMe5P6TYA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Ese1MqB2ST20jI5fz9R3RdkCdvkwtYRoG7o1J4IdlEPfAKwh//3wrtThB/5U87fmv
         neK3oLh5ShlzrSO2dzNFnapsXwcMG8TvYEPG4s3wQB3SINx/ENbc13+LxkUc3zQQpc
         Hr1ZAiRUyHfjX/rgsJI+WbLPe8ZRwaQXzfHlsd9iXTPh2fZhXm+XkK63M+igprs70P
         MZeytg3FU4UvzA5ZABKJPJImtxsp9sfnp2Gzc8nS/z8O9xArLbwf8HEfaVeRUrFl2B
         2aUTX17zYeen2hfcs5273ZtuOtA4qhEy8zFv7+yNNRaV6AMGYZzI3iQJ8A+is7en9y
         HMbm5PGsReH9w==
Message-ID: <d280e5cc-1114-b65b-83de-a9406d99071c@kernel.org>
Date:   Wed, 7 Jun 2023 11:54:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Slow random write access
To:     Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-block@vger.kernel.org
References: <CALqELGxfvF-YuU_K7709nN=LPkr5AWQe9ypGH2JZkPosORg9rw@mail.gmail.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CALqELGxfvF-YuU_K7709nN=LPkr5AWQe9ypGH2JZkPosORg9rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/6/23 20:37, Andrew Murray wrote:
> Hello,
> 
> I've been working with an embedded video recording device that writes
> data to the exfat filesystem of an SD card. 4 files (streams of video)
> are written simultaneously by processes usually running on different
> cores.
> 
> If you assume a newly formatted SD card, then because exfat clusters
> appear to be sequentially allocated as needed when data is written (in
> userspace), then those clusters are interleaved across the 4 files.
> When writeback occurs, you see a cluster of sequential writes for each
> file but with gaps where clusters are used by other files (as if
> writeback is happening per process at different times). This results
> in a random access pattern. Ideally an IO scheduler would recognise
> these are cooperating processes, merge these 4 clusters of activities
> to result in a sequential write pattern and combine into fewer larger
> writes.
> 
> This is important for SD cards, because their write throughput is very
> dependent on access patterns and size of write request. For example my
> current SD card and above access pattern (with writes averaging 60KB)
> results in a write throughput for a fully utilised device of less than
> a few MB/S. This may seem contrary to the performance claims of SD
> card manufacturers, but those claims are typically made for sequential
> access with 512KB writes. Further, the claims made for the UHS speed
> grades, e.g. U3 and the video class grades, e.g. V90 also assume that
> specific SD card commands are used to enter a specific speed grade
> mode (which isn't supported in Linux it seems). In other words larger
> write accesses and more sequential access patterns will increase the
> available bandwidth. (The only exception appears to be for the
> application classes of SD cards which are optimised for random access
> at 4KB).
> 
> I've explored the various mq schedulers (i'm still learning) - though
> I understand that to prevent software being a bottleneck for fast
> devices each core (or is that process?) has its own queue. As a result
> schedulers can't make decisions across those queues (as that defeats
> the point of mq). Thus implying that in my use-case, where
> "cooperating processes" are on separate cores, then there is no
> capability for the scheduler to combine the interleaved writes (I
> notice that bfq has logic to detect this, though not sure if it's for
> reads or rotational devices).
> 
> I've seen that mq-deadline appears to sort it's dispatch queue (I
> understand a single queue for the device - so this is where those
> software queues join) by sector - combined with the write_expire and
> fifo_depth tunables - then it appears that mq-deadline does a good job
> of turning interleaved writes to sequential writes (even across
> processes running on different cores). However it doesn't appear to
> combine writes which would greatly help.
> 
> Many of the schedulers aim to achieve a maximum latency, but it feels

maximum throughput... Maximizing latency is not something that anyone wants :)

> like for slow devices, then a minimum write latency and ability to
> reorder and combine those writes across cores would be beneficial.
> I'm keen to understand if there is anything I've missed? Perhaps there
> are tuneables or a specific scheduler that fits this purpose? Are my
> assumptions about the mq layer correct?
> 
> Does it make sense to add merging in the dispatch queue (within
> mq-deadline), is this the right approach?

Try with "none" scheduler, that is no scheduler at all.

> 
> Thanks,
> 
> Andrew Murray

-- 
Damien Le Moal
Western Digital Research

