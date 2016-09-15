Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50669 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933894AbcIOMN4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 08:13:56 -0400
Date: Thu, 15 Sep 2016 04:38:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Wouter Verhelst <w@uter.be>
Cc: Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
        mpa@pengutronix.de, kernel-team@fb.com,
        nbd-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160915113807.GA23259@infradead.org>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160915104935.ohuwgq2chsedz6fl@grep.be>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 15, 2016 at 12:49:35PM +0200, Wouter Verhelst wrote:
> A while back, we spent quite some time defining the semantics of the
> various commands in the face of the NBD_CMD_FLUSH and NBD_CMD_FLAG_FUA
> write barriers. At the time, we decided that it would be unreasonable
> to expect servers to make these write barriers effective across
> different connections.

Do you have a nbd protocol specification?  treating a flush or fua
as any sort of barrier is incredibly stupid.  Is it really documented
that way, and if yes, why?
