Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF4AC77B7A
	for <linux-block@archiver.kernel.org>; Wed,  7 Jun 2023 09:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbjFGJFf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239898AbjFGJFB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jun 2023 05:05:01 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92DD19AA
        for <linux-block@vger.kernel.org>; Wed,  7 Jun 2023 02:04:04 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1b3836392so61472421fa.0
        for <linux-block@vger.kernel.org>; Wed, 07 Jun 2023 02:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20221208.gappssmtp.com; s=20221208; t=1686128643; x=1688720643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D12qzdeZNd8GDlu1l78nzRV3Jc1c4SuEUMofWsnmbvI=;
        b=wlviFvKYLXLxEr/6N1q2CTRXb3v4BIHJn2u7orG9cNV1k8Oe7EI1zHkYunbIgRAg3z
         S/DsUGbMslLHmfxBoKRxttggTnBVpYtMDSxBBaTu7NzJ71m3zLU7KbCpOTdeRc1OOH3L
         ZLlaHEn0WK0lHfZJpOoVKFHFaWmYN1blF8GdZOqci+ISFQDbbxb6kjATtWFmdr6/kQrw
         DsJRWegw9mHEOrVzE4NtoiCWk38dBS4C0upbBpyUNyqEtu8sIFapjxtxUAbwv/rNqc3M
         VcUtf4GPCFSffGXLOAIFwR7Fm3v+XZt1HMtC6PFSzPRCx/M7aPzVa1/PTdjUyFmq0onr
         nwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128643; x=1688720643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D12qzdeZNd8GDlu1l78nzRV3Jc1c4SuEUMofWsnmbvI=;
        b=F2yS3rV2MuIot1kdKvCsva/clv538m44aDupSrhFxAX42TXX7UidayqzOwuXMBrtnH
         nZ2mZkpOqJNVhJ7SItx5Oso05goDOwNT/3kk5j0Gvyfj8CngLNinIwusp2ymx5VPeSUq
         9Y4SxJdr/XnIprstEYft09e6NKJCcUcVko59VQp7V120Yec260SUO4g0gb5C6hHtR6Jk
         zKTv+KUP4BzPp4+IChwscA4qDCtMCHRzBICszQaRpU4b1Zq1D51DOTrtKWov6NmShzlh
         RFp/DrxOJlMJ0ykrRlKn7JsiEvQlpHM5S4KLn6+0vTtcWQ+kDKLGDUOao8T126oxx857
         ceFQ==
X-Gm-Message-State: AC+VfDznqBlKtBJ6W4kccgdnVCYuFyXO2sjicr7qFkwJglEGiufDhmyg
        nYdDbiEMfomlc3oUUzUjeDRBzJdy3ukka9H0HGJcatCEiBw4t2hcjpw=
X-Google-Smtp-Source: ACHHUZ5jN3ACvIdOWdg2s/MhHapRZwnGqVJzcVYNYWWkzJFMHDCfGILmuG1SKQ4vzw+ua0iV5v9djciKETVbsLv3HDY=
X-Received: by 2002:a2e:6e13:0:b0:2ac:81c3:55eb with SMTP id
 j19-20020a2e6e13000000b002ac81c355ebmr2025074ljc.28.1686128643076; Wed, 07
 Jun 2023 02:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <CALqELGxfvF-YuU_K7709nN=LPkr5AWQe9ypGH2JZkPosORg9rw@mail.gmail.com>
 <d280e5cc-1114-b65b-83de-a9406d99071c@kernel.org>
