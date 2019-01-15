Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C590C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 16:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD5E20645
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 16:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfAOQvg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:51:36 -0500
Received: from ms.lwn.net ([45.79.88.28]:43578 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731289AbfAOQvg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 11:51:36 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 611CA2DD;
        Tue, 15 Jan 2019 16:51:35 +0000 (UTC)
Date:   Tue, 15 Jan 2019 09:51:34 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 05/16] Add io_uring IO interface
Message-ID: <20190115095134.6286b7d6@lwn.net>
In-Reply-To: <20190115025531.13985-6-axboe@kernel.dk>
References: <20190115025531.13985-1-axboe@kernel.dk>
        <20190115025531.13985-6-axboe@kernel.dk>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 14 Jan 2019 19:55:20 -0700
Jens Axboe <axboe@kernel.dk> wrote:

So the [0/16] cover letter seems to have gone astray this time?

Anyway, a couple of minor notes/questions:

> The submission queue (SQ) and completion queue (CQ) rings are shared
> between the application and the kernel. This eliminates the need to
> copy data back and forth to submit and complete IO.
> 
> IO submissions use the io_uring_sqe data structure, and completions
> are generated in the form of io_uring_sqe data structures. The SQ
> ring is an index into the io_uring_sqe array, which makes it possible
> to submit a batch of IOs without them being contiguous in the ring.
> The CQ ring is always contiguous, as completion events are inherently
> unordered and can point to any io_uring_iocb.
> 
> Two new system calls are added for this:
> 
> io_uring_setup(entries, iovecs, params)
> 	Sets up a context for doing async IO. On success, returns a file
> 	descriptor that the application can mmap to gain access to the
> 	SQ ring, CQ ring, and io_uring_iocbs.

Looking at the code, it would appear that the "iovecs" parameter doesn't
actually exist.

> io_uring_enter(fd, to_submit, min_complete, flags)
> 	Initiates IO against the rings mapped to this fd, or waits for
> 	them to complete, or both The behavior is controlled by the
> 	parameters passed in. If 'min_complete' is non-zero, then we'll
> 	try and submit new IO. If IORING_ENTER_GETEVENTS is set, the
> 	kernel will wait for 'min_complete' events, if they aren't
> 	already available.

I feel like I'm missing something here.  Rather than have the
IORING_ENTER_GETEVENTS flag, why not just wait if min_complete > 0 ?

Thanks,

jon
