Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C151FC17440
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 14:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F40222C5
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 14:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LsZjhUe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfKLO1A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:27:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42659 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfKLO1A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Nov 2019 09:27:00 -0500
Received: by mail-pf1-f195.google.com with SMTP id s5so13443167pfh.9
        for <linux-block@vger.kernel.org>; Tue, 12 Nov 2019 06:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xsX4vkIXtchloL78tpPr3rMdJ8PZpJ6BJHZ2kAG9slU=;
        b=LsZjhUe0PQ1y2MECo0wfM3LOj4tEo43D1W+iMx+g8qyq5fRbTfyrINigVSoyCjzJbF
         y8O2JRSMJAOClUh4MZ3pwOVZJXTs705V1KxBY76rXcmpBWDjRPTqQSe1HJfs/EELoZAV
         ojxyI7ODCBAcCK0Y5m2m8jjQ17sYxRgtX3wxWA2fAGRCNoPZGrMAJ6dm8udc2fTebhuV
         FpovRiLQdhF49Oke6rYTiiZitfiPLOKckfn717+7FSJ3jeHBZqiADMTMQ3Es1ZjelF0Y
         8Psx1JlJ9r00Tk2tomZqYjDZoSetelmT8HufsblIdqFsZmCBZfzHhQXuWllLZf0m1x7S
         Wduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xsX4vkIXtchloL78tpPr3rMdJ8PZpJ6BJHZ2kAG9slU=;
        b=r5mlT1YrUibQarSKIZ+iskKA3jzR4ZTu9O1XjoOizbPh2vNNTf6zcNwqYCR0WBvy1R
         MlIL8lm51Hp90nF5MABfxsu7KD3jUFm7sldTRm7Hf5NhIrRhAU1tO6z1u7y7xqsMYER3
         gYu9iJ3FqcxT2y2hNoilEs7tfYCb6q4XRqRGNYgoFXHegRxYN+CcKbnGs3A2eAq6dXMA
         h6UEtlI6whcRW6UajGmua4Pg82dCAr371BExPSIrfzIWw14mMA7a9Mfwr7w/HqTT0qHB
         7zagXjlwSmXdU3UZjv64b5M0KbCl0eN6P2vaY24BLrwA16jpM3thPJmy74rCXjB+VSOG
         k89Q==
X-Gm-Message-State: APjAAAW9y+QDF1J3/KOJ4eJOBjN9miLD5f3G3FpnUAtkPrFmsy4GZbl5
        IklovI/t1gLaujtgIZqFWYCPSg==
X-Google-Smtp-Source: APXvYqzqeMtv/xt/pYx3mCZNRbbjEt9OHqsnEIwVUKm1AmX3oMisjNguf7DPTkeRX/jvQDrrO2QrVw==
X-Received: by 2002:a62:7bd3:: with SMTP id w202mr34623529pfc.200.1573568819529;
        Tue, 12 Nov 2019 06:26:59 -0800 (PST)
Received: from [192.168.201.136] ([50.234.116.4])
        by smtp.gmail.com with ESMTPSA id w11sm18106581pgp.28.2019.11.12.06.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 06:26:58 -0800 (PST)
Subject: Re: [PATCH] block: check bi_size overflow before merge
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
References: <20191112071957.GA10061@jeru.linux.bs1.fc.nec.co.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <60f17a5b-aade-2a1f-8524-e8186a1dc66b@kernel.dk>
Date:   Tue, 12 Nov 2019 06:26:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112071957.GA10061@jeru.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/11/19 11:19 PM, Junichi Nomura wrote:
> __bio_try_merge_page() may merge a page to bio without bio_full() check
> and cause bi_size overflow.
> 
> The overflow typically ends up with sd_init_command() warning on zero
> segment request with call trace like this:
> 
>      ------------[ cut here ]------------
>      WARNING: CPU: 2 PID: 1986 at drivers/scsi/scsi_lib.c:1025 scsi_init_io+0x156/0x180
>      CPU: 2 PID: 1986 Comm: kworker/2:1H Kdump: loaded Not tainted 5.4.0-rc7 #1
>      Workqueue: kblockd blk_mq_run_work_fn
>      RIP: 0010:scsi_init_io+0x156/0x180
>      RSP: 0018:ffffa11487663bf0 EFLAGS: 00010246
>      RAX: 00000000002be0a0 RBX: ffff8e6e9ff30118 RCX: 0000000000000000
>      RDX: 00000000ffffffe1 RSI: 0000000000000000 RDI: ffff8e6e9ff30118
>      RBP: ffffa11487663c18 R08: ffffa11487663d28 R09: ffff8e6e9ff30150
>      R10: 0000000000000001 R11: 0000000000000000 R12: ffff8e6e9ff30000
>      R13: 0000000000000001 R14: ffff8e74a1cf1800 R15: ffff8e6e9ff30000
>      FS:  0000000000000000(0000) GS:ffff8e6ea7680000(0000) knlGS:0000000000000000
>      CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>      CR2: 00007fff18cf0fe8 CR3: 0000000659f0a001 CR4: 00000000001606e0
>      Call Trace:
>       sd_init_command+0x326/0xb40 [sd_mod]
>       scsi_queue_rq+0x502/0xaa0
>       ? blk_mq_get_driver_tag+0xe7/0x120
>       blk_mq_dispatch_rq_list+0x256/0x5a0
>       ? elv_rb_del+0x24/0x30
>       ? deadline_remove_request+0x7b/0xc0
>       blk_mq_do_dispatch_sched+0xa3/0x140
>       blk_mq_sched_dispatch_requests+0xfb/0x170
>       __blk_mq_run_hw_queue+0x81/0x130
>       blk_mq_run_work_fn+0x1b/0x20
>       process_one_work+0x179/0x390
>       worker_thread+0x4f/0x3e0
>       kthread+0x105/0x140
>       ? max_active_store+0x80/0x80
>       ? kthread_bind+0x20/0x20
>       ret_from_fork+0x35/0x40
>      ---[ end trace f9036abf5af4a4d3 ]---
>      blk_update_request: I/O error, dev sdd, sector 2875552 op 0x1:(WRITE) flags 0x0 phys_seg 0 prio class 0
>      XFS (sdd1): writeback error on sector 2875552
> 
> __bio_try_merge_page() should check the overflow before actually doing
> merge.

Nice catch, applied for 5.4, thanks!

-- 
Jens Axboe

