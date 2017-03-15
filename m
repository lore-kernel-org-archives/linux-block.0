Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34436 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753349AbdCOQqn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2017 12:46:43 -0400
Date: Thu, 16 Mar 2017 00:46:35 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "yizhan@redhat.com" <yizhan@redhat.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] blk-mq: don't complete un-started request in timeout
 handler
Message-ID: <20170315164631.GA19203@ming.t460p>
References: <1489064578-17305-1-git-send-email-tom.leiming@gmail.com>
 <1489064578-17305-3-git-send-email-tom.leiming@gmail.com>
 <1489536441.2676.21.camel@sandisk.com>
 <20170315121851.GA15807@ming.t460p>
 <20170315124024.GA16549@ming.t460p>
 <1489592177.2660.1.camel@sandisk.com>
 <20170315162158.GA18768@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170315162158.GA18768@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Mar 16, 2017 at 12:22:01AM +0800, Ming Lei wrote:
> On Wed, Mar 15, 2017 at 03:36:31PM +0000, Bart Van Assche wrote:
> 
> OK, this race should only exist in case that the requeue happens after dispatch
> busy, because COMPLETE flag isn't set. And if the requeue is from io completion,
> no such race because COMPLETE flag is set.
> 
> One solution I thought of is to call blk_mark_rq_complete() before requeuing
> when dispatch busy happened, but that looks a bit silly. Another way is to
> set STARTED flag just after .queue_rq returns BLK_MQ_RQ_QUEUE_OK, which looks
> reasonable too. Any comments on the 2nd solution?

Actually it isn't possible to happen because rq->deadline is just set
in blk_mq_start_request() called from .queue_rq, and it won't trigger
timeout handling even STARTED is observed as true in blk_mq_check_expired()
because timeout period is often set as big enough. So it is still safe, isn't it?

But this situation should have been commented.

Thanks,
Ming
