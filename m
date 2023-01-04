Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E841FC46467
	for <linux-block@archiver.kernel.org>; Wed,  4 Jan 2023 07:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjADHvi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Jan 2023 02:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjADHvK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Jan 2023 02:51:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEB419C05
        for <linux-block@vger.kernel.org>; Tue,  3 Jan 2023 23:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672818623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=byrUUjIuJ5uxTuXkhVoV8Wrb/RqZl7LjHZ25gNideR8=;
        b=L5iC9zRTiZpXcDf9esbIXAAg2XPlkNB5KTqRnEwEgYO3BuVJQBuek5dBUh3XtkDD4Z2Ade
        +cIIyTVWBDQLHdxkVst5VIT8qwXo1yJ0pCgs2m/i6JxJmsSwxPVxLBIoqCeEf40wjB9QZZ
        ghnrSz0yR8bPStd88KzfwGrtPDz8LPc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-HSOehhX6O7C1Re16lAY98g-1; Wed, 04 Jan 2023 02:50:20 -0500
X-MC-Unique: HSOehhX6O7C1Re16lAY98g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69E691869B60;
        Wed,  4 Jan 2023 07:50:20 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 006ECC15BA0;
        Wed,  4 Jan 2023 07:50:16 +0000 (UTC)
Date:   Wed, 4 Jan 2023 15:50:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Nadav Amit <nadav.amit@gmail.com>, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: Potential hang on ublk_ctrl_del_dev()
Message-ID: <Y7Uvs6uGJbzsxpE5@T590>
References: <862272BC-C6A3-4A60-A620-4C5596972D01@gmail.com>
 <974410c0-46e8-c240-388c-9b0c339fcd09@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <974410c0-46e8-c240-388c-9b0c339fcd09@kernel.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 03, 2023 at 02:51:20PM -0700, Jens Axboe wrote:
> On 1/3/23 2:47?PM, Nadav Amit wrote:
> > Hello Ming,
> > 
> > I am trying the ublk and it seems very exciting.
> > 
> > However, I encounter an issue when I remove a ublk device that is mounted or
> > in use.
> > 
> > In ublk_ctrl_del_dev(), shouldn?t we *not* wait if ublk_idr_freed() is false?
> > It seems to me that it is saner to return -EBUSY in such a case and let
> > userspace deal with the results.
> > 
> > For instance, if I run the following (using ubdsrv):
> > 
> >  $ mkfs.ext4 /dev/ram0
> >  $ ./ublk add -t loop -f /dev/ram0
> >  $ sudo mount /dev/ublkb0 tmp
> >  $ sudo ./ublk del -a
> > 
> > ublk_ctrl_del_dev() would not be done until the partition is unmounted, and you
> > can get a splat that is similar to the one below.
> > 
> > What do you say? Would you agree to change the behavior to return -EBUSY?
> > 
> > Thanks,
> > Nadav
> > 
> > 
> > [  974.149938] INFO: task ublk:2250 blocked for more than 120 seconds.
> > [  974.157786]       Not tainted 6.1.0 #30
> > [  974.162369] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  974.171417] task:ublk            state:D stack:0     pid:2250  ppid:2249   flags:0x00004004
> > [  974.181054] Call Trace:
> > [  974.184097]  <TASK>
> > [  974.186726]  __schedule+0x37e/0xe10
> > [  974.190915]  ? __this_cpu_preempt_check+0x13/0x20
> > [  974.196463]  ? lock_release+0x133/0x2a0
> > [  974.201043]  schedule+0x67/0xe0
> > [  974.204846]  ublk_ctrl_uring_cmd+0xf45/0x1110
> > [  974.210016]  ? lock_is_held_type+0xdd/0x130
> > [  974.214990]  ? var_wake_function+0x60/0x60
> > [  974.219872]  ? rcu_read_lock_sched_held+0x4f/0x80
> > [  974.225443]  io_uring_cmd+0x9a/0x130
> > [  974.229743]  ? io_uring_cmd_prep+0xf0/0xf0
> > [  974.234638]  io_issue_sqe+0xfe/0x340
> > [  974.238946]  io_submit_sqes+0x231/0x750
> > [  974.243553]  __x64_sys_io_uring_enter+0x22b/0x640
> > [  974.249134]  ? trace_hardirqs_on+0x3c/0xe0
> > [  974.254042]  do_syscall_64+0x35/0x80
> > [  974.258361]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Ming, this also looks like ublk doesn't always honor
> IO_URING_F_NONBLOCK, we can't be sleeping like that under issue. Then it
> should be bounced with -EAGAIN and retried from an io-wq worker.

Yeah, you are right, and looks the following change is needed and all
ublk control commands are actually handled in sync style from userspace.

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 144eda037646..8011ae1f20d5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2264,6 +2264,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	struct ublk_device *ub = NULL;
 	int ret = -EINVAL;
 
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
+
 	ublk_ctrl_cmd_dump(cmd);
 
 	if (!(issue_flags & IO_URING_F_SQE128))

thanks,
Ming

