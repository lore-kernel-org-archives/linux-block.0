Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751748AbdIVAgi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 20:36:38 -0400
Date: Fri, 22 Sep 2017 08:36:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH V2 0/7] blk-mq: don't allocate driver tag beforehand for
 flush rq
Message-ID: <20170922003619.GK6854@ming.t460p>
References: <20170916030351.28019-1-ming.lei@redhat.com>
 <20170916030351.28019-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170916030351.28019-2-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Sep 16, 2017 at 11:03:44AM +0800, Ming Lei wrote:
> Hi,
> 
> This patchset avoids to allocate driver tag beforehand for flush rq
> in case of I/O scheduler, then flush rq isn't treated specially
> wrt. get/put driver tag, code gets cleanup much, such as,
> reorder_tags_to_front() is removed, and we needn't to worry
> about request order in dispatch list for avoiding I/O deadlock.
> 
> 'dbench -t 30 -s -F 64' has been run on different devices(shared tag,
> multi-queue, singele queue, ...), and no issues are observed,
> even very low queue depth(1) test are run, debench still works
> well.
> 
> Any comments are welcome!
> 
> V2:
> 	- release driver tag before requeue
> 	- warning on inserting a req with driver tag

Hi Jens,

Did V2 pass your test?

If yes and you are fine with this patchset, could you
move on and make it land in your for-next?

-- 
Ming
