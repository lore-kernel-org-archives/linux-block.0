Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:58130 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbcJFNQl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2016 09:16:41 -0400
Date: Thu, 6 Oct 2016 06:16:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Wouter Verhelst <w@uter.be>
Cc: Christoph Hellwig <hch@infradead.org>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
Message-ID: <20161006131630.GA29465@infradead.org>
References: <2B49072B-6F83-4CD2-863B-5AB21E1F7816@fb.com>
 <20161003072049.GA16847@infradead.org>
 <20161003075149.u3ppcnk2j55fci6h@grep.be>
 <20161003075701.GA29457@infradead.org>
 <97C12880-A095-4F7B-B828-1837E65F7721@alex.org.uk>
 <20161003210714.ukgojallutalpjun@grep.be>
 <2AEFCBE9-E2C9-400E-9FF8-91901D7CE442@alex.org.uk>
 <20161006090415.xme3mgcjtkdx2j5f@grep.be>
 <20161006103155.GA20279@infradead.org>
 <20161006130949.nk7gsy6lpw5kudbg@grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161006130949.nk7gsy6lpw5kudbg@grep.be>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Oct 06, 2016 at 03:09:49PM +0200, Wouter Verhelst wrote:
> Okay, I've updated the proto.md file then, to clarify that in the case
> of multiple connections, a client MUST NOT send a flush request until it
> has seen the replies to the write requests that it cares about. That
> should be enough for now.

How do you guarantee that nothing has been reordered or even lost even for
a single connection?
