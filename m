Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:34899 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756829AbcIVO7Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2016 10:59:24 -0400
Date: Thu, 22 Sep 2016 07:59:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, jbacik@fb.com,
        Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH 2/2] blk-mq: add flag for drivers wanting blocking
 ->queue_rq()
Message-ID: <20160922145922.GB1800@infradead.org>
References: <1474555980-2787-1-git-send-email-axboe@fb.com>
 <1474555980-2787-3-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474555980-2787-3-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 22, 2016 at 08:53:00AM -0600, Jens Axboe wrote:
> If a driver sets BLK_MQ_F_BLOCKING, it is allowed to block in its
> ->queue_rq() handler. For that case, blk-mq ensures that we always
> calls it from a safe context.

First can you provide a more useful defintion of blocking?  Lots of current
drivers will already block in ->queue_rq, mostly to allocate memory.

Second we looked at something similar a few times ago, mosty notably
when converting loop and rbd, and came to the conclusion that
performance sucks when we only have that single per-hctx work struct
for a busy device.  I think Ming has done a lot of the benchmarking,
so I've added him to Cc.
