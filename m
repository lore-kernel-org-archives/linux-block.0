Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20237C4361B
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A13233A2
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgLQQzy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 11:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgLQQzu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 11:55:50 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBB2C0617B0
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 08:55:10 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y5so28129973iow.5
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 08:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=94SXVPLk6dxrjkrztJ2xCBJHw01MzQaAZHGiXBHQxjw=;
        b=laaH/9a3BSonuTozLMpmsGNGND4KidMRwkNzS66B7kd4gHmdkITBRmJywWMFV+DyZS
         4kleven7BErPsD/N9yfbvbrbeVvP3ZFqGslY8vButHdNseA4He9bnBL66MHZPxJ3MVSs
         W7LJOwHsITLQMqKF4wlk2rKjVIOVAR5ujs9rdC2I/PaDhluhXwCrRg/fg/dsMB4fWry/
         pkz03QujcK/ZxvQ348BtRfOkDGfG0ZsAjO7cFBH0s8hPUhx2dYC1P3jaUoMAl1MstjMQ
         HqA4M3/FMKOaUdmizLqcX7s5RZvESIS95KS05s02On47YG9tl45tuuN8v4uY2opicYEB
         c4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=94SXVPLk6dxrjkrztJ2xCBJHw01MzQaAZHGiXBHQxjw=;
        b=bLEu5nUY+1FnIeBr1GDRJjfJCdjPwpo9VLTR3fmosvIc9cikoj11MLven9Jb/xEmCs
         CQVvaatWAXeHI/7Qo5ptKV1Zej6JDsEtEeHRiFrI6t1Xypbf8hrWVHPQj3wXD6G0tegn
         m7dYB1R7vVEVTq8ek52czZ0W/BSIM+KLJvW3cvRHLIidl41V9YSVtkWsfbHUhanlgSkr
         SB4Vcm4zPU8PVIAPFdeRwErLxtMO+D6bW7VMP5q90H/qbsHcB/nZGz+LIx1pBDa4YKGI
         N9JKhAoczWQR31Y4jrD+CYbcwZdU1pbfp5/dy8rpOuLRT6nWt+4jKJ0tUt56NpD6kWHK
         XmuQ==
X-Gm-Message-State: AOAM533i19UVdHcjHvdwuOu9ElypuQNd2S79tUpiSJB+D1P6bicJ5sbs
        1BxJSG5+gibrVZOuP9WkZ/+uCA==
X-Google-Smtp-Source: ABdhPJw8jxJQhNhG4kfSYJ0MBaC1k+x/nnPsk0lxjUga8vz1vvxR0wwsMqSTvLdBCryyBHXXJid4OQ==
X-Received: by 2002:a05:6638:f89:: with SMTP id h9mr49039087jal.89.1608224109996;
        Thu, 17 Dec 2020 08:55:09 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z10sm14438908ioi.47.2020.12.17.08.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 08:55:09 -0800 (PST)
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>,
        Mike Galbraith <efault@gmx.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208131319.GB22219@infradead.org>
 <20201217164308.ueki3scv3oxt4uta@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e3ca3c82-cddc-ea06-39ae-48605abc77eb@kernel.dk>
Date:   Thu, 17 Dec 2020 09:55:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201217164308.ueki3scv3oxt4uta@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/20 9:43 AM, Sebastian Andrzej Siewior wrote:
> On 2020-12-08 13:13:19 [+0000], Christoph Hellwig wrote:
>> On Mon, Dec 07, 2020 at 04:52:57PM -0700, Jens Axboe wrote:
>>> On 12/4/20 12:13 PM, Sebastian Andrzej Siewior wrote:
>>>> Controllers with multiple queues have their IRQ-handelers pinned to a
>>>> CPU. The core shouldn't need to complete the request on a remote CPU.
>>>>
>>>> Remove this case and always raise the softirq to complete the request.
>>>
>>> I don't like this one at all, it'll add a softirq jump for the fast path
>>> for eg nvme devices.
>>
>> For the real fast path, that is either a polled queue or irq driven
>> queues that only map to a single CPU we are never reaching this code,
>> so I'm not too worried.  Not that I'd complain about numbers, preferably
>> in the commit log.
> 
> Did Daniel provide all the numbers you/Jens were looking for or do we
> still wait for some?

Yeah, I think we're good at this point. I'll queue this up for 5.11.

-- 
Jens Axboe

