Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F46C4332F
	for <linux-block@archiver.kernel.org>; Fri, 18 Nov 2022 12:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241747AbiKRMtj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 07:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiKRMti (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 07:49:38 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB2212AC5
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 04:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668775777; x=1700311777;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=KfVnVY+18WIUeYPd4+neO3on0HS0UZlVrqBxg+Udt40=;
  b=NIIxwYhGaP95ZCyTQRFPg3xGMcNTr0WdbW3goXDiDzQM6MA320WSG7Qs
   mAVZVfOxcE+1+iGfeDhHEx2YWP1vPG9pFGJ6I/rT9a+gYEBzNqeWLsypJ
   ld2jIX5ir8tBFAJ0o4r2b+aJojy6V79Xk8W5ySoYbY4UYqx6oliYPa5xL
   m/uj1rIIekunzCT6M3Nbb1uTtOkRriELRUy9VoBt/X+kay4iLSEz2uNzR
   U18Ts6yrm64nJdZ6y50zetLMPSHnqAC0n1G3gHXvdG+ikDX6sO/34X6UV
   ThYXRec9bg0MInOKtkGkAh4qVwI9BFSj9XjbAH6Ki3KRo7Gs5DUyWQ8R6
   g==;
X-IronPort-AV: E=Sophos;i="5.96,174,1665417600"; 
   d="scan'208";a="328711233"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2022 20:49:37 +0800
IronPort-SDR: E0nYGWNIrP6XF6EAogkimTcTjGVlImk2kTLj2+0UscoZw3+9DUeFDCJLZtZsJYj6SmjQJ9Ew0Y
 4iMinlTcRdexQy931UAGXCDuGFguU+vzjFRREaEH9eIOaxoI+5Q/qLdq78vg9a6UerQGi2JA82
 dDdMFgKhu79lskq9EX2tS4fLcsTdg2C5gCU7v8loAlBFJoeFCdePViOsP97BQDQvoWa5h2MMil
 owALwc/OZdKspkloYVtzmYwYGodN/j1BpjZ+KTfCn0noFlkBSIA5rWmcZYNnOETjdUpEGn33Yd
 iJ4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2022 04:08:31 -0800
IronPort-SDR: yumdZbEJ3jg+qAOJRKSlyIMvdBg5l65lFVhCM5i8Tk19pJ0q4myyN8nBDCvLiZV0F3vnT1piz6
 SjS/XBm6BRXdl7NoRftMEF6EiOmEVg7zs0e6H3FmImynrZaYzCYtaEJ2XuN+r7V8sr3ewhzjSI
 xL1HUsHcEMCh+c0GfAnLgYnSPQKE4lfXuMAY5g8aG68kTDzx1HrcuGcPh0NXIdZLsrj0KtOodv
 q4/P2zsgrMZltU9boYkUpdyjOrMm+G8orpTs5TT062Al6W2Y0IL3b8PJIQ5ZX/7P5PduxJ9JQz
 Xdk=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO localhost) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2022 04:49:36 -0800
References: <Y3WZ41tKFZHkTSHL@T590> <87o7t67zzv.fsf@wdc.com>
 <Y3X2M3CSULigQr4f@T590> <87k03u7x3r.fsf@wdc.com> <Y3YfUjrrLJzPWc4H@T590>
 <87fseh92aa.fsf@wdc.com> <Y3cGM0es14vj3n3N@T590>
 <2f86eb58-148b-03ac-d2bf-d67c5756a7a6@opensource.wdc.com>
 <Y3chDDdbuN99l7v7@T590> <8735ag8ueg.fsf@wdc.com> <Y3dscKle5oqLjSNT@T590>
 <87v8nc79cv.fsf@wdc.com>
User-agent: mu4e 1.8.11; emacs 28.2.50
From:   Andreas Hindborg <andreas.hindborg@wdc.com>
To:     Andreas Hindborg <andreas.hindborg@wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: Reordering of ublk IO requests
Date:   Fri, 18 Nov 2022 13:46:48 +0100
In-reply-to: <87v8nc79cv.fsf@wdc.com>
Message-ID: <87mt8o77hc.fsf@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Andreas Hindborg <andreas.hindborg@wdc.com> writes:

[...]
>>> >
>>> > oops, I miss the single queue depth point per zone, so ublk won't break
>>> > zoned write at all, and I agree order of batch IOs is one problem, but
>>> > not hard to solve.
>>>
>>> The current implementation _does_ break zoned write because it reverses
>>> batched writes. But if it is an easy fix, that is cool :)
>>
>> Please look at Damien's comment:
>>
>>>> That lock is already there and using it, mq-deadline will never dispatch
>>>> more than one write per zone at any time. This is to avoid write
>>>> reordering. So multi queue or not, for any zone, there is no possibility
>>>> of having writes reordered.
>>
>> For zoned write, mq-deadline is used to limit at most one inflight write
>> for each zone.
>>
>> So can you explain a bit how the current implementation breaks zoned
>> write?
>
> Like Damien wrote in another email, mq-deadline will only impose
> ordering for requests submitted in batch. The flow we have is the
> following:
>
>  - Userspace sends requests to ublk gendisk
>  - Requests go through block layer and is _not_ reordered when using
>    mq-deadline. They may be split.
>  - Requests hit ublk_drv and ublk_drv will reverse order of _all_
>    batched up requests (including split requests).
>  - ublk_drv sends request to ublksrv in _reverse_ order.
>  - ublksrv sends requests _not_ batched up to target device.
>  - Requests that enter mq-deadline at the same time are reordered in LBA
>    order, that is all good.
>  - Requests that enter the kernel in different batches are not reordered
>    in LBA order and end up missing the write pointer. This is bad.
>
> So, ublk_drv is not functional for zoned storage as is. Either we have
> to fix up the ordering in userspace in ublksrv, and that _will_ have a
> performance impact. Or we fix the bug in ublk_drv that causes batched
> requests to be _reversed_.

Here is a suggestion for a fix. It needs work, but it illustrates the
idea.

From 48f54a2a83daf19dda3c928e6518ce4a3e443fcd Mon Sep 17 00:00:00 2001
From: Andreas Hindborg <andreas.hindborg@wdc.com>
Date: Fri, 18 Nov 2022 13:44:45 +0100
Subject: [PATCH] wip: Do not reorder requests in ublk

---
 drivers/block/ublk_drv.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6a4a94b4cdf4..4fb5ccd01202 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -9,6 +9,7 @@
  *
  * (part of code stolen from loop.c)
  */
+#include <linux/llist.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>
@@ -55,6 +56,7 @@
 #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
 
 struct ublk_rq_data {
+	struct llist_node llnode;
 	struct callback_head work;
 };
 
@@ -121,6 +123,7 @@ struct ublk_queue {
 	unsigned int max_io_sz;
 	bool abort_work_pending;
 	unsigned short nr_io_ready;	/* how many ios setup */
+	struct llist_head pdu_queue;
 	struct ublk_device *dev;
 	struct ublk_io ios[0];
 };
@@ -724,8 +727,15 @@ static void ublk_rq_task_work_fn(struct callback_head *work)
 	struct ublk_rq_data *data = container_of(work,
 			struct ublk_rq_data, work);
 	struct request *req = blk_mq_rq_from_pdu(data);
+	struct ublk_queue *ubq = req->mq_hctx->driver_data;
 
-	__ublk_rq_task_work(req);
+	/* Some times this list is empty, but that is OK */
+	struct llist_node *head = llist_del_all(&ubq->pdu_queue);
+	head = llist_reverse_order(head);
+	llist_for_each_entry(data, head, llnode) {
+		req = blk_mq_rq_from_pdu(data);
+		__ublk_rq_task_work(req);
+	}
 }
 
 static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -753,6 +763,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 		enum task_work_notify_mode notify_mode = bd->last ?
 			TWA_SIGNAL_NO_IPI : TWA_NONE;
 
+		llist_add(&data->llnode, &ubq->pdu_queue);
 		if (task_work_add(ubq->ubq_daemon, &data->work, notify_mode))
 			goto fail;
 	} else {
@@ -1170,6 +1181,9 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 
 	ubq->io_cmd_buf = ptr;
 	ubq->dev = ub;
+
+	init_llist_head(&ubq->pdu_queue);
+
 	return 0;
 }
 
-- 
2.38.1


