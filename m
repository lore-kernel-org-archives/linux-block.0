Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34490C49ED7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 21:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A4220830
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 21:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="auFj39YR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VvGDWEhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfIMV6t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 17:58:49 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38067 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbfIMV6t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 17:58:49 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A0FAC2012F;
        Fri, 13 Sep 2019 17:58:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 13 Sep 2019 17:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:mime-version:content-type; s=
        fm2; bh=503hJLOycOjj34OrLfGvcdFgN4AR42mcrYxNX+M8u9k=; b=auFj39YR
        C44HLoXN3H5zvBLWR/ool1ehcUEmYYpz1eg0vyClmbNV7sMBYN/P6NQS6dxlCxBL
        aXkPu7o9byOGUzKUfEIUfR7nlJdlmjp2xnifhF2r8eE3aRPmB9TGE+k/eQxPFACS
        5N8VTlBfCJS28QLPz9wPiVzyE3aRtCWo3yTd3AovaHO3qKQq/TGB5xUkP4q+9ZrV
        MoB1SnioBim3r/l7UiMav5hY0E8VLrSUhmbZdBeGA3rknSOAk1hR8fJzat19YnvD
        keWZZ36YzokdHIlS0XNuFsyIuNVBIuXFMj+PR6aYjXsrVRCIMd0pMRzcxfAXE6EL
        dHS9g2jQ8LGv2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=503hJLOycOjj34OrLfGvcdFgN4AR4
        2mcrYxNX+M8u9k=; b=VvGDWEhM+ONCimn7gCbiuCgjXffpmYx4N4aAXIN4jUPYj
        DygGq23zHJbsIzMAj9oepyrSOaj9/Gnko43vNGoKhvqsSQR2K/lX0DOTY0Uciskj
        Y3S1i/tl3F4i4ACw2XxwEzbkVamzONajevZ/EIkQJOafNTbSj1vqNjDWCpgoKkoW
        2cKfqTWz3o84uliV2fSLfxLmCqelbUT3LmeyYa3dQl0VusNDsPpKFZ0YQPaME97e
        qzlI6DbMoTdGOUhFF5w+0u8DJrHqPzOV5xHdI50eGxQ4ghmziVZ+wbyqi3B8FZv6
        K7QCka6s/VmW4g0UlmOX5COsqhdvZlSiTBaRKxnHQ==
X-ME-Sender: <xms:FxF8XTaNWmbmvSyPRoIh9xevz5pHry34yo_OiRI64wKS3c3ufVtR5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrtdekucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvffukfggtggusehttdertddttddvnecuhfhrohhmpeetnhgurhgvshcuhfhrvghu
    nhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucffohhmrghinhepuhhrih
    hnghdrtgifnecukfhppedvudeirddukeelrddvuddurdduhedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghlrdguvgenucevlhhushhtvghruf
    hiiigvpedt
X-ME-Proxy: <xmx:FxF8XbOyj0GfhCddDImr8zhVOEmTZ82tGJnzCEGMEseuAx69seHMmg>
    <xmx:FxF8XcjV5ovSrobgIWLYq7tpv1Cw6YibYZPJWWorXPVWlGXgnKnIfQ>
    <xmx:FxF8XXBLvmmItnHH8BRk7jRhEr3exGtF4OoDR-Gyu9bj6zbCwsrMJA>
    <xmx:FxF8XQQDn2bQE9EAH8d_E8ySo2bmJjZoVjwNPKIKJKJY9JTVkA1-XQ>
Received: from intern.anarazel.de (unknown [216.189.211.150])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1AE6DD6005B;
        Fri, 13 Sep 2019 17:58:47 -0400 (EDT)
Date:   Fri, 13 Sep 2019 14:58:46 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: kernel (or fio) bug with IOSQE_IO_DRAIN
Message-ID: <20190913215846.uz4llevvdm5rpatf@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

While I'm not absolutely certain, this looks like a kernel side bug. I
modified fio to set DRAIN (because I'd need that in postgres, to not
actually just loose data as my current prototype does).  But the
submissions currently fail after a very short amount of time, as soon as
I use a queue depth bigger than one.

I modified fio's master like (obviously not intended as an actual fio
patch):

