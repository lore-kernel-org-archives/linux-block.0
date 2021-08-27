Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C3AC432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 03:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 072BC60F6F
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 03:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244113AbhH0DOU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 23:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244100AbhH0DOT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 23:14:19 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E55FC061757
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 20:13:31 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id j15so5670885ila.1
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 20:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xnK5VpSXR680Pu/S8RrWUoqbOfQzHSydZ5l9QXM8IpI=;
        b=W4K7wt+y9lU+4C+whxkj5qrSjRqcdUcIsrYyDG2UMnSv/ZczLU9idypA0VtIUzZfSj
         rfDYt6RSE0tXyT/5lpWGjL27MCujtc8BgnGin6k4J2NWioZ/elUgddkj1C6RMxW+gPuv
         p3PKppIE4hAzeNry3FtimozGQYU6YyZst4g7/JL2wvpyqHspDDko7WTjpOLVWZmjW5q+
         a45Al8dOGKR/6Wnm7dLrSdA9CU3+0q/4k40N1g0NJETdknhItVLWqz5mPZPtWGv7S58D
         URP0gWz1Kvh4dJSMQ+1A9HhmM9P3AsEnBQF7lAsc/ZNUtHsyTSjL45jSXrRl70MW7/Ix
         coJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xnK5VpSXR680Pu/S8RrWUoqbOfQzHSydZ5l9QXM8IpI=;
        b=GqjhAfpqg96DgDL6M9YHDCvqkukKoy6eaLhwi8H6Bs7F48J2LjkVLE5QVK75OzUmpq
         Ke2nup+w48Upd+fSXbiREyiSc1N15ZaQNrN6z8k2tyqQBEvuD6aBj6CjybmMlbuLRyK+
         zMRbzRLe8GSiaK/dX/9h7Zj/CqVunBgFmSYBWtENldAPi8mqUi9EKBpyikpmsByiy7ys
         t2HV74/StYT96caIICQIzT9CvW8Qlv47PouwPQU+59HzBCGvcEEoYJBQfKEMw3aD58sD
         Kzq8xmjZJaoJcJFGiKFpOR67+OJ+KeDAet4wV9WVHTtXEAi/DxijvKPJYvNd1pArDrIP
         2zSQ==
X-Gm-Message-State: AOAM530LEPa+vGtnOPMJdF/KpjuWD1yFIXbcJfY64vjObbuAQ1K7MdOp
        bgIWgEdXHUSwQiAqJI0vJiLTSA==
X-Google-Smtp-Source: ABdhPJw4JvID2ayGXBpMacNSoYRJbGJYrx2pmy3BTsOjuyNKoopFH47/w9wttR6PL9wfVWVOmrtVcQ==
X-Received: by 2002:a05:6e02:1107:: with SMTP id u7mr4696536ilk.39.1630034010849;
        Thu, 26 Aug 2021 20:13:30 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g11sm2633444iom.46.2021.08.26.20.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 20:13:30 -0700 (PDT)
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
To:     Bart Van Assche <bvanassche@acm.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>
References: <20210826144039.2143-1-thunder.leizhen@huawei.com>
 <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
 <537620de-646d-e78e-ccb8-4105bac398b3@kernel.dk>
 <82612be1-d61e-1ad5-8fb5-d592a5bc4789@kernel.dk>
 <59c19a63-f321-94e8-cb31-87e88bd4e3d5@acm.org>
 <0ef7865d-a9ce-c5d9-ff7f-c0ef58de3d21@kernel.dk>
 <2332cba0-efe6-3b35-0587-ee6355a3567d@acm.org>
 <dd1f2b01-abe5-4e6f-14cf-c3bef90eb6f9@kernel.dk>
 <fdd60ef5-285c-964b-818a-6e0ee0481751@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6ad27546-d61f-a98a-1633-9a4808a829ba@kernel.dk>
Date:   Thu, 26 Aug 2021 21:13:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fdd60ef5-285c-964b-818a-6e0ee0481751@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/26/21 8:48 PM, Bart Van Assche wrote:
> On 8/26/21 5:05 PM, Jens Axboe wrote:
>> On 8/26/21 6:03 PM, Bart Van Assche wrote:
>>> Here is an overview of the tests I ran so far, all on the same test
>>> setup:
>>> * No I/O scheduler:               about 5630 K IOPS.
>>> * Kernel v5.11 + mq-deadline:     about 1100 K IOPS.
>>> * block-for-next + mq-deadline:   about  760 K IOPS.
>>> * block-for-next with improved mq-deadline performance: about 970 K IOPS.
>>
>> So we're still off by about 12%, I don't think that is good enough.
>> That's assuming that v5.11 + mq-deadline is the same as for-next with
>> the mq-deadline change reverted? Because that would be the key number to
>> compare it with.
> 
> With the patch series that is available at
> https://github.com/bvanassche/linux/tree/block-for-next the same test reports
> 1090 K IOPS or only 1% below the v5.11 result. I will post that series on the
> linux-block mailing list after I have finished testing that series.

OK sounds good. I do think we should just do the revert at this point,
any real fix is going to end up being bigger than I'd like at this
point. Then we can re-introduce the feature once we're happy with the
results.

-- 
Jens Axboe

