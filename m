Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A5AC433EF
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 12:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiESMqN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 08:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiESMqM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 08:46:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356AD3669D
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 05:46:11 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d22so4674369plr.9
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 05:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2ZWlEemDZrTKXDOdy25O0sTye2+vppjZ+Zvhbx0G8CM=;
        b=jVaMTqh/9vGO8AgRz8vjEUjwMNXjzZNqAS+wPzoNXDZEQQYtcCDzwDz0NxrfteeFi6
         ZM0YG+Q+FJ13HQBu7KYxMg/sHny/5mlDR52MaKdeONgI01nUdYlTZVcdtIIXnIukS4Ps
         hfJxUxLRJtFbXmVaPv3X9hewE3EfstAYunBR72XrpxZbMYxF1RIZSVFyzQB64PCFrvIU
         m4UVZyB0WkjdPcXUZ8jLRQzAAH8BK4R/NZJGJrFC4+XVHnz9jIhniF399MPl/roWOhwR
         5LbJRuCstBRehBfuKUaaMhjQEatsbYQHEwOvuvN62sSyoP8DmqYqZlJoGtCUWjUuVMd5
         /wNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2ZWlEemDZrTKXDOdy25O0sTye2+vppjZ+Zvhbx0G8CM=;
        b=AKI2VAxcaVM9CYI7QPGLkn37tICaxrsXmyL602VfC8Z4EuQVRwwskFyloYWzwT5lBb
         qzL2YpE1SmhqpA+OhiAZl4YSSm3NkFjLMZ+3g2G/60JL/BBiBU4hng2qDhnoBZiOL4Y/
         UdVhwpHi1GCcHZikcKWYFqXBvos3aSS80207YkcjPkU7w8bItGWSXyaLzQ3U4xRiooOW
         8t6Vyrus+bGVAc80rclhmX+OdkWcAqxdvUtpbuJJFr/Fy6xPHmQH0H7oPna/kcKHCDiX
         NtQpQr7tnK7UI/BScmSlkRbAiJF+b5IVABZW9xOaL3Nk/A6cjzNjK/wX8/Bq9hr+4afL
         pO/w==
X-Gm-Message-State: AOAM531DomtVoINGy2sqySxpUkl7gsq4IcKRTBK9TrzlBFzWgj1n2jOO
        eVioTNdGFDi0I2K3RngORF2+zg==
X-Google-Smtp-Source: ABdhPJzeF1qWqkRiWbULZci50AO29+Nb/8GtFi7I5tFhGULXNKR0KIOSxrWV8X415nx1dqKWrSau0Q==
X-Received: by 2002:a17:90b:388f:b0:1dc:6e0f:372b with SMTP id mu15-20020a17090b388f00b001dc6e0f372bmr4969307pjb.93.1652964370610;
        Thu, 19 May 2022 05:46:10 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p17-20020a63e651000000b003f5e19c047dsm3456890pgj.37.2022.05.19.05.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 05:46:10 -0700 (PDT)
Message-ID: <92ee257f-c19f-adee-7bd2-409546b95d47@kernel.dk>
Date:   Thu, 19 May 2022 06:46:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 0/3] direct io alignment relax
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        Keith Busch <kbusch@kernel.org>
References: <20220518171131.3525293-1-kbusch@fb.com>
 <dc8e7b85-fba1-b45e-231e-9c8054aea505@kernel.dk>
 <20220519074225.GH22301@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220519074225.GH22301@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/22 1:42 AM, Christoph Hellwig wrote:
> On Wed, May 18, 2022 at 04:45:10PM -0600, Jens Axboe wrote:
>> On 5/18/22 11:11 AM, Keith Busch wrote:
>>> From: Keith Busch <kbusch@kernel.org>
>>>
>>> Including the fs list this time.
>>>
>>> I am still working on a better interface to report the dio alignment to
>>> an application. The most recent suggestion of using statx is proving to
>>> be less straight forward than I thought, but I don't want to hold this
>>> series up for that.
>>
>> This looks good to me. Anyone object to queueing this one up?
> 
> Yes.  I really do like this feature, but I don't think it is ready to
> rush it in.  In addition to the ongoing discussions in this thread
> we absolutely need proper statx support for the alignments to avoid
> userspace growing all kinds of sysfs growling crap to make use of it.

OK fair enough, I do agree that we need a better story for exposing this
data, and in fact for a whole bunch of other stuff that is currently
hard to get programatically. We can defer to 5.20 and get the statx side
hashed out at the same time.

-- 
Jens Axboe

