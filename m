Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:38218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbdAMIRK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 03:17:10 -0500
Date: Fri, 13 Jan 2017 00:16:53 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        osandov@osandov.com, bart.vanassche@sandisk.com
Subject: Re: [PATCH 04/10] blk-mq: un-export blk_mq_free_hctx_request()
Message-ID: <20170113081653.GB637@infradead.org>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <1484170803-9311-5-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484170803-9311-5-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 11, 2017 at 02:39:57PM -0700, Jens Axboe wrote:
> It's only used in blk-mq, kill it from the main exported header
> and kill the symbol export as well.

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
