Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56998 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932794AbcIOMXH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 08:23:07 -0400
Date: Thu, 15 Sep 2016 05:23:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Wouter Verhelst <w@uter.be>
Cc: Christoph Hellwig <hch@infradead.org>,
        nbd-general@lists.sourceforge.net, linux-block@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>, linux-kernel@vger.kernel.org,
        mpa@pengutronix.de, kernel-team@fb.com
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160915122304.GA15501@infradead.org>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <20160915113807.GA23259@infradead.org>
 <20160915115514.7hba23nqvvwfhb5z@grep.be>
 <20160915120125.GA31044@infradead.org>
 <20160915122120.4h3ykbewaavjk5nx@grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160915122120.4h3ykbewaavjk5nx@grep.be>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 15, 2016 at 02:21:20PM +0200, Wouter Verhelst wrote:
> Right. So do I understand you correctly that blk-mq currently doesn't
> look at multiple queues, and just assumes that if a FLUSH is sent over
> any one of the queues, it applies to all queues?

Yes.  The same is true at the protocol level for NVMe or SCSI transports
that can make use of multiple queues.
