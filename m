Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:60940 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752094AbcIOQ1e (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 12:27:34 -0400
Date: Thu, 15 Sep 2016 18:27:14 +0200
From: Wouter Verhelst <w@uter.be>
To: Alex Bligh <alex@alex.org.uk>
Cc: "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, linux-block@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, mpa@pengutronix.de,
        kernel-team@fb.com
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160915162714.om3rwucexi5ogjtm@grep.be>
References: <20160915120125.GA31044@infradead.org>
 <20160915122120.4h3ykbewaavjk5nx@grep.be>
 <20160915122304.GA15501@infradead.org>
 <2ABB8966-5C20-45A7-BB4C-6882F042905D@alex.org.uk>
 <20160915123646.GA10394@infradead.org>
 <C48DD624-6EDF-4EED-B474-8BEA021F00F0@alex.org.uk>
 <20160915124103.GA20657@infradead.org>
 <DA0880DA-700F-4989-9326-68F5F7A55F25@alex.org.uk>
 <20160915131741.cth6kilmcgnobbuu@grep.be>
 <ECDC1983-E21B-48D5-892D-63CA3572B2B4@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ECDC1983-E21B-48D5-892D-63CA3572B2B4@alex.org.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 15, 2016 at 05:08:21PM +0100, Alex Bligh wrote:
> Wouter,
> 
> > The server can always refuse to allow multiple connections.
> 
> Sure, but it would be neater to warn the client of that at negotiation
> stage (it would only be one flag, e.g.  'multiple connections
> unsafe').

I suppose that's not a bad idea.

[...]
> > I was thinking of changing the spec as follows:
> > 
> > diff --git a/doc/proto.md b/doc/proto.md
> > index 217f57e..cb099e2 100644
> > --- a/doc/proto.md
> > +++ b/doc/proto.md
> > @@ -308,6 +308,23 @@ specification, the
> > [kernel documentation](https://www.kernel.org/doc/Documentation/block/writeback_cache_control.txt)
> > may be useful.
> > 
> > +For performance reasons, clients MAY open multiple connections to the
> > +same server. To support such clients, servers SHOULD ensure that at
> > +least one of the following conditions hold:
> > +
> > +* Flush commands are processed for ALL connections. That is, when an
> > +  `NBD_CMD_WRITE` is processed on one connection, and then an
> > +  `NBD_CMD_FLUSH` is processed on another connection, the data of the
> > +  `NBD_CMD_WRITE` on the first connection MUST reach permanent storage
> > +  before the reply of the `NBD_CMD_FLUSH` is sent.
> > +* The server allows `NBD_CMD_WRITE` and `NBD_CMD_FLUSH` on at most one
> > +  connection
> > +* Multiple connections are not allowed
> > +
> > +In addition, clients using multiple connections SHOULD NOT send
> > +`NBD_CMD_FLUSH` if an `NBD_CMD_WRITE` for which they care in relation to
> > +the flush has not been replied to yet.
> > +
> 
> I don't think that should be a mandatory behaviour.

Which part of it?

> For once, it would
> be reasonably easy on gonbdserver but a PITA on the reference server.
> You'd need to put in IPC between each of the forked processes OR rely
> on fdatasync() only - I'm not sure that would necessarily work
> safely with (e.g.) the 'treefiles' / COW options.
> 
> I think better would be to say that the server MUST either
> 
> * Not support NBD_CMD_FLUSH at all

I think we should discourage not supporting FLUSH, rather than
suggesting it. 

> * Support NBD_CMD_FLUSH across channels (as you set out above), or
> * Indicate that it does not support multiple channels.

You dropped the one with no writes. I said "at most" there for a reason.
Originally I was going to say "if the server is read-only", but then
thought that it could work to do the "at most" thing. After having given
that some more thought, I now realize that if you write, you need to
flush across to other channels, regardless of whether they write too, so
that bit of it is moot now anyway.

Still, a server which exports read-only should still be safe for
multiple connections, even if there is no cache coherency (since
presumably nothing's going to change anyway).

[...]
> > The latter bit (on the client side) is because even if your backend has
> > no cache coherency issues, TCP does not guarantee ordering between
> > multiple connections. I don't know if the above is in line with what
> > blk-mq does, but consider the following scenario:
> > 
> > - A client sends two writes to the server, followed (immediately) by a
> >  flush, where at least the second write and the flush are not sent over
> >  the same connection.
> > - The first write is a small one, and it is handled almost immediately.
> > - The second write takes a little longer, so the flush is handled
> >  earlier than the second write
> > - The network packet containing the flush reply gets lost for whatever
> >  reason, so the client doesn't get it, and we fall into TCP
> >  retransmits.
> > - The second write finishes, and its reply header does not get lost
> > - After the second write reply reaches the client, the TCP retransmits
> >  for the flush reply are handled.
> > 
> > In the above scenario, the flush reply arrives on the client side after
> > a write reply which it did not cover; so the client will (incorrectly)
> > assume that the write has reached permanent storage when in fact it may
> > not have done so yet.
> > 
> > If the kernel does not care about the ordering of the two writes versus
> > the flush, then there is no problem. I don't know how blk-mq works in
> > that context, but if the above is a likely scenario, we may have to
> > reconsider adding blk-mq to nbd.
> 
> Actually I think this is a problem anyway. A simpler failure case is
> one where (by chance) one channel gets the writes, and one channel
> gets the flushes. The flush reply is delayed beyond the replies to
> unconnected writes (on the other channel) and hence the kernel thinks
> replied-to writes have been persisted when they have not been.

Yes, that is another example of essentially the same problem.

> The only way to fix that (as far as I can see) without changing flush
> semantics is for the block layer to issue flush requests on each
> channel when flushing on one channel.

Christoph just said that that doesn't (currently) happen; I don't know
whether the kernel currently already (optimistically) sends out flush
requests before the writes that it expects to hit permanent storage have
finished, but if it doesn't do that, then there is no problem and my
suggested bit of spec would be okay.

If there are good reasons to do so, however, we do indeed have a problem
and something else is necessary. I don't think flushing across all
connections is the best solution, though.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
