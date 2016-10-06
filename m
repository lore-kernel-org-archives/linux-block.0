Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:55571 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965281AbcJFJll (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Oct 2016 05:41:41 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161006090415.xme3mgcjtkdx2j5f@grep.be>
Date: Thu, 6 Oct 2016 10:41:36 +0100
Cc: Alex Bligh <alex@alex.org.uk>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, Jens Axboe <axboe@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Message-Id: <BB210E6A-0B67-4963-B4AB-AE801987C5DE@alex.org.uk>
References: <20160929164100.akytbkbtvziwaqqj@grep.be> <a2d8d560-41d0-e17d-90df-b1953ce00a51@fb.com> <F4CD5523-E3BC-4151-B9B8-ADFE9040F6E3@alex.org.uk> <2B49072B-6F83-4CD2-863B-5AB21E1F7816@fb.com> <20161003072049.GA16847@infradead.org> <20161003075149.u3ppcnk2j55fci6h@grep.be> <20161003075701.GA29457@infradead.org> <97C12880-A095-4F7B-B828-1837E65F7721@alex.org.uk> <20161003210714.ukgojallutalpjun@grep.be> <2AEFCBE9-E2C9-400E-9FF8-91901D7CE442@alex.org.uk> <20161006090415.xme3mgcjtkdx2j5f@grep.be>
To: Wouter Verhelst <w@uter.be>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Wouter,

> On 6 Oct 2016, at 10:04, Wouter Verhelst <w@uter.be> wrote:
> 
> Hi Alex,
> 
> On Tue, Oct 04, 2016 at 10:35:03AM +0100, Alex Bligh wrote:
>> Wouter,
>>> I see now that it should be closer
>>> to the former; a more useful definition is probably something along the
>>> following lines:
>>> 
>>>   All write commands (that includes NBD_CMD_WRITE and NBD_CMD_TRIM)
>>>   for which a reply was received on the client side prior to the
>> 
>> No, that's wrong as the server has no knowledge of whether the client
>> has actually received them so no way of knowing to which writes that
>> would reply.
> 
> I realise that, but I don't think it's a problem.
> 
> In the current situation, a client could opportunistically send a number
> of write requests immediately followed by a flush and hope for the best.
> However, in that case there is no guarantee that for the write requests
> that the client actually cares about to have hit the disk, a reply
> arrives on the client side before the flush reply arrives. If that
> doesn't happen, that would then mean the client would have to issue
> another flush request, probably at a performance hit.

Sure, but the client knows (currently) that any write request which
it has a reply to before it receives the reply from the flush request
has been written to disk. Such a client might simply note whether it
has issued any subsequent write requests.

> As I understand Christoph's explanations, currently the Linux kernel
> *doesn't* issue flush requests unless and until the necessary writes
> have already completed (i.e., the reply has been received and processed
> on the client side).

Sure, but it is not the only client.

> Given that, given the issue in the previous
> paragraph, and given the uncertainty introduced with multiple
> connections, I think it is reasonable to say that a client should just
> not assume a flush touches anything except for the writes for which it
> has already received a reply by the time the flush request is sent out.

OK. So you are proposing weakening the semantic for flush (saying that
it is only guaranteed to cover those writes for which the client has
actually received a reply prior to sending the flush, as opposed to
prior to receiving the flush reply). This is based on the view that
the Linux kernel client wouldn't be affected, and if other clients
were affected, their behaviour would be 'somewhat unusual'.

We do have one significant other client out there that uses flush
which is Qemu. I think we should get a view on whether they would be
affected.

> Those are semantics that are actually useful and can be guaranteed in
> the face of multiple connections. Other semantics can not.

Well there is another semantic which would work just fine, and also
cures the other problem (synchronisation between channels) which would
be simply that flush is only guaranteed to affect writes issued on the
same channel. Then flush would do the natural thing, i.e. flush
all the writes that had been done *on that channel*.

> It is indeed impossible for a server to know what has been received by
> the client by the time it (the client) sent out the flush request.
> However, the server doesn't need that information, at all. The flush
> request's semantics do not say that any request not covered by the flush
> request itself MUST NOT have hit disk; instead, it just says that there
> is no guarantee on whether or not that is the case. That's fine; all a
> server needs to know is that when it receives a flush, it needs to
> fsync() or some such, and then send the reply. All a *client* needs to
> know is which requests have most definitely hit the disk. In my
> proposal, those are the requests that finished before the flush request
> was sent, and not the requests that finished between that and when the
> flush reply is received. Those are *likely* to also be covered
> (especially on single-connection NBD setups), but in my proposal,
> they're no longer *guaranteed* to be.

I think my objection was more that you were writing mandatory language
for a server's behaviour based on what the client perceives.

What you are saying from the client's point of view is that it under
your proposed change it can only rely on that writes in respect of
which the reply has been received prior to issuing the flush are persisted
to disk (more might be persisted, but the client can't rely on it).

So far so good.

However, I don't think you can usefully make the guarantee weaker from the
SERVER'S point of view, because it doesn't know how things got reordered.
IE it still needs to persist to disk any write that it has completed
when it processes the flush. Yes, the client doesn't get the same guarantee,
but it can't know whether it can be slacker about a particular write
which it has performed but for which the client didn't receive the reply
prior to issuing the flush - it must just assume that if it did send
the reply prior to issuing the flush (or even queue it to be sent) then
it MIGHT have arrived prior to the flush being issued.

IE I don't actually think the wording from the server side needs changing
now I see what you are trying to do. Just we need a new paragraph saying
what the client can and cannot reply on.

> Christoph: just to double-check: would such semantics be incompatible
> with the semantics that the Linux kernel expects of block devices? If
> so, we'll have to review. Otherwise, I think we should go with that.

It would also really be nice to know whether there is any way the
flushes could be linked to the channel(s) containing the writes to which
they belong - this would solve the issues with coherency between channels.

Equally no one has answered the question as to whether fsync/fdatasync
is guaranteed (especially when not on Linux, not on a block FS) to give
synchronisation when different processes have different FDs open on the
same file. Is there some way to detect when this is safe?

> 
> [...]
>>>> b) What I'm describing - which is the lack of synchronisation between
>>>> channels.
>>> [... long explanation snipped...]
>>> 
>>> Yes, and I acknowledge that. However, I think that should not be a
>>> blocker. It's fine to mark this feature as experimental; it will not
>>> ever be required to use multiple connections to connect to a server.
>>> 
>>> When this feature lands in nbd-client, I plan to ensure that the man
>>> page and -help output says something along the following lines:
>>> 
>>> use N connections to connect to the NBD server, improving performance
>>> at the cost of a possible loss of reliability.
>> 
>> So in essence we are relying on (userspace) nbd-client not to open
>> more connections if it's unsafe? IE we can sort out all the negotiation
>> of whether it's safe or unsafe within userspace and not bother Josef
>> about it?
> 
> Yes, exactly.
> 
>> I suppose that's fine in that we can at least shorten the CC: line,
>> but I still think it would be helpful if the protocol
> 
> unfinished sentence here...

... but I still think it would be helpful if the protocol helped out
the end user of the client and refused to negotiate multichannel
connections when they are unsafe. How is the end client meant to know
whether the back end is not on Linux, not on a block device, done
via a Ceph driver etc?

I still think it's pretty damn awkward that with a ceph back end
(for instance) which would be one of the backends to benefit the
most from multichannel connections (as it's inherently parallel),
no one has explained how flush could be done safely.

-- 
Alex Bligh




