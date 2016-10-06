Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:43477 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752199AbcJFN4P (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Oct 2016 09:56:15 -0400
Date: Thu, 6 Oct 2016 15:55:29 +0200
From: Wouter Verhelst <w@uter.be>
To: Christoph Hellwig <hch@infradead.org>
Cc: "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Josef Bacik <jbacik@fb.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
Message-ID: <20161006135529.zrdkxycu7ajvhhmv@grep.be>
References: <20161003072049.GA16847@infradead.org>
 <20161003075149.u3ppcnk2j55fci6h@grep.be>
 <20161003075701.GA29457@infradead.org>
 <97C12880-A095-4F7B-B828-1837E65F7721@alex.org.uk>
 <20161003210714.ukgojallutalpjun@grep.be>
 <2AEFCBE9-E2C9-400E-9FF8-91901D7CE442@alex.org.uk>
 <20161006090415.xme3mgcjtkdx2j5f@grep.be>
 <20161006103155.GA20279@infradead.org>
 <20161006130949.nk7gsy6lpw5kudbg@grep.be>
 <20161006131630.GA29465@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161006131630.GA29465@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Oct 06, 2016 at 06:16:30AM -0700, Christoph Hellwig wrote:
> On Thu, Oct 06, 2016 at 03:09:49PM +0200, Wouter Verhelst wrote:
> > Okay, I've updated the proto.md file then, to clarify that in the case
> > of multiple connections, a client MUST NOT send a flush request until it
> > has seen the replies to the write requests that it cares about. That
> > should be enough for now.
> 
> How do you guarantee that nothing has been reordered or even lost even for
> a single connection?

In the case of a single connection, we already stated that the flush
covers the write requests for which a reply has already been sent out by
the time the flush reply is sent out. On a single connection, there is
no way an implementation can comply with the old requirement but not the
new one.

We do not guarantee any ordering beyond that; and lost requests would be
a bug in the server.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
