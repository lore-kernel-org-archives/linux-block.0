Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbdKDERS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 4 Nov 2017 00:17:18 -0400
Date: Sat, 4 Nov 2017 12:17:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 0/7] blk-mq: don't allocate driver tag beforehand for
 flush rq
Message-ID: <20171104041703.GA2819@ming.t460p>
References: <20171102152438.25324-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171102152438.25324-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Nov 02, 2017 at 11:24:31PM +0800, Ming Lei wrote:
> Hi Jens,
> 
> This patchset avoids to allocate driver tag beforehand for flush rq
> in case of I/O scheduler, then flush rq isn't treated specially
> wrt. get/put driver tag, code gets cleanup much, such as,
> reorder_tags_to_front() is removed, and we needn't to worry
> about request order in dispatch list for avoiding I/O deadlock.
> 
> 'dbench -t 30 -s 64' has been run on different devices(shared tag,
> multi-queue, singele queue, ...), and no issues are observed,
> even very low queue depth test are run, debench still works well.
> 
> Please consider it for V4.15, thanks!

Hi Jens,

As we discussed before, this patch is a good cleanup on handling flush
request, could you share your opinion on V3?

thanks,
Ming
