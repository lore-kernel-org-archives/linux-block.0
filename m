Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB768C433EF
	for <linux-block@archiver.kernel.org>; Fri,  8 Apr 2022 07:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiDHHrG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Apr 2022 03:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiDHHrF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Apr 2022 03:47:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D51E1D4C05
        for <linux-block@vger.kernel.org>; Fri,  8 Apr 2022 00:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649403900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=690R2TOKySO04ek0uQJQDpSorhXPia/msCTPV3d9aP4=;
        b=W/5wEWCgAfc8GeK033Ty6DevgSdFELjBKol3+TOR/Rjc/Mwy60ZkcTQ5sKLoZI/OGMkQKX
        INOHqDsPpO3UJYyReBlyoewgi7a61itma8tWZZbYYIhcIJHKT4wiY/NoxAEqmbHr4jXutc
        JbYXvwuBHMaWNMv/MghFF5ZYyImF+6U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-GurDIhHOPHuHGSuuhA_9yg-1; Fri, 08 Apr 2022 03:44:55 -0400
X-MC-Unique: GurDIhHOPHuHGSuuhA_9yg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF98B299E743;
        Fri,  8 Apr 2022 07:44:54 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D69AFC1D3AD;
        Fri,  8 Apr 2022 07:44:50 +0000 (UTC)
Date:   Fri, 8 Apr 2022 15:44:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Message-ID: <Yk/n7UtGK1vVGFX0@T590>
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de>
 <YkCSVSk1SwvtABIW@T590>
 <d2361ebc-1f04-dce5-744c-d4fcb8aca7aa@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2361ebc-1f04-dce5-744c-d4fcb8aca7aa@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 08, 2022 at 02:52:35PM +0800, Xiaoguang Wang wrote:
> hi,
> 
> > On Tue, Feb 22, 2022 at 07:57:27AM +0100, Hannes Reinecke wrote:
> >> On 2/21/22 20:59, Gabriel Krisman Bertazi wrote:
> >>> I'd like to discuss an interface to implement user space block devices,
> >>> while avoiding local network NBD solutions.  There has been reiterated
> >>> interest in the topic, both from researchers [1] and from the community,
> >>> including a proposed session in LSFMM2018 [2] (though I don't think it
> >>> happened).
> >>>
> >>> I've been working on top of the Google iblock implementation to find
> >>> something upstreamable and would like to present my design and gather
> >>> feedback on some points, in particular zero-copy and overall user space
> >>> interface.
> >>>
> >>> The design I'm pending towards uses special fds opened by the driver to
> >>> transfer data to/from the block driver, preferably through direct
> >>> splicing as much as possible, to keep data only in kernel space.  This
> >>> is because, in my use case, the driver usually only manipulates
> >>> metadata, while data is forwarded directly through the network, or
> >>> similar. It would be neat if we can leverage the existing
> >>> splice/copy_file_range syscalls such that we don't ever need to bring
> >>> disk data to user space, if we can avoid it.  I've also experimented
> >>> with regular pipes, But I found no way around keeping a lot of pipes
> >>> opened, one for each possible command 'slot'.
> >>>
> >>> [1] https://dl.acm.org/doi/10.1145/3456727.3463768
> >>> [2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html
> >>>
> >> Actually, I'd rather have something like an 'inverse io_uring', where an
> >> application creates a memory region separated into several 'ring' for
> >> submission and completion.
> >> Then the kernel could write/map the incoming data onto the rings, and
> >> application can read from there.
> >> Maybe it'll be worthwhile to look at virtio here.
> > IMO it needn't 'inverse io_uring', the normal io_uring SQE/CQE model
> > does cover this case, the userspace part can submit SQEs beforehand
> > for getting notification of each incoming io request from kernel driver,
> > then after one io request is queued to the driver, the driver can
> > queue a CQE for the previous submitted SQE. Recent posted patch of
> > IORING_OP_URING_CMD[1] is perfect for such purpose.
> >
> > I have written one such userspace block driver recently, and [2] is the
> > kernel part blk-mq driver(ubd driver), the userspace part is ubdsrv[3].
> > Both the two parts look quite simple, but still in very early stage, so
> > far only ubd-loop and ubd-null targets are implemented in [3]. Not only
> > the io command communication channel is done via IORING_OP_URING_CMD, but
> > also IO handling for ubd-loop is implemented via plain io_uring too.
> >
> > It is basically working, for ubd-loop, not see regression in 'xfstests -g auto'
> > on the ubd block device compared with same xfstests on underlying disk, and
> > my simple performance test on VM shows the result isn't worse than kernel loop
> > driver with dio, or even much better on some test situations.
> I also have spent time to learn your codes, its idea is really good, thanks for this
> great work. Though we're using tcmu, indeed we just needs a simple block device
> based on block semantics. Tcmu is based on scsi protocol, which is somewhat
> complicated and influences small io request performance. So if you like, we're
> willing to participate this project, and may use it in our internal business, thanks.

That is great, and welcome to participate! Glad to see there is real potential
user of userspace block device.

I believe there are lots of thing to do in this area, but so far:

1) consolidate the interface between ubd driver and ubdsrv, since this
part is kabi

2) consolidate design in ubdsrv(userspace part), so that we can support
different backing or target easily, one idea is to handle all io request
via io_uring.

3) consolidate design in ubdsrv for providing stable interface to support
advanced languages(python, rust, ...), and inevitable one new complicated
target/backing should be developed meantime, such as qcow2, or other
real/popular device.

I plan to post driver formal patches out after the patchset of io_uring
command interface is merged, but maybe we can make it soon for early
review.

And the driver side should be kept as simple as possible, and as
efficient as possible. It just focuses on : forward io request
to userspace and handle data copy or zero copy, and ubd driver won't store
any state of backing/target. Also actual performance is really sensitive with
batching handling. Recently, I take task_work_add() to improve batching, and
easy to observe performance boot. Another related part is how to implement
zero copy, which exists on tcmu or other projects too.

> 
> Another little question, why you use raw io_uring interface rather than liburing?
> Are there any special reasons?

It is just for building ubdsrv easily without any dependency, and it
definitely will switch to liburing. And the change should be quite simple,
since the related glue code is put in one source file, and the current
interface is similar with liburing's too.


Thanks,
Ming

