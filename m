Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDDEC433DF
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 21:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75519205CB
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 21:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597784568;
	bh=F9kPz14Ny7HQIlyBfFUu7EXS46q4jlz0biHyP3bbX5I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qqR+9Gx8PbEg8ZCIrHprGvYsFU69qGMHZdllJ1gFUEvdiJhBAkv2BtfTYuG7cEo7I
	 gsgEbeRStebZn/D9zsQKo5F9YvpHJi36+gqOr2Z1mZAKGpIS6gzeSwLAUvfIo/OCSy
	 TJyTD1o5wkTgqRFYpBL+ah6ysf9AshZ7yel8wSaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgHRVCr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 17:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHRVCr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 17:02:47 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF91C061389
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 14:02:46 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t6so22978845ljk.9
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 14:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QjxDFeJL3uqd+6em4nSwHG/s4baUYfLjhwPDfmfoDEg=;
        b=Z+wWWf0OzwIjlpxCx6NFBrne2WUrLm57UYNAu3HiEDDDr6SSslBEq92o5mhJ3Rtgm7
         OtZsK0Gun0ZBQQesa8uDBJonT8LvqRmBlmzKD3alMQd+zUa2MhA58Vg7W5yYG+U41U7m
         fXVv1SwPc6WFUlILRvJDCUDrNkhe92eRxqdDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QjxDFeJL3uqd+6em4nSwHG/s4baUYfLjhwPDfmfoDEg=;
        b=KBWxkePk7ASt37zHM80Xq1tqrk3d6/jPND37pV96JJhT+6VC7I46/Yu8sdRTuplhwI
         NVk6C/QV6zvXJoMnakMLMnwAHq0Lhc82GMyLRSj8VkCpzi/Ewg72EbfqKzXrbWzyPK1r
         vvY1NDeZMLMQM375fA0HkGlRR3/Frr/NrnThWtsTtRPQ7QHrT27YVp5Wd9wgRn1J7W5P
         5hLosEjJWAR9DOu32oVu24hzgxgAi0wxqPul74MDLp4FnLJDGFZb9I4uLRmxLxrfv/97
         kDIJNO3hiQ/+JUr4b1pZMr4g86AEwP8moOhK6daIamqpCqiQOHGVNfJy7K3gIpl7PDKN
         3lkw==
X-Gm-Message-State: AOAM5330f3Mebdk4TOTtt45XGuByZA8DHhvyVE4hp57/qci47dH599uw
        FFTO5hsCxzbj4zRYQk1ZyYgRmA5TMsPHIg==
X-Google-Smtp-Source: ABdhPJz13LFoEff1TqW4NeUYJfVcZN/P4dR8dpsf7nptMByLTYTXo0SdJqI+BNDnSrlRsR3GcC4sAA==
X-Received: by 2002:a2e:8ecc:: with SMTP id e12mr9704371ljl.33.1597784564741;
        Tue, 18 Aug 2020 14:02:44 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v1sm6170176ljg.60.2020.08.18.14.02.43
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 14:02:43 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 185so22962020ljj.7
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 14:02:43 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr9412922ljk.421.1597784563217;
 Tue, 18 Aug 2020 14:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200807160327.GA977@redhat.com> <CAHk-=wiC=g-0yZW6QrEXRH53bUVAwEFgYxd05qgOnDLJYdzzcA@mail.gmail.com>
 <20200807204015.GA2178@redhat.com> <CAMeeMh_=M3Z7bLPN3_SD+VxNbosZjXgC_H2mZq1eCeZG0kUx1w@mail.gmail.com>
In-Reply-To: <CAMeeMh_=M3Z7bLPN3_SD+VxNbosZjXgC_H2mZq1eCeZG0kUx1w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Aug 2020 14:02:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsz_w4zyJMHSL78MuOfxKcjDDfk2GfM2ZpjSjkOfzfwQ@mail.gmail.com>
Message-ID: <CAHk-=wjsz_w4zyJMHSL78MuOfxKcjDDfk2GfM2ZpjSjkOfzfwQ@mail.gmail.com>
Subject: Re: [git pull] device mapper changes for 5.9
To:     John Dorminy <jdorminy@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Alasdair G Kergon <agk@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ignat Korchagin <ignat@cloudflare.com>,
        JeongHyeon Lee <jhs2.lee@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        yangerkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 18, 2020 at 1:40 PM John Dorminy <jdorminy@redhat.com> wrote:
>
>    The summary (for my FIO workloads focused on
> parallelism) is that offloading is useful for high IO depth random
> writes on SSDs, and for long sequential small writes on HDDs.

Do we have any non-microbenchmarks that might be somewhat
representative of something, and might be used to at least set a
default?

Or can we perhaps - even better - dynamically notice whether to offload or not?

I suspect that offloading is horrible for any latency situation,
particularly with any modern setup where the SSD is fast enough that
doing scheduling to another thread is noticeable.

After all, some people are working on polling IO, because the result
comes back so fast that taking the interrupt is unnecessary extra
work. Those people admittedly have faster disks than most of us, but
..

At least from a latency angle, maybe we could have the fairly common
case of a IO depth of 1 (because synchronous reads) not trigger it.

It looks like you only did throughput benchmarks (like pretty much
everybody always does, because latency benchmarks are a lot harder to
do well).

                 Linus
