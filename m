Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:52182 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966669AbcJFJE5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Oct 2016 05:04:57 -0400
Date: Thu, 6 Oct 2016 11:04:15 +0200
From: Wouter Verhelst <w@uter.be>
To: Alex Bligh <alex@alex.org.uk>
Cc: "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, Jens Axboe <axboe@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
Message-ID: <20161006090415.xme3mgcjtkdx2j5f@grep.be>
References: <20160929164100.akytbkbtvziwaqqj@grep.be>
 <a2d8d560-41d0-e17d-90df-b1953ce00a51@fb.com>
 <F4CD5523-E3BC-4151-B9B8-ADFE9040F6E3@alex.org.uk>
 <2B49072B-6F83-4CD2-863B-5AB21E1F7816@fb.com>
 <20161003072049.GA16847@infradead.org>
 <20161003075149.u3ppcnk2j55fci6h@grep.be>
 <20161003075701.GA29457@infradead.org>
 <97C12880-A095-4F7B-B828-1837E65F7721@alex.org.uk>
 <20161003210714.ukgojallutalpjun@grep.be>
 <2AEFCBE9-E2C9-400E-9FF8-91901D7CE442@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2AEFCBE9-E2C9-400E-9FF8-91901D7CE442@alex.org.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Alex,

On Tue, Oct 04, 2016 at 10:35:03AM +0100, Alex Bligh wrote:
> Wouter,
> > I see now that it should be closer
> > to the former; a more useful definition is probably something along the
> > following lines:
> > 
> >    All write commands (that includes NBD_CMD_WRITE and NBD_CMD_TRIM)
> >    for which a reply was received on the client side prior to the
> 
> No, that's wrong as the server has no knowledge of whether the client
> has actually received them so no way of knowing to which writes that
> would reply.

I realise that, but I don't think it's a problem.

In the current situation, a client could opportunistically send a number
of write requests immediately followed by a flush and hope for the best.
However, in that case there is no guarantee that for the write requests
that the client actually cares about to have hit the disk, a reply
arrives on the client side before the flush reply arrives. If that
doesn't happen, that would then mean the client would have to issue
another flush request, probably at a performance hit.

As I understand Christoph's explanations, currently the Linux kernel
*doesn't* issue flush requests unless and until the necessary writes
have already completed (i.e., the reply has been received and processed
on the client side). Given that, given the issue in the previous
paragraph, and given the uncertainty introduced with multiple
connections, I think it is reasonable to say that a client should just
not assume a flush touches anything except for the writes for which it
has already received a reply by the time the flush request is sent out.

Those are semantics that are actually useful and can be guaranteed in
the face of multiple connections. Other semantics can not.

It is indeed impossible for a server to know what has been received by
the client by the time it (the client) sent out the flush request.
However, the server doesn't need that information, at all. The flush
request's semantics do not say that any request not covered by the flush
request itself MUST NOT have hit disk; instead, it just says that there
is no guarantee on whether or not that is the case. That's fine; all a
server needs to know is that when it receives a flush, it needs to
fsync() or some such, and then send the reply. All a *client* needs to
know is which requests have most definitely hit the disk. In my
proposal, those are the requests that finished before the flush request
was sent, and not the requests that finished between that and when the
flush reply is received. Those are *likely* to also be covered
(especially on single-connection NBD setups), but in my proposal,
they're no longer *guaranteed* to be.

Christoph: just to double-check: would such semantics be incompatible
with the semantics that the Linux kernel expects of block devices? If
so, we'll have to review. Otherwise, I think we should go with that.

[...]
> >> b) What I'm describing - which is the lack of synchronisation between
> >> channels.
> > [... long explanation snipped...]
> > 
> > Yes, and I acknowledge that. However, I think that should not be a
> > blocker. It's fine to mark this feature as experimental; it will not
> > ever be required to use multiple connections to connect to a server.
> > 
> > When this feature lands in nbd-client, I plan to ensure that the man
> > page and -help output says something along the following lines:
> > 
> > use N connections to connect to the NBD server, improving performance
> > at the cost of a possible loss of reliability.
> 
> So in essence we are relying on (userspace) nbd-client not to open
> more connections if it's unsafe? IE we can sort out all the negotiation
> of whether it's safe or unsafe within userspace and not bother Josef
> about it?

Yes, exactly.

> I suppose that's fine in that we can at least shorten the CC: line,
> but I still think it would be helpful if the protocol

unfinished sentence here...

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
