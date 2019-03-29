Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E5BC10F05
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 23:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2914218A6
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 23:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfC2XWe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 19:22:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729932AbfC2XWd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 19:22:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 016AB9AE76;
        Fri, 29 Mar 2019 23:22:33 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 33DEC60BFB;
        Fri, 29 Mar 2019 23:22:23 +0000 (UTC)
Date:   Sat, 30 Mar 2019 07:22:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     James Smart <james.smart@broadcom.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Andrew Jones <drjones@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        "jianchao . wang" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V2] SCSI: fix queue cleanup race before queue
 initialization is done
Message-ID: <20190329232217.GA21943@ming.t460p>
References: <20181114082551.12141-1-ming.lei@redhat.com>
 <63c063ad-7d74-4268-bfd4-2de89908949e@kernel.dk>
 <4e24ace9-c83f-5311-5419-18f4a0fb5148@kernel.dk>
 <20181122010034.GA20814@ming.t460p>
 <dc374ec8-2ea2-0792-4677-0ae81fa7826e@kernel.dk>
 <baba41b1-8495-8bd1-0bea-341d207852a7@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <baba41b1-8495-8bd1-0bea-341d207852a7@broadcom.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 29 Mar 2019 23:22:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello James,

On Fri, Mar 29, 2019 at 01:21:12PM -0700, James Smart wrote:
> 
> 
> On 11/21/2018 5:42 PM, Jens Axboe wrote:
> > On 11/21/18 6:00 PM, Ming Lei wrote:
> > > On Wed, Nov 21, 2018 at 02:47:35PM -0700, Jens Axboe wrote:
> > > > On 11/14/18 8:20 AM, Jens Axboe wrote:
> > > > > On 11/14/18 1:25 AM, Ming Lei wrote:
> > > > > > c2856ae2f315d ("blk-mq: quiesce queue before freeing queue") has
> > > > > > already fixed this race, however the implied synchronize_rcu()
> > > > > > in blk_mq_quiesce_queue() can slow down LUN probe a lot, so caused
> > > > > > performance regression.
> > > > > > 
> > > > > > Then 1311326cf4755c7 ("blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()")
> > > > > > tried to quiesce queue for avoiding unnecessary synchronize_rcu()
> > > > > > only when queue initialization is done, because it is usual to see
> > > > > > lots of inexistent LUNs which need to be probed.
> > > > > > 
> > > > > > However, turns out it isn't safe to quiesce queue only when queue
> > > > > > initialization is done. Because when one SCSI command is completed,
> > > > > > the user of sending command can be waken up immediately, then the
> > > > > > scsi device may be removed, meantime the run queue in scsi_end_request()
> > > > > > is still in-progress, so kernel panic can be caused.
> > > > > > 
> > > > > > In Red Hat QE lab, there are several reports about this kind of kernel
> > > > > > panic triggered during kernel booting.
> > > > > > 
> > > > > > This patch tries to address the issue by grabing one queue usage
> > > > > > counter during freeing one request and the following run queue.
> > > > > Thanks applied, this bug was elusive but ever present in recent
> > > > > testing that we did internally, it's been a huge pain in the butt.
> > > > > The symptoms were usually a crash in blk_mq_get_driver_tag() with
> > > > > hctx->tags == NULL, or a crash inside deadline request insert off
> > > > > requeue.
> 
> All,
> 
> We are seeing errors with the following error:
> 
> [44492.814347] BUG: unable to handle kernel NULL pointer dereference at
> (null)
> [44492.814383] IP: [<ffffffff8135a10b>] sbitmap_any_bit_set+0xb/0x30
> ...
> [44492.815634] Call Trace:
> [44492.815652]  [<ffffffff81303a88>] blk_mq_run_hw_queues+0x48/0x90
> [44492.819755]  [<ffffffff813053cc>] blk_mq_requeue_work+0x10c/0x120
> [44492.819777]  [<ffffffff81098cb4>] process_one_work+0x154/0x410
> [44492.819781]  [<ffffffff81099896>] worker_thread+0x116/0x4a0
> [44492.819784]  [<ffffffff8109edb9>] kthread+0xc9/0xe0
> [44492.819790]  [<ffffffff81619b05>] ret_from_fork+0x55/0x80
> [44492.822798] DWARF2 unwinder stuck at ret_from_fork+0x55/0x80
> [44492.822798]
> [44492.822799] Leftover inexact backtrace:
> 
> [44492.822802]  [<ffffffff8109ecf0>] ? kthread_park+0x50/0x50
> [44492.822818] Code: c6 44 0f 46 ce 83 c2 01 45 89 ca 4c 89 54 01 08 48 8b
> 4f
> 10 2b 74 01 08 39 57 08 77 d8 f3 c3 90 8b 4f 08 85 c9 74 1f 48 8b 57 10 <48>
> 83
> 3a 00 75 18 31 c0 eb 0a 48 83 c2 40 48 83 3a 00 75 0a 83
> [44492.822820] RIP  [<ffffffff8135a10b>] sbitmap_any_bit_set+0xb/0x30
> [44492.822821]  RSP <ffff8807219ffdd8>
> [44492.822821] CR2: 0000000000000000
> 
> It appears the queue has been freed thus the bitmap is bad.

Could you provide a little background about this report? Such as the
device/driver, reproduction steps, and kernel release.

> 
> Looking at the commit relative to this email thread:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/scsi/scsi_lib.c?id=8dc765d438f1e42b3e8227b3b09fad7d73f4ec9a
> 
> It's interesting that the queue reference taken was released after the
> kblockd_schedule_work() call was made, and it's this work element that is
> hitting the issue. So perhaps the patch missed keeping the reference until
> the requeue_work item finished ?

blk_mq's requeue_work is supposed to be drained before freeing queue,
see blk_sync_queue(), and SCSI's requeue_work should have been drained too.

This following change might make a difference for this issue, but looks
it isn't good enough, given SCSI's requeue may come between
cancel_work_sync() and blk_cleanup_queue(). Will take a close look on it
in this weekend.

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 6a9040faed00..94882f65ccf1 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1397,8 +1397,8 @@ void __scsi_remove_device(struct scsi_device *sdev)
 	scsi_device_set_state(sdev, SDEV_DEL);
 	mutex_unlock(&sdev->state_mutex);
 
-	blk_cleanup_queue(sdev->request_queue);
 	cancel_work_sync(&sdev->requeue_work);
+	blk_cleanup_queue(sdev->request_queue);
 
 	if (sdev->host->hostt->slave_destroy)
 		sdev->host->hostt->slave_destroy(sdev);

Thanks,
Ming
