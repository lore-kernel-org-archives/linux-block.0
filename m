Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:47661 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755575AbcJFNKg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Oct 2016 09:10:36 -0400
Date: Thu, 6 Oct 2016 15:09:49 +0200
From: Wouter Verhelst <w@uter.be>
To: Christoph Hellwig <hch@infradead.org>
Cc: "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
Message-ID: <20161006130949.nk7gsy6lpw5kudbg@grep.be>
References: <F4CD5523-E3BC-4151-B9B8-ADFE9040F6E3@alex.org.uk>
 <2B49072B-6F83-4CD2-863B-5AB21E1F7816@fb.com>
 <20161003072049.GA16847@infradead.org>
 <20161003075149.u3ppcnk2j55fci6h@grep.be>
 <20161003075701.GA29457@infradead.org>
 <97C12880-A095-4F7B-B828-1837E65F7721@alex.org.uk>
 <20161003210714.ukgojallutalpjun@grep.be>
 <2AEFCBE9-E2C9-400E-9FF8-91901D7CE442@alex.org.uk>
 <20161006090415.xme3mgcjtkdx2j5f@grep.be>
 <20161006103155.GA20279@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161006103155.GA20279@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Oct 06, 2016 at 03:31:55AM -0700, Christoph Hellwig wrote:
> No, they match the cache flush semantics in every other storage protocol
> known to me, and they match the expectations of both the Linux kernel
> and any other OS or comsumer I know about perfectly.

Okay, I've updated the proto.md file then, to clarify that in the case
of multiple connections, a client MUST NOT send a flush request until it
has seen the replies to the write requests that it cares about. That
should be enough for now.

Thanks,

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
