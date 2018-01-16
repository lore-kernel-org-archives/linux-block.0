Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbeAPBer (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jan 2018 20:34:47 -0500
Date: Mon, 15 Jan 2018 20:34:38 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V4 3/3] blk-mq: issue request directly for
 blk_insert_cloned_request
Message-ID: <20180116013437.GA27125@redhat.com>
References: <20180115165810.2515-1-ming.lei@redhat.com>
 <20180115165810.2515-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180115165810.2515-4-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jan 15 2018 at 11:58am -0500,
Ming Lei <ming.lei@redhat.com> wrote:

> blk_insert_cloned_request() is called in fast path of dm-rq driver, and
> in this function we append request to hctx->dispatch_list of the underlying
> queue directly.
> 
> 1) This way isn't efficient enough because hctx lock is always required
> 
> 2) With blk_insert_cloned_request(), we bypass underlying queue's IO scheduler
> totally, and depend on DM rq driver to do IO schedule completely. But DM
> rq driver can't get underlying queue's dispatch feedback at all, and this
> information is extreamly useful for IO merge. Without that IO merge can't
> be done basically by blk-mq, and causes very bad sequential IO performance.
> 
> This patch makes use of blk_mq_try_issue_directly() to dispatch rq to
> underlying queue and provides disptch result to dm-rq and blk-mq, and
> improves the above situations very much.
> 
> With this patch, seqential IO is improved by 3X in my test over
> mpath/virtio-scsi.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)

Hey Ming,

I also just noticed your V4 of this patch only includes the
block/blk-mq.c changes.

You're missing:

 block/blk-core.c   |  3 +--
 block/blk-mq.h     |  3 +++
 drivers/md/dm-rq.c | 19 +++++++++++++---

Please let Jens know if you're OK with my V4, tagged here:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/tag/?h=for-block-4.16/dm-changes-2
And also detailed in this message from earlier in this thread:
https://marc.info/?l=linux-block&m=151603824725438&w=2

Or please generate V5 of your series.  Hopefully it'd include the header
I revised for this 3/3 patch, see:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=for-block-4.16/dm-changes-2&id=d86beab5712a8f18123011487dee797a1e3a07e1

We also need to address the issues Jens noticed and I looked at a bit
closer: https://marc.info/?l=linux-block&m=151604528127707&w=2
(those issues might need fixing first, and marked for stable@, and the
series rebased ontop of it?)

Thanks!
Mie
