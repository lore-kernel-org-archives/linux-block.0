Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A38C4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 14:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EBF960698
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 14:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFUOHe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 10:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229747AbhFUOHe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 10:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624284319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=upfGk/98pZA3QPB7oLwR+MhWulCYYbB02mWSMUEUjto=;
        b=SDa/94fMh5TetvADTMwzke2gr63Nwv6kbtftSamNoBLjKywE8wT1EKK6Vh5jWrcXob6DwT
        XNpK2Pas5AnuQbFlfjjNFVwtHMFWAVpVH024R6qefKwKD0neTEg58qZ/F2BXn8n/iVzHst
        BpI7FM06iTLiaRQxrnVj7IysOBao2pg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-F8WHfA80MJ2mAUFgVXYtQQ-1; Mon, 21 Jun 2021 10:05:18 -0400
X-MC-Unique: F8WHfA80MJ2mAUFgVXYtQQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CED461054F98;
        Mon, 21 Jun 2021 14:05:15 +0000 (UTC)
Received: from T590 (ovpn-12-104.pek2.redhat.com [10.72.12.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38A2C60853;
        Mon, 21 Jun 2021 14:04:59 +0000 (UTC)
Date:   Mon, 21 Jun 2021 22:04:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [dm-devel] [RFC PATCH V2 3/3] dm: support bio polling
Message-ID: <YNCchke/OxQVnSZA@T590>
References: <20210617103549.930311-1-ming.lei@redhat.com>
 <20210617103549.930311-4-ming.lei@redhat.com>
 <5ba43dac-b960-7c85-3a89-fdae2d1e2f51@linux.alibaba.com>
 <YMywCX6nLqLiHXyy@T590>
 <9b42601a-ca54-4748-e592-3720b7994d7b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b42601a-ca54-4748-e592-3720b7994d7b@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 21, 2021 at 07:33:34PM +0800, JeffleXu wrote:
> 
> 
> On 6/18/21 10:39 PM, Ming Lei wrote:
> > From 47e523b9ee988317369eaadb96826323cd86819e Mon Sep 17 00:00:00 2001
> > From: Ming Lei <ming.lei@redhat.com>
> > Date: Wed, 16 Jun 2021 16:13:46 +0800
> > Subject: [RFC PATCH V3 3/3] dm: support bio polling
> > 
> > Support bio(REQ_POLLED) polling in the following approach:
> > 
> > 1) only support io polling on normal READ/WRITE, and other abnormal IOs
> > still fallback on IRQ mode, so the target io is exactly inside the dm
> > io.
> > 
> > 2) hold one refcnt on io->io_count after submitting this dm bio with
> > REQ_POLLED
> > 
> > 3) support dm native bio splitting, any dm io instance associated with
> > current bio will be added into one list which head is bio->bi_end_io
> > which will be recovered before ending this bio
> > 
> > 4) implement .poll_bio() callback, call bio_poll() on the single target
> > bio inside the dm io which is retrieved via bio->bi_bio_drv_data; call
> > dec_pending() after the target io is done in .poll_bio()
> > 
> > 4) enable QUEUE_FLAG_POLL if all underlying queues enable QUEUE_FLAG_POLL,
> > which is based on Jeffle's previous patch.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> > V3:
> > 	- covers all comments from Jeffle
> > 	- fix corner cases when polling on abnormal ios
> > 
> ...
> 
> One bug and one performance issue, though I haven't investigated deep
> for both.
> 
> 
> kernel base: based on Jens' for-next, applying Christoph and Leiming's
> patchset.
> 
> 
> 1. One bug when there's DM device stack, e.g., dm-linear upon another
> dm-linear. Can be reproduced by following steps:
> 
> ```
> $ sudo dmsetup create tmpdev --table '0 2097152 linear /dev/nvme0n1 0'
> 
> $ cat tmp.table
> 0 2097152 linear /dev/mapper/tmpdev 0
> 2097152 2097152 linear /dev/nvme0n1 0
> 
> $ cat tmp.table | dmsetup create testdev
> 
> $ fio -name=test -ioengine=io_uring -iodepth=128 -numjobs=1 -thread
> -rw=randread -direct=1 -bs=4k -time_based -runtime=10 -cpus_allowed=6
> -filename=/dev/mapper/testdev -hipri=1
> ```
> 
> 
> BUG: unable to handle page fault for address: ffffffffc01a6208
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0003) - permissions violation
> PGD 39740c067 P4D 39740c067 PUD 39740e067 PMD 1035db067 PTE 1ddf6f061
> Oops: 0003 [#1] SMP PTI
> CPU: 6 PID: 5899 Comm: fio Tainted: G S
> 5.13.0-0.1.git.81bcdc3.al7.x86_64 #1
> Hardware name: Inventec     K900G3-10G/B900G3, BIOS A2.20 06/23/2017
> RIP: 0010:dm_submit_bio+0x171/0x3e0 [dm_mod]

It has been fixed in my local repo:

@@ -1608,6 +1649,7 @@ static void init_clone_info(struct clone_info *ci, struct mapped_device *md,
        ci->map = map;
        ci->io = alloc_io(md, bio);
        ci->sector = bio->bi_iter.bi_sector;
+       ci->submit_as_polled = false;

> 
> 
> 2. Performance Issue
> 
> I test both on x86 (with only one NVMe) and aarch64 (with multiple NVMes).
> 
> The result (IOPS) on x86 is as expected:
> 
> Type 	  |IRQ   | Polling
> --------- | ---- | ----
> dm-linear | 239k | 357k
> 
> - dm-linear built upon one NVMe，bs=4k, iopoll=1, iodepth=128,
> numjobs=1, direct, randread, ioengine=io_uring

This data looks good.

> 
> 
> 
> While the result on aarch64 is a little confusing.
> 
> Type 	      |IRQ   | Polling
> ------------- | ---- | ----
> dm-linear [1] | 208k | 230k
> dm-linear [2] | 637k | 691k
> dm-stripe     | 310k | 354k
> 
> - dm-linear [1] built upon *one* NVMe，bs=4k, iopoll=1, iodepth=128,
> *numjobs=1*, direct, randread, ioengine=io_uring
> - dm-linear [2] built upon *three* NVMes，bs=4k, iopoll=1, iodepth=128,
> *numjobs=3*, direct, randread, ioengine=io_uring
> - dm-stripe built upon *three* NVMes，chunk_size=4k, bs=12k, iopoll=1,
> iodepth=128, numjobs=3, direct, randread, ioengine=io_uring
> 
> 
> Following is the corresponding test result of Leiming's last
> implementation for bio-based polling on aarch64.
> IRQ	IOPOLL	ratio
> dm-linear [2]	639K	835K	~30%
> dm-stripe 	314K	408K	~30%

The previous version polls one hw queue once if bios are submitted to
same hw queue. We might improve it in future.


Thanks,
Ming

