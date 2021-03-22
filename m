Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52248C433E1
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 11:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F5BC6199E
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 11:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhCVLXD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:23:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:34716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhCVLW5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 07:22:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1504AADE3;
        Mon, 22 Mar 2021 11:22:56 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <84378224-df30-8205-ebc3-45daf7a173d5@suse.de>
Date:   Mon, 22 Mar 2021 12:22:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210322073726.788347-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/21 8:37 AM, Christoph Hellwig wrote:
> When we reset/teardown a controller, we must freeze and quiesce the
> namespaces request queues to make sure that we safely stop inflight I/O
> submissions. Freeze is mandatory because if our hctx map changed between
> reconnects, blk_mq_update_nr_hw_queues will immediately attempt to freeze
> the queue, and if it still has pending submissions (that are still
> quiesced) it will hang.
> 
> However, by freezing the namespaces request queues, and only unfreezing
> them when we successfully reconnect, inflight submissions that are
> running concurrently can now block grabbing the nshead srcu until either
> we successfully reconnect or ctrl_loss_tmo expired (or the user
> explicitly disconnected).
> 
> This caused a deadlock when a different controller (different path on the
> same subsystem) became live (i.e. optimized/non-optimized). This is
> because nvme_mpath_set_live needs to synchronize the nshead srcu before
> requeueing I/O in order to make sure that current_path is visible to
> future (re-)submisions. However the srcu lock is taken by a blocked
> submission on a frozen request queue, and we have a deadlock.
> 
> In order to fix this use the blk_mq_submit_bio_direct API to submit the
> bio to the low-level driver, which does not block on the queue free
> but instead allows nvme-multipath to pick another path or queue up the
> bio.
> 
> Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
> Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")
> 
> Reported-by Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/multipath.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index a1d476e1ac020f..92adebfaf86fd1 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -309,6 +309,7 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
>  	 */
>  	blk_queue_split(&bio);
>  
> +retry:
>  	srcu_idx = srcu_read_lock(&head->srcu);
>  	ns = nvme_find_path(head);
>  	if (likely(ns)) {
> @@ -316,7 +317,12 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
>  		bio->bi_opf |= REQ_NVME_MPATH;
>  		trace_block_bio_remap(bio, disk_devt(ns->head->disk),
>  				      bio->bi_iter.bi_sector);
> -		ret = submit_bio_noacct(bio);
> +
> +		if (!blk_mq_submit_bio_direct(bio, &ret)) {
> +			nvme_mpath_clear_current_path(ns);
> +			srcu_read_unlock(&head->srcu, srcu_idx);
> +			goto retry;
> +		}
>  	} else if (nvme_available_path(head)) {
>  		dev_warn_ratelimited(dev, "no usable path - requeuing I/O\n");
>  
> 
Ah. We've run into the same issue, and I've come up with basically the
same patch to have it fixed.
Tests are still outstanding, so I haven't been able to validate it properly.
Thanks for fixing it up.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
