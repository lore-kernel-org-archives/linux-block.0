Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2074C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 10:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbiGLKI4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 06:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiGLKIr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 06:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53A36BC00
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 03:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657620520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rFweDuIk2SBo5KB2wklW/S9Ar1k61Yu0hajCwnXEGu0=;
        b=bCG0p5ficA0BmVXvXEUHSVjKOQRjNAr6S5pgP/4GXAeEuj7Nw82VTboEvEwfhH3DcOl3Z2
        hoV+IqHulfYi6e4eV5e0iH/VA8EJkk+gFVptsfqAemHL7yQlBnmFhetkB4p/05EQnO4hmS
        6KjpRe8DJKy023NGNl7K0HC5QIv9Hrg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-bPi2MNEPMj2hs1inCXRbsA-1; Tue, 12 Jul 2022 06:08:30 -0400
X-MC-Unique: bPi2MNEPMj2hs1inCXRbsA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B3758032F0;
        Tue, 12 Jul 2022 10:08:29 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 143F8492C3B;
        Tue, 12 Jul 2022 10:08:23 +0000 (UTC)
Date:   Tue, 12 Jul 2022 18:08:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Oleg Nesterov <oleg@redhat.com>, ming.lei@redhat.com
Subject: Re: [PATCH V4 2/2] ublk_drv: add UBLK_IO_REFETCH_REQ for supporting
 to build as module
Message-ID: <Ys1IEiIs2Xlp5iAk@T590>
References: <20220711022024.217163-1-ming.lei@redhat.com>
 <20220711022024.217163-3-ming.lei@redhat.com>
 <87lesze7o3.fsf@collabora.com>
 <YszdfgTbmHWveFjW@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YszdfgTbmHWveFjW@T590>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 12, 2022 at 10:33:34AM +0800, Ming Lei wrote:
> Hi Gabriel,
> 
> On Mon, Jul 11, 2022 at 04:06:04PM -0400, Gabriel Krisman Bertazi wrote:
> > Ming Lei <ming.lei@redhat.com> writes:
> > 
> > > Add UBLK_IO_REFETCH_REQ command to fetch the incoming io request in
> > > ubq daemon context, so we can avoid to call task_work_add(), then
> > > it is fine to build ublk driver as module.
> > >
> > > In this way, iops is affected a bit, but just by ~5% on ublk/null,
> > > given io_uring provides pretty good batching issuing & completing.
> > >
> > > One thing to be careful is race between ->queue_rq() and handling
> > > abort, which is avoided by quiescing queue when aborting queue.
> > > Except for that, handling abort becomes much easier with
> > > UBLK_IO_REFETCH_REQ since aborting handler is strictly exclusive with
> > > anything done in ubq daemon kernel context.
> > 
> > Hi Ming,
> > 
> > FWIW, I'm not very fond this change.  It adds complexity to the kernel
> > driver and to the userspace server implementation, who now have to deal
> 
> IMO, this way just adds dozens line of code, no much complexity. The only
> complexity in ublk driver should be in aborting code, which is actually
> originated from concurrent aborting work and running task work which may be
> run after task is exiting. But any storage driver's aborting/error
> handling code is complicated.
> 
> Using REFETCH_REQ actually becomes much easier for handling abort which is
> run exclusively with any code running in ubq daemon context, but with
> performance cost.
> 
> > with different interface semantics just because the driver was built-in
> > or built as a module.  I don't think the tristate support warrants such
> > complexity.  I was hoping we might get away with exporting that symbol
> > or adding a built-in ubd-specific wrapper that can be exported and
> > invokes task_work_add.
> 
> If task_work_add can be exported, that would be very great.

Another choice is to use io_uring_cmd_complete_in_task which is actually
exported, now we can build ublk_drv as module by using io_uring_cmd_complete_in_task
without needing one new command.

Thanks,
Ming

