Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018B8C38A2A
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 02:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C842B2192A
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 02:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScSBl4um"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgEIC3H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 22:29:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41833 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728415AbgEIC3G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 22:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588991345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p7R1sXy8irZfr0XxEAzmfa42JQNYmXPeYhTHZbGBrRM=;
        b=ScSBl4umqrA2SKBTttMWZQJzdllL2c7RiMSgOA+HNnRNDJsJ+UfTRApkWeMtXznpXp08bv
        O/sLo5RrzZTVabrEB1MISsCoJ+b134Oczdjep4c6lXzI9tfac1I/CCmLgguLjGThYn+8fZ
        cWmBaG1t3wA/fjCAJuMCA/f+xRyJh84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-Pdz1jHA4OLK8yNQkJZ-WNA-1; Fri, 08 May 2020 22:29:01 -0400
X-MC-Unique: Pdz1jHA4OLK8yNQkJZ-WNA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24C2780058A;
        Sat,  9 May 2020 02:29:00 +0000 (UTC)
Received: from T590 (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FD2A10016E8;
        Sat,  9 May 2020 02:28:52 +0000 (UTC)
Date:   Sat, 9 May 2020 10:28:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Alan Adamson <ALAN.ADAMSON@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        martin.petersen@oracle.com, himanshu.madhani@oracle.com
Subject: Re: [PATCH 0/1] block: don't inject fake timeouts on quiesced queues
Message-ID: <20200509022847.GD1392681@T590>
References: <1588974394-15430-1-git-send-email-alan.adamson@oracle.com>
 <20200508220526.GC1389136@T590>
 <9B08C28D-BD67-4C3C-BADD-C0E3B67040BE@ORACLE.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9B08C28D-BD67-4C3C-BADD-C0E3B67040BE@ORACLE.COM>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 08, 2020 at 03:23:32PM -0700, Alan Adamson wrote:
> 
> 
> > On May 8, 2020, at 3:05 PM, Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > On Fri, May 08, 2020 at 02:46:34PM -0700, Alan Adamson wrote:
> >> While using the block fake timeout injector to reproduce a nvme error handling hang, a hang was
> >> observed when the following script was run:
> >> 
> >> echo 100 > /sys/kernel/debug/fail_io_timeout/probability
> >> echo 1000 > /sys/kernel/debug/fail_io_timeout/times
> >> echo 1 > /sys/block/nvme0n1/io-timeout-fail
> >> dd if=/dev/nvme0n1 of=/dev/null bs=512 count=1 
> >> 
> >> 
> >> dmesg:
> >> 
> >> [  370.018164] INFO: task kworker/u113:9:1191 blocked for more than 122 seconds.
> >> [  370.018849]       Not tainted 5.7.0-rc4 #1
> >> [  370.019251] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >> [  370.019653] kworker/u113:9  D    0  1191      2 0x80004000
> >> [  370.019660] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
> >> [  370.019661] Call Trace:
> >> [  370.019667]  __schedule+0x2dc/0x710
> >> [  370.019668]  schedule+0x44/0xb0
> >> [  370.019671]  blk_mq_freeze_queue_wait+0x4b/0xb0
> >> [  370.019675]  ? finish_wait+0x80/0x80
> >> [  370.019681]  nvme_wait_freeze+0x36/0x50 [nvme_core]
> >> [  370.019683]  nvme_reset_work+0xb65/0xf2b [nvme]
> >> [  370.019688]  process_one_work+0x1ab/0x380
> >> [  370.019689]  worker_thread+0x37/0x3b0
> >> [  370.019691]  kthread+0x120/0x140
> >> [  370.019692]  ? create_worker+0x1b0/0x1b0
> >> [  370.019693]  ? kthread_park+0x90/0x90
> >> [  370.019696]  ret_from_fork+0x35/0x40
> >> 
> >> This occurs when a fake timeout is scheduled on a request that is in he process
> >> of being cancelled due to the previous fake timeout.
> > 
> > Not sure root cause is timeout injection, and in theory request queue shouldn't
> > have been quiesced before freezing, otherwise it is easy to cause deadlock.
> 
> It's the handling of the previously injected timeout that causes the queue to the quiesed.  When the request is attempted to be canceled (as part of the
> nvme reset) the request is setup for another timeout and doesn’t get cancelled and the hang then occurs.

Got it, that is exactly the fragile nvme EH handling, and nvme timeout
handling should be fixed instead of error injection code.

The value of fault injection is exactly for finding issue, instead of
avoiding issue, so NAK this patch.

I remember that block/011 of blktests can trigger similar issue too,
unfortunately it is still not fixed after years.


Thanks,
Ming

