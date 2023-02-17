Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA7EC05027
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 14:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBQOlA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 09:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjBQOk7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 09:40:59 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5503C6D7B9
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 06:40:57 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id m16so220875ilq.10
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 06:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N8N0BgXi69CCe+Y5lZOJFkw+jt9TQTak6Z986E1XVXE=;
        b=05dVsJ/gi0XtRFL6hAJq01GLXtNNUTdITF20218DCLloA17i+cLyttQEXEDofnB6My
         LNZ8cwG0X3LZQUz8LYUzugqKAZnPGwOQyhj7zBVJeu4VOhyBYezxJa2EK33jVnVOzrx3
         KTeMgMga8RFBWlmVkZAvAEoGPetaQNfJ507h4agdXQeampJlbcN1VxIAt8EqsraEGjRS
         xVO9A2778A+kJH/IBwvTs6UDUCi7ctA90mirOOGE+auVZPAJZsx1cCEYF1W/v6mTRqiQ
         IIc8wX4uw3Sda3wPqpbKFdImgaKdKuzWLxXOQ3CSwcpozzrKhTenTpR3j4C4IRim965j
         k26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N8N0BgXi69CCe+Y5lZOJFkw+jt9TQTak6Z986E1XVXE=;
        b=N1TnrOZdzEMaMoNG2CXERmva/0uQfKsFERHCDlPj95xE/1qzUpDxuhy/eLRs62+ZSp
         6pp/fv5wqIWxZISj1pzTL94Tf7tiSBjhg8CzsyPj6NM2sdQFGEueKxfNDbRXxjQfto7X
         o0QT6OETh+ZOBGw5ZS0iG/zx69mKX1RQ+BTS8UOcJelGXSEwIxX6Vd8582ueViw8UYPj
         ojtWefYqyld9amViKrdp7SOgHc41Jp0djXN9KT70vfPOVHjHRsDlOgOEvYlJZYTwPX7m
         XrxLiruj0nWwnM28MAqn5jW8pHizUM6z6jEHAYzIflsXA+PfYBN6YVceItfN8yYYe0ZY
         zhtw==
X-Gm-Message-State: AO0yUKX6pl6qXNJLPRLyBjkfCGu9X8YRZ3O/Hz/c4gAnqa8uVEQcCM8u
        iSk2FV6oD0TNaeAAXiBLSr9YrA==
X-Google-Smtp-Source: AK7set8dPbCpjbJeAl887oD+ZZ5YkCOZTfthPXYEf06tGQmBAdEkECjNX/g2i6dQOvcwVhhvBUo1eA==
X-Received: by 2002:a05:6e02:e03:b0:314:1121:dd85 with SMTP id a3-20020a056e020e0300b003141121dd85mr805145ilk.1.1676644856285;
        Fri, 17 Feb 2023 06:40:56 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e3-20020a056638020300b003a96f9940ddsm1513482jaq.102.2023.02.17.06.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 06:40:55 -0800 (PST)
Message-ID: <db1d7cd7-6c89-7d6b-3fe5-3778bb3cb5e9@kernel.dk>
Date:   Fri, 17 Feb 2023 07:40:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 0/1] improve brd performance with blk-mq
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     hch@lst.de, mcgrof@kernel.org, gost.dev@samsung.com,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
References: <CGME20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e@eucas1p1.samsung.com>
 <20230203103005.31290-1-p.raghav@samsung.com> <Y+Gsu0PiXBIf8fFU@T590>
 <6035da22-5667-93d5-fe00-62b988425cb5@samsung.com> <Y+nwh7V5xehxMWDR@T590>
 <95506a88-c89c-0f41-3ab4-eb5741410c02@samsung.com>
 <7c28caf6-931e-0a7a-a3c0-e4a430f860ff@kernel.dk>
 <8cc2659b-b7f9-eb8a-e73b-3056b82f159b@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8cc2659b-b7f9-eb8a-e73b-3056b82f159b@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/17/23 7:27 AM, Pankaj Raghav wrote:
> Hi Jens,
> 
> On 2023-02-16 05:08, Jens Axboe wrote:
> 
>> I think your numbers are skewed because brd isn't flagg nowait, can you
>> try with this?
>>
>> I ran some quick testing here, using the current tree:
>>
>> 		without patch		with patch
>> io_uring	~430K IOPS		~3.4M IOPS
>> libaio		~895K IOPS		~895K IOPS
>>
>> which is a pretty substantial difference...
>>
> 
> I rebased my blk-mq changes on top of your nowait patches, but still I see a
> regression with blk-mq. When I tried to trace and run perf, nothing odd
> stood out, except for the normal blk-mq overhead.
> 
> Could you try it in your setup and see if you are noticing a similar trend?
> Because based on the numbers you shared yesterday, I didn't see this regression.
> 
> fio script I run to benchmark:
> 
> $ fio --name=<workload>  --rw=<workload>  --ramp_time=5s --size=1G
> --io_size=10G --loop=4 --cpus_allowed=1 --filename=/dev/ram0 --direct=1
> --iodepth=128 --ioengine=<engine>
> 
> +-----------+-----------+--------+--------+
> | io_uring  | bio(base) | blk-mq | delta  |
> +-----------+-----------+--------+--------+
> |   read    |    577    |  446   | -22.7  |
> | randread  |    504    |  416   | -17.46 |
> |   write   |    554    |  424   | -23.47 |
> | randwrite |    484    |  381   | -21.28 |
> +-----------+-----------+--------+--------+
> 
> +-----------+-----------+--------+--------+
> |  libaio   | bio(base) | blk-mq | delta  |
> +-----------+-----------+--------+--------+
> |   read    |    412    |  341   | -17.23 |
> | randread  |    389    |  335   | -13.88 |
> |   write   |    401    |  329   | -17.96 |
> | randwrite |    351    |  304   | -13.39 |
> +-----------+-----------+--------+--------+

This is pretty much expected, as blk-mq adds a bunch of things that
brd doesn't really care about. One example of such would be tag
management.

My reaction to your initial report wasn't a surprise that blk-mq
would be slower than bio based for this use case, rather that
io_uring was slower than libaio.

-- 
Jens Axboe


