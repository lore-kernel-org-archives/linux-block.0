Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:54887 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752200AbcJCHwH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Oct 2016 03:52:07 -0400
Date: Mon, 3 Oct 2016 09:51:49 +0200
From: Wouter Verhelst <w@uter.be>
To: Christoph Hellwig <hch@infradead.org>
Cc: Josef Bacik <jbacik@fb.com>, Alex Bligh <alex@alex.org.uk>,
        Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
Message-ID: <20161003075149.u3ppcnk2j55fci6h@grep.be>
References: <1475092892-8230-1-git-send-email-jbacik@fb.com>
 <20160929095204.mexr6wpypo3bl6mx@grep.be>
 <87908d95-0b7c-bc3f-f69d-94d006829daf@fb.com>
 <20160929164100.akytbkbtvziwaqqj@grep.be>
 <a2d8d560-41d0-e17d-90df-b1953ce00a51@fb.com>
 <F4CD5523-E3BC-4151-B9B8-ADFE9040F6E3@alex.org.uk>
 <2B49072B-6F83-4CD2-863B-5AB21E1F7816@fb.com>
 <20161003072049.GA16847@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161003072049.GA16847@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 03, 2016 at 12:20:49AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 03, 2016 at 01:47:06AM +0000, Josef Bacik wrote:
> > It's not "broken", it's working as designed, and any fs on top of this
> > patch will be perfectly safe because they all wait for their io to complete
> > before issuing the FLUSH.  If somebody wants to address the paranoid case
> > later then all the power to them, but this works for my use case and isn't
> > inherently broken.  If it doesn't work for yours then don't use the
> > feature, it's that simple.  Thanks,
> 
> Let's take one step back here.  I agree with Josef that sending
> one single flush is perfectly fine for all usual cases.  The issue
> that was brought up last time we had this discussion was that some
> (I think mostly theoretical) backends could not be coherent and
> this would be an issue.

Actually, I was pointing out the TCP head-of-line issue, where a delay
on the socket that contains the flush reply would result in the arrival
in the kernel block layer of a write reply before the said flush reply,
resulting in a write being considered part of the flush when in fact it
was not.

This is an edge case, and one highly unlikely to result in problems in
the common case (as per my other mail), but it is something to consider.

> So maybe the right way is to simply not support the current odd flush
> defintion in the kernel then and require a new properly defined flush
> version instead.

Can you clarify what you mean by that? Why is it an "odd flush
definition", and how would you "properly" define it?

Thanks,

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
