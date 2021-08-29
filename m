Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8914AC4320A
	for <linux-block@archiver.kernel.org>; Sun, 29 Aug 2021 12:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD1B60698
	for <linux-block@archiver.kernel.org>; Sun, 29 Aug 2021 12:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhH2MxY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Aug 2021 08:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbhH2MxX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Aug 2021 08:53:23 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B20C061575
        for <linux-block@vger.kernel.org>; Sun, 29 Aug 2021 05:52:31 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b200so15804799iof.13
        for <linux-block@vger.kernel.org>; Sun, 29 Aug 2021 05:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ElxFKhoOE+2l4ZsT/KhkpXvb6ACO/HEvPuyEWsCkQM8=;
        b=Ggg03/kfxdZN+ZLPSyer9S/ZbaQq9btIVZvpNl5xLCEFGo26Pa2LXcBYwv7Sc0ravl
         eKRaU05MQEw28Y3x4aSN5kmg4yPMFP2kZ8Gw0ylHk7Dm25lkkmo9p/z6TF5SQnhbUY8R
         DB+6ldLY+G5Ge3AumD/iQ7rCIehnFB5gJ7nri1/rSOKxdkPQB/qjWMGQaoNsdOiSXQaE
         Mn+or5B+6kNTqbe379Yk7QxwUrWtMrn5rlph+kxbW08Eh6iErNwNYYY8CVdVGrxbX/TK
         dOETcFJMa1X8DrBWm8cjtwwOfGkPmAQXQAmwMkAbZi5pKkqwQYKUqVFqOKfm3FJXS3YZ
         YPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ElxFKhoOE+2l4ZsT/KhkpXvb6ACO/HEvPuyEWsCkQM8=;
        b=NNql661/lZCNl/MGidw7zIVmRgy7vZuH5WaM7Dc7Q+ErHVGCm8ZABYMT5xQtV1zzDo
         S2+WFCNMJSN5izaKIxkcO5YbRfU4iiddP+OEtGH69ba8wZqdxr9Rmse8zslVlQM7NvF2
         kZZQdL0ko2hLjevawMyZ8aJokN8UIBR0/Dms+7JmRIx92jw+nvcAKqWKOXmNvVOR6j+0
         CvQm05yx+vCvDxzhssnne4DfHGoZYzeIVrFMPb0azVtW1b816WV3bvwTAKSzhqU+jJ4W
         +zAGo5W4tZLhqz7RXyfjdfNmRmlPFVFJqf+aaHXRglC/a1q+cbXwBLVZ7h9+BW68jcMe
         CByw==
X-Gm-Message-State: AOAM533wlaz0CYMn4jyfoYeMWlfzhJRQscQnAA8+x+jdYXnSDZFFY0Ux
        kD0FAbKvOhWldraBMo/HFYE9XTMCbA2EHQ==
X-Google-Smtp-Source: ABdhPJz6atu6JZqEKksoXeuyPHoMtFp7ARRNfjv9p6nlbG5PW8/420blpHQWNxLcXRUGky/KqbHGiQ==
X-Received: by 2002:a05:6638:974:: with SMTP id o20mr15941659jaj.10.1630241551077;
        Sun, 29 Aug 2021 05:52:31 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id x1sm6877311ilg.33.2021.08.29.05.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 05:52:30 -0700 (PDT)
Subject: Re: [GIT PULL] Floppy patch for 5.15
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-block@vger.kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>
References: <388418f4-2b9a-6fed-836c-a004369dc7c0@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0d3e8324-18ee-32c4-f666-21971bd8f334@kernel.dk>
Date:   Sun, 29 Aug 2021 06:52:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <388418f4-2b9a-6fed-836c-a004369dc7c0@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/29/21 4:08 AM, Denis Efremov wrote:
> Hi Jens,
> 
> Sorry for the late PR this time. I'll resend it later if it's too late for
> your for-5.15/drivers branch. Thanks.

Given the patch in question, let's just do it. I've pulled it, thanks.

-- 
Jens Axboe

