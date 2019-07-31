Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF47C433FF
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 01:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFCF206E0
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 01:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfGaBxy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 21:53:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfGaBxy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 21:53:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 428CE3086268;
        Wed, 31 Jul 2019 01:53:54 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE4101000321;
        Wed, 31 Jul 2019 01:53:46 +0000 (UTC)
Date:   Wed, 31 Jul 2019 09:53:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alexandru Moise <00moses.alexander00@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        syzbot+ff9ab4a23afa7553@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] block: Fix a race condition in submit_bio()
Message-ID: <20190731015340.GB4822@ming.t460p>
References: <20190730181757.248832-1-bvanassche@acm.org>
 <20190730181757.248832-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730181757.248832-3-bvanassche@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 31 Jul 2019 01:53:54 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 30, 2019 at 11:17:57AM -0700, Bart Van Assche wrote:
> generic_make_request_checks() needs to be protected by a
> blk_queue_enter() / blk_queue_exit() pair because it calls
> blkcg_bio_issue_check() and because that last function calls
> blkg_lookup().
> 
> This patch fixes https://syzkaller.appspot.com/bug?id=ff9ab4a23afa7553fb79f745a92be87ba4144508.
> 
> This patch also fixes the following kernel warning, triggered by
> blktests:
> 
> WARNING: CPU: 5 PID: 10706 at block/blk-core.c:903 generic_make_request_checks+0x9c6/0xe60
> RIP: 0010:generic_make_request_checks+0x9c6/0xe60
> Call Trace:
>  generic_make_request+0x7a/0x5c0
>  submit_bio+0x92/0x280
>  mpage_readpages+0x2b1/0x300
>  blkdev_readpages+0x1d/0x20
>  read_pages+0xd9/0x2c0
>  __do_page_cache_readahead+0x2e0/0x310
>  force_page_cache_readahead+0xfb/0x170
>  page_cache_sync_readahead+0x28d/0x2a0
>  generic_file_read_iter+0xc13/0x1530
>  blkdev_read_iter+0x7d/0x90
>  new_sync_read+0x2c5/0x3d0
>  __vfs_read+0x7b/0x90
>  vfs_read+0xc6/0x1f0
>  ksys_read+0xc3/0x160
>  __x64_sys_read+0x43/0x50
>  do_syscall_64+0x71/0x270
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Alexandru Moise <00moses.alexander00@gmail.com>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Reported-by: syzbot+ff9ab4a23afa7553@syzkaller.appspotmail.com
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-core.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ff27c3080348..cd844c54e9f1 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1150,6 +1150,9 @@ EXPORT_SYMBOL_GPL(direct_make_request);
>   */
>  blk_qc_t submit_bio(struct bio *bio)
>  {
> +	struct request_queue *q = bio->bi_disk->queue;
> +	blk_qc_t ret;
> +
>  	if (blkcg_punt_bio_submit(bio))
>  		return BLK_QC_T_NONE;
>  
> @@ -1182,7 +1185,15 @@ blk_qc_t submit_bio(struct bio *bio)
>  		}
>  	}
>  
> -	return generic_make_request(bio);
> +	if (unlikely(blk_queue_enter(q, 0) < 0)) {
> +		bio->bi_status = BLK_STS_IOERR;
> +		bio->bi_end_io(bio);
> +		return BLK_QC_T_NONE;
> +	}
> +	ret = generic_make_request(bio);
> +	blk_queue_exit(q);

No, nested blk_queue_enter() is easy to cause deadlock.

Thanks,
Ming
