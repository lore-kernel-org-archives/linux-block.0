Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B5FC4743C
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 02:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76EE960FEB
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 02:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhFVCsC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 22:48:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42125 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230045AbhFVCsB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 22:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624329945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vL11UxMPyDMwQrfDzx++stQ9MkHn49ENBfKq+N76pFI=;
        b=Q4X8sxz4lrjrVk15vHNWLngqCrHGZFAvuL+lfezS40I77H7yENV6liCaOh2OG3GDJJzm/7
        3YlYf7h6N0kCPIkZP1CMFJSL+p5rOYT+x+BIBFOGadD3QQ3HmNg2V4Jt7H77fbKjKIraBC
        Wc5I2tX7UPN7I4iA5nguftB+fhU/Vsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-fKq6hiCIPWeYkCugQKjwRQ-1; Mon, 21 Jun 2021 22:45:41 -0400
X-MC-Unique: fKq6hiCIPWeYkCugQKjwRQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D108800C60;
        Tue, 22 Jun 2021 02:45:40 +0000 (UTC)
Received: from T590 (ovpn-13-127.pek2.redhat.com [10.72.13.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BAE7910016FE;
        Tue, 22 Jun 2021 02:45:27 +0000 (UTC)
Date:   Tue, 22 Jun 2021 10:45:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [dm-devel] [RFC PATCH V2 3/3] dm: support bio polling
Message-ID: <YNFOw9Ko8rZh1eyD@T590>
References: <20210617103549.930311-1-ming.lei@redhat.com>
 <20210617103549.930311-4-ming.lei@redhat.com>
 <5ba43dac-b960-7c85-3a89-fdae2d1e2f51@linux.alibaba.com>
 <YMywCX6nLqLiHXyy@T590>
 <9b42601a-ca54-4748-e592-3720b7994d7b@linux.alibaba.com>
 <YNCchke/OxQVnSZA@T590>
 <ba95e8f3-7466-7167-bcfd-49f89ee0b99c@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba95e8f3-7466-7167-bcfd-49f89ee0b99c@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 10:26:15AM +0800, JeffleXu wrote:
> 
> 
> On 6/21/21 10:04 PM, Ming Lei wrote:
> > On Mon, Jun 21, 2021 at 07:33:34PM +0800, JeffleXu wrote:
> >>
> >>
> >> On 6/18/21 10:39 PM, Ming Lei wrote:
> >>> From 47e523b9ee988317369eaadb96826323cd86819e Mon Sep 17 00:00:00 2001
> >>> From: Ming Lei <ming.lei@redhat.com>
> >>> Date: Wed, 16 Jun 2021 16:13:46 +0800
> >>> Subject: [RFC PATCH V3 3/3] dm: support bio polling
> >>>
> >>> Support bio(REQ_POLLED) polling in the following approach:
> >>>
> >>> 1) only support io polling on normal READ/WRITE, and other abnormal IOs
> >>> still fallback on IRQ mode, so the target io is exactly inside the dm
> >>> io.
> >>>
> >>> 2) hold one refcnt on io->io_count after submitting this dm bio with
> >>> REQ_POLLED
> >>>
> >>> 3) support dm native bio splitting, any dm io instance associated with
> >>> current bio will be added into one list which head is bio->bi_end_io
> >>> which will be recovered before ending this bio
> >>>
> >>> 4) implement .poll_bio() callback, call bio_poll() on the single target
> >>> bio inside the dm io which is retrieved via bio->bi_bio_drv_data; call
> >>> dec_pending() after the target io is done in .poll_bio()
> >>>
> >>> 4) enable QUEUE_FLAG_POLL if all underlying queues enable QUEUE_FLAG_POLL,
> >>> which is based on Jeffle's previous patch.
> >>>
> >>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>> ---
> >>> V3:
> >>> 	- covers all comments from Jeffle
> >>> 	- fix corner cases when polling on abnormal ios
> >>>
> >> ...
> >>
> >> One bug and one performance issue, though I haven't investigated deep
> >> for both.
> >>
> >>
> >> kernel base: based on Jens' for-next, applying Christoph and Leiming's
> >> patchset.
> >>
> >>
> >> 1. One bug when there's DM device stack, e.g., dm-linear upon another
> >> dm-linear. Can be reproduced by following steps:
> >>
> >> ```
> >> $ sudo dmsetup create tmpdev --table '0 2097152 linear /dev/nvme0n1 0'
> >>
> >> $ cat tmp.table
> >> 0 2097152 linear /dev/mapper/tmpdev 0
> >> 2097152 2097152 linear /dev/nvme0n1 0
> >>
> >> $ cat tmp.table | dmsetup create testdev
> >>
> >> $ fio -name=test -ioengine=io_uring -iodepth=128 -numjobs=1 -thread
> >> -rw=randread -direct=1 -bs=4k -time_based -runtime=10 -cpus_allowed=6
> >> -filename=/dev/mapper/testdev -hipri=1
> >> ```
> >>
> >>
> >> BUG: unable to handle page fault for address: ffffffffc01a6208
> >> #PF: supervisor write access in kernel mode
> >> #PF: error_code(0x0003) - permissions violation
> >> PGD 39740c067 P4D 39740c067 PUD 39740e067 PMD 1035db067 PTE 1ddf6f061
> >> Oops: 0003 [#1] SMP PTI
> >> CPU: 6 PID: 5899 Comm: fio Tainted: G S
> >> 5.13.0-0.1.git.81bcdc3.al7.x86_64 #1
> >> Hardware name: Inventec     K900G3-10G/B900G3, BIOS A2.20 06/23/2017
> >> RIP: 0010:dm_submit_bio+0x171/0x3e0 [dm_mod]
> > 
> > It has been fixed in my local repo:
> > 
> > @@ -1608,6 +1649,7 @@ static void init_clone_info(struct clone_info *ci, struct mapped_device *md,
> >         ci->map = map;
> >         ci->io = alloc_io(md, bio);
> >         ci->sector = bio->bi_iter.bi_sector;
> > +       ci->submit_as_polled = false;
> > 
> 
> It doesn't work in my test environment. Actually the following fix
> should be applied.
> 
> 
> @@ -1390,6 +1403,8 @@ static int clone_bio(struct dm_target_io *tio,
> struct bio *bio,
>         if (bio_integrity(bio))
>                 bio_integrity_trim(clone);
> 
> +       clone->bi_opf &= ~REQ_SAVED_END_IO;
> +

This change is good, but it shouldn't fix the panic except for nested
device map, I will fold into V3.

>         return 0;
>  }
> 
> 
> The rationale is that, REQ_SAVED_END_IO should be cleared once the bio
> *passes through* the device stack layer. Or the cloned bio for next
> layer will inherit REQ_SAVED_END_IO flag, in which case
> 'cloned_bio->bi_end_io' (actually acts as the hlist head) won't be
> initialized in dm_setup_polled_io(), and thus it gets crashed when
> trying to insert into this hash list in __split_and_process_bio().

'cloned_bio' can't reach dm_submit_bio() if it isn't one DM bio.


Thanks,
Ming

