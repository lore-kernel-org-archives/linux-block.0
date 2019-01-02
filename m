Return-Path: <SRS0=PKU6=PK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A97C43387
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 19:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35684218FC
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 19:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfABTLp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:11:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbfABTLp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Jan 2019 14:11:45 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36C54D963D;
        Wed,  2 Jan 2019 19:11:45 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63B0B5C207;
        Wed,  2 Jan 2019 19:11:44 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 16/22] aio: add support for submission/completion rings
References: <20181221192236.12866-1-axboe@kernel.dk>
        <20181221192236.12866-17-axboe@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 02 Jan 2019 14:11:43 -0500
In-Reply-To: <20181221192236.12866-17-axboe@kernel.dk> (Jens Axboe's message
        of "Fri, 21 Dec 2018 12:22:30 -0700")
Message-ID: <x49ftuaho28.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 02 Jan 2019 19:11:45 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> The submission queue (SQ) and completion queue (CQ) rings are shared
> between the application and the kernel. This eliminates the need to
> copy data back and forth to submit and complete IO. We use the same
> structures as the old aio interface. The SQ rings are indexes into a
> struct iocb array, like we would submit through io_submit(), and the
> CQ rings are struct io_event, like we would pass in (and copy back)
> from io_getevents().
>
> A new system call is added for this, io_ring_enter(). This system call
> submits IO that is stored in the SQ ring, and/or completes IO and stores
> the results in the CQ ring. Hence it's possible to both complete and
> submit IO in a single system call.
>
> For IRQ driven IO, an application only needs to enter the kernel for
> completions if it wants to wait for them to occur.

It looks like the memory for the submission and completion queues is
not migratable (scq rings are non-migratory!  [1]).  Maybe you should use
the aio pseudofs for allocations, like is done with the original aio
ring.  I realize that would change the api...

-Jeff

[1] https://www.youtube.com/watch?v=liIlW-ovx0Y
