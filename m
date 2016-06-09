Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:54357 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbcFIOKO (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 9 Jun 2016 10:10:14 -0400
Date: Thu, 9 Jun 2016 16:10:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@lightbits.io>
Cc: Ming Lin <mlin@kernel.org>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH 2/2] nvme-rdma: check the number of hw queues mapped
Message-ID: <20160609141012.GB30293@lst.de>
References: <1465415292-9416-1-git-send-email-mlin@kernel.org> <1465415292-9416-3-git-send-email-mlin@kernel.org> <575950DB.6080701@lightbits.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <575950DB.6080701@lightbits.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 09, 2016 at 02:19:55PM +0300, Sagi Grimberg wrote:
> This needs documentation in the form of:
>
> /*
>  * XXX: blk-mq might not map all our hw contexts but this is a must for
>  * us for fabric connects. So until we can fix blk-mq we check that.
>  */

I think the right thing to do is to have a member of actually mapped
queues in the block layer, and I also don't think we need the XXX comment
as there are valid reasons for not mapping all queues.
