Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:39162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755271AbcIOMhJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 08:37:09 -0400
Date: Thu, 15 Sep 2016 05:36:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alex Bligh <alex@alex.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Wouter Verhelst <w@uter.be>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, linux-block@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mpa@pengutronix.de, kernel-team@fb.com
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160915123646.GA10394@infradead.org>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <20160915113807.GA23259@infradead.org>
 <20160915115514.7hba23nqvvwfhb5z@grep.be>
 <20160915120125.GA31044@infradead.org>
 <20160915122120.4h3ykbewaavjk5nx@grep.be>
 <20160915122304.GA15501@infradead.org>
 <2ABB8966-5C20-45A7-BB4C-6882F042905D@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2ABB8966-5C20-45A7-BB4C-6882F042905D@alex.org.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 15, 2016 at 01:33:20PM +0100, Alex Bligh wrote:
> At an implementation level that is going to be a little difficult
> for some NBD servers, e.g. ones that fork() a different process per
> connection. There is in general no IPC to speak of between server
> instances. Such servers would thus be unsafe with more than one
> connection if FLUSH is in use.
> 
> I believe such servers include the reference server where there is
> process per connection (albeit possibly with several threads).
> 
> Even single process servers (including mine - gonbdserver) would
> require logic to pair up multiple connections to the same
> device.

Why?  If you only send the completion after your I/O syscall returned
your are fine if fsync comes from a difference process, no matter
if you're using direct or buffered I/O underneath.
