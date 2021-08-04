Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EFAC4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 18:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF0E60FC4
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 18:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhHDSEe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 14:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhHDSEd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 14:04:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35C1C0613D5
        for <linux-block@vger.kernel.org>; Wed,  4 Aug 2021 11:04:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ca5so4157500pjb.5
        for <linux-block@vger.kernel.org>; Wed, 04 Aug 2021 11:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iyLe0Y1BfElrhcpvVPQ33sfiugWpHZZQOzQxvESOTPI=;
        b=VvDeSnEWVT68pViFiX4NZEKkx3MZaxpsHaEXbum1C1nIpY8f1MAr0X8bXfRar2IFsa
         OMuKDhVtAI9+gfb3MGH2qzGD+ZRyYpjPSSY72FaniqJH8Wgubv58/sOY0Gnsc0iFo7Sl
         5a279RRxSlETAG8/FPLKghM0gPpVZmj7hyLRGin+Yt2RLThnKmtL6PJcR1eUsGdejY49
         9tM1smdyofFwLR2hWgZi+Vz8WiRZKiLEddPG95O3R+YXav7kn6StD0cICuTDzbft3Bsn
         quNbYv+f601Zm+7foQeSnVFgp/k4JbKBQkmhlar9/B42Xf77JfgW5OwY6jiJBDhpGztC
         UsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iyLe0Y1BfElrhcpvVPQ33sfiugWpHZZQOzQxvESOTPI=;
        b=fpSO85sfKzJkeVRmSUtAG1BoqO0DOR7JIAkdSBnJaWRc1nluoWZ018jDY7VGSCU/RA
         GJj51AquaVjZzcg69n/W55bG2rAOfWOaNZr9XwsYonaxsGLwDIhOwuAJtlflxF1vQONZ
         vclq91E24Ik7xAx4eAb/slt3Z9fEOzSqcQKpCGjUCPf0dG0+M28kWcUjXWMGP8pYHNEU
         00JMUkE1aipjyZ0/Eg2GZgoD5A72qzusjiRZnIeChEbjIAzVW9QNIKovP4IKCe+r1Kug
         nUjAZ0veRneleXuvQuDma/rjrC0YkwGto/jpe4XbQGPPmQXnGuCK/9dE6yYrgEE37FXx
         NrdA==
X-Gm-Message-State: AOAM531Bd/wrUZr9Bj+yjFcfFiDOtjhBVuAGjdgisGPh0GSaqDBiJtxt
        TkViYE0nhqDQUiAygEfOL+hLzg==
X-Google-Smtp-Source: ABdhPJw/Dw3tUzeZU9eubSKBiiYTPuxaSZWqMFD5ThIMSF4OY3g1MxFNZEEfLXxM6fZwV6+EEWfWqA==
X-Received: by 2002:a17:90a:3d0d:: with SMTP id h13mr403692pjc.20.1628100259446;
        Wed, 04 Aug 2021 11:04:19 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id o8sm3244514pjm.21.2021.08.04.11.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 11:04:18 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] loop: Select I/O scheduler 'none' from inside
 add_disk()
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Martijn Coenen <maco@android.com>
References: <20210803182304.365053-1-bvanassche@acm.org>
 <20210803182304.365053-3-bvanassche@acm.org> <20210804053527.GA5711@lst.de>
 <c6337526-8f25-7efc-96ff-fbfe054fe9c0@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5fa2fc32-ad90-14c6-bb42-b0d7b5189ff6@kernel.dk>
Date:   Wed, 4 Aug 2021 12:04:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c6337526-8f25-7efc-96ff-fbfe054fe9c0@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/4/21 11:58 AM, Bart Van Assche wrote:
> On 8/3/21 10:35 PM, Christoph Hellwig wrote:
>> On Tue, Aug 03, 2021 at 11:23:03AM -0700, Bart Van Assche wrote:
>>> We noticed that the user interface of Android devices becomes very slow
>>> under memory pressure. This is because Android uses the zram driver on top
>>> of the loop driver for swapping,
>>
>> Sorry, but that is just amazingly stupid.  If you really want to swap
>> to compressed files introduce that support in the swap code instead of
>> coming up with dumb driver stacks from hell.
> 
> Hi Christoph,
> 
> That's an interesting suggestion. We can look into adding compression 
> support in the swap code.
> 
> Independent of the use case of this patch, is it acceptable to change 
> the default I/O scheduler of loop devices from mq-deadline into none 
> (patches 1 and 2 of this series)?

Probably does, there's always going to be underlying storage for it
anyway.

-- 
Jens Axboe

