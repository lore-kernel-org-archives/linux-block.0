Return-Path: <SRS0=923v=WB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FE3C0650F
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 17:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5C7208E3
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 17:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfHERLf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:11:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38119 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHERLf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Aug 2019 13:11:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so36690710plb.5
        for <linux-block@vger.kernel.org>; Mon, 05 Aug 2019 10:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TmiGhC2Z9FD7tD69VPok7/EvDMfAQV7qY55hppLJ6Ec=;
        b=UFQVTbiSpUPlAWSkhmRpfqVu8PCRW8jG2GR40B4+9MbgzEDq0zzwRh14sp/hN+X6fX
         vxmW4u54Jo8/hoyHx3RFoy7VJvp/h9c9+pidUSGNnWXZ6XSzDyb0bKmvC0TFIOrT5hXu
         A6s7hENx+Bk1LSJi7lwcU9B1r2oJN4CzJp+1IXpGIg015nrD6S4lEHg0ZgcGjZoCXK73
         nf+EXsd/NMrqVadDy4lVQEaDgHIpZLLIoo424UdOf3pQvlX3ypbuyucFP23barPBCy8h
         SjJYVB2J2dDguvaBXId5u8UK0FaYozsYMXir1bU7q6C5bNzIXostpGVQKUz1pXQT13GZ
         pTpw==
X-Gm-Message-State: APjAAAXT/tD91jkUdp35D8gJCIZioDshSnsOf0R4Sp0hmI005GPNU/PE
        kpGRjGK9RsyITfST5HjkvPlGN/MN
X-Google-Smtp-Source: APXvYqzicCJenq3QPDDUM0y+Stz7ax4ETuQ0jUilAAuShQ+7AaE9WhXU/D/e53mfK/Wyet8JMcIVXQ==
X-Received: by 2002:a17:902:9346:: with SMTP id g6mr145153457plp.61.1565025094001;
        Mon, 05 Aug 2019 10:11:34 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id o12sm14306524pjr.22.2019.08.05.10.11.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 10:11:33 -0700 (PDT)
Subject: Re: [PATCH] block: Fix __blkdev_direct_IO()
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Masato Suzuki <masato.suzuki@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
References: <20190801102151.7846-1-damien.lemoal@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8d6bb95a-3bf5-4bee-90ca-1b0110e39ff1@acm.org>
Date:   Mon, 5 Aug 2019 10:11:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801102151.7846-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/1/19 3:21 AM, Damien Le Moal wrote:
> The recent fix to properly handle IOCB_NOWAIT for async O_DIRECT IO
> (patch 6a43074e2f46) introduced two problems with BIO fragment handling
> for direct IOs:
> 1) The dio size processed is claculated by incrementing the ret variable
> by the size of the bio fragment issued for the dio. However, this size
> is obtained directly from bio->bi_iter.bi_size AFTER the bio submission
> which may result in referencing the bi_size value after the bio
> completed, resulting in an incorrect value use.
> 2) The ret variable is not incremented by the size of the last bio
> fragment issued for the bio, leading to an invalid IO size being
> returned to the user.
> 
> Fix both problem by using dio->size (which is incremented before the bio
> submission) to update the value of ret after bio submissions, including
> for the last bio fragment issued.
> 
> Fixes: 6a43074e2f46 ("block: properly handle IOCB_NOWAIT for async O_DIRECT IO")
> Reported-by: Masato Suzuki <masato.suzuki@wdc.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   fs/block_dev.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index c2a85b587922..75cc7f424b3a 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -439,6 +439,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>   					ret = -EAGAIN;
>   				goto error;
>   			}
> +			ret = dio->size;
>   
>   			if (polled)
>   				WRITE_ONCE(iocb->ki_cookie, qc);
> @@ -465,7 +466,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>   				ret = -EAGAIN;
>   			goto error;
>   		}
> -		ret += bio->bi_iter.bi_size;
> +		ret = dio->size;
>   
>   		bio = bio_alloc(gfp, nr_pages);
>   		if (!bio) {

Hi Damien,

Had you verified this patch with blktests and KASAN enabled? I think the
above patch introduced the following KASAN complaint:

==================================================================
BUG: KASAN: use-after-free in blkdev_direct_IO+0x9d5/0xa20
Read of size 8 at addr ffff888114d872c8 by task fio/12456

CPU: 3 PID: 12456 Comm: fio Not tainted 5.3.0-rc3-dbg+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Call Trace:
  dump_stack+0x86/0xca
  print_address_description+0x74/0x32d
  __kasan_report.cold.6+0x1b/0x36
  kasan_report+0x12/0x17
  __asan_load8+0x54/0x90
  blkdev_direct_IO+0x9d5/0xa20
  generic_file_direct_write+0x10e/0x200
  __generic_file_write_iter+0x120/0x2a0
  blkdev_write_iter+0x13c/0x220
  aio_write+0x1bb/0x2d0
  io_submit_one+0xe30/0x18e0
  __x64_sys_io_submit+0x117/0x350
  do_syscall_64+0x71/0x270
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Allocated by task 12456:
  save_stack+0x21/0x90
  __kasan_kmalloc.constprop.9+0xc7/0xd0
  kasan_slab_alloc+0x11/0x20
  kmem_cache_alloc+0xf9/0x3a0
  mempool_alloc_slab+0x15/0x20
  mempool_alloc+0xef/0x260
  bio_alloc_bioset+0x148/0x310
  blkdev_direct_IO+0x223/0xa20
  generic_file_direct_write+0x10e/0x200
  __generic_file_write_iter+0x120/0x2a0
  blkdev_write_iter+0x13c/0x220
  aio_write+0x1bb/0x2d0
  io_submit_one+0xe30/0x18e0
  __x64_sys_io_submit+0x117/0x350
  do_syscall_64+0x71/0x270
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 26:
  save_stack+0x21/0x90
  __kasan_slab_free+0x139/0x190
  kasan_slab_free+0xe/0x10
  slab_free_freelist_hook+0x67/0x1e0
  kmem_cache_free+0x102/0x320
  mempool_free_slab+0x17/0x20
  mempool_free+0x63/0x160
  bio_free+0x144/0x210
  bio_put+0x59/0x60
  blkdev_bio_end_io+0x172/0x1f0
  bio_endio+0x2b8/0x4c0
  blk_update_request+0x180/0x4f0
  end_clone_bio+0xbb/0xd0
  bio_endio+0x2b8/0x4c0
  blk_update_request+0x180/0x4f0
  blk_mq_end_request+0x33/0x200
  nvme_complete_rq+0xff/0x420 [nvme_core]
  nvme_rdma_complete_rq+0xba/0x100 [nvme_rdma]
  blk_mq_complete_request+0x174/0x250
  nvme_rdma_recv_done+0x330/0x5a0 [nvme_rdma]
  __ib_process_cq+0x8c/0x100 [ib_core]
  ib_poll_handler+0x47/0xb0 [ib_core]
  irq_poll_softirq+0xf5/0x270
  __do_softirq+0x128/0x60f

(gdb) list *(blkdev_direct_IO+0x9d5)
0x49c5 is in blkdev_direct_IO (fs/block_dev.c:442).
437                             if (qc == BLK_QC_T_EAGAIN) {
438                                     if (!ret)
439                                             ret = -EAGAIN;
440                                     goto error;
441                             }
442                             ret = dio->size;
443
444                             if (polled)
445                                     WRITE_ONCE(iocb->ki_cookie, qc);
446                             break;


