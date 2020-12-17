Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC28C4361B
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F01A233A0
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgLQQz2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 11:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgLQQz1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 11:55:27 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DF0C061794
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 08:54:47 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id m23so13372662ioy.2
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 08:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QIo8kzUF4f+VTog26R2WYri/e5hT/K24u2XhhGbpvmY=;
        b=12tfeVKvbvIjZ5DLs4nRbJBlPkjLN+ebRzw0SetxPwbniKC+ml7PiuHLwrtUg06nuV
         bNsDpSIrCfQCXu7JewaICvIw+JeixSdbxLATVEY7PMgHIBzMa8QHz3tidoFQ+OOKY7LG
         y4/Q5v7Rs9rSIvZSVX4UtBsjBOpGApQGISBtxhB9fyBUK8vqUTs0/YgT8TFiomy6VWUN
         hY6UKhnw1R6tofoKmquDmLx/MPcdq1V145m109CEDxsXnQij3DbHaOOQOn7Q9eNiI/U5
         cVSXglSyAOVmwvqYPfc4M+vcjg0L92bmnxVjLnAAyXRkE1cYaec7qcrDzG52uir5KOUG
         sL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QIo8kzUF4f+VTog26R2WYri/e5hT/K24u2XhhGbpvmY=;
        b=Q0A1yi54NzMozPFi9fBbvOfYyVhXr3L79JDlkrPpPERdjvZLB99DhgpOy1e0mjaSgd
         HNsyY3+/yLzEtXJfRcRID1H1dAeatqN5iO8kqClK6v0bkXGY+NUUSVGBtRGaAGhXtMJ7
         mHSlM549hACgCq9bySRWzqDmfwyILbshOP9MGsRXYauf55pnIe7X/FcPZBfckZy/Tapa
         vX6VLsCxwOBuXiMm/Z9JPzN1lXKWt2wr7ewDytU22ysPbLpKVZKcMvWe8f3wQ/hbB1wg
         X8rpyItwQdr1btsaCDYywM30p8scdjiSEz/+1U0PZopUqP62riAzIwbetUKYOt8XfkwC
         Ki9w==
X-Gm-Message-State: AOAM533HbR+JvLAQn+yNanOMxaTi6Nu0QfNxbbLq994vmbq2KyN2qwiI
        Bw/8gtNnNoCfHTzft8A2i/n3sQkQpgKVrw==
X-Google-Smtp-Source: ABdhPJxxctiNc66vwUCN8Frvksjrp05MoeYZN0sQBMID6CyTlENBHoK3Xt3bwHaZdopAE2AIB4DQJg==
X-Received: by 2002:a05:6638:25d4:: with SMTP id u20mr48459381jat.54.1608224086818;
        Thu, 17 Dec 2020 08:54:46 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f10sm3488698ilq.64.2020.12.17.08.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 08:54:46 -0800 (PST)
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208082220.hhel5ubeh4uqrwnd@linutronix.de>
 <20201208084409.koeftbpnvesp4xtv@beryllium.lan>
 <243c7259-0b1b-b239-4f0f-650520333392@kernel.dk>
 <20201217164939.z4zjhycpxsyqvvcd@beryllium.lan>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6d9a1201-0de3-5b9d-4a4b-6b076bf4bc45@kernel.dk>
Date:   Thu, 17 Dec 2020 09:54:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201217164939.z4zjhycpxsyqvvcd@beryllium.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/20 9:49 AM, Daniel Wagner wrote:
> On Thu, Dec 17, 2020 at 09:45:47AM -0700, Jens Axboe wrote:
>> On 12/8/20 1:44 AM, Daniel Wagner wrote:
>>> It looks like the patched version show tiny bit better numbers for this
>>> workload. slat seems to be one of the major difference between the two
>>> runs. But that is the only thing I really spotted to be really off.
>>
>> slat is the same, just one is in nsec and the other is in usec.
> 
> Ah, good eyes. Need to remember this :)
> 
>>> I keep going with some more testing. Let what kind of tests you would
>>> also want to see. I'll do a few plain NVMe tests next.
>>
>> This is a good test, thanks.
> 
> Got sidetracked. Haven't started yet with these tests.

I just ran some here, and as expected, didn't see much change. Single
core IOPS at 2.8M in both cases, and not expecting any remote IPI for
that test case.

So I'd say that's good enough, wasn't expecting a change, and we don't
see one even for your case with remote IPI.

-- 
Jens Axboe

