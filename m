Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34753 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdCOMkc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2017 08:40:32 -0400
Date: Wed, 15 Mar 2017 20:40:25 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "yizhan@redhat.com" <yizhan@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] blk-mq: don't complete un-started request in timeout
 handler
Message-ID: <20170315124024.GA16549@ming.t460p>
References: <1489064578-17305-1-git-send-email-tom.leiming@gmail.com>
 <1489064578-17305-3-git-send-email-tom.leiming@gmail.com>
 <1489536441.2676.21.camel@sandisk.com>
 <20170315121851.GA15807@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170315121851.GA15807@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Mar 15, 2017 at 08:18:53PM +0800, Ming Lei wrote:
> On Wed, Mar 15, 2017 at 12:07:37AM +0000, Bart Van Assche wrote:
> 
> > or __blk_mq_requeue_request(). Another issue with this function is that the
> 
> __blk_mq_requeue_request() can be run from two pathes:
> 
> 	- dispatch failure, in which case the req/tag isn't released to tag set
> 	
> 	- IO completion path, in which COMPLETE flag is cleared before requeue.
> 	
> so I can't see races with timeout in case of start rq vs. requeue rq. 

Actually rq/tag won't be released to tag set if it will be requeued, so
the timeout race is nothing to do with requeue.

Thanks,
Ming
