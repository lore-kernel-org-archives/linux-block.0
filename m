Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E03C0018C
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 23:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA00723EB3
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 23:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393656AbgLJXTU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 18:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393442AbgLJXTO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 18:19:14 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE917C0613D3
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 15:18:33 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r3so7212909wrt.2
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 15:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2c3ITc+KgRDiZY/nVBJ7xTcOC/g5lJ0Z+VewXxiWLWI=;
        b=EZd1XLIY+xG8lOeSm1CBFn7kcKxtwrZHzpCLd1oHHLNBvasmBxy9mLjbMoXl0j/77c
         ZbS8kuu4F21TFqkkwcO97QB3O2qf+56HC3UcrDgYqswflS8rMZIo8vtiCjqGHe+DCDdd
         Jg7s0bSJPSGVXho9PXKUenboKCpGS6dcl/4gKMsniCaaEGlwtJvGx9Hq86/xaTbTcKp3
         vdwAF03RuN5eTEy5p2FhJDd483fsM6GOK5u0LNJct//J7qhGEJ9Nw0qzeJjxZ0P7sEmJ
         uGdLSP8y/belayeIgOnX7SwWuG1QidQHkUYBWI3kO+4blnbV1NVfS8uZ7O1wYf8P7DcP
         KwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2c3ITc+KgRDiZY/nVBJ7xTcOC/g5lJ0Z+VewXxiWLWI=;
        b=UK8oPIUDg1CmlK1dSXx9VH+bfAIjEEJloqKRo4/NQYKsF0JtjUAhcB7PRDvxaWag2d
         WUEA9ZWhHNTi55GcEF6hU6vSdaJtCABMKwGfTfHTQS7Y1y7U4CA2UWa6yR2SsOUXsDPo
         b5b0tIWQSEjwGvmG8mP1mkoeXkSkospczB65aDlk2jGWwq9InWQ6BnsH679fqXwZVdIY
         esFW5XSubvLokzktymvCGKZDxEgQaxyXWe4U5mSzE5HbRDKoSRCz22GAGTVm+/mY/a4b
         m5fmNdeAhA8s9H/l5kJAM8nwj/WveH2l71WFETnWAAxSO5ujf11L9oYhyuP34FNy6xQI
         xMAQ==
X-Gm-Message-State: AOAM533Lb2iMjgYy/vtrf+x2islmPW9AWZkqWsNX58qn3caWygd4lb0A
        tRdG1QspRR2iH9A7/icWV6BRoJAnoRSZ/A==
X-Google-Smtp-Source: ABdhPJxEANlGiGjQPvJ0O7fLmGw4EYvG1R7YlhucuQ7Nwvv9Gitk1pIkmVYawibSqnhnDSJh4yixCw==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr3843239wru.84.1607642312442;
        Thu, 10 Dec 2020 15:18:32 -0800 (PST)
Received: from [192.168.8.123] ([185.69.144.17])
        by smtp.gmail.com with ESMTPSA id v125sm10964207wme.42.2020.12.10.15.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 15:18:31 -0800 (PST)
Subject: Re: hybrid polling on an nvme doesn't seem to work with iodepth > 1
 on 5.10.0-rc5
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Andres Freund <andres@anarazel.de>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20201210205141.px7suygfrl2lhdkr@alap3.anarazel.de>
 <73c43682-10f2-0bc9-5aa5-e433abd4f3c3@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <aa735173-fad1-b7d4-1c90-4fccc90c562d@gmail.com>
Date:   Thu, 10 Dec 2020 23:15:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <73c43682-10f2-0bc9-5aa5-e433abd4f3c3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/2020 23:12, Pavel Begunkov wrote:
> On 10/12/2020 20:51, Andres Freund wrote:
>> Hi,
>>
>> When using hybrid polling (i.e echo 0 >
>> /sys/block/nvme1n1/queue/io_poll_delay) I see stalls with fio when using
>> an iodepth > 1. Sometimes fio hangs, other times the performance is
>> really poor. I reproduced this with SSDs from different vendors.
> 
> Can you get poll stats from debugfs while running with hybrid?
> For both iodepth=1 and 32.

Even better if for 32 you would show it in dynamic, i.e. cat it several
times while running it.

> 
> cat <debugfs>/block/nvme1n1/poll_stat
> 
> e.g. if already mounted
> cat /sys/kernel/debug/block/nvme1n1/poll_stat
> 
>>
>>
>> $ echo -1 | sudo tee /sys/block/nvme1n1/queue/io_poll_delay
>> $ fio --ioengine io_uring --rw write --filesize 1GB --overwrite=1 --name=test --direct=1 --bs=$((1024*4)) --time_based=1 --runtime=10 --hipri --iodepth 1
>> 93.4k iops
>>
>> $ fio --ioengine io_uring --rw write --filesize 1GB --overwrite=1 --name=test --direct=1 --bs=$((1024*4)) --time_based=1 --runtime=10 --hipri --iodepth 32
>> 426k iops
>>
>> $ echo 0 | sudo tee /sys/block/nvme1n1/queue/io_poll_delay
>> $ fio --ioengine io_uring --rw write --filesize 1GB --overwrite=1 --name=test --direct=1 --bs=$((1024*4)) --time_based=1 --runtime=10 --hipri --iodepth 1
>> 94.3k iops
>>
>> $ fio --ioengine io_uring --rw write --filesize 1GB --overwrite=1 --name=test --direct=1 --bs=$((1024*4)) --time_based=1 --runtime=10 --hipri --iodepth 32
>> 167 iops
>> fio took 33s
>>
>>
>> However, if I ask fio / io_uring to perform all those IOs at once, the performance is pretty decent again (but obviously that's not that desirable)
>>
>> $ fio --ioengine io_uring --rw write --filesize 1GB --overwrite=1 --name=test --direct=1 --bs=$((1024*4)) --time_based=1 --runtime=10 --hipri --iodepth 32 --iodepth_batch_submit=32 --iodepth_batch_complete_min=32
>> 394k iops
>>
>>
>> So it looks like there's something wrong around tracking what needs to
>> be polled for in hybrid mode.

-- 
Pavel Begunkov
