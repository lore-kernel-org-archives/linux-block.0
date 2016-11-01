Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:37282 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034847AbcKAOqL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Nov 2016 10:46:11 -0400
Date: Tue, 1 Nov 2016 08:40:45 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, Rafael.Antognolli@intel.com, axboe@fb.com,
        linux-block@vger.kernel.org, jonathan.derrick@intel.com,
        j.naumann@fu-berlin.de
Subject: Re: [RFC PATCH 5/6] nvme: Add unlock_from_suspend
Message-ID: <20161101144044.GA7911@sbauer-Z170X-UD5>
References: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
 <1477951099-3127-6-git-send-email-scott.bauer@intel.com>
 <6a6a131a-09fe-4c7c-85a7-01149555e427@grimberg.me>
 <20161101135705.GA32697@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161101135705.GA32697@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 01, 2016 at 06:57:05AM -0700, Christoph Hellwig wrote:
> On Tue, Nov 01, 2016 at 10:18:13AM +0200, Sagi Grimberg wrote:
> > > +
> > > +	return nvme_insert_rq(q, req, 1, sec_submit_endio);
> > 
> > No need to introduce nvme_insert_rq at all, just call
> > blk_mq_insert_request (other examples call blk_execute_rq_nowait
> > but its pretty much the same...)
> 
> blk_execute_rq_nowait is the API to use - blk_mq_insert_request isn't
> even exported.

Thanks for the reviews. This patch needs to be separated into two 
patches. There is the addition of the nvme-suspend stuff and the
addition of sec_ops. Most of the clutter and weird stuff is coming
from the latter. I'll separate the patches, use the correct api and 
clean the clutter.

Thanks




