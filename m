Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BA5C433C1
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 15:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC02619B2
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 15:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhCWPjm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 11:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbhCWPjh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 11:39:37 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08DBC061763
        for <linux-block@vger.kernel.org>; Tue, 23 Mar 2021 08:39:36 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id x17so6856638iog.2
        for <linux-block@vger.kernel.org>; Tue, 23 Mar 2021 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MMOXNb+O2wXfYQW35rUSCGI74G6+HJz3hHwWTGaaHPo=;
        b=Vms0NpLf24bhKMFEGMXlMhZHupcUHxFR6xEoyBX7Ix9aLjemTLTkWUIiwvTvShMNcW
         G2wRzi9Q8nn8bCCuozZWyfek+LCDWONTgN5WV257GlyF3FSPMTg15sGH0coIBwMUvxyM
         FiDc+yb+yt0vMqY8WKrhlW1bS+cRR0UCepfTs8ROnsyLRQ3fqFyQoyoDBrmcHPs4yLJ8
         VdnNOYqhwiakCybuugtyvwcR8ILqOjLmxsiKlI5uKbV4K78aoLQNFzBo4ZNTGooFFGZR
         60GLLLrSfg2jGooCWYt7kmYG5aotnrtMXhKRnGgFxg8XvXS7sh/Mbeu6dhYUmL9nFHAM
         Mb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MMOXNb+O2wXfYQW35rUSCGI74G6+HJz3hHwWTGaaHPo=;
        b=H398HK+sw9fOs8MkS3EuFb7GR4BO094QaWAcWqbUHUcKciv41u9KL1dz92buN4Y7DQ
         Tprac/5eQc0i6jOfimnFj5KquBYhTh8Xzg0N5YGAcZthrM0gU/hoSiSEYGvPB9Nn5A3j
         22SoDE+aKTl6sus5VRK8ukXQ8D9JI+VKvCkFMdggC55SaznpovHgB8/NfomVweZGwOXc
         w1qfTm3v3Van5/tT59Uckpv4+S4CK/vCXN7d+qS9PzWrnveN8lWBRdDp8WY+YC2EdUd8
         XC2HNPeq8i+A0AujgjlslNuAmuPOzT/t5b+jzp0Uyt4NGqHSiWht+28Jn2gFHpbm+xPK
         RBTA==
X-Gm-Message-State: AOAM533u4YMVBMyPVgDalxG1sCz5p4bOUZjKv3aFxAlcGEr/lWTtmrPt
        wnX5fw5GTTQlgzMVhnDk6jKvpg==
X-Google-Smtp-Source: ABdhPJweG1DDe6bGzcXvI/3yUdC5fMk+FvUK+FyQVbBY3wnFeeqrJLes8iUdSzW2z3a98+WlcdxX4w==
X-Received: by 2002:a5e:d908:: with SMTP id n8mr4883261iop.121.1616513975896;
        Tue, 23 Mar 2021 08:39:35 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g16sm9545537iln.29.2021.03.23.08.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 08:39:35 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Fix races between iterating over requests and
 freeing requests
To:     John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20210319010009.10041-1-bvanassche@acm.org>
 <721c833d-7dc6-30a5-371e-c8c6388fb852@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ecab7c5c-53b8-61e4-800e-b9c368e4b8b4@kernel.dk>
Date:   Tue, 23 Mar 2021 09:39:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <721c833d-7dc6-30a5-371e-c8c6388fb852@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/23/21 6:34 AM, John Garry wrote:
> On 19/03/2021 01:00, Bart Van Assche wrote:
>> Multiple users have reported use-after-free complaints similar to the
>> following (see also https://lore.kernel.org/linux-block/1545261885.185366.488.camel@acm.org/):
>>
>> BUG: KASAN: use-after-free in bt_iter+0x86/0xf0
>> Read of size 8 at addr ffff88803b335240 by task fio/21412
>>
>> CPU: 0 PID: 21412 Comm: fio Tainted: G        W         4.20.0-rc6-dbg+ #3
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> Call Trace:
>>   dump_stack+0x86/0xca
>>   print_address_description+0x71/0x239
>>   kasan_report.cold.5+0x242/0x301
>>   __asan_load8+0x54/0x90
>>   bt_iter+0x86/0xf0
>>   blk_mq_queue_tag_busy_iter+0x373/0x5e0
>>   blk_mq_in_flight+0x96/0xb0
>>   part_in_flight+0x40/0x140
>>   part_round_stats+0x18e/0x370
>>   blk_account_io_start+0x3d7/0x670
>>   blk_mq_bio_to_request+0x19c/0x3a0
>>   blk_mq_make_request+0x7a9/0xcb0
>>   generic_make_request+0x41d/0x960
>>   submit_bio+0x9b/0x250
>>   do_blockdev_direct_IO+0x435c/0x4c70
>>   __blockdev_direct_IO+0x79/0x88
>>   ext4_direct_IO+0x46c/0xc00
>>   generic_file_direct_write+0x119/0x210
>>   __generic_file_write_iter+0x11c/0x280
>>   ext4_file_write_iter+0x1b8/0x6f0
>>   aio_write+0x204/0x310
>>   io_submit_one+0x9d3/0xe80
>>   __x64_sys_io_submit+0x115/0x340
>>   do_syscall_64+0x71/0x210
>>
> 
> Hi Bart,
> 
> Do we have any performance figures to say that the effect is negligible?

I ran this through my usual peak testing, it's pretty good at finding
any changes in performance related to changes in overhead. The workload
is a pretty simple 512b random read, QD 128, using io_uring and polled
IO.

It seems to cause a slight slowdown for me. Performance before the patch
is around 3.23-3.27M IOPS, and after we're at around 3.20-3.22. Looking
at perf diff, the most interesting bits seem to be:


2.09%     -1.05%  [kernel.vmlinux]  [k] blk_mq_get_tag
0.48%     +0.98%  [kernel.vmlinux]  [k] __do_sys_io_uring_enter
1.49%     +0.85%  [kernel.vmlinux]  [k] __blk_mq_alloc_request
          +0.71%  [kernel.vmlinux]  [k] __blk_mq_free_request

which seems to show some shifting around of cost (often happens), but
generally up a bit looking at the blk side.

So nothing really major here, and I don't think it's something that
should getting this fixed. John, I can run your series through the same,
let me know.

-- 
Jens Axboe

