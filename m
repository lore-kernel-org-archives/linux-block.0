Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:38366 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754106AbcJFKPw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Oct 2016 06:15:52 -0400
Date: Thu, 6 Oct 2016 12:15:06 +0200
From: Wouter Verhelst <w@uter.be>
To: Alex Bligh <alex@alex.org.uk>
Cc: "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
Message-ID: <20161006101506.evrrkoly5cifdtxq@grep.be>
References: <F4CD5523-E3BC-4151-B9B8-ADFE9040F6E3@alex.org.uk>
 <2B49072B-6F83-4CD2-863B-5AB21E1F7816@fb.com>
 <20161003072049.GA16847@infradead.org>
 <20161003075149.u3ppcnk2j55fci6h@grep.be>
 <20161003075701.GA29457@infradead.org>
 <97C12880-A095-4F7B-B828-1837E65F7721@alex.org.uk>
 <20161003210714.ukgojallutalpjun@grep.be>
 <2AEFCBE9-E2C9-400E-9FF8-91901D7CE442@alex.org.uk>
 <20161006090415.xme3mgcjtkdx2j5f@grep.be>
 <BB210E6A-0B67-4963-B4AB-AE801987C5DE@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BB210E6A-0B67-4963-B4AB-AE801987C5DE@alex.org.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Oct 06, 2016 at 10:41:36AM +0100, Alex Bligh wrote:
> Wouter,
[...]
> > Given that, given the issue in the previous
> > paragraph, and given the uncertainty introduced with multiple
> > connections, I think it is reasonable to say that a client should just
> > not assume a flush touches anything except for the writes for which it
> > has already received a reply by the time the flush request is sent out.
> 
> OK. So you are proposing weakening the semantic for flush (saying that
> it is only guaranteed to cover those writes for which the client has
> actually received a reply prior to sending the flush, as opposed to
> prior to receiving the flush reply). This is based on the view that
> the Linux kernel client wouldn't be affected, and if other clients
> were affected, their behaviour would be 'somewhat unusual'.

Right.

> We do have one significant other client out there that uses flush
> which is Qemu. I think we should get a view on whether they would be
> affected.

That's certainly something to consider, yes.

> > Those are semantics that are actually useful and can be guaranteed in
> > the face of multiple connections. Other semantics can not.
> 
> Well there is another semantic which would work just fine, and also
> cures the other problem (synchronisation between channels) which would
> be simply that flush is only guaranteed to affect writes issued on the
> same channel. Then flush would do the natural thing, i.e. flush
> all the writes that had been done *on that channel*.

That is an option, yes, but the natural result will be that you issue N
flush requests, rather than one, which I'm guessing will kill
performance. Therefore, I'd prefer not to go down that route.

[...]
> > It is indeed impossible for a server to know what has been received by
> > the client by the time it (the client) sent out the flush request.
> > However, the server doesn't need that information, at all. The flush
> > request's semantics do not say that any request not covered by the flush
> > request itself MUST NOT have hit disk; instead, it just says that there
> > is no guarantee on whether or not that is the case. That's fine; all a
> > server needs to know is that when it receives a flush, it needs to
> > fsync() or some such, and then send the reply. All a *client* needs to
> > know is which requests have most definitely hit the disk. In my
> > proposal, those are the requests that finished before the flush request
> > was sent, and not the requests that finished between that and when the
> > flush reply is received. Those are *likely* to also be covered
> > (especially on single-connection NBD setups), but in my proposal,
> > they're no longer *guaranteed* to be.
> 
> I think my objection was more that you were writing mandatory language
> for a server's behaviour based on what the client perceives.
> 
> What you are saying from the client's point of view is that it under
> your proposed change it can only rely on that writes in respect of
> which the reply has been received prior to issuing the flush are persisted
> to disk (more might be persisted, but the client can't rely on it).

Exactly.

[...]
> IE I don't actually think the wording from the server side needs changing
> now I see what you are trying to do. Just we need a new paragraph saying
> what the client can and cannot reply on.

That's obviously also a valid option. I'm looking forward to your
proposed wording then :-)

[...]
> >> I suppose that's fine in that we can at least shorten the CC: line,
> >> but I still think it would be helpful if the protocol
> > 
> > unfinished sentence here...
> 
> .... but I still think it would be helpful if the protocol helped out
> the end user of the client and refused to negotiate multichannel
> connections when they are unsafe. How is the end client meant to know
> whether the back end is not on Linux, not on a block device, done
> via a Ceph driver etc?

Well, it isn't. The server, if it provides certain functionality, should
also provide particular guarantees. If it can't provide those
guarantees, it should not provide that functionality.

e.g., if a server runs on a backend with cache coherency issues, it
should not allow multiple connections to the same device, etc.

> I still think it's pretty damn awkward that with a ceph back end
> (for instance) which would be one of the backends to benefit the
> most from multichannel connections (as it's inherently parallel),
> no one has explained how flush could be done safely.

If ceph doesn't have any way to guarantee that a write is available to
all readers of a particular device, then it *cannot* be used to map
block device semantics with multiple channels. Therefore, it should not
allow writing to the device from multiple clients, period, unless the
filesystem (or other thing) making use of the nbd device above the ceph
layer actually understands how things may go wrong and can take care of
it.

As such, I don't think that the problems inherent in using multiple
connections to a ceph device (which I do not deny) have any place in a
discussion on how NBD should work in the face of multiple channels with
a sane/regular backend.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
