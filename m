Return-Path: <SRS0=yWSg=4X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0D5C10DCE
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 23:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E837D20658
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 23:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mm+uJf+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgCFXLw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:11:52 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34960 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFXLv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Mar 2020 18:11:51 -0500
Received: by mail-lj1-f196.google.com with SMTP id a12so3937129ljj.2;
        Fri, 06 Mar 2020 15:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gK0NIKisFWdsMrtmzgYZAFdeJlOFf5qgx10lmxvVCTk=;
        b=mm+uJf+5ympFMJq5u0MTaFeFHYjmBfZeImyavE70t/lDjr1oUEtoWnjUjTC52tUIKo
         sT2B6YDOr/QwJUwqv5+X0gcLScFHMNGmFM+lqGJ/1Leoa9oeqZ6rHvxIH6q2BQ5T55wx
         Q85DZ8VKJGuWWrGd3PH1KTlVn9nHz4FU8HQBFVjN1rsr+ezX1fOxlcXvcZvrH4gs7uPT
         /ccVrZxuVeKsXkk3VRXqAaR7RCuYWBG5I8/JAir3AIUw5GPXEhdw9UAjv1W0Km0rWVrW
         ZqIjouiLqRzVErbhCj+APOhqnoE/Zt9mSHDPb80/ZgDj0aIGlPKiCy9OFfcbqHf1DjsR
         XmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gK0NIKisFWdsMrtmzgYZAFdeJlOFf5qgx10lmxvVCTk=;
        b=dDSTvd9K5VpYGWqx4BA6d5culwJSa0FW9J5mYPhs+1uOKongJd720Q8aIE75M5RnYh
         drc6wEgSArnG3n+5yt7lv9/V2t6JzBAJMXwc0O8vCNxgjc93DVuL49dt5/PZx+zTP+JB
         xO/dXkff38N7i5fLzQWWufXkP6U+thaG8L88PHuD/JqZpc7JaO32lppgHYpumHnFIRcL
         yoQJlZ6gbfmXZyA+Op4/EqJ4bB02Qtcf8736MnRh1L5KN0IZkDGKCtcuoUE9CY/ZJGbG
         gZuMfdl4/3sf+s/bqmkk9uwKWsDdF0dlR4P5yJSbBgKvVJIassGKPSVIS0ROoTkpgYln
         5+Zw==
X-Gm-Message-State: ANhLgQ2Jwqhz+s4cxFVk9cYlX75zmpmk2kl3PgEKXuJC5DVuyI/n/EUp
        by6offpk3ltaShBlTn4+uxEogJW4
X-Google-Smtp-Source: ADFU+vvCrvTob9iFZY6HE4Gqd8Ft7QfjakCUfpIv0st2+oa4Ze6vk/10TpObFCLeWg4GAu2xku65TA==
X-Received: by 2002:a2e:6a08:: with SMTP id f8mr3412182ljc.76.1583536308523;
        Fri, 06 Mar 2020 15:11:48 -0800 (PST)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id n26sm16610009lfi.5.2020.03.06.15.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 15:11:47 -0800 (PST)
Subject: Re: [PATCH v1 3/3] partitions: Introduce NVIDIA Tegra Partition Table
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200224231841.26550-1-digetx@gmail.com>
 <20200224231841.26550-4-digetx@gmail.com>
 <44c22925-a14e-96d0-1f93-1979c0c60525@wwwdotorg.org>
 <CAPDyKFoXnoukjH_2cM=f0DGHBHS6kVUQSYOa_5ffQppC7VOn2A@mail.gmail.com>
 <824a4d5f-8280-8860-3e80-68188a13aa3d@gmail.com>
 <CAPDyKFric6pZbJ5-2qkwAFoeJ0c0kcha99zHJ12AUrWO6FQmgg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6047f07b-c0af-08c8-90d1-79a0d880e0a2@gmail.com>
Date:   Sat, 7 Mar 2020 02:11:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFric6pZbJ5-2qkwAFoeJ0c0kcha99zHJ12AUrWO6FQmgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

06.03.2020 16:37, Ulf Hansson пишет:
...
>>
>> Technically, it should be possible to chain-load some custom secondary
>> bootloader instead of a kernel image, but this is not very practical
>> because now:
>>
>> 1. There is a need to make a custom bootloader and it is quite a lot of
>> work.
>>
>> 2. You'll have to tell everybody that a custom booloader may need to be
>> used in order to get a working eMMC.
> 
> Yeah, I get the point. It's not an optimal situation, but I assume
> it's about informing developers. They can cope with this, no?

Perhaps no, it's not only about the informing. The need for a custom
bootloader creates other inconveniences because:

1. It won't be possible to boot a vanilla upstream kernel using
Android's "fastboot boot ..." without applying extra patches to kernel
for the partition table support. Advanced users usually tend to use
fastboot and it's also very useful for a regular development purposes as
well.

2. Somebody (a developer / advanced user) will have to create a custom
bootloader for each device in the first place. This is not what an
average person will be able to do and there are not that many developers
who would want to dedicate theirs time to this.

3. The entry barrier for upstreaming Android devices support to the
kernel is already quite enormous. Adding extra hurdles isn't a step into
the right direction, IMO.

>> 3. NVIDIA's bootloader already passes a command line parameter to kernel
>> for locating GPT entry, but this hack is not acceptable for the upstream
>> kernel.
> 
> Well, I am just worried that we will end up with one partition format
> per vendor/product, that wouldn't scale very well.
> 
> In any case, from mmc point of view I am less concerned, we can find a
> way to support the needed bits. I just need to review the series more
> carefully and provide some comments. :-)
> 
> However, before I do that, I would like to hear Jens opinion about
> adding a new partition format, so I don't waste my time here.

Sure, no problems :) Let's wait for the comments from Jens.
