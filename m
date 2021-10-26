Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B1AC433F5
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 08:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A0F60E75
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 08:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhJZIiY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 04:38:24 -0400
Received: from verein.lst.de ([213.95.11.211]:60937 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234461AbhJZIiT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 04:38:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C92116732D; Tue, 26 Oct 2021 10:35:53 +0200 (CEST)
Date:   Tue, 26 Oct 2021 10:35:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        skt-results-master@redhat.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [bug report][bisected] WARNING: CPU: 109 PID: 739473 at
 block/blk-stat.c:218 blk_free_queue_stats+0x3c/0x80
Message-ID: <20211026083553.GB4494@lst.de>
References: <CAHj4cs9w7_thDw-DN11GaoA+HH9YVAMHmrAZhi_rA24xhbTYOA@mail.gmail.com> <CAHj4cs_CM7NzJtNmnD0CiPVOmr0jVEktNyD8d=UMZ0xEUArzow@mail.gmail.com> <CAHj4cs-M0Pp7OxE6QXJkGrjHcoqz+bdBuVngjsTp07h8gzLHXQ@mail.gmail.com> <9350ac53-84c0-b102-16ba-68fee6bcdbca@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9350ac53-84c0-b102-16ba-68fee6bcdbca@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Yi,

can you try the patch below?  This changes the teardown code to not
re-enable writeback tracking when we're shutting the queue down, which
is what I suspect is on the ->callbacks list.

diff --git a/block/elevator.c b/block/elevator.c
index ff45d8388f487..bb5c6ee4546cd 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -523,8 +523,6 @@ void elv_unregister_queue(struct request_queue *q)
 		kobject_del(&e->kobj);
 
 		e->registered = 0;
-		/* Re-enable throttling in case elevator disabled it */
-		wbt_enable_default(q);
 	}
 }
 
@@ -591,8 +589,11 @@ int elevator_switch_mq(struct request_queue *q,
 	lockdep_assert_held(&q->sysfs_lock);
 
 	if (q->elevator) {
-		if (q->elevator->registered)
+		if (q->elevator->registered) {
 			elv_unregister_queue(q);
+			/* Re-enable throttling in case elevator disabled it */
+			wbt_enable_default(q);
+		}
 
 		ioc_clear_queue(q);
 		elevator_exit(q, q->elevator);
