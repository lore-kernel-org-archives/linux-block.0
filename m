Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37761 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763607AbcIOLjW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 07:39:22 -0400
Date: Thu, 15 Sep 2016 04:39:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alex Bligh <alex@alex.org.uk>
Cc: Wouter Verhelst <w@uter.be>, Josef Bacik <jbacik@fb.com>,
        linux-block@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>,
        kernel-team@fb.com,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Blake <eblake@redhat.com>
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160915113918.GB23259@infradead.org>
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
> A more general point is that with multiple queues requests
> may be processed in a different order even by those servers that
> currently process the requests in strict order, or in something
> similar to strict order. The server is permitted by the spec
> (save as mandated by NBD_CMD_FLUSH and NBD_CMD_FLAG_FUA) to
> process commands out of order anyway, but I suspect this has
> to date been little tested.

The Linux kernel does not assume any synchroniztion between block I/O
commands.  So any sort of synchronization a protocol does is complete
overkill for us.
