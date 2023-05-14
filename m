Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B6FC7EE22
	for <linux-block@archiver.kernel.org>; Sun, 14 May 2023 12:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjENMVZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 May 2023 08:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjENMVY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 May 2023 08:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD492695
        for <linux-block@vger.kernel.org>; Sun, 14 May 2023 05:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684066840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HYum6SseXpAycSdb5vQRRRjwbjycbR5zeik/eU2W1ho=;
        b=iEdqB1Hkkoq8mVIC+tKdORgoD0PEwB3yV1O9aO9/FfqZtDCannWwJn2QYCckZ8LX2AuZWY
        n8JHMErs2sObuglCQqYklc/v+S05NaS7C4mO8D42R/vYGix8Su6sCiM5Qmix+rtY9l97Dg
        asxAGLfG8rNMlfm28zotqodU9AZObNE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-dVTjZGSNM5GQNbowQZFsIw-1; Sun, 14 May 2023 08:20:34 -0400
X-MC-Unique: dVTjZGSNM5GQNbowQZFsIw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F71185A5A3;
        Sun, 14 May 2023 12:20:34 +0000 (UTC)
Received: from ovpn-8-17.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4377E63F3D;
        Sun, 14 May 2023 12:20:12 +0000 (UTC)
Date:   Sun, 14 May 2023 20:20:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tian Lan <tilan7663@gmail.com>, horms@kernel.org,
        linux-block@vger.kernel.org, lkp@intel.com, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, tian.lan@twosigma.com,
        ming.lei@redhat.com
Subject: Re: [PATCH 1/1] blk-mq: fix blk_mq_hw_ctx active request accounting
Message-ID: <ZGDR9YgB8dBhlqzY@ovpn-8-17.pek2.redhat.com>
References: <892f5292-884b-42ef-fe24-05cfac56e527@kernel.dk>
 <20230513221227.497327-1-tilan7663@gmail.com>
 <da0ae57e-71c2-9ad5-1134-c12309032402@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da0ae57e-71c2-9ad5-1134-c12309032402@kernel.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On Sat, May 13, 2023 at 07:52:37PM -0600, Jens Axboe wrote:
> On 5/13/23 4:12 PM, Tian Lan wrote:
> > From: Tian Lan <tian.lan@twosigma.com>
> > 
> > The nr_active counter continues to increase over time which causes the
> > blk_mq_get_tag to hang until the thread is rescheduled to a different
> > core despite there are still tags available.
> > 
> > kernel-stack
> > 
> >   INFO: task inboundIOReacto:3014879 blocked for more than 2 seconds
> >   Not tainted 6.1.15-amd64 #1 Debian 6.1.15~debian11
> >   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >   task:inboundIOReacto state:D stack:0  pid:3014879 ppid:4557 flags:0x00000000
> >     Call Trace:
> >     <TASK>
> >     __schedule+0x351/0xa20
> >     scheduler+0x5d/0xe0
> >     io_schedule+0x42/0x70
> >     blk_mq_get_tag+0x11a/0x2a0
> >     ? dequeue_task_stop+0x70/0x70
> >     __blk_mq_alloc_requests+0x191/0x2e0
> > 
> > kprobe output showing RQF_MQ_INFLIGHT bit is not cleared before
> > __blk_mq_free_request being called.
> > 
> >   320    320  kworker/29:1H __blk_mq_free_request rq_flags 0x220c0 in-flight 1
> >          b'__blk_mq_free_request+0x1 [kernel]'
> >          b'bt_iter+0x50 [kernel]'
> >          b'blk_mq_queue_tag_busy_iter+0x318 [kernel]'
> >          b'blk_mq_timeout_work+0x7c [kernel]'
> >          b'process_one_work+0x1c4 [kernel]'
> >          b'worker_thread+0x4d [kernel]'
> >          b'kthread+0xe6 [kernel]'
> >          b'ret_from_fork+0x1f [kernel]'
> > 
> > Signed-off-by: Tian Lan <tian.lan@twosigma.com>
> 
> I think this needs:
> 
> Cc: stable@vger.kernel.org
> Fixes: 2e315dc07df0 ("blk-mq: grab rq->refcount before calling ->fn in blk_mq_tagset_busy_iter")

I am still not sure what is wrong with above commit, and the real cause
of Tian's issue & this fix.

> 
> tags, but I'm also now confused as to whether the flush handling part
> of that patch. Ming, what am I missing in terms of not honoring the
> flush ref on put?

From Tian's log, the issue didn't happen on flush request.

> What happens if two iterators both grab the
> flush at the same time, and then subsequently put them?

Both two code paths try to acquire the request refcount, and put it
if the reference is grabbed, and reference release is just done
in flush_end_io().


Thanks, 
Ming

