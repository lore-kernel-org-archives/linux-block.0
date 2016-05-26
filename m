Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:50227 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbcEZHJg (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 26 May 2016 03:09:36 -0400
Date: Thu, 26 May 2016 09:09:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lin <mlin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: clear q->mq_ops if init fail
Message-ID: <20160526070934.GB22449@lst.de>
References: <1464243807-27526-1-git-send-email-mlin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464243807-27526-1-git-send-email-mlin@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, May 25, 2016 at 11:23:27PM -0700, Ming Lin wrote:
> From: Ming Lin <ming.l@samsung.com>
> 
> blk_mq_init_queue() calls blk_mq_init_allocated_queue(), but q->mq_ops
> was not cleared when blk_mq_init_allocated_queue() fails.
> Then blk_cleanup_queue() calls blk_mq_free_queue() which will crash because:
> - q->all_q_node is not added to all_q_list yet
> - q->tag_set is NULL
> - hctx was not setup yet or already freed
> 
> Fixed it by clearing q->mq_ops on error path.

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
