Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E620FC77B61
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 14:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjC1OxQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjC1OxD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 10:53:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE60FD520
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 07:52:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C300B81D73
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 14:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81706C4339B;
        Tue, 28 Mar 2023 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680015177;
        bh=WoO6PtuXAgnsaZpuL2RMkjnPmQYDohpfLo07J0iy+ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EIfP4LEInyloxi8XloSlWkjhcXAOjSK4wIGxLuKSTu88V6vS5egyeO/L19c0CFQv6
         liK7kjOPvyxV+fn6I6/Q3JdywxBVVSjXcRDmO0hsMCYIxOv95k4CO3oULGKeQ2pGQ1
         NfVTMP3WqnIb0ONg1TvDFJKB0bOgn+VgkbCo0vcM5qyPETFAv1jn4wPFc9QKUJ9OrF
         KBgJEX6UdoSeX2RjH8SL8Cd7NIyOnlsULmwUdMPAN855rrSvbyQ3NqwLLOpGsCLhJx
         qndmXmpskXXO2dDMcAWo2a/O/txp0g1LOzZ8fSfk3BP6yHqk4RRwOddgq27wHkL1kg
         EM5vvcE4M/gsA==
Date:   Tue, 28 Mar 2023 08:52:53 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Kanchan Joshi <joshiiitr@gmail.com>, Keith Busch <kbusch@meta.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
Message-ID: <ZCL/RTHoflUVCMyw@kbusch-mbp.dhcp.thefacebook.com>
References: <20230324212803.1837554-1-kbusch@meta.com>
 <CGME20230324213124epcas5p331ea3c2e2a05ec6a6825e719e47d2427@epcas5p3.samsung.com>
 <20230324212803.1837554-2-kbusch@meta.com>
 <20230327135810.GA8405@green5>
 <ZCG0O6RdlA/sUd7C@kbusch-mbp.dhcp.thefacebook.com>
 <CA+1E3rK2h9gyy26v1NmwTFtUsCwMkc1DgkDsCFME+HjZJPn5Hg@mail.gmail.com>
 <ZCI5XopTr7nJvVF1@kbusch-mbp.dhcp.thefacebook.com>
 <20230328074939.GA2800@green5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328074939.GA2800@green5>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 28, 2023 at 01:19:39PM +0530, Kanchan Joshi wrote:
> On Mon, Mar 27, 2023 at 06:48:30PM -0600, Keith Busch wrote:
> > On Mon, Mar 27, 2023 at 10:50:47PM +0530, Kanchan Joshi wrote:
> > > On Mon, Mar 27, 2023 at 8:59 PM Keith Busch <kbusch@kernel.org> wrote:
> > > > > >     rcu_read_lock();
> > > > > > -   bio = READ_ONCE(ioucmd->cookie);
> > > > > > -   ns = container_of(file_inode(ioucmd->file)->i_cdev,
> > > > > > -                   struct nvme_ns, cdev);
> > > > > > -   q = ns->queue;
> > > > > > -   if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
> > > > > > -           ret = bio_poll(bio, iob, poll_flags);
> > > > > > +   req = READ_ONCE(ioucmd->cookie);
> > > > > > +   if (req) {
> > > > >
> > > > > This is risky. We are not sure if the cookie is actually "req" at this
> > > > > moment.
> > > >
> > > > What else could it be? It's either a real request from a polled hctx tag, or
> > > > NULL at this point.
> > > 
> > > It can also be a function pointer that gets assigned on irq-driven completion.
> > > See the "struct io_uring_cmd" - we are tight on cacheline, so cookie
> > > and task_work_cb share the storage.
> > > 
> > > > It's safe to check the cookie like this and rely on its contents.
> > > Hence not safe. Please try running this without poll-queues (at nvme
> > > level), you'll see failures.
> > 
> > Okay, you have a iouring polling instance used with a file that has poll
> > capabilities, but doesn't have any polling hctx's. It would be nice to exclude
> > these from io_uring's polling since they're wasting CPU time, but that doesn't
> > look easily done.
> 
> Do you mean having the ring with IOPOLL set, and yet skip the attempt of
> actively reaping the completion for certain IOs?

Yes, exactly. It'd be great if non-polled requests don't get added to the
ctx->iopoll_list in the first place.
 
> > This simple patch atop should work though.
> > 
> > ---
> > diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> > index 369e8519b87a2..e3ff019404816 100644
> > --- a/drivers/nvme/host/ioctl.c
> > +++ b/drivers/nvme/host/ioctl.c
> > @@ -612,6 +612,8 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> > 
> > 	if (blk_rq_is_poll(req))
> > 		WRITE_ONCE(ioucmd->cookie, req);
> > +	else if (issue_flags & IO_URING_F_IOPOLL)
> > +		ioucmd->flags |= IORING_URING_CMD_NOPOLL;
> 
> If IO_URING_F_IOPOLL would have come here as part of "ioucmd->flags", we
> could have just cleared that here. That would avoid the need of NOPOLL flag.
> That said, I don't feel strongly about new flag too. You decide.

IO_URING_F_IOPOLL, while named in an enum that sounds suspiciouly like it is
part of ioucmd->flags, is actually ctx flags, so a little confusing. And we
need to be a litle careful here: the existing ioucmd->flags is used with uapi
flags.
