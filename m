Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:33585 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbcJCHUy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2016 03:20:54 -0400
Date: Mon, 3 Oct 2016 00:20:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Josef Bacik <jbacik@fb.com>
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>,
        Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
Message-ID: <20161003072049.GA16847@infradead.org>
References: <1475092892-8230-1-git-send-email-jbacik@fb.com>
 <20160929095204.mexr6wpypo3bl6mx@grep.be>
 <87908d95-0b7c-bc3f-f69d-94d006829daf@fb.com>
 <20160929164100.akytbkbtvziwaqqj@grep.be>
 <a2d8d560-41d0-e17d-90df-b1953ce00a51@fb.com>
 <F4CD5523-E3BC-4151-B9B8-ADFE9040F6E3@alex.org.uk>
 <2B49072B-6F83-4CD2-863B-5AB21E1F7816@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2B49072B-6F83-4CD2-863B-5AB21E1F7816@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 03, 2016 at 01:47:06AM +0000, Josef Bacik wrote:
> It's not "broken", it's working as designed, and any fs on top of this patch will be perfectly safe because they all wait for their io to complete before issuing the FLUSH.  If somebody wants to address the paranoid case later then all the power to them, but this works for my use case and isn't inherently broken.  If it doesn't work for yours then don't use the feature, it's that simple.  Thanks,

Let's take one step back here.  I agree with Josef that sending
one single flush is perfectly fine for all usual cases.  The issue
that was brought up last time we had this discussion was that some
(I think mostly theoretical) backends could not be coherent and
this would be an issue.

So maybe the right way is to simply not support the current odd flush
defintion in the kernel then and require a new properly defined flush
version instead.
