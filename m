Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:57198 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755271AbcIOMVg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 08:21:36 -0400
Date: Thu, 15 Sep 2016 14:21:20 +0200
From: Wouter Verhelst <w@uter.be>
To: Christoph Hellwig <hch@infradead.org>
Cc: nbd-general@lists.sourceforge.net, linux-block@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>, linux-kernel@vger.kernel.org,
        mpa@pengutronix.de, kernel-team@fb.com
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160915122120.4h3ykbewaavjk5nx@grep.be>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <20160915113807.GA23259@infradead.org>
 <20160915115514.7hba23nqvvwfhb5z@grep.be>
 <20160915120125.GA31044@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160915120125.GA31044@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 15, 2016 at 05:01:25AM -0700, Christoph Hellwig wrote:
> On Thu, Sep 15, 2016 at 01:55:14PM +0200, Wouter Verhelst wrote:
> > If that's not a write barrier, then I was using the wrong terminology
> > (and offer my apologies for the confusion).
> 
> It's not a write barrier - a write barrier was command that ensured that
[...]

Okay, I'll update the spec to remove that term then.

> > The point still remains that "X was sent before Y" is difficult to
> > determine on the client side if X was sent over a different TCP channel
> > than Y, because a packet might be dropped (requiring a retransmit) for
> > X, and similar things. If blk-mq can deal with that, we're good and
> > nothing further needs to be done. If not, this should be evaluated by
> > someone more familiar with the internals of the kernel block subsystem
> > than me.
> 
> The important bit in all the existing protocols, and which Linux relies
> on is that any write the Linux block layer got a completion for earlier
> needs to be flushed out to non-volatile storage when a FLUSH command is
> set.  Anything that still is in flight does not matter.  Which for
> NBD means anything that you already replies to need to be flushed.
> 
> Or to say it more practicly - in the nbd server you simply need to
> call fdatasync on the backing device or file whenever you get a FLUSH
> requires, and it will do the right thing.

Right. So do I understand you correctly that blk-mq currently doesn't
look at multiple queues, and just assumes that if a FLUSH is sent over
any one of the queues, it applies to all queues?

If so, I'll update the spec to clarify that servers should ensure this
holds in the case of multiple connections, or not allow writes, or not
allow multiple connections.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
