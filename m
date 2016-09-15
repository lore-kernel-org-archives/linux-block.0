Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:36760 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933595AbcIOML1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 08:11:27 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20160915120125.GA31044@infradead.org>
Date: Thu, 15 Sep 2016 13:11:24 +0100
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, linux-block@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mpa@pengutronix.de, kernel-team@fb.com
Message-Id: <30DE0D1A-FAB1-43EE-A88E-ED6565719166@alex.org.uk>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com> <20160909200203.phhvodsfs7ymukfp@grep.be> <20160915104935.ohuwgq2chsedz6fl@grep.be> <20160915113807.GA23259@infradead.org> <20160915115514.7hba23nqvvwfhb5z@grep.be> <20160915120125.GA31044@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Christoph,

> It's not a write barrier - a write barrier was command that ensured =
that
>=20
> a) all previous writes were completed to the host/client
> b) all previous writes were on non-volatile storage
>=20
> and
>=20
> c) the actual write with the barrier bit was on non-volatile storage

Ah! the bit you are complaining about is not the bit I pointed to you, =
but:

> NBD_CMD_FLUSH (3)
>=20
> A flush request; a write barrier.=20

I can see that's potentially confusing as isn't meant to mean 'an =
old-style
linux kernel block device write barrier'. I think in general terms it
probably is some form of barrier, but I see no problem in deleting the
words "a write barrier" from the spec text if only to make it
clearer. However, I think the description of the command itself:

> The server MUST NOT send a successful reply header for this request =
before all write requests for which a reply has already been sent to the =
client have reached permanent storage (using fsync() or similar).

and the ordering section I pointed you to before, were both correct, =
yes?


>> The point still remains that "X was sent before Y" is difficult to
>> determine on the client side if X was sent over a different TCP =
channel
>> than Y, because a packet might be dropped (requiring a retransmit) =
for
>> X, and similar things. If blk-mq can deal with that, we're good and
>> nothing further needs to be done. If not, this should be evaluated by
>> someone more familiar with the internals of the kernel block =
subsystem
>> than me.
>=20
> The important bit in all the existing protocols, and which Linux =
relies
> on is that any write the Linux block layer got a completion for =
earlier
> needs to be flushed out to non-volatile storage when a FLUSH command =
is
> set.  Anything that still is in flight does not matter.  Which for
> NBD means anything that you already replies to need to be flushed.

... that's what it says (I hope).

> Or to say it more practicly - in the nbd server you simply need to
> call fdatasync on the backing device or file whenever you get a FLUSH
> requires, and it will do the right thing.

actually fdatasync() technically does more than is necessary, as it
will also flush commands that have been processed, but for which no
reply has yet been sent - that's no bad thing.

--=20
Alex Bligh




