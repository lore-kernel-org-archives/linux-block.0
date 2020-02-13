Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18701C3B189
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 08:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA2721734
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 08:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhB5E3Vv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgBMI1C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Feb 2020 03:27:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21207 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729440AbgBMI1C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Feb 2020 03:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581582420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z12raJGzmP3ewFFkzOjLyM0T/GP1BeNJQ4XTGkx2X3s=;
        b=DhB5E3VvAhQ/n9aoeNmupbvFtzMTRTy67FVDjjfXYBFV3pE2+7ACiG0LAmKe6d83itL0Qc
        Ni75ZplAfVy5dLCbOA3fsO97ZwQDHfCjaD1ryzhO13EdyTC8dgCdOOhxqqev1/0QSyPlDT
        q2WYQBCfvaIgl4C8zfFbBDkx5fQALu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-eGc5_gbMMi6FGS17bB_EvA-1; Thu, 13 Feb 2020 03:26:56 -0500
X-MC-Unique: eGc5_gbMMi6FGS17bB_EvA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01D0F1088383;
        Thu, 13 Feb 2020 08:26:55 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 158E28EA1A;
        Thu, 13 Feb 2020 08:26:47 +0000 (UTC)
Date:   Thu, 13 Feb 2020 16:26:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Salman Qazi <sqazi@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Gwendal Grignou <gwendal@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Subject: Re: BLKSECDISCARD ioctl and hung tasks
Message-ID: <20200213082643.GB9144@ming.t460p>
References: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 12, 2020 at 02:27:09PM -0800, Salman Qazi wrote:
> Hi,
> 
> So, here's another issue that we are grappling with, where we have a
> root-cause but don't currently have a good fix for.  BLKSECDISCARD is
> an operation used for securely destroying a subset of the data on a
> device.  Unfortunately, on SSDs, this is an operation with variable
> performance.  It can be O(minutes) in the worst case.  The
> pathological case is when many erase blocks on the flash contain a
> small amount of data that is part of the discard and a large amount of
> data that isn't.  In such cases, the erase blocks have to be copied
> almost in entirety to fresh blocks, in order to erase the sectors to
> be discarded. This can be thought of as a defragmentation operation on
> the drive and can be expected to cost in the same ballpark as
> rewriting most of the contents of the drive.
> 
> Therefore, it is possible for the thread waiting in the IOCTL in
> submit_bio_wait call in blkdev_issue_discard to wait for several
> minutes.  The hung task watchdog is usually configured for 2 minutes,
> and this can expire before the operation finishes.
> 
> This operation is very important to the security model of Chrome OS
> devices.  Therefore, we would like the kernel to survive this even if
> it takes several minutes.
> 
> Three approaches come to mind:
> 
> One approach is to somehow avoid waiting for a single monolithic
> operation and instead wait on bits and pieces of the operation.  These
> can be sized to finish within a reasonable timeframe.  The exact size
> is likely device-specific.  We already split these operations before
> issuing to the device, but the IOCTL thread is waiting for the whole
> rather than the parts. The hung task watchdog only sees the total
> amount of time the thread slept and not the forward progress taking
> place quietly.
> 
> Another approach might be to do something in the spirit of the write
> system call: complete the partial operation (whatever the kernel
> thinks is reasonable), adjust the IOCTL argument and have the
> userspace reissue the syscall to continue the operation.  The second
> option should probably be done with a different IOCTL name to avoid
> breaking userspace.
> 
> A third approach, which is perhaps more adventurous, is to have a
> notion of forward progress that a thread can export and the hung task
> watchdog can evaluate.  This can take the form of a function pointer
> and an argument.  The result of the function is a monotonically
> decreasing unsigned value.  When this value stops changing, we can
> conclude that the thread is hung.  This can be used in place of
> context switch count for tasks where this function is available.  This
> can potentially solve other similar issues, there is a way to tell if
> there is forward progress, but it is not as straightforward as the
> context switch count.
> 
> What are your thoughts?

The approach used in blk_execute_rq() can be borrowed for workaround the
issue, such as:

diff --git a/block/bio.c b/block/bio.c
index 94d697217887..c9ce19a86de7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -17,6 +17,7 @@
 #include <linux/cgroup.h>
 #include <linux/blk-cgroup.h>
 #include <linux/highmem.h>
+#include <linux/sched/sysctl.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
@@ -1019,12 +1020,19 @@ static void submit_bio_wait_endio(struct bio *bio)
 int submit_bio_wait(struct bio *bio)
 {
 	DECLARE_COMPLETION_ONSTACK_MAP(done, bio->bi_disk->lockdep_map);
+	unsigned long hang_check;
 
 	bio->bi_private = &done;
 	bio->bi_end_io = submit_bio_wait_endio;
 	bio->bi_opf |= REQ_SYNC;
 	submit_bio(bio);
-	wait_for_completion_io(&done);
+
+	/* Prevent hang_check timer from firing at us during very long I/O */
+	hang_check = sysctl_hung_task_timeout_secs;
+	if (hang_check)
+		while (!wait_for_completion_io_timeout(&done, hang_check * (HZ/2)));
+	else
+		wait_for_completion_io(&done);
 
 	return blk_status_to_errno(bio->bi_status);
 }

thanks,
Ming

