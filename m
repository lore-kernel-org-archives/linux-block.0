Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751794AbdK0MmD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Nov 2017 07:42:03 -0500
Date: Mon, 27 Nov 2017 20:41:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 0/2] block: fix queue freeze and cleanup
Message-ID: <20171127124147.GA16095@ming.t460p>
References: <20171123044800.25251-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171123044800.25251-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Nov 23, 2017 at 12:47:58PM +0800, Ming Lei wrote:
> Hi Jens,
> 
> The 1st patch runs queue in blk_freeze_queue_start() for fixing one
> regression by 055f6e18e08f("block: Make q_usage_counter also track legacy
> requests").
> 
> The 2nd patch drians blkcg part of request_queue for both blk-mq and
> legacy, which can be a fix on blk-mq's queue cleanup.
> 
> V2:
> 	- follow Bart's suggestion to use run queue instead of drain queue
> 	- drians blkcg part of request_queue for blk-mq
> 

Hi Jens,

Without this patchset, IO hang can be triggered in Mauricio's disk
pull test, and this IO hang won't happen any more after this patchset
is applied.

So could you make it in V4.15 if you are fine with the two patches?

Thanks,
Ming
