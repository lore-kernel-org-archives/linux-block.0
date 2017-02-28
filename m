Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751737AbdB1Jr4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Feb 2017 04:47:56 -0500
Date: Tue, 28 Feb 2017 10:46:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 0/4] blk-mq: cleanup on all kinds of kobjects
Message-ID: <20170228094643.GE6557@twins.programming.kicks-ass.net>
References: <1487758442-5855-1-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487758442-5855-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Feb 22, 2017 at 06:13:58PM +0800, Ming Lei wrote:
> This patchset cleans up on kojects of request_queue.mq_kobj,
> sw queue's kobject and hw queue's kobject.
> 
> The 1st patch initialized kobject of request_queue and sw queue
> in blk_mq_init_allocated_queue(), so we can avoid to initialize
> these kobjects several times, and this patch fixes one kerne
> warning reported from Omar Sandoval.
> 
> The 2nd patch makes lifetime consitent between mq request queue/sw
> queue and their kobjects.
> 
> The 3rd patch makes lifetime consitent between hw queue and their
> kobjects.
> 
> The last patch is a followup of 3rd patch.

These do indeed make the kobject warnings, and the resulting refcount
warning, go away.

Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
