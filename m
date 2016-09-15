Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:42863 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934709AbcIOMBc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 08:01:32 -0400
Date: Thu, 15 Sep 2016 05:01:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Wouter Verhelst <w@uter.be>
Cc: Christoph Hellwig <hch@infradead.org>,
        nbd-general@lists.sourceforge.net, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        mpa@pengutronix.de, kernel-team@fb.com
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160915120125.GA31044@infradead.org>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <20160915113807.GA23259@infradead.org>
 <20160915115514.7hba23nqvvwfhb5z@grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160915115514.7hba23nqvvwfhb5z@grep.be>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 15, 2016 at 01:55:14PM +0200, Wouter Verhelst wrote:
> Maybe I'm not using the correct terminology here. The point is that
> after a FLUSH, the server asserts that all write commands *for which a
> reply has already been sent to the client* will also have reached
> permanent storage. Nothing is asserted about commands for which the
> reply has not yet been sent, regardless of whether they were sent to the
> server before or after the FLUSH; they may reach permanent storage as a
> result of the FLUSH, or they may not, we don't say.
> 
> With FUA, we only assert that the FUA-flagged command reaches permanent
> storage before its reply is sent, nothing else.

Yes, that's the correct semantics.

> If that's not a write barrier, then I was using the wrong terminology
> (and offer my apologies for the confusion).

It's not a write barrier - a write barrier was command that ensured that

 a) all previous writes were completed to the host/client
 b) all previous writes were on non-volatile storage

and

 c) the actual write with the barrier bit was on non-volatile storage

> The point still remains that "X was sent before Y" is difficult to
> determine on the client side if X was sent over a different TCP channel
> than Y, because a packet might be dropped (requiring a retransmit) for
> X, and similar things. If blk-mq can deal with that, we're good and
> nothing further needs to be done. If not, this should be evaluated by
> someone more familiar with the internals of the kernel block subsystem
> than me.

The important bit in all the existing protocols, and which Linux relies
on is that any write the Linux block layer got a completion for earlier
needs to be flushed out to non-volatile storage when a FLUSH command is
set.  Anything that still is in flight does not matter.  Which for
NBD means anything that you already replies to need to be flushed.

Or to say it more practicly - in the nbd server you simply need to
call fdatasync on the backing device or file whenever you get a FLUSH
requires, and it will do the right thing.
