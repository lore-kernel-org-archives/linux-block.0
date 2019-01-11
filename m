Return-Path: <SRS0=DRnZ=PT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7CDC43387
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 16:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165742084C
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 16:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbfAKQVq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:21:46 -0500
Received: from verein.lst.de ([213.95.11.211]:57024 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729961AbfAKQVq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jan 2019 11:21:46 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A8E3168DD2; Fri, 11 Jan 2019 17:21:43 +0100 (CET)
Date:   Fri, 11 Jan 2019 17:21:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Roman Penyaev <rpenyaev@suse.de>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, linux-block <linux-block@vger.kernel.org>,
        linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        jmoyer@redhat.com, avi@scylladb.com,
        linux-block-owner@vger.kernel.org
Subject: Re: [PATCHSET v2] io_uring IO interface
Message-ID: <20190111162143.GA14914@lst.de>
References: <20190110024404.25372-1-axboe@kernel.dk> <fe686e4316f9746c46b91fd58c984531@suse.de> <CAOi1vP9B7Z5jm4vcLux8eOvixgWmC7V=zKBzGnOOJHYO1AhVwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP9B7Z5jm4vcLux8eOvixgWmC7V=zKBzGnOOJHYO1AhVwA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 11, 2019 at 05:11:57PM +0100, Ilya Dryomov wrote:
> I think you can use the new IOCB_CMD_POLL from Christoph and avoid
> epoll_wait() in favor of aio/io_uring interface, at least in new high
> performance applications.  Reaping events entirely in userspace (i.e.
> performing io_getevents() without entering the kernel) has been
> possible for a long time even with the existing aio interface.

For io_uring we can reuse the IOCB_CMD_POLL concept, but we'd have to
add a new cancel command, as the uring right now doesn't support
cancelation.  But I'd rather make that command a new opcode instead
of a separate syscall, which would lead to a nicer design.

A prototype for this should be fairly easy, I'd just want someone
to actually use it for real life testing, like ScyllaDB does for
IOCB_CMD_POLL.
