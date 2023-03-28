Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A639FC76195
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 00:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjC1Asf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 20:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1Asf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 20:48:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1F81A5
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 17:48:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E88076151A
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 00:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB0FC433D2;
        Tue, 28 Mar 2023 00:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679964513;
        bh=0rgESySpV8tmoV70b1vmivA1o41rDzU0AOIJVRQCvyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2FN0XYYjNzuSeDVvTlfWitJr6bKPJj8ZqBCs/wTltg4VC1ZZ5V1l/DsIViLQK5wR
         SaqrGAiRypCickB8GfeKcuGFY+awOZHXGT2FGrzAvR85YXizRsPfybEQrRfXMV/c31
         FFEBWIVL4dEZqhPdUWFJVNxVxJtFqWrlTJAAMOXcmZO98khBuMi1q8c5SiWlaqEeY9
         SXRrLnzfJ92SmQp/YARsDSo45TYBNe05ShGLRq6DHcefPwxnhjfFFSnO1tdJG0f2Fb
         yVdWoIcIqik8JfryJS/6n9qeg3YR+MLU16e4X01ox8UENWsEme2/Ag8LSNg4IfGEf5
         nToL+OFGEIPQA==
Date:   Mon, 27 Mar 2023 18:48:30 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshiiitr@gmail.com>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
Message-ID: <ZCI5XopTr7nJvVF1@kbusch-mbp.dhcp.thefacebook.com>
References: <20230324212803.1837554-1-kbusch@meta.com>
 <CGME20230324213124epcas5p331ea3c2e2a05ec6a6825e719e47d2427@epcas5p3.samsung.com>
 <20230324212803.1837554-2-kbusch@meta.com>
 <20230327135810.GA8405@green5>
 <ZCG0O6RdlA/sUd7C@kbusch-mbp.dhcp.thefacebook.com>
 <CA+1E3rK2h9gyy26v1NmwTFtUsCwMkc1DgkDsCFME+HjZJPn5Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+1E3rK2h9gyy26v1NmwTFtUsCwMkc1DgkDsCFME+HjZJPn5Hg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 27, 2023 at 10:50:47PM +0530, Kanchan Joshi wrote:
> On Mon, Mar 27, 2023 at 8:59 PM Keith Busch <kbusch@kernel.org> wrote:
> > > >     rcu_read_lock();
> > > > -   bio = READ_ONCE(ioucmd->cookie);
> > > > -   ns = container_of(file_inode(ioucmd->file)->i_cdev,
> > > > -                   struct nvme_ns, cdev);
> > > > -   q = ns->queue;
> > > > -   if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
> > > > -           ret = bio_poll(bio, iob, poll_flags);
> > > > +   req = READ_ONCE(ioucmd->cookie);
> > > > +   if (req) {
> > >
> > > This is risky. We are not sure if the cookie is actually "req" at this
> > > moment.
> >
> > What else could it be? It's either a real request from a polled hctx tag, or
> > NULL at this point.
> 
> It can also be a function pointer that gets assigned on irq-driven completion.
> See the "struct io_uring_cmd" - we are tight on cacheline, so cookie
> and task_work_cb share the storage.
> 
> > It's safe to check the cookie like this and rely on its contents.
> Hence not safe. Please try running this without poll-queues (at nvme
> level), you'll see failures.

Okay, you have a iouring polling instance used with a file that has poll
capabilities, but doesn't have any polling hctx's. It would be nice to exclude
these from io_uring's polling since they're wasting CPU time, but that doesn't
look easily done. This simple patch atop should work though.

---
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 369e8519b87a2..e3ff019404816 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -612,6 +612,8 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	if (blk_rq_is_poll(req))
 		WRITE_ONCE(ioucmd->cookie, req);
+	else if (issue_flags & IO_URING_F_IOPOLL)
+		ioucmd->flags |= IORING_URING_CMD_NOPOLL;
 
 	/* to free bio on completion, as req->bio will be null at that time */
 	pdu->bio = req->bio;
@@ -774,6 +776,9 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 	struct request *req;
 	int ret = 0;
 
+	if (ioucmd->flags & IORING_URING_CMD_NOPOLL)
+		return 0;
+
 	/*
 	 * The rcu lock ensures the 'req' in the command cookie will not be
 	 * freed until after the unlock. The queue must be frozen to free the
diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 934e5dd4ccc08..2abf45491b3df 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -22,6 +22,8 @@ enum io_uring_cmd_flags {
 	IO_URING_F_IOPOLL		= (1 << 10),
 };
 
+#define IORING_URING_CMD_NOPOLL	(1U << 31)
+
 struct io_uring_cmd {
 	struct file	*file;
 	const void	*cmd;
--
