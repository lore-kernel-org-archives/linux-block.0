Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:49175 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751473AbcJCVHp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Oct 2016 17:07:45 -0400
Date: Mon, 3 Oct 2016 23:07:14 +0200
From: Wouter Verhelst <w@uter.be>
To: Alex Bligh <alex@alex.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, Jens Axboe <axboe@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
Message-ID: <20161003210714.ukgojallutalpjun@grep.be>
References: <20160929095204.mexr6wpypo3bl6mx@grep.be>
 <87908d95-0b7c-bc3f-f69d-94d006829daf@fb.com>
 <20160929164100.akytbkbtvziwaqqj@grep.be>
 <a2d8d560-41d0-e17d-90df-b1953ce00a51@fb.com>
 <F4CD5523-E3BC-4151-B9B8-ADFE9040F6E3@alex.org.uk>
 <2B49072B-6F83-4CD2-863B-5AB21E1F7816@fb.com>
 <20161003072049.GA16847@infradead.org>
 <20161003075149.u3ppcnk2j55fci6h@grep.be>
 <20161003075701.GA29457@infradead.org>
 <97C12880-A095-4F7B-B828-1837E65F7721@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <97C12880-A095-4F7B-B828-1837E65F7721@alex.org.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Alex,
Christoph,

On Mon, Oct 03, 2016 at 12:34:33PM +0100, Alex Bligh wrote:
> On 3 Oct 2016, at 08:57, Christoph Hellwig <hch@infradead.org> wrote:
> >> Can you clarify what you mean by that? Why is it an "odd flush
> >> definition", and how would you "properly" define it?
> > 
> > E.g. take the defintion from NVMe which also supports multiple queues:
> > 
> > "The Flush command shall commit data and metadata associated with the
> > specified namespace(s) to non-volatile media. The flush applies to all
> > commands completed prior to the submission of the Flush command.

Oh, prior to submission? Okay, that means I must have misunderstood what
you meant before; in that case there shouldn't be a problem.

> > The controller may also flush additional data and/or metadata from any
> > namespace."
> > 
> > The focus is completed - we need to get a reply to the host first
> > before we can send the flush command, so anything that we require
> > to be flushed needs to explicitly be completed first.
> 
> I think there are two separate issues here:
> 
> a) What's described as the "HOL blocking issue". 
> 
> This comes down to what Wouter said here:
> 
> > Well, when I asked earlier, Christoph said[1] that blk-mq assumes that
> > when a FLUSH is sent over one channel, and the reply comes in, that all
> > commands which have been received, regardless of which channel they were
> > received over, have reched disk.
> > 
> > [1] Message-ID: <20160915122304.GA15501@infradead.org>
> > 
> > It is impossible for nbd to make such a guarantee, due to head-of-line
> > blocking on TCP.
> 
> this is perfectly accurate as far as it goes, but this isn't the current
> NBD definition of 'flush'.

I didn't read it that way.

> That is (from the docs):
> 
> > All write commands (that includes NBD_CMD_WRITE, and NBD_CMD_TRIM)
> > that the server completes (i.e. replies to) prior to processing to a
> > NBD_CMD_FLUSH MUST be written to non-volatile storage prior to
> > replying to thatNBD_CMD_FLUSH.

This is somewhat ambiguous, in that (IMO) it doesn't clearly state the
point where the cutoff of "may not be on disk yet" is. What is
"processing"? We don't define that, and therefore it could be any point
between "receipt of the request message" and "sending the reply
message". I had interpreted it closer to the latter than was apparently
intended, but that isn't very useful; I see now that it should be closer
to the former; a more useful definition is probably something along the
following lines:

    All write commands (that includes NBD_CMD_WRITE and NBD_CMD_TRIM)
    for which a reply was received on the client side prior to the
    transmission of the NBD_CMD_FLUSH message MUST be written to
    non-volatile storage prior to replying to that NBD_CMD_FLUSH. A
    server MAY process this command in ways that result committing more
    data to non-volatile storage than is strictly required.

[...]
> I don't think there is actually a problem here - Wouter if I'm wrong
> about this, I'd like to understand your argument better.

No, I now see that there isn't, and I misunderstood things. However, I
do think we should update the spec to clarify this.

> b) What I'm describing - which is the lack of synchronisation between
> channels.
[... long explanation snipped...]

Yes, and I acknowledge that. However, I think that should not be a
blocker. It's fine to mark this feature as experimental; it will not
ever be required to use multiple connections to connect to a server.

When this feature lands in nbd-client, I plan to ensure that the man
page and -help output says something along the following lines:

 use N connections to connect to the NBD server, improving performance
 at the cost of a possible loss of reliability.

 The interactions between multiple connections and the NBD_CMD_FLUSH
 command, especially when the actual storage and the NBD server are not
 physically on the same machine, are not currently well defined and not
 completely understood, and therefore the use of multiple connections to
 the same server could theoretically lead to data corruption and/or
 loss. Use with caution.

This probably needs some better wording, but you get the idea.

(also, this will interact really really badly with the reference
implementation's idea of copy-on-write, I suppose, since that implements
COW on a per-socket basis with a per-IP diff file...)

Anyway, the point is that this is a feature which may still cause
problems in a number of edge cases and which should therefore not be the
default yet, but which can be useful in a number of common situations
for which NBD is used today.

[...]
> Now, in the reference server, NBD_CMD_FLUSH is implemented through an
> fdatasync().

Actually, no, the reference server uses fsync() for reasons that I've
forgotten (side note: you wrote it that way ;-)

[...]

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
