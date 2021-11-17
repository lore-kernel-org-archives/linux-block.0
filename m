Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64736C433F5
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 10:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46DB661BAA
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 10:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbhKQKWt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:22:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232776AbhKQKWs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 05:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637144389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iKe2mE7c3MFaKZJJkx5RnwvPm+0OFhFwmWEBATWZjlU=;
        b=D3qyLTs9p5JnPkd9EVQikfW99MwGNbd4REiCz6MDG8jQeIVsBb1+3kQj4G3RoypzOJ8g0f
        FOLA8RupSCzy/Iz/lkskKG+IPSaP65Sd2WnbJzfTfCCnFUuheoD1AVlGKklFNxsQhbcA0h
        B5Pf7EiKt7gp7wcvzGUma9AKY1tPAt8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-HLZTN7yAO6WuHuzwrqJWWw-1; Wed, 17 Nov 2021 05:19:46 -0500
X-MC-Unique: HLZTN7yAO6WuHuzwrqJWWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5C901023F4E;
        Wed, 17 Nov 2021 10:19:44 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7025E19E7E;
        Wed, 17 Nov 2021 10:19:33 +0000 (UTC)
Date:   Wed, 17 Nov 2021 18:19:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     yangerkun <yangerkun@huawei.com>
Cc:     damien.lemoal@wdc.com, axboe@kernel.dk, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, yi.zhang@huawei.com,
        yebin10@huawei.com, houtao1@huawei.com, ming.lei@redhat.com
Subject: Re: [QUESTION] blk_mq_freeze_queue in elevator_init_mq
Message-ID: <YZTXMZRxvb5Orsdo@T590>
References: <d9113bf8-4654-cb04-f79c-38e11493cb2c@huawei.com>
 <YZS4FYxtxYAXjtFJ@T590>
 <d9ca8e57-55b8-96f8-e5fd-6103c8b1fa4b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9ca8e57-55b8-96f8-e5fd-6103c8b1fa4b@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 17, 2021 at 05:00:22PM +0800, yangerkun wrote:
> 
> 
> On 2021/11/17 16:06, Ming Lei wrote:
> > On Wed, Nov 17, 2021 at 11:37:13AM +0800, yangerkun wrote:
> > > Nowdays we meet the boot regression while enable lots of mtdblock
> > 
> > What is your boot regression? Any dmesg log?
> 
> The result is that when boot with 5.10 kernel compare with 4.4, 5.10
> will consume about 1.6s more...

OK, I understand the issue now, and please try the attached patch
which depends on the following one:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.16&id=2a19b28f7929866e1cec92a3619f4de9f2d20005


diff --git a/block/elevator.c b/block/elevator.c
index 1f39f6e8ebb9..19a78d5516ba 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -694,12 +694,18 @@ void elevator_init_mq(struct request_queue *q)
 	if (!e)
 		return;
 
+	/*
+	 * We are called before adding disk, when there isn't any FS I/O,
+	 * so freezing queue plus canceling dispatch work is enough to
+	 * drain any dispatch activities originated from passthrough
+	 * requests, then no need to quiesce queue which may add long boot
+	 * latency, especially when lots of disks are involved.
+	 */
 	blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue(q);
+	blk_mq_cancel_work_sync(q);
 
 	err = blk_mq_init_sched(q, e);
 
-	blk_mq_unquiesce_queue(q);
 	blk_mq_unfreeze_queue(q);
 
 	if (err) {



thanks,
Ming

