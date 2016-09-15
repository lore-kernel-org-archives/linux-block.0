Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:40746 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757554AbcIOLaQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 07:30:16 -0400
Date: Thu, 15 Sep 2016 13:29:36 +0200
From: Wouter Verhelst <w@uter.be>
To: Alex Bligh <alex@alex.org.uk>
Cc: Josef Bacik <jbacik@fb.com>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>,
        kernel-team@fb.com
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160915112936.vb7zxe7k6rvczosg@grep.be>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 15, 2016 at 12:09:28PM +0100, Alex Bligh wrote:
> Wouter, Josef, (& Eric)
> 
> > On 15 Sep 2016, at 11:49, Wouter Verhelst <w@uter.be> wrote:
> > 
> > Hi,
> > 
> > On Fri, Sep 09, 2016 at 10:02:03PM +0200, Wouter Verhelst wrote:
> >> I see some practical problems with this:
> > [...]
> > 
> > One more that I didn't think about earlier:
> > 
> > A while back, we spent quite some time defining the semantics of the
> > various commands in the face of the NBD_CMD_FLUSH and NBD_CMD_FLAG_FUA
> > write barriers. At the time, we decided that it would be unreasonable
> > to expect servers to make these write barriers effective across
> > different connections.
> 
> Actually I wonder if there is a wider problem in that implementations
> might mediate access to a device by presence of an extant TCP connection,
> i.e. only permit one TCP connection to access a given block device at
> once. If you think about (for instance) a forking daemon that does
> writeback caching, that would be an entirely reasonable thing to do
> for data consistency.

Sure. They will have to live with the fact that clients connected to
them will run slower; I don't think that's a problem. In addition,
Josef's client implementation requires the user to explicitly ask for
multiple connections.

There are multiple contexts in which NBD can be used, and in some
performance is more important than in others. I think that is fine.

[...]
> A more general point is that with multiple queues requests
> may be processed in a different order even by those servers that
> currently process the requests in strict order, or in something
> similar to strict order. The server is permitted by the spec
> (save as mandated by NBD_CMD_FLUSH and NBD_CMD_FLAG_FUA) to
> process commands out of order anyway, but I suspect this has
> to date been little tested.

Yes, and that is why I was asking about this. If the write barriers
are expected to be shared across connections, we have a problem. If,
however, they are not, then it doesn't matter that the commands may be
processed out of order.

[...]

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
