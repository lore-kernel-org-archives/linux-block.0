Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAA8C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 23:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A41213F2
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 23:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfAJXMv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:12:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfAJXMu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 18:12:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB8368E66F;
        Thu, 10 Jan 2019 23:12:50 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1D1760C67;
        Thu, 10 Jan 2019 23:12:49 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, avi@scylladb.com
Subject: Re: [PATCH 15/15] io_uring: add io_uring_event cache hit information
References: <20190110024404.25372-1-axboe@kernel.dk>
        <20190110024404.25372-16-axboe@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 10 Jan 2019 18:12:49 -0500
In-Reply-To: <20190110024404.25372-16-axboe@kernel.dk> (Jens Axboe's message
        of "Wed, 9 Jan 2019 19:44:04 -0700")
Message-ID: <x4936q0ds3y.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 10 Jan 2019 23:12:50 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> Add hint on whether a read was served out of the page cache, or if it
> hit media. This is useful for buffered async IO, O_DIRECT reads would
> never have this set (for obvious reasons).
>
> If the read hit page cache, cqe->flags will have IOCQE_FLAG_CACHEHIT
> set.

We may want to hold off on this one until the whole mincore/RWF_NOWAIT
debate is sorted. [1]

Cheers,
Jeff

[1] https://lore.kernel.org/lkml/20190109022430.GE27534@dastard/
