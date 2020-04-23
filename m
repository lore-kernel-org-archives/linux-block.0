Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83572C54FCB
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 15:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D92E20857
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 15:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="X6Zx5YlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgDWPIo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728921AbgDWPIo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Apr 2020 11:08:44 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23A6C08ED7D
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2020 08:08:43 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id 19so6691664ioz.10
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2020 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S0YFAaVW9uGpyIPdV24cufa1fusWbtOhedjvog9H8Ws=;
        b=X6Zx5YlWzB21Tsfi5n5HO3/21sczmsH8tmzy+3TDi9Mpn3vjeZLyVjDjt7aDVgeqIb
         QUu5y9hWWCNEKxIb66ityAp7Bx/UQsG5kqRlpcpMgjGCk+bQUGHiGS7+Gi10kRwkN78r
         7xjIe1SJhncMerUEflHKvEkLPLVgYvoTwKFwMn11nYMpCUKdUEqvoYgcPKKzYaTt6R/p
         0H23ajy9PIXVoZjQOO9+CKXpgxUqlml6zThPRb5RkL9hZOLVGipe9glnxYXfoyvOEISS
         tvmDuGHlB19Vgib7BS/C4gWi/GGNziOjnl1MCAxpEs1TFiHRJ8pBQBgM6SmWLpwnDDvf
         K7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S0YFAaVW9uGpyIPdV24cufa1fusWbtOhedjvog9H8Ws=;
        b=hobrJNov5LqnUuCsr43mf6stxZRyhYnDZHe0jTpC4PLnzYfxEFJ5cVwmVU5Qr7/gjB
         DMgYq+foZeLk6blsNQ68m+6oNoPq4wxP5j1RgVblVOI1QURZV0LEJrvOAozL049HDQyc
         mLWJIw9G4soGrGWgKKHMV8F70/+XWekoPt7pv5YsCrYvE1/B90d4S8/stLtjx5Y2Wpu/
         5be+AIKjVp3ko0jrNO6pXqJV0H5angfuatOYKx5cEwez7eljoMZh8Mys+6EOWOlR6g4A
         4bZyjSC4OJc6FuF17rsmme/iWWQhc2J8i6ZuoixtRZSMQsdMIpHJOh3jSfwGXbayiX0h
         e6tQ==
X-Gm-Message-State: AGi0Pua5bbENSaj/XqwVKtIXsB7WUd0b74Rqahc1yQqNuuSFFoU15AOG
        9U48yNJiSIdXS8nD3bX6CfsCRq281Tnu5g==
X-Google-Smtp-Source: APiQypI2Em9HQgr7tm7PL5rLKD7w9CJJmeSE0yYvepbX7ZuI9d+GWLxfjZHrBblOmS/FfoSf04NBPA==
X-Received: by 2002:a05:6638:c44:: with SMTP id g4mr3508647jal.99.1587654522605;
        Thu, 23 Apr 2020 08:08:42 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p7sm910735iob.7.2020.04.23.08.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 08:08:41 -0700 (PDT)
Subject: Re: Request For Suggestion: how to handle udevd timeout for bcache
 registration
To:     Coly Li <colyli@suse.de>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>
Cc:     linux-block@vger.kernel.org
References: <7c92cd67-8e62-7d55-c520-345c30513bfa@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <140de6d9-b5ff-0736-ddbd-5b9e1ae70f5b@kernel.dk>
Date:   Thu, 23 Apr 2020 09:08:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7c92cd67-8e62-7d55-c520-345c30513bfa@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/23/20 5:23 AM, Coly Li wrote:
> Hi folk,
> 
> I want to listen to your suggestion on how to handle the udevd timeout
> for bcache registration.
> 
> First of all let me introduce the background of this timeout problem.
> 
> Now the bcache registration is synchronized, the registering process
> will be blocked until the whole registration done. In boot up time, such
> registration can be initiated from a bcache udev rule. Normally it won't
> be problem, but for very large cached data size there might be a large
> internal btree on the cache device. During the registration checking all
> the btree nodes may take 50+ minutes as a udev task, it exceeds 180
> seconds timeout and udevd will kill it. The killing signal will make
> kthread_create() fail during bcache initialization, then the automatic
> bcache registration in boot up time will fail.
> 
> The above text describes the problem I need to solve: make boot up time
> automatic bache registration always success no mater how long it will take.
> 
> I know there are several solutions to solve such problem, I do
> appreciate if you may share the solution so that I may learn good ideas
> from them.
> 
> Thank you in advance for the information sharing of my request of
> suggestion.

The way I see it, you have only two choices:

1) Make the registration async (or lazy), so that starting the device is
   fast, but the btree verification happens on-demand or in the
   background.

2) Increase udev timeout.

That's about it, I don't think there's any clever tricks to be had, and
I definitely don't want to go down the path of trying to work around the
udev killing in the kernel.

-- 
Jens Axboe

