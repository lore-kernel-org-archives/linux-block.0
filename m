Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:53688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934042AbcIOMSV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 08:18:21 -0400
Date: Thu, 15 Sep 2016 05:18:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alex Bligh <alex@alex.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Wouter Verhelst <w@uter.be>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, linux-block@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mpa@pengutronix.de, kernel-team@fb.com
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160915121818.GA1155@infradead.org>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <20160915113807.GA23259@infradead.org>
 <20160915115514.7hba23nqvvwfhb5z@grep.be>
 <20160915120125.GA31044@infradead.org>
 <30DE0D1A-FAB1-43EE-A88E-ED6565719166@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <30DE0D1A-FAB1-43EE-A88E-ED6565719166@alex.org.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 15, 2016 at 01:11:24PM +0100, Alex Bligh wrote:
> > NBD_CMD_FLUSH (3)
> > 
> > A flush request; a write barrier. 
> 
> I can see that's potentially confusing as isn't meant to mean 'an old-style
> linux kernel block device write barrier'. I think in general terms it
> probably is some form of barrier, but I see no problem in deleting the
> words "a write barrier" from the spec text if only to make it
> clearer.

Yes, please do that.  A "barrier" implies draining of the queue.

> However, I think the description of the command itself:
> 
> > The server MUST NOT send a successful reply header for this request before all write requests for which a reply has already been sent to the client have reached permanent storage (using fsync() or similar).
> 
> and the ordering section I pointed you to before, were both correct, yes?

Yes, this seems correct.

> actually fdatasync() technically does more than is necessary, as it
> will also flush commands that have been processed, but for which no
> reply has yet been sent - that's no bad thing.

Yes.  But without an actual barrier it's hard to be exact - and
fdatasync does the right thing by including false positives.
