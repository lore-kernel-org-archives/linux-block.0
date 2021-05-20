Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24818C433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 15:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C4D613C1
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 15:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhETPHL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 11:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbhETPHL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 11:07:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EE0C06175F
        for <linux-block@vger.kernel.org>; Thu, 20 May 2021 08:05:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a4so18065728wrr.2
        for <linux-block@vger.kernel.org>; Thu, 20 May 2021 08:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RLEDbktj5bRyh4+JP4j8AjoV+IDl4w3B2t8kuc3G64I=;
        b=VRdcSL8FxVkwiEit3vGgSTkMN1gb6Dm5LEONe3JZ1zm9818tvvdO9q1fcq6jhZ5TDp
         mwTzJO3tUehCSMUba6S8PTsoG/j1HpfNlVwLFz9pOwbNj35VfPdI79Q7C1cJPfA+GheP
         xhTgEbPHc25fAk+o+igIGakNp0T91aGg7577aC9dKBzTgxCDlaih8IvALKU7RpzP6Kqu
         xbNqy8YJutKmEFJN8Q6xwGjUt2i91EN6AY+RsaXjZTb53kmcOguxh6fGgPpTPPIy5mqe
         g4q9QOs640aR4Udqdj7pitNS6IdKwD7d1kS9285k5SAbKN0Q3EH6AT26Rx9OXzpmSFGF
         3l0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RLEDbktj5bRyh4+JP4j8AjoV+IDl4w3B2t8kuc3G64I=;
        b=ZQZob3RhNxwvZFUgEg8hACNfKIQoudAbEmczkjXTV2lF4mDgm0kW0Ja+RGu2gyuNFt
         KRSVPHB7YrWaBjy94sBZUHMfxuHRDE5Gy8C++NMinNNTlb1mBnzFcPIJ5VuCtM9TppyK
         nlV3G+A7HmHtJo6dUV9Zs1rPMmz9TFCzrPL/N0BuSRHvElsabriQtRijmsZ6077VUxMY
         /Q1cuUSnE6xP50pMKB9GMXutsOs1ifF+PubrI6+LAEUUZVF+hs7wYxD0X8uOOG20PGUO
         IdX6UAh34s06/ryxGlm3PZ9J5P/hbhitVa7+ENj719uwIx9K49v0BN0WOoJ/ho/CPXQi
         2Nrw==
X-Gm-Message-State: AOAM530yrDE3FTDJNhXbIyDqdvm2/WUET2chNyQ/mz9pPIUi72bilD6u
        jkgUUm4oReEHvW1IYek3KGEKkQZ+EZhfSfsJ
X-Google-Smtp-Source: ABdhPJwI0zDKQ/lRZQAxNS3J/gBwNypUCWq5nIxVR36SdsW1FAx4KprX/f06lGBZAtXtkHxpkZN1Wg==
X-Received: by 2002:a5d:4ac6:: with SMTP id y6mr4765780wrs.414.1621523148229;
        Thu, 20 May 2021 08:05:48 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id z66sm10386972wmc.4.2021.05.20.08.05.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 May 2021 08:05:47 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: False waker detection in BFQ
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210505162050.GA9615@quack2.suse.cz>
Date:   Thu, 20 May 2021 17:05:45 +0200
Cc:     linux-block@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <FFFA8EE2-3635-4873-9F2C-EC3206CC002B@linaro.org>
References: <20210505162050.GA9615@quack2.suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 5 mag 2021, alle ore 18:20, Jan Kara <jack@suse.cz> ha scritto:
> 
> Hi Paolo!
> 
> I have two processes doing direct IO writes like:
> 
> dd if=/dev/zero of=/mnt/file$i bs=128k oflag=direct count=4000M
> 
> Now each of these processes belongs to a different cgroup and it has
> different bfq.weight. I was looking into why these processes do not split
> bandwidth according to BFQ weights. Or actually the bandwidth is split
> accordingly initially but eventually degrades into 50/50 split. After some
> debugging I've found out that due to luck, one of the processes is decided
> to be a waker of the other process and at that point we loose isolation
> between the two cgroups. This pretty reliably happens sometime during the
> run of these two processes on my test VM. So can we tweak the waker logic
> to reduce the chances for false positives? Essentially when there are only
> two processes doing heavy IO against the device, the logic in
> bfq_check_waker() is such that they are very likely to eventually become
> wakers of one another. AFAICT the only condition that needs to get
> fulfilled is that they need to submit IO within 4 ms of the completion of
> IO of the other process 3 times.
> 

Hi Jan!
as I happened to tell you moths ago, I feared some likely cover case
to show up eventually.  Actually, I was even more pessimistic than how
reality proved to be :)

I'm sorry for my delay, but I've had to think about this issue for a
while.  Being too strict would easily run out journald as a waker for
processes belonging to a different group.

So, what do you think of this proposal: add the extra filter that a
waker must belong to the same group of the woken, or, at most, to the
root group?

Thanks,
Paolo

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

