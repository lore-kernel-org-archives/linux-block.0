Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE82C4161D
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36959206BA
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36959206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeKUDvw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:51:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbeKUDvw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 22:51:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03CC83084258;
        Tue, 20 Nov 2018 17:21:38 +0000 (UTC)
Received: from ming.t460p (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B164B608E1;
        Tue, 20 Nov 2018 17:21:31 +0000 (UTC)
Date:   Wed, 21 Nov 2018 01:21:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/7] block: Remove bio->bi_ioc
Message-ID: <20181120172126.GA28169@ming.t460p>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
 <20181119035131.11255-3-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119035131.11255-3-damien.lemoal@wdc.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 20 Nov 2018 17:21:38 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 19, 2018 at 12:51:26PM +0900, Damien Le Moal wrote:
> bio->bi_ioc is never set so always NULL. Remove references to it in
> bio_disassociate_task() and in rq_ioc() and delete this field from
> struct bio. With this change, rq_ioc() always returns
> current->io_context without the need for a bio argument. Further
> simplify the code and make it more readable by also removing this
> helper, which also allows to simplify blk_mq_sched_assign_ioc() by
> removing its bio argument.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  block/bio.c               |  4 ----
>  block/blk-core.c          |  2 +-
>  block/blk-mq-sched.c      |  4 ++--
>  block/blk-mq-sched.h      |  2 +-
>  block/blk-mq.c            |  4 ++--
>  block/blk.h               | 16 ----------------
>  include/linux/blk_types.h |  3 +--
>  7 files changed, 7 insertions(+), 28 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 4f4d9884443b..03895cc0d74a 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -2027,10 +2027,6 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
>   */
>  void bio_disassociate_task(struct bio *bio)
>  {
> -	if (bio->bi_ioc) {
> -		put_io_context(bio->bi_ioc);
> -		bio->bi_ioc = NULL;
> -	}
>  	if (bio->bi_css) {
>  		css_put(bio->bi_css);
>  		bio->bi_css = NULL;
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d6e8ab9ca99d..492648c96992 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -813,7 +813,7 @@ unsigned int blk_plug_queued_count(struct request_queue *q)
>  
>  void blk_init_request_from_bio(struct request *req, struct bio *bio)
>  {
> -	struct io_context *ioc = rq_ioc(bio);
> +	struct io_context *ioc = current->io_context;
>  
>  	if (bio->bi_opf & REQ_RAHEAD)
>  		req->cmd_flags |= REQ_FAILFAST_MASK;
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index d084f731d104..13b8dc332541 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -31,10 +31,10 @@ void blk_mq_sched_free_hctx_data(struct request_queue *q,
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_sched_free_hctx_data);
>  
> -void blk_mq_sched_assign_ioc(struct request *rq, struct bio *bio)
> +void blk_mq_sched_assign_ioc(struct request *rq)
>  {
>  	struct request_queue *q = rq->q;
> -	struct io_context *ioc = rq_ioc(bio);
> +	struct io_context *ioc = current->io_context;
>  	struct io_cq *icq;
>  
>  	spin_lock_irq(&q->queue_lock);
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index 7ff5671bf128..0f719c8532ae 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -8,7 +8,7 @@
>  void blk_mq_sched_free_hctx_data(struct request_queue *q,
>  				 void (*exit)(struct blk_mq_hw_ctx *));
>  
> -void blk_mq_sched_assign_ioc(struct request *rq, struct bio *bio);
> +void blk_mq_sched_assign_ioc(struct request *rq);
>  
>  void blk_mq_sched_request_inserted(struct request *rq);
>  bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 32b246ed44c0..636f80b96fa6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -389,8 +389,8 @@ static struct request *blk_mq_get_request(struct request_queue *q,
>  	if (!op_is_flush(data->cmd_flags)) {
>  		rq->elv.icq = NULL;
>  		if (e && e->type->ops.prepare_request) {
> -			if (e->type->icq_cache && rq_ioc(bio))
> -				blk_mq_sched_assign_ioc(rq, bio);
> +			if (e->type->icq_cache)
> +				blk_mq_sched_assign_ioc(rq);
>  
>  			e->type->ops.prepare_request(rq, bio);
>  			rq->rq_flags |= RQF_ELVPRIV;
> diff --git a/block/blk.h b/block/blk.h
> index 816a9abb87cd..610948157a5b 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -254,22 +254,6 @@ void ioc_clear_queue(struct request_queue *q);
>  
>  int create_task_io_context(struct task_struct *task, gfp_t gfp_mask, int node);
>  
> -/**
> - * rq_ioc - determine io_context for request allocation
> - * @bio: request being allocated is for this bio (can be %NULL)
> - *
> - * Determine io_context to use for request allocation for @bio.  May return
> - * %NULL if %current->io_context doesn't exist.
> - */
> -static inline struct io_context *rq_ioc(struct bio *bio)
> -{
> -#ifdef CONFIG_BLK_CGROUP
> -	if (bio && bio->bi_ioc)
> -		return bio->bi_ioc;
> -#endif
> -	return current->io_context;
> -}
> -
>  /**
>   * create_io_context - try to create task->io_context
>   * @gfp_mask: allocation mask
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index dbdbfbd6a987..c0ba1a038ff3 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -174,10 +174,9 @@ struct bio {
>  	void			*bi_private;
>  #ifdef CONFIG_BLK_CGROUP
>  	/*
> -	 * Optional ioc and css associated with this bio.  Put on bio
> +	 * Optional css associated with this bio.  Put on bio
>  	 * release.  Read comment on top of bio_associate_current().
>  	 */
> -	struct io_context	*bi_ioc;
>  	struct cgroup_subsys_state *bi_css;
>  	struct blkcg_gq		*bi_blkg;
>  	struct bio_issue	bi_issue;

Hi,

Just found the following kernel oops, seems it is likely related with this
patch.

[  391.981012] BUG: unable to handle kernel NULL pointer dereference at 0000000000000038
[  391.982506] PGD 0 P4D 0
[  391.982975] Oops: 0000 [#1] PREEMPT SMP PTI
[  391.983769] CPU: 1 PID: 1790 Comm: scsi_id Not tainted 4.20.0-rc3_72abead3bf43_for-4.21-block-mp-bvec-V11+ #1
[  391.985563] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-2.fc27 04/01/2014
[  391.987107] RIP: 0010:ioc_lookup_icq+0x13/0x54
[  391.987936] Code: f6 48 8b 3d 1c 78 5b 01 5b 5d 41 5c 41 5d 41 5e 41 5f e9 68 bd eb ff 0f 1f 44 00 00 55 53 48 89 fb 51 48 89 f5 e8 e3 82 da ff <48> 8b 43 38 48 85 c0 74 05 48 39 28 74 22 48 63 b5 8c 00 00 00 48
[  391.991318] RSP: 0018:ffffc90001467bb0 EFLAGS: 00010002
[  391.992292] RAX: ffff888266c85ac0 RBX: 0000000000000000 RCX: 0000000000000100
[  391.993615] RDX: 0000000000000001 RSI: ffff88826601f230 RDI: 0000000000000000
[  391.994917] RBP: ffff88826601f230 R08: 00000000f461df07 R09: 0000000000000006
[  391.996242] R10: ffffc90001467b10 R11: 0000000000000020 R12: ffff888269df4000
[  391.997572] R13: 0000000000000000 R14: ffff88826601f2c4 R15: 0000000000000001
[  391.998905] FS:  00007fa6923b7940(0000) GS:ffff888277a80000(0000) knlGS:0000000000000000
[  392.000389] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  392.001468] CR2: 0000000000000038 CR3: 0000000106dd8005 CR4: 0000000000760ee0
[  392.002783] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  392.004108] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  392.005394] PKRU: 55555554
[  392.005897] Call Trace:
[  392.006384]  blk_mq_sched_assign_ioc+0x3d/0x7f
[  392.007216]  blk_mq_get_request+0x321/0x354
[  392.008008]  blk_mq_alloc_request+0x4e/0xbf
[  392.008802]  blk_get_request+0x24/0x4c
[  392.009518]  sg_io+0x93/0x371
[  392.010074]  ? bd_acquire+0xa6/0xa6
[  392.010707]  ? dput+0x29/0xfd
[  392.011232]  ? mntput_no_expire+0x11/0x185
[  392.011987]  scsi_cmd_ioctl+0x1d3/0x386
[  392.012707]  sd_ioctl+0xbb/0xde [sd_mod]
[  392.013449]  blkdev_ioctl+0x893/0x8bf
[  392.014132]  block_ioctl+0x3c/0x3f
[  392.014781]  vfs_ioctl+0x1e/0x2b
[  392.015378]  do_vfs_ioctl+0x531/0x559
[  392.016059]  ksys_ioctl+0x3e/0x5d
[  392.016681]  __x64_sys_ioctl+0x16/0x19
[  392.017361]  do_syscall_64+0x84/0x13f
[  392.018060]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  392.018995] RIP: 0033:0x7fa691edf267
[  392.019663] Code: b3 66 90 48 8b 05 19 3c 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 3b 2c 00 f7 d8 64 89 01 48
[  392.023072] RSP: 002b:00007ffe463e8de8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  392.024457] RAX: ffffffffffffffda RBX: 00007ffe463e8e20 RCX: 00007fa691edf267
[  392.025767] RDX: 00007ffe463e8e20 RSI: 0000000000002285 RDI: 0000000000000004
[  392.027068] RBP: 00007ffe463e9470 R08: 0000000000002006 R09: 00000000fffffe00
[  392.028413] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe463e9920
[  392.029722] R13: 00007ffe463e8e20 R14: 00007ffe463e8e2a R15: 00007ffe463e9920
[  392.031031] Modules linked in: scsi_debug null_blk isofs iTCO_wdt iTCO_vendor_support i2c_i801 i2c_core lpc_ich mfd_core ip_tables sr_mod cdrom usb_storage sd_mod ahci libahci libata crc32c_intel virtio_scsi qemu_fw_cfg dm_mirror dm_region_hash dm_log dm_mod [last unloaded: null_blk]
[  392.035573] Dumping ftrace buffer:
[  392.036203]    (ftrace buffer empty)
[  392.036871] CR2: 0000000000000038
[  392.037503] ---[ end trace fa20a1088b068790 ]---

Thanks,
Ming
