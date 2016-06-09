Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:54337 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbcFIOJL (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 9 Jun 2016 10:09:11 -0400
Date: Thu, 9 Jun 2016 16:09:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lin <mlin@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
	James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH 0/2] check the number of hw queues mapped to sw queues
Message-ID: <20160609140909.GA30293@lst.de>
References: <1465415292-9416-1-git-send-email-mlin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465415292-9416-1-git-send-email-mlin@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 08, 2016 at 03:48:10PM -0400, Ming Lin wrote:
> It adds check code to blk_mq_update_queue_map().
> But it seems too aggresive because it's not an error that some hw queues
> were not mapped to sw queues.
> 
> So this series just add a new function blk_mq_hctx_mapped() to check
> how many hw queues were mapped. And the driver(for example, nvme-rdma)
> that cares about it will do the check.

I think it would be better to have this number available a structure
field.  Any reason not to update nr_hw_queues in the tag set
with the actual number of queues?
