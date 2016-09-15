Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40077 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756916AbcIOLqO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 07:46:14 -0400
Date: Thu, 15 Sep 2016 04:46:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alex Bligh <alex@alex.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Wouter Verhelst <w@uter.be>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>,
        kernel-team@fb.com
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160915114610.GA6411@infradead.org>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <20160915113807.GA23259@infradead.org>
 <751994A2-653B-4201-8210-A31495804788@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <751994A2-653B-4201-8210-A31495804788@alex.org.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 15, 2016 at 12:43:35PM +0100, Alex Bligh wrote:
> Sure, it's at:
> 
> https://github.com/yoe/nbd/blob/master/doc/proto.md#ordering-of-messages-and-writes
> 
> and that link takes you to the specific section.
> 
> The treatment of FLUSH and FUA is meant to mirror exactly the
> linux block layer (or rather how the linux block layer was a few
> years ago). I even asked on LKML to verify a few points.

Linux never expected ordering on the wire.  Before 2010 we had barriers
in the kernel that provided ordering to the caller, but we never
required it from the protocol / hardware.
