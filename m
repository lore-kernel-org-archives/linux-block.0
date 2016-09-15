Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37958 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763811AbcIOLkJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 07:40:09 -0400
Date: Thu, 15 Sep 2016 04:40:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Wouter Verhelst <w@uter.be>
Cc: Alex Bligh <alex@alex.org.uk>, Josef Bacik <jbacik@fb.com>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>,
        kernel-team@fb.com
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160915114005.GC23259@infradead.org>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk>
 <20160915112936.vb7zxe7k6rvczosg@grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160915112936.vb7zxe7k6rvczosg@grep.be>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 15, 2016 at 01:29:36PM +0200, Wouter Verhelst wrote:
> Yes, and that is why I was asking about this. If the write barriers
> are expected to be shared across connections, we have a problem. If,
> however, they are not, then it doesn't matter that the commands may be
> processed out of order.

There is no such thing as a write barrier in the Linux kernel.  We'd
much prefer protocols not to introduce any pointless synchronization
if we can avoid it.