diff --git i/engines/io_uring.c w/engines/io_uring.c
index e5edfcd2..a3fe461f 100644
--- i/engines/io_uring.c
+++ w/engines/io_uring.c
@@ -181,16 +181,20 @@ static int fio_ioring_prep(struct thread_data *td, struct io_u *io_u)
                        sqe->len = 1;
                }
                sqe->off = io_u->offset;
+               sqe->flags |= IOSQE_IO_DRAIN;
        } else if (ddir_sync(io_u->ddir)) {
                if (io_u->ddir == DDIR_SYNC_FILE_RANGE) {
                        sqe->off = f->first_write;
                        sqe->len = f->last_write - f->first_write;
                        sqe->sync_range_flags = td->o.sync_file_range;
                        sqe->opcode = IORING_OP_SYNC_FILE_RANGE;
+
+                       //sqe->flags |= IOSQE_IO_DRAIN;
                } else {
                        if (io_u->ddir == DDIR_DATASYNC)
                                sqe->fsync_flags |= IORING_FSYNC_DATASYNC;
                        sqe->opcode = IORING_OP_FSYNC;
+                       //sqe->flags |= IOSQE_IO_DRAIN;
                }
        }
 

I pretty much immediately get failed requests back with a simple fio
job:

[global]
name=fio-drain-bug

size=1G
nrfiles=1

iodepth=2
ioengine=io_uring

[test]
rw=write


andres@alap4:~/src/fio$ ~/build/fio/install/bin/fio  ~/tmp/fio-drain-bug.fio
test: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=2
fio-3.15
Starting 1 process
files=0
fio: io_u error on file test.0.0: Invalid argument: write offset=794877952, buflen=4096
fio: pid=3075, err=22/file:/home/andres/src/fio/io_u.c:1787, func=io_u error, error=Invalid argument

test: (groupid=0, jobs=1): err=22 (file:/home/andres/src/fio/io_u.c:1787, func=io_u error, error=Invalid argument): pid=3075: Fri Sep 13 12:45:19 2019


Where I think the EINVAL might come from

	if (unlikely(s->index >= ctx->sq_entries))
		return -EINVAL;

based on the stack trace a perf probe returns (hacketyhack):

kworker/u16:0-e  6304 [006] 28733.064781: probe:__io_submit_sqe: (ffffffff81356719)
        ffffffff8135671a __io_submit_sqe+0xfa (/lib/modules/5.3.0-rc8-andres-00007-g3120b9a6a3f7-dirty/build/vmlinux)
        ffffffff81356da0 io_sq_wq_submit_work+0xe0 (/lib/modules/5.3.0-rc8-andres-00007-g3120b9a6a3f7-dirty/build/vmlinux)
        ffffffff81137392 process_one_work+0x1d2 (/lib/modules/5.3.0-rc8-andres-00007-g3120b9a6a3f7-dirty/build/vmlinux)
        ffffffff8113758d worker_thread+0x4d (/lib/modules/5.3.0-rc8-andres-00007-g3120b9a6a3f7-dirty/build/vmlinux)
        ffffffff8113d1e6 kthread+0x106 (/lib/modules/5.3.0-rc8-andres-00007-g3120b9a6a3f7-dirty/build/vmlinux)
        ffffffff8200021a ret_from_fork+0x3a (/lib/modules/5.3.0-rc8-andres-00007-g3120b9a6a3f7-dirty/build/vmlinux

/home/andres/src/kernel/fs/io_uring.c:1800

which precisely the return:
	if (unlikely(s->index >= ctx->sq_entries))
		return -EINVAL;

This is with your change to limit the number of workqueue threads
applied, but I don't think that should matter.

I suspect that this is hit due to ->index being unitialized, rather than
actually too large. In io_sq_wq_submit_work() the sqe_submit embedded in
io_kiocb is used.  ISTM that e.g. when
io_uring_enter()->io_ring_submit()->io_submit_sqe()
allocates the new io_kiocb and io_queue_sqe()->io_req_defer() and then
submits that to io_sq_wq_submit_work() io_kiocb->submit.index (and some
other fields?) is not initialized.

Greetings,

Andres Freund
