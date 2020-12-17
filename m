Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAB0C4361B
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A029220637
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgLQQqa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 11:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgLQQqa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 11:46:30 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F32C061794
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 08:45:49 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id i18so28133881ioa.1
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 08:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5IXKKZuCItJr6HUat/eaBFpMBwHh3XuMNTFBubYuNCg=;
        b=UgEabXsZy5DL4psNz3csEJEPIqNaJBAIGeahXysfcT7lfLIJRYxS19ZyWbsITmmwxv
         7iAKU4M2fbaJ9myBmSr9Fgtu9ymaM1ggQ/sCZIeJLPUAuNYtIZTbD6R8fI1z/Y0II0aM
         DO+hA1OVN1vkNOUytJKe8nQh4OvhOeyPyp14bhIGGu+zk7YwKshiOAMEUqn2I/CtH9jd
         Gl1u3zRMRb6lzo8dXEAk/E/vVdrOBximfJWBIPnz+vHeUWBI7n4UPzDzn1kWkGbiyjUC
         T90Q4RVg3vVzKx1PrUzQ+FNggI0BLnQRwIbq6pmdutMY+ocPeDbvJbDFTwofKG00bBKk
         vKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5IXKKZuCItJr6HUat/eaBFpMBwHh3XuMNTFBubYuNCg=;
        b=CS2bfi7VCjgtl7OYf9soWKi6N9wv4fCllrr5VWKWEvK6dp3nKjtTMIGyyigBvjOD2S
         /J1MJllEjnP74sjT5UzuQU1AhDBVRH4raJwmka2nrlH3chn+8+MoORtm0jRSsTggZRNI
         7FJgZ3m/ywAe60j7rY+Z7oWFvGGXglB+Z9aeU9RXq0CuBa1h+eGh/ofK8lwstn7HqV2U
         tpTl1h5pUyHk5xme02moZclt8rpZEu5asOlKIPcDrcj6I95HN3o00N9ft/NHReerY+JR
         XQlixAzAr/sjcuheNedsK7kgI7UYngzYReca/mCj6RkblgxIn1tVCkIS1jvnMcbLHLMU
         DwAw==
X-Gm-Message-State: AOAM531WT2gFL3cK1YVLgg+pUJKWj2VQtNFqj2svRxVgpFFwvVq7A0XR
        puCG4LKCIofgvLnLsHjcYg7TGw==
X-Google-Smtp-Source: ABdhPJw613pHBJGKBCAmyBeEmTZG7KwXB+c7zyG1x0Dh2dMamuv7l/kTzPZ9z9UGOxppwugRKmSRdA==
X-Received: by 2002:a02:9691:: with SMTP id w17mr48102236jai.9.1608223548877;
        Thu, 17 Dec 2020 08:45:48 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f6sm14057532ioh.2.2020.12.17.08.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 08:45:48 -0800 (PST)
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
To:     Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208082220.hhel5ubeh4uqrwnd@linutronix.de>
 <20201208084409.koeftbpnvesp4xtv@beryllium.lan>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <243c7259-0b1b-b239-4f0f-650520333392@kernel.dk>
Date:   Thu, 17 Dec 2020 09:45:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201208084409.koeftbpnvesp4xtv@beryllium.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/8/20 1:44 AM, Daniel Wagner wrote:
> It looks like the patched version show tiny bit better numbers for this
> workload. slat seems to be one of the major difference between the two
> runs. But that is the only thing I really spotted to be really off.

slat is the same, just one is in nsec and the other is in usec.

> I keep going with some more testing. Let what kind of tests you would
> also want to see. I'll do a few plain NVMe tests next.

This is a good test, thanks.

-- 
Jens Axboe

