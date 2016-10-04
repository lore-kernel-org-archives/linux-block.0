Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:36041 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbcJDJiX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Oct 2016 05:38:23 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161003210714.ukgojallutalpjun@grep.be>
Date: Tue, 4 Oct 2016 10:35:03 +0100
Cc: Alex Bligh <alex@alex.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, Jens Axboe <axboe@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Message-Id: <2AEFCBE9-E2C9-400E-9FF8-91901D7CE442@alex.org.uk>
References: <20160929095204.mexr6wpypo3bl6mx@grep.be> <87908d95-0b7c-bc3f-f69d-94d006829daf@fb.com> <20160929164100.akytbkbtvziwaqqj@grep.be> <a2d8d560-41d0-e17d-90df-b1953ce00a51@fb.com> <F4CD5523-E3BC-4151-B9B8-ADFE9040F6E3@alex.org.uk> <2B49072B-6F83-4CD2-863B-5AB21E1F7816@fb.com> <20161003072049.GA16847@infradead.org> <20161003075149.u3ppcnk2j55fci6h@grep.be> <20161003075701.GA29457@infradead.org> <97C12880-A095-4F7B-B828-1837E65F7721@alex.org.uk> <20161003210714.ukgojallutalpjun@grep.be>
To: Wouter Verhelst <w@uter.be>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Wouter,

>>> It is impossible for nbd to make such a guarantee, due to head-of-line
>>> blocking on TCP.
>> 
>> this is perfectly accurate as far as it goes, but this isn't the current
>> NBD definition of 'flush'.
> 
> I didn't read it that way.
> 
>> That is (from the docs):
>> 
>>> All write commands (that includes NBD_CMD_WRITE, and NBD_CMD_TRIM)
>>> that the server completes (i.e. replies to) prior to processing to a
>>> NBD_CMD_FLUSH MUST be written to non-volatile storage prior to
>>> replying to thatNBD_CMD_FLUSH.
> 
> This is somewhat ambiguous, in that (IMO) it doesn't clearly state the
> point where the cutoff of "may not be on disk yet" is. What is
> "processing"?

OK. I now get the problem. There are actually two types of HOL blocking,
server to client and client to server.

Before we allowed the server to issue replies out of order with requests.
However, the protocol did guarantee that the server saw requests in the
order presented by clients. With the proposed multi-connection support,
this changes. Whilst the client needed to be prepared for things to be
disordered by the server, the server did not previously need to be
be prepared for things being disordered by the client. And (more subtly)
the client could assume that the server got its own requests in the
order it sent them, which is important for flush the way written at the
moment.


Here's an actual illustration of the problem:

Currently we have:

     Client              Server
     ======              ======

     TX: WRITE
     RX: FLUSH
                         RX: WRITE
                         RX: FLUSH
                                                
                         Process write
                      
                         Process flush including write

                         TX: write reply
                         TX: flush reply
     RX: write reply
     RX: flush reply


Currently the RX statements cannot be disordered. However the
server can process the requests in a different order. If it
does, the flush need not include the write, like this:

     Client              Server
     ======              ======

     TX: WRITE
     RX: FLUSH
                         RX: WRITE
                         RX: FLUSH
                                                
                         Process flush not including write

                         Process write                      

                         TX: flush reply
                         TX: write reply
    RX: flush reply
    RX: write reply

and the client gets to know of the fact, because the flush
reply comes before the write reply. It can know it's data has
not been flushed. It could send another flush in this case, or
simply change its code to not send the flush until the write
has been received.

However, with the multi-connection support, both the replies
and the requests can be disordered. So the client can ONLY
know a flush has been completed if it has received a reply
to the write before it sends the flush.

This is in my opinion problematic, as what you want to do as
a client is stream requests (write, write, write, flush, write,
write, write). If those go down different channels, AND you
don't wait for a reply, you can no longer safely stream requests
at all. Now you need to wait for the flush request to respond
before sending another write (if write ordering to the platter
is important), which seems to defeat the object of streaming
commands.

An 'in extremis' example would be a sequence of write / flush
requests sent down two channels, where the write requests all
end up on one channel, and the flush requests on the other,
and the write channel is serviced immediately and the flush
requests delayed indefinitely.

