Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:38687 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbcJCH5F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2016 03:57:05 -0400
Date: Mon, 3 Oct 2016 00:57:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Wouter Verhelst <w@uter.be>
Cc: Christoph Hellwig <hch@infradead.org>, Josef Bacik <jbacik@fb.com>,
        Alex Bligh <alex@alex.org.uk>, Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
Message-ID: <20161003075701.GA29457@infradead.org>
References: <1475092892-8230-1-git-send-email-jbacik@fb.com>
 <20160929095204.mexr6wpypo3bl6mx@grep.be>
 <87908d95-0b7c-bc3f-f69d-94d006829daf@fb.com>
 <20160929164100.akytbkbtvziwaqqj@grep.be>
 <a2d8d560-41d0-e17d-90df-b1953ce00a51@fb.com>
 <F4CD5523-E3BC-4151-B9B8-ADFE9040F6E3@alex.org.uk>
 <2B49072B-6F83-4CD2-863B-5AB21E1F7816@fb.com>
 <20161003072049.GA16847@infradead.org>
 <20161003075149.u3ppcnk2j55fci6h@grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161003075149.u3ppcnk2j55fci6h@grep.be>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 03, 2016 at 09:51:49AM +0200, Wouter Verhelst wrote:
> Actually, I was pointing out the TCP head-of-line issue, where a delay
> on the socket that contains the flush reply would result in the arrival
> in the kernel block layer of a write reply before the said flush reply,
> resulting in a write being considered part of the flush when in fact it
> was not.

The kernel (or any other user of SCSI/ATA/NVMe-like cache flushes)
will wait for all I/O that needs to be in the cache for explicitly,
so this is not a problem.

> Can you clarify what you mean by that? Why is it an "odd flush
> definition", and how would you "properly" define it?

E.g. take the defintion from NVMe which also supports multiple queues:

"The Flush command shall commit data and metadata associated with the
specified namespace(s) to non-volatile media. The flush applies to all
commands completed prior to the submission of the Flush command.
The controller may also flush additional data and/or metadata from any
namespace."

The focus is completed - we need to get a reply to the host first
before we can send the flush command, so anything that we require
to be flushed needs to explicitly be completed first.

