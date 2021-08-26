Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BBFC432BE
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 23:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A80A360F11
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 23:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243852AbhHZXuf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 19:50:35 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:36389 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243854AbhHZXue (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 19:50:34 -0400
Received: by mail-pg1-f169.google.com with SMTP id t1so4471762pgv.3
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 16:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ej0AXHAH0jLVsC6JuxaJKzuk6jfkcv2M/3eovG+AHc=;
        b=rMIVflVbuUg4VMkTyOMIaR11Ma1O0EQOus9sS/GoCFcKJgiozDrisczOa/iJTGHv8o
         bm08nAImE2BKUiX0W/acF4JjJ/fKgNM3KzTJIkBBxiW3JJI404a1Ndxv6gO+k3f3eEbm
         4KRwIyeHHXnA4I2bYD+UoBpCpfjX6vl3V/mBZ/Cs8YhUDNuMcvFe1o9qk9shpK7o4QMr
         60TtRbrhET7TVuCheJsVmEJy9CzyhdpLtPEocOHiMiA/J8m3Xck3FMIPaS9m9HVpIe1P
         WY4DWOUy4qZKIkTl8t10xYKlkidUG7xSG8klV77hPL7x/gqs07eMxDDmFd7D+rWp/+9P
         rjpA==
X-Gm-Message-State: AOAM530tkNgbPZC0HetElvC4UzVEDkmoBr9k0axR5Y2NpVaUv4qmNSiW
        RgG3BocQAzIkAwlLsmxoCEM=
X-Google-Smtp-Source: ABdhPJxm3oFuMSn0WTRk3IBEOltl0yvaF6dEiLTPcxKR5thK8VL78PfA0CGm2/xF554tnIIaGMAzJg==
X-Received: by 2002:a63:4455:: with SMTP id t21mr5431139pgk.91.1630021786316;
        Thu, 26 Aug 2021 16:49:46 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:22e3:6079:e5ce:5e45? ([2601:647:4000:d7:22e3:6079:e5ce:5e45])
        by smtp.gmail.com with ESMTPSA id cq8sm3714818pjb.31.2021.08.26.16.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 16:49:45 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
To:     Jens Axboe <axboe@kernel.dk>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>
References: <20210826144039.2143-1-thunder.leizhen@huawei.com>
 <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
 <537620de-646d-e78e-ccb8-4105bac398b3@kernel.dk>
 <82612be1-d61e-1ad5-8fb5-d592a5bc4789@kernel.dk>
Message-ID: <59c19a63-f321-94e8-cb31-87e88bd4e3d5@acm.org>
Date:   Thu, 26 Aug 2021 16:49:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <82612be1-d61e-1ad5-8fb5-d592a5bc4789@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/26/21 11:45 AM, Jens Axboe wrote:
> Just ran a quick test here, and I go from 3.55M IOPS to 1.23M switching
> to deadline, of which 37% of the overhead is from dd_dispatch().
> 
> With the posted patch applied, it runs at 2.3M IOPS with mq-deadline,
> which is a lot better. This is on my 3970X test box, so 32 cores, 64
> threads.

Hi Jens,

With the script below, queue depth >= 2 and an improved version of
Zhen's patch I see 970 K IOPS with the mq-deadline scheduler in an
8 core VM (i7-4790 CPU). In other words, more IOPS than what Zhen
reported with fewer CPU cores. Is that good enough?

Thanks,

Bart.

#!/bin/bash

if [ -e /sys/kernel/config/nullb ]; then
    for d in /sys/kernel/config/nullb/*; do
        [ -d "$d" ] && rmdir "$d"
    done
fi
numcpus=$(grep -c ^processor /proc/cpuinfo)
modprobe -r null_blk
[ -e /sys/module/null_blk ] && exit $?
modprobe null_blk nr_devices=0 &&
    udevadm settle &&
    cd /sys/kernel/config/nullb &&
    mkdir nullb0 &&
    cd nullb0 &&
    echo 0 > completion_nsec &&
    echo 512 > blocksize &&
    echo 0 > home_node &&
    echo 0 > irqmode &&
    echo 1024 > size &&
    echo 0 > memory_backed &&
    echo 2 > queue_mode &&
    echo 1 > power ||
    exit $?

(
    cd /sys/block/nullb0/queue &&
	echo 2 > rq_affinity
) || exit $?

iodepth=${1:-1}
runtime=30
args=()
if [ "$iodepth" = 1 ]; then
	args+=(--ioengine=psync)
else
	args+=(--ioengine=io_uring --iodepth_batch=$((iodepth/2)))
fi
args+=(--iodepth=$iodepth --name=nullb0 --filename=/dev/nullb0\
    --rw=read --bs=512 --loops=$((1<<20)) --direct=1 --numjobs=$numcpus \
    --thread --runtime=$runtime --invalidate=1 --gtod_reduce=1 \
    --group_reporting=1 --ioscheduler=mq-deadline)
if numactl -m 0 -N 0 echo >&/dev/null; then
	numactl -m 0 -N 0 -- fio "${args[@]}"
else
	fio "${args[@]}"
fi

