Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98582C433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 23:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6785A2332A
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 23:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394272AbgLJXQk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 18:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391943AbgLJXQN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 18:16:13 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7A2C0613CF
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 15:15:33 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r7so7187155wrc.5
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 15:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yX8kPVWHNVJgVb2LzVu1ZRpxc9YkzPpxSKlJ1xewQPw=;
        b=T3HKwSAmwjENPChJzuHTLJgBQQVqEWOMsb0NfNcZZSOdHXaUahtz/IrOBY+XWozGpR
         26yN3Q0h8S6uGqyaPwYtBElusI8fA8c8v2tUvJpalsmeikkl767jFLvX1fsgBrtzFd7J
         s3qdF3Zt86RGmPIWDOFoZyTu946Zq+5nSXI9NITLimGe4iIYvtd2IqFYJVXVh8TKrYIZ
         KoZ6Nfgj5jJSF+kgoGf5BCA5qAPsTLDC+Ic8Q+ItNAFT5lTbNKUP0Nt6GcHlzmA7299f
         C75gbNzH8p4c61uyxY+D3EVHqVQzBMWY9zg/ZPmqwFmHALF0kTeA5iSp+0oMhufJuk4u
         9c7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yX8kPVWHNVJgVb2LzVu1ZRpxc9YkzPpxSKlJ1xewQPw=;
        b=rxBC+6Y2OzvGQ+0Y1yM57niOJYFNCwDHdnnKTx1xTEw6uZKeebHWvyI/qSwmnzr5Wn
         JOZqBUpyIcc31QYAkznawjER+D01ZQC9MCg+Nfm0UHAojsJHDAKxEX8bk82ZpMONxfkQ
         /3sltKviLyuyXrVrE59N/8R02jFW19vllUepF+CvyizAeZzvrk4vHlTRU995xVMbSAU/
         d8CZ5vbfnqGKW7Wj2j9VB/6s/4ovigE0R4/16ZHbPklcPVa52uEtAr4H53kYJfX9vipU
         UtG/LFHl1Snf0UtRYl6an8TEKXBKoBqcKQSjyU4UoeWTkpH0CYWhGN/+6VCXuzITU1zL
         rA/A==
X-Gm-Message-State: AOAM532VfPMKIFode9wW8y6X7McC/Mp1/fEYP/LyniXYG9Q8Uqn0CNNj
        HMX8TAa3lTLGJh3fLfo3jJ7pxopX5ynLVA==
X-Google-Smtp-Source: ABdhPJz+maz33JImDlHefANoRcyvefagcHKcuMXRoNi3ZpusA6iL5eVNxpyvBuliEG2ONIQ5ZiiwJA==
X-Received: by 2002:a5d:4101:: with SMTP id l1mr11045647wrp.196.1607642132093;
        Thu, 10 Dec 2020 15:15:32 -0800 (PST)
Received: from [192.168.8.123] ([185.69.144.17])
        by smtp.gmail.com with ESMTPSA id a5sm4934129wrx.49.2020.12.10.15.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 15:15:31 -0800 (PST)
To:     Andres Freund <andres@anarazel.de>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20201210205141.px7suygfrl2lhdkr@alap3.anarazel.de>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: hybrid polling on an nvme doesn't seem to work with iodepth > 1
 on 5.10.0-rc5
Message-ID: <73c43682-10f2-0bc9-5aa5-e433abd4f3c3@gmail.com>
Date:   Thu, 10 Dec 2020 23:12:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201210205141.px7suygfrl2lhdkr@alap3.anarazel.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/2020 20:51, Andres Freund wrote:
> Hi,
> 
> When using hybrid polling (i.e echo 0 >
> /sys/block/nvme1n1/queue/io_poll_delay) I see stalls with fio when using
> an iodepth > 1. Sometimes fio hangs, other times the performance is
> really poor. I reproduced this with SSDs from different vendors.

Can you get poll stats from debugfs while running with hybrid?
For both iodepth=1 and 32.

cat <debugfs>/block/nvme1n1/poll_stat

e.g. if already mounted
cat /sys/kernel/debug/block/nvme1n1/poll_stat

> 
> 
> $ echo -1 | sudo tee /sys/block/nvme1n1/queue/io_poll_delay
> $ fio --ioengine io_uring --rw write --filesize 1GB --overwrite=1 --name=test --direct=1 --bs=$((1024*4)) --time_based=1 --runtime=10 --hipri --iodepth 1
> 93.4k iops
> 
> $ fio --ioengine io_uring --rw write --filesize 1GB --overwrite=1 --name=test --direct=1 --bs=$((1024*4)) --time_based=1 --runtime=10 --hipri --iodepth 32
> 426k iops
> 
> $ echo 0 | sudo tee /sys/block/nvme1n1/queue/io_poll_delay
> $ fio --ioengine io_uring --rw write --filesize 1GB --overwrite=1 --name=test --direct=1 --bs=$((1024*4)) --time_based=1 --runtime=10 --hipri --iodepth 1
> 94.3k iops
> 
> $ fio --ioengine io_uring --rw write --filesize 1GB --overwrite=1 --name=test --direct=1 --bs=$((1024*4)) --time_based=1 --runtime=10 --hipri --iodepth 32
> 167 iops
> fio took 33s
> 
> 
> However, if I ask fio / io_uring to perform all those IOs at once, the performance is pretty decent again (but obviously that's not that desirable)
> 
> $ fio --ioengine io_uring --rw write --filesize 1GB --overwrite=1 --name=test --direct=1 --bs=$((1024*4)) --time_based=1 --runtime=10 --hipri --iodepth 32 --iodepth_batch_submit=32 --iodepth_batch_complete_min=32
> 394k iops
> 
> 
> So it looks like there's something wrong around tracking what needs to
> be polled for in hybrid mode.
-- 
Pavel Begunkov
