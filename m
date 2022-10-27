Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27BEECAAA1
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 20:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbiJ0Uwa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 16:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbiJ0Uvw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 16:51:52 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D167769BED
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 13:45:19 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id l127so2795866iof.12
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 13:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w3cNJszIOLu7Ajbt6UF4medPVH6NcGkPBqBqEjUUtIg=;
        b=vTslt0uz8a0xdXYgHZ4p/lEXYLpP2dXZPTZ7iLKwSoA2HTeivZrW5WBmBqvEVj+VJk
         NvE/oEoQ2hYuO+wGANCFVwsMMo7ug00T4xw8MYUruuSe/1im4FtuCVTnGZc8XS1aEQT3
         GgKJCDYrtZFM8adVwc7R4n7PH30yMKLojj2tyjmKE+nmd7As61CN/n+Q5k064I57F2Nn
         /izMwXhgNeZIjYwUr+tXd8+3r8+UMEi5rcG4m2/1isrnH5RYsuPGCpuMe6FZw2n66vdO
         IUd/+/FMvsIfag+cg/Mb38mGUQvueHfKk07Cq8/Cij8EoZweI1SH50jishhd3pBenVFg
         uisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3cNJszIOLu7Ajbt6UF4medPVH6NcGkPBqBqEjUUtIg=;
        b=wGwUopblF12WXklS1Y1962dqckM2fV0hhbn56POjLkVDhDhoTpUbZG0Oks4k7BsTp3
         heJ50cNMiW5s/WYNUvrT7bR3oVvk37xOD3xjEoAT653pGI6/ZGg4a+cuE1MRElp2lpwS
         zlbzZaxUjP7i5bIEAqEB4sGexUd9oiAP6AWWpVBEXhJGzZaquvXvMj8+cpHPpalpyJP4
         f3mw+as+RF3rQAMzvemc5M0Olb+xwsckUhh225LZioSXaYh1pn6lihF2rhKy4431r6z8
         MRCFwxnudV0eEp9bAbPxmdwiZwitojxmE7KhUUaHb76qPKsZw+gVkcI+dugk8do9HkgU
         YnOQ==
X-Gm-Message-State: ACrzQf3YuoFO+v/ZxhLCUBGy7sxyKb7xxJHHBoiJnap7qdzmxs1UlWbb
        svQLtAC3EC+8f/II4PDRrtwjCw==
X-Google-Smtp-Source: AMsMyM7ihZICvnX5tVGjRwvpiRdwxZJMYejBFqq4K0MIWYhtb8eIv+TFJhTgmjF7bGFi0I+mSdnbPA==
X-Received: by 2002:a05:6638:2412:b0:370:8315:7731 with SMTP id z18-20020a056638241200b0037083157731mr15059131jat.212.1666903474899;
        Thu, 27 Oct 2022 13:44:34 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i10-20020a056e0212ca00b002ff9ea02044sm884750ilm.61.2022.10.27.13.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 13:44:34 -0700 (PDT)
Message-ID: <38b863cd-9cec-1300-6d92-a0a5b89b3399@kernel.dk>
Date:   Thu, 27 Oct 2022 14:44:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] block: fix bio-allocation from per-cpu cache
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>, asml.silence@gmail.com,
        linux-block@vger.kernel.org
References: <CGME20221027101534epcas5p3b8335c05a1003531f1a4488dc27f27ee@epcas5p3.samsung.com>
 <20221027100410.3891-1-joshi.k@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221027100410.3891-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/22 4:04 AM, Kanchan Joshi wrote:
> If cache does not have any entry, make sure to detect that and return
> failure. Otherwise this leads to null pointer dereference.
> 
> Fixes: 13a184e26965 ("block/bio: add pcpu caching for non-polling bio_put")
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
> Can be reproduced by:
> fio -direct=1 -iodepth=1 -rw=randread -ioengine=io_uring -bs=4k -numjobs=1 -size=4k -filename=/dev/nvme0n1 -hipri=1 -name=block
> 
> BUG: KASAN: null-ptr-deref in bio_alloc_bioset.cold+0x2a/0x16a
> Read of size 8 at addr 0000000000000000 by task fio/1835
> 
> CPU: 5 PID: 1835 Comm: fio Not tainted 6.1.0-rc2+ #226
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x34/0x48
>  print_report+0x490/0x4a1
>  ? __virt_addr_valid+0x28/0x140
>  ? bio_alloc_bioset.cold+0x2a/0x16a
>  kasan_report+0xb3/0x130
>  ? bio_alloc_bioset.cold+0x2a/0x16a
>  bio_alloc_bioset.cold+0x2a/0x16a
>  ? bvec_alloc+0xf0/0xf0
>  ? iov_iter_is_aligned+0x130/0x2c0
>  blkdev_direct_IO.part.0+0x16a/0x8d0

Was going to apply this, but after running some testing, it does
fix the initial crash but I still get weird corruption crashes
with the series it's fixing.

Pavel, I'm going to drop this series for now.

-- 
Jens Axboe