In-Reply-To: <d280e5cc-1114-b65b-83de-a9406d99071c@kernel.org>
From:   Andrew Murray <amurray@thegoodpenguin.co.uk>
Date:   Wed, 7 Jun 2023 10:03:52 +0100
Message-ID: <CALqELGx_o-XUa_V9Ap7dSR0AUAQm5TuNNFa9dEYHr6nRbirpLQ@mail.gmail.com>
Subject: Re: Slow random write access
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 7 Jun 2023 at 03:54, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 6/6/23 20:37, Andrew Murray wrote:
> > Hello,
> >
> > I've been working with an embedded video recording device that writes
> > data to the exfat filesystem of an SD card. 4 files (streams of video)
> > are written simultaneously by processes usually running on different
> > cores.
> >
> > If you assume a newly formatted SD card, then because exfat clusters
> > appear to be sequentially allocated as needed when data is written (in
> > userspace), then those clusters are interleaved across the 4 files.
> > When writeback occurs, you see a cluster of sequential writes for each
> > file but with gaps where clusters are used by other files (as if
> > writeback is happening per process at different times). This results
> > in a random access pattern. Ideally an IO scheduler would recognise
> > these are cooperating processes, merge these 4 clusters of activities
> > to result in a sequential write pattern and combine into fewer larger
> > writes.
> >
> > This is important for SD cards, because their write throughput is very
> > dependent on access patterns and size of write request. For example my
> > current SD card and above access pattern (with writes averaging 60KB)
> > results in a write throughput for a fully utilised device of less than
> > a few MB/S. This may seem contrary to the performance claims of SD
> > card manufacturers, but those claims are typically made for sequential
> > access with 512KB writes. Further, the claims made for the UHS speed
> > grades, e.g. U3 and the video class grades, e.g. V90 also assume that
> > specific SD card commands are used to enter a specific speed grade
> > mode (which isn't supported in Linux it seems). In other words larger
> > write accesses and more sequential access patterns will increase the
> > available bandwidth. (The only exception appears to be for the
> > application classes of SD cards which are optimised for random access
> > at 4KB).
> >
> > I've explored the various mq schedulers (i'm still learning) - though
> > I understand that to prevent software being a bottleneck for fast
> > devices each core (or is that process?) has its own queue. As a result
> > schedulers can't make decisions across those queues (as that defeats
> > the point of mq). Thus implying that in my use-case, where
> > "cooperating processes" are on separate cores, then there is no
> > capability for the scheduler to combine the interleaved writes (I
> > notice that bfq has logic to detect this, though not sure if it's for
> > reads or rotational devices).
> >
> > I've seen that mq-deadline appears to sort it's dispatch queue (I
> > understand a single queue for the device - so this is where those
> > software queues join) by sector - combined with the write_expire and
> > fifo_depth tunables - then it appears that mq-deadline does a good job
> > of turning interleaved writes to sequential writes (even across
> > processes running on different cores). However it doesn't appear to
> > combine writes which would greatly help.
> >
> > Many of the schedulers aim to achieve a maximum latency, but it feels
>
> maximum throughput... Maximizing latency is not something that anyone wants :)

I didn't phrase that well, I was referring to the ability to specify a
worse case latency, for example the write-expire tuneable in
mq-deadline and the fifo_expire_sync tuneable in bfq. I guess there is
often a tradeoff between throughput and latency (for example the
low_latency mode of bfq) - if you can hold on to IO requests for
longer, then you may have a better ability to reorder and combine them
which can improve throughput on devices that are sensitive to IO size
and ordering.


>
> > like for slow devices, then a minimum write latency and ability to
> > reorder and combine those writes across cores would be beneficial.
> > I'm keen to understand if there is anything I've missed? Perhaps there
> > are tuneables or a specific scheduler that fits this purpose? Are my
> > assumptions about the mq layer correct?
> >
> > Does it make sense to add merging in the dispatch queue (within
> > mq-deadline), is this the right approach?
>
> Try with "none" scheduler, that is no scheduler at all.

This won't improve throughput for the use-case I described.

As I understand, with scheduler "none", then the software queues
(associated with each core) will get dispatched directly to the single
(in my case) queue for the device. The block layer may perform very
simple merges on entry to the queues - but without an IO scheduler
nothing more advanced will be performed. As writes are interleaved
across queues then this merging is ineffective. This results in small
interleaved writes - I'm looking for a way to coax Linux to reorder
(which I can see the mq-deadline scheduler does in the context of a
single hardware queue) and combine the reordered requests. With the
view that this will result in more sequential writes of a larger block
size (which most SD cards are happier with).

Thanks,

Andrew Murray

>
> >
> > Thanks,
> >
> > Andrew Murray
>
> --
> Damien Le Moal
> Western Digital Research
>
