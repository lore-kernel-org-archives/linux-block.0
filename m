Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12309 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbdHAH20 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Aug 2017 03:28:26 -0400
Date: Tue, 1 Aug 2017 15:28:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <minlei@redhat.com>
Subject: Re: [PATCH] blk-mq: don't leak preempt counter/q_usage_counter when
 allocating rq failed
Message-ID: <20170801072812.GA17297@ming.t460p>
References: <20170714084136.24850-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170714084136.24850-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 14, 2017 at 04:41:36PM +0800, Ming Lei wrote:
> From: Ming Lei <minlei@redhat.com>
> 
> When blk_mq_get_request() failed, preempt counter isn't
> released, and blk_mq_make_request() doesn't release the counter
> too.
> 
> This patch fixes the issue, and makes sure that preempt counter
> is only held if rq is allocated successfully. The same policy is
> applied on .q_usage_counter too.

Hi Jens,

Given NOWAIT has been merged, could you consider this patch for
v4.13?

Thanks,
Ming
