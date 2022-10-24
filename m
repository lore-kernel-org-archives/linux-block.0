Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491CFC38A2D
	for <linux-block@archiver.kernel.org>; Mon, 24 Oct 2022 23:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiJXXgR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 19:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiJXXfw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 19:35:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9B6270D1E
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666648578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jDZhxeP2TwwBagjsTWzkhVAY7jSjuBxTunb+OPsAibU=;
        b=JyGUig9LrjFbmJD1CqWXrUqHe+3ZUdjCVuRev8a4qF6e5m/CQkMBi6BKPyV9wqTUqo4xf9
        +VVZGPlCMKdicSSbpRE677g+9FH1RxsP9GD8cnOwGI6c8mx/40CcLmsw27YnKJiJ6Egylk
        QDKVebwdzQRw8DnbAF87uS0i5nl03r8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-sgba_hcxP5a_xjp2TsMkqg-1; Mon, 24 Oct 2022 09:20:15 -0400
X-MC-Unique: sgba_hcxP5a_xjp2TsMkqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 409E885A5B6;
        Mon, 24 Oct 2022 13:20:15 +0000 (UTC)
Received: from T590 (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 398341121315;
        Mon, 24 Oct 2022 13:20:11 +0000 (UTC)
Date:   Mon, 24 Oct 2022 21:20:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] ublk_drv: don't call task_work_add for queueing io
 commands
Message-ID: <Y1aRBaUWGH54TTs4@T590>
References: <20221023093807.201946-1-ming.lei@redhat.com>
 <8a225315-3932-62a6-2bc6-8e81e672fd9d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a225315-3932-62a6-2bc6-8e81e672fd9d@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Ziyang,

On Mon, Oct 24, 2022 at 05:48:51PM +0800, Ziyang Zhang wrote:
> On 2022/10/23 17:38, Ming Lei wrote:
> > task_work_add() is used for waking ubq daemon task with one batch
> > of io requests/commands queued. However, task_work_add() isn't
> > exported for module code, and it is still debatable if the symbol
> > should be exported.
> > 
> > Fortunately we still have io_uring_cmd_complete_in_task() which just
> > can't handle batched wakeup for us.
> > 
> > Add one one llist into ublk_queue and call io_uring_cmd_complete_in_task()
> > via current command for running them via task work.
> > 
> > This way cleans up current code a lot, meantime allow us to wakeup
> > ubq daemon task after queueing batched requests/io commands.
> > 
> 
> 
> Hi, Ming
> 
> This patch works and I have run some tests to compare current version(ucmd)
> with your patch(ucmd-batch).
> 
> iodepth=128 numjobs=1 direct=1 bs=4k
> 
> --------------------------------------------
> ublk loop target, the backend is a file.
> IOPS(k)
> 
> type		ucmd		ucmd-batch
> seq-read	54.7		54.2	
> rand-read	52.8		52.0
> 
> --------------------------------------------
> ublk null target
> IOPS(k)
> 
> type		ucmd		ucmd-batch
> seq-read	257		257
> rand-read	252		253
> 
> 
> I find that io_req_task_work_add() puts task_work node into a llist
> first, then it may call task_work_add() to run batched task_works. So do we really
> need such llist in ublk_drv? I think io_uring has already considered task_work batch
> optimization.
> 
> BTW, task_work_add() in ublk_drv achieves
> higher IOPS(about 5-10% on my machine) than io_uring_cmd_complete_in_task()
> in ublk_drv.

Yeah, that is same with my observation, and motivation of this patch is
to get same performance with task_work_add by building ublk_drv as
module. One win of task_work_add() is that we get exact batching info
meantime only send TWA_SIGNAL_NO_IPI for whole batch, that is basically
what the patch is doing, but needs help of the following ublksrv patch:

https://github.com/ming1/ubdsrv/commit/dce6d1d222023c1641292713b311ced01e6dc548

which sets IORING_SETUP_COOP_TASKRUN for ublksrv's uring, then
io_uring_cmd_complete_in_task will notify via TWA_SIGNAL_NO_IPI, and 5+%
IOPS boost is observed on loop/001 by putting image on SSD in my test
VM.

Thanks, 
Ming

