Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:51539 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755840AbcIOLz5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 07:55:57 -0400
Date: Thu, 15 Sep 2016 13:55:14 +0200
From: Wouter Verhelst <w@uter.be>
To: Christoph Hellwig <hch@infradead.org>
Cc: nbd-general@lists.sourceforge.net, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        mpa@pengutronix.de, kernel-team@fb.com
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160915115514.7hba23nqvvwfhb5z@grep.be>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <20160915113807.GA23259@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160915113807.GA23259@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 15, 2016 at 04:38:07AM -0700, Christoph Hellwig wrote:
> On Thu, Sep 15, 2016 at 12:49:35PM +0200, Wouter Verhelst wrote:
> > A while back, we spent quite some time defining the semantics of the
> > various commands in the face of the NBD_CMD_FLUSH and NBD_CMD_FLAG_FUA
> > write barriers. At the time, we decided that it would be unreasonable
> > to expect servers to make these write barriers effective across
> > different connections.
> 
> Do you have a nbd protocol specification?

https://github.com/yoe/nbd/blob/master/doc/proto.md

> treating a flush or fua as any sort of barrier is incredibly stupid.

Maybe I'm not using the correct terminology here. The point is that
after a FLUSH, the server asserts that all write commands *for which a
reply has already been sent to the client* will also have reached
permanent storage. Nothing is asserted about commands for which the
reply has not yet been sent, regardless of whether they were sent to the
server before or after the FLUSH; they may reach permanent storage as a
result of the FLUSH, or they may not, we don't say.

With FUA, we only assert that the FUA-flagged command reaches permanent
storage before its reply is sent, nothing else.

If that's not a write barrier, then I was using the wrong terminology
(and offer my apologies for the confusion).

The point still remains that "X was sent before Y" is difficult to
determine on the client side if X was sent over a different TCP channel
than Y, because a packet might be dropped (requiring a retransmit) for
X, and similar things. If blk-mq can deal with that, we're good and
nothing further needs to be done. If not, this should be evaluated by
someone more familiar with the internals of the kernel block subsystem
than me.

> Is it really documented that way, and if yes, why?

The documentation does use the term write barrier, but only right before
the same explanation as above. It does so because I assumed that that is
what a write barrier is, and that this would make things easier to
understand. If you tell me that that term is wrong as used there, I can
easily remove it (it's not critical to the rest of the documentation).

Regards,

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
