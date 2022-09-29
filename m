Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D04C433F5
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 13:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiI2NpH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 09:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbiI2NpG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 09:45:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72542A50E3
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 06:45:04 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u12so1389384pjj.1
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 06:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ia9jEqWhh53MogJIIKyHxztz6mKbtRn1r17sMFOclHM=;
        b=P/5+cEmzYezKcpeSjnwNAj8suFPYREd8NVIEW/Z7hSwalKTtM21yXIImvwAonZyJfQ
         HHhVVVWqFRAZ+Wbd4AuoA2QjDhznGZaCgO+5mnIu0nnHnBG5LJF+rm57kWqpCHxvIyfS
         qed5J/oZnbPTY/vuutD3Qn+6Z/KmT090jeUd/Q4YUz47ANhVZIp5vjvYYyJ6WO31ZjmI
         3y6GVgfs4356XaCiET9x1pyiP2fKG5slHZv03N3V6uQx90z6Y5ittTTCxleTrfV2U0di
         Ov5EB4uyxzmqHOqZu1ZfQc9oFfa6woFyAQsu+uuKM06EYrKVoGZBCCuNYKACsGk5U515
         a4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ia9jEqWhh53MogJIIKyHxztz6mKbtRn1r17sMFOclHM=;
        b=zolZR2ePgSuvGv75zxl1b4cnNfCPFVbJwhm469lXKTrrt7aQ7Aj7GWdb2CXya1/KLm
         6pNdgnQU5yUQR4aOOp3ZH2vKNDIUkU6MnafG2pUFnw7uzcAsHHHe9kGUIhrV+dzKfiWq
         1tH07wi0o0+DulSQS9bdTEhPOSePSwCUSg/RUs7kJxwFukPx/gHwYC6xSXa0d+t82wCG
         IsyYQ8Damuuf5Vix2ctBZ7VImb0onNpH6VvBUtFY+5qZRVsXlcJ6MSPDm0FBiQgVHxJc
         3xP+QecT4kduTDIalxPa2XzHtW6z9xsol+N1hKSd8MRQ20puRl7dPMmPBHArigu45P5a
         7PNg==
X-Gm-Message-State: ACrzQf3z+xefOl6YlwnS0Iwg0mTul3GstOzMe+Zu7jSboNOOhbI3C2p1
        lU5/ac3QLYkauellUFUUj3dt1Q==
X-Google-Smtp-Source: AMsMyM5XOTlQa/n/yfhQ8dmN+lTkRrSb/MM+h0rnBDFBfATm0YMiBTnIR6MURh8UeHWDv2mlPEUg/w==
X-Received: by 2002:a17:90a:b284:b0:208:4a69:aba9 with SMTP id c4-20020a17090ab28400b002084a69aba9mr2700641pjr.82.1664459103868;
        Thu, 29 Sep 2022 06:45:03 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ce8d00b001786b712bf7sm5976016plg.151.2022.09.29.06.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 06:45:03 -0700 (PDT)
Message-ID: <f6e54907-1035-2b2c-6387-ed178be05ccb@kernel.dk>
Date:   Thu, 29 Sep 2022 07:45:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 2/2] block: use blk_mq_plug() wrapper consistently in
 the block layer
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de
Cc:     gost.dev@samsung.com, linux-block@vger.kernel.org,
        damien.lemoal@opensource.wdc.com
References: <20220929074745.103073-1-p.raghav@samsung.com>
 <CGME20220929074749eucas1p206ebab35a37e629ed49924506e325554@eucas1p2.samsung.com>
 <20220929074745.103073-3-p.raghav@samsung.com>
 <d9a86bdd-bcba-51e9-16d4-287b333e18ad@kernel.dk>
 <ff8bfd82-d4aa-4263-28c0-9c4788e45da8@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ff8bfd82-d4aa-4263-28c0-9c4788e45da8@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/29/22 7:41 AM, Pankaj Raghav wrote:
>>> Either of the changes should not have led to a bug in zoned devices:
>>>
>>> - blk_execute_rq_nowait:
>>>   Only passthrough requests can use this function, and plugging can be
>>>   performed on those requests in zoned devices. So no issues directly
>>>   accessing the plug.
>>>
>>> - blk_flush_plug in bio_poll:
>>>   As we don't plug the requests that require a zone lock in the first
>>>   place, flushing should not have any impact. So no issues directly
>>>   accessing the plug.
>>>
>>> This is just a cleanup patch to use this wrapper to get the plug
>>> consistently across the block layer.
>>
>> While I did suggest to make this consistent and in principle it's
>> the right thing to do, it also irks me to add extra checks to paths
>> where we know that it's just extra pointless code. Maybe we can
>> just comment these two spots? Basically each of the sections above
>> could just go into the appropriate file.
>>
> The checks should go away, and the plug could be inlined by the
> compiler if we don't have CONFIG_BLK_DEV_ZONED. Otherwise, I do agree
> with you that it is a pointless check.

But that's my general complaint with the argument that "it doesn't
matter if this feature isn't configured" - distros enable features.
Anything that uses IS_ENABLED() is handy for testing, but assuming it
all pretty much gets enabled in the distro kernel, it does absolutely
nothing to help the added overhead. It's something that gets done to
create the illusion that an added feature CAN have zero core overhead,
while in reality that's utterly wrong.

> I am fine with either, though I prefer what this patch is doing. So if
> you feel strongly against calling the blk_mq_plug function, I can turn
> this patch into just adding comments as you suggested.

I think we should. I can pick patch 1 here, and then you can send a
patch 2 for that when you have time.

-- 
Jens Axboe
