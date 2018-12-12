Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA08C6783B
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 00:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D154020849
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 00:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QMnrpQHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D154020849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeLLADD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:03:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41857 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeLLADC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 19:03:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so7917310pfi.8
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 16:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SGBLbRLkEfyF2sjD+TFDp/jkGBNq0TL7k/4J8CjI32U=;
        b=QMnrpQHZp/r91EKur5BTy6phR3VfoGgfwmCGJgde8Lykph1+sXDA2rgsvWymGjctJD
         X5qbG0Foa/iKLB7TFHkKTV7h6IgEAflRl8u+omrH8EdurUlb3FuTr65bd6PNdZKyG/wv
         xqfdpTGUSFolHN6Wahw+ZNXC1Os3nQHC+OPNSVLgGodfiRSHx13WDz6zkWJexXHOKqa5
         PuXyoWDi1wToP+T8v5rTC+a0LEGZXipn0nxNsD9BCIcUE7qI1yZK0DfhPjUwT7z8RNGt
         eQQ3hth+QI+fHQTqoG0zGax7mkWE/lXdGoLEAtUn95FkCsMhS4kPYvr2o3J5s2oyXEGG
         MKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SGBLbRLkEfyF2sjD+TFDp/jkGBNq0TL7k/4J8CjI32U=;
        b=pITGpMHWc+SQnVkeDkeMoZQrxkyx+/TnuFNOSJg7+MZdHhjP3uNE2xB53+ZvdhiGEC
         leCX84cF/vd2jbrmqAuOgeCg9s96y3fqY3dizv5EHJhAJ2TsTlzr4CVATMReBZCFDp3e
         sZzkysgl1zlYgWe8s9FLp0yJtbRJq/uKu3i3r+f2P2vbodrw6GQEy+Z92miA+cebkROi
         h25p2eb/McOWf0xWlKnFJTCP5wI2ymET8H5ErMxwAxv15w+V4uWVST3jNwtxMnrT41fc
         f5Zr2IoTejq35Ak1/AMCkPgOwnVINeSqpTTuvTIAwgrkW5v5HbDwH45TEJ9NSt5iexo4
         cTOA==
X-Gm-Message-State: AA+aEWZYlUQQkBViMh0WOSWrUTSCnOqh1u0vtl0ZrzTWXbhnN1pseK2M
        4ZyId6r0xh8/3HN9MI1OB7NAgg==
X-Google-Smtp-Source: AFSGD/Xk9a/0cTjXk+iOWub+aH85W4+Rh1K5xmSZR6TdGWKIkZSlHJl9xvZ+RmrbWjVR0YDhVOP2hQ==
X-Received: by 2002:a63:6483:: with SMTP id y125mr16249178pgb.91.1544572981866;
        Tue, 11 Dec 2018 16:03:01 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id z186sm22916080pfz.119.2018.12.11.16.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:03:00 -0800 (PST)
Subject: Re: for-next hangs on test srp/012
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <1544569107.185366.391.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0688562b-7776-7efe-10dd-caf2a6a4f274@kernel.dk>
Date:   Tue, 11 Dec 2018 17:02:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544569107.185366.391.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/18 3:58 PM, Bart Van Assche wrote:
> Hi Jens,
> 
> If I run the following subset of blktests:
> 
>   while :; do ./check -q srp && ./check -q nvmeof-mp; done
> 
> against today's for-next branch (commit dd2bf2df85a7) then after some
> time the following hang is reported:
> 
> INFO: task fio:14869 blocked for more than 120 seconds.
>       Not tainted 4.20.0-rc6-dbg+ #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> fio             D25272 14869  14195 0x00000000
> Call Trace:
>  __schedule+0x401/0xe50
>  schedule+0x4e/0xd0
>  io_schedule+0x21/0x50
>  blk_mq_get_tag+0x46d/0x640
>  blk_mq_get_request+0x7c0/0xa00
>  blk_mq_make_request+0x241/0xa70
>  generic_make_request+0x411/0x950
>  submit_bio+0x9b/0x250
>  blkdev_direct_IO+0x7fb/0x870
>  generic_file_direct_write+0x119/0x210
>  __generic_file_write_iter+0x11c/0x280
>  blkdev_write_iter+0x13c/0x220
>  aio_write+0x204/0x310
>  io_submit_one+0x9c6/0xe70
>  __x64_sys_io_submit+0x115/0x340
>  do_syscall_64+0x71/0x210
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> When that hang occurs my list-pending-block-requests script does not show
> any pending requests:
> 
> # list-pending-block-requests        
> dm-0
> loop0
> loop1
> loop2
> loop3
> loop4
> loop5
> loop6
> loop7
> nullb0
> nullb1
> sda
> sdb
> sdc
> sdd
> vda
> vdb
> 
> Enabling fail_if_no_path mode did not resolve the hang so I don't think
> that the root cause is in any of the dm drivers used in this test:
> 
> # dmsetup ls | while read dm rest; do dmsetup message $dm 0 fail_if_no_path; done; dmsetup remove_all; dmsetup table
> 360014056e756c6c62300000000000000: 0 65536 multipath 0 1 alua 1 1 service-time 0 1 2 8:16 1 1
> 
> The same test passes against kernel v4.20-rc6.

What device is this being run on?

-- 
Jens Axboe

