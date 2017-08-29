Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:26771 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751323AbdH2PhF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Aug 2017 11:37:05 -0400
Date: Tue, 29 Aug 2017 11:41:38 -0400
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 10/10] nvme: implement multipath access to nvme subsystems
Message-ID: <20170829154138.GB4428@localhost.localdomain>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-11-hch@lst.de>
 <20170829145417.GA4428@localhost.localdomain>
 <20170829145559.GA32760@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170829145559.GA32760@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Aug 29, 2017 at 04:55:59PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 29, 2017 at 10:54:17AM -0400, Keith Busch wrote:
> > It also looks like new submissions will get a new path only from the
> > fact that the original/primary is being reset. The controller reset
> > itself seems a bit heavy-handed. Can we just set head->current_path to
> > the next active controller in the list?
> 
> For ANA we'll have to do that anyway, but if we got a failure
> that clearly indicates a path failure what benefit is there in not
> resetting the controller?  But yeah, maybe we can just switch the
> path for non-ANA controllers and wait for timeouts to do their work.

Okay, sounds reasonable.

Speaking of timeouts, nvme_req_needs_retry will fail the command
immediately rather than try the alternate path if it was cancelled due
to timeout handling. Should we create a new construct for a command's
total time separate from recovery timeout so we may try an alternate
paths?
