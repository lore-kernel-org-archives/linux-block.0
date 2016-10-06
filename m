Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752332AbcJFKcB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2016 06:32:01 -0400
Date: Thu, 6 Oct 2016 03:31:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Wouter Verhelst <w@uter.be>
Cc: Alex Bligh <alex@alex.org.uk>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, Jens Axboe <axboe@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
Message-ID: <20161006103155.GA20279@infradead.org>
References: <a2d8d560-41d0-e17d-90df-b1953ce00a51@fb.com>
 <F4CD5523-E3BC-4151-B9B8-ADFE9040F6E3@alex.org.uk>
 <2B49072B-6F83-4CD2-863B-5AB21E1F7816@fb.com>
 <20161003072049.GA16847@infradead.org>
 <20161003075149.u3ppcnk2j55fci6h@grep.be>
 <20161003075701.GA29457@infradead.org>
 <97C12880-A095-4F7B-B828-1837E65F7721@alex.org.uk>
 <20161003210714.ukgojallutalpjun@grep.be>
 <2AEFCBE9-E2C9-400E-9FF8-91901D7CE442@alex.org.uk>
 <20161006090415.xme3mgcjtkdx2j5f@grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161006090415.xme3mgcjtkdx2j5f@grep.be>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Oct 06, 2016 at 11:04:15AM +0200, Wouter Verhelst wrote:
> In the current situation, a client could opportunistically send a number
> of write requests immediately followed by a flush and hope for the best.
> However, in that case there is no guarantee that for the write requests
> that the client actually cares about to have hit the disk, a reply
> arrives on the client side before the flush reply arrives. If that
> doesn't happen, that would then mean the client would have to issue
> another flush request, probably at a performance hit.

There is also no guarantee that the server would receive them in order.

Note that people looked into schemes like this multiple times using
a SCSI feature called ordered tags which should provide this sort
of ordering, but no one managed to make it work reliably.

> As I understand Christoph's explanations, currently the Linux kernel
> *doesn't* issue flush requests unless and until the necessary writes
> have already completed (i.e., the reply has been received and processed
> on the client side). Given that, given the issue in the previous
> paragraph, and given the uncertainty introduced with multiple
> connections, I think it is reasonable to say that a client should just
> not assume a flush touches anything except for the writes for which it
> has already received a reply by the time the flush request is sent out.

Exactly.  That's the wording in other protocol specifications, and the
semantics Linux (and Windows) rely on.

> Christoph: just to double-check: would such semantics be incompatible
> with the semantics that the Linux kernel expects of block devices? If
> so, we'll have to review. Otherwise, I think we should go with that.

No, they match the cache flush semantics in every other storage protocol
known to me, and they match the expectations of both the Linux kernel
and any other OS or comsumer I know about perfectly.
