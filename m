Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933268AbcIOMlG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 08:41:06 -0400
Date: Thu, 15 Sep 2016 05:41:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alex Bligh <alex@alex.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Wouter Verhelst <w@uter.be>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, linux-block@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mpa@pengutronix.de, kernel-team@fb.com
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160915124103.GA20657@infradead.org>
References: <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <20160915113807.GA23259@infradead.org>
 <20160915115514.7hba23nqvvwfhb5z@grep.be>
 <20160915120125.GA31044@infradead.org>
 <20160915122120.4h3ykbewaavjk5nx@grep.be>
 <20160915122304.GA15501@infradead.org>
 <2ABB8966-5C20-45A7-BB4C-6882F042905D@alex.org.uk>
 <20160915123646.GA10394@infradead.org>
 <C48DD624-6EDF-4EED-B474-8BEA021F00F0@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C48DD624-6EDF-4EED-B474-8BEA021F00F0@alex.org.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 15, 2016 at 01:39:11PM +0100, Alex Bligh wrote:
> That's probably right in the case of file-based back ends that
> are running on a Linux OS. But gonbdserver for instance supports
> (e.g.) Ceph based backends, where each connection might be talking
> to a completely separate ceph node, and there may be no cache
> consistency between connections.

Yes, if you don't have a cache coherent backend you are generally
screwed with a multiqueue protocol.