> We don't define that, and therefore it could be any point
> between "receipt of the request message" and "sending the reply
> message". I had interpreted it closer to the latter than was apparently
> intended, but that isn't very useful;

The thing is the server doesn't know what replies the client has
received, only the replies it has sent. Equally the server doesn't
know what commands the client has sent, only what commands it has
received.

As currently written, it's a simple rule, NBD_CMD_FLUSH means
"Mr Server: you must make sure that any write you have sent a
reply to must now be persisted on disk. If you haven't yet sent
a reply to a write - perhaps because due to HOL blocking you
haven't received it, or perhaps it's still in progress, or perhaps
it's finished but you haven't sent the reply - don't worry".

The promise to the the client is that all the writes to which the
server has sent a reply are now on disk. But the client doesn't
know what replies the server has sent a reply to. It only knows
which replies it has received (which will be a subset of those). So
to the client it means that the server has persisted to disk all
those commands to which it has received a reply. However, to the
server, the 'MUST' condition needs to refer to the replies it sent,
not the replies the client receives.

I think "before processing" here really just means "before sending
a reply to the NBD_CMD_FLUSH". I believe the 'before processing'
phrase came from the kernel wording.

> I see now that it should be closer
> to the former; a more useful definition is probably something along the
> following lines:
> 
>    All write commands (that includes NBD_CMD_WRITE and NBD_CMD_TRIM)
>    for which a reply was received on the client side prior to the

No, that's wrong as the server has no knowledge of whether the client
has actually received them so no way of knowing to which writes that
would reply. It thus has to ensure it covers a potentially larger
set of writes - those for which a reply has been sent, as all those
MIGHT have been received by the client.

>    transmission of the NBD_CMD_FLUSH message MUST be written to

no that's wrong because the server has no idea when the client
transmitted the NBD_CMD_FLUSH message. It can only deal with
events it knows about. And the delimiter is (in essence) those
write commands that were replied to prior to the sending of the
reply to the NBD_CMD_FLUSH - of course it can flush others too.

>    non-volatile storage prior to replying to that NBD_CMD_FLUSH. A
>    server MAY process this command in ways that result committing more
>    data to non-volatile storage than is strictly required.

I think the wording is basically right for the current semantic,
but here's a slight improvement:

   The server MUST NOT send a non-error reply to NBD_CMD_FLUSH
   until it has ensured that the contents of all writes to which it
   has already completed (i.e. replied to) have been persisted
   to non-volatile storage.

However, given that the replies can subsequently be reordered, I
now think we do have a problem, as the client can't tell to which
those refer.

> [...]
>> I don't think there is actually a problem here - Wouter if I'm wrong
>> about this, I'd like to understand your argument better.
> 
> No, I now see that there isn't, and I misunderstood things. However, I
> do think we should update the spec to clarify this.

Haha - I now think there is. You accidentally convinced me!

>> b) What I'm describing - which is the lack of synchronisation between
>> channels.
> [... long explanation snipped...]
> 
> Yes, and I acknowledge that. However, I think that should not be a
> blocker. It's fine to mark this feature as experimental; it will not
> ever be required to use multiple connections to connect to a server.
> 
> When this feature lands in nbd-client, I plan to ensure that the man
> page and -help output says something along the following lines:
> 
> use N connections to connect to the NBD server, improving performance
> at the cost of a possible loss of reliability.

So in essence we are relying on (userspace) nbd-client not to open
more connections if it's unsafe? IE we can sort out all the negotiation
of whether it's safe or unsafe within userspace and not bother Josef
about it? I suppose that's fine in that we can at least shorten
the CC: line, but I still think it would be helpful if the protocol

>> Now, in the reference server, NBD_CMD_FLUSH is implemented through an
>> fdatasync().
> 
> Actually, no, the reference server uses fsync() for reasons that I've
> forgotten (side note: you wrote it that way ;-)
> 
> [...]

I vaguely remember why - something to do with files expanding when
holes were written to. However, I don't think that makes much
difference to the question I asked, or at most s/fdatasync/fsync/g

-- 
Alex Bligh




