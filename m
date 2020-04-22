Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E74CC55189
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 09:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7019220735
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 09:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgDVJHx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:07:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:57664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgDVJHw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 05:07:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7086FAEED;
        Wed, 22 Apr 2020 09:07:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6DCF91E125C; Wed, 22 Apr 2020 11:07:46 +0200 (CEST)
Date:   Wed, 22 Apr 2020 11:07:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] bdi: use bdi_dev_name() to get device name
Message-ID: <20200422090746.GD8775@quack2.suse.cz>
References: <20200422073851.303714-1-hch@lst.de>
 <20200422073851.303714-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422073851.303714-4-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 22-04-20 09:38:45, Christoph Hellwig wrote:
> From: Yufen Yu <yuyufen@huawei.com>
> 
> Use the common interface bdi_dev_name() to get device name.
> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c        | 5 +++--
>  block/blk-cgroup.c         | 2 +-
>  fs/ceph/debugfs.c          | 2 +-
>  include/trace/events/wbt.h | 8 ++++----
>  4 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 78ba57efd16b..4d4fe44a9eea 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4976,8 +4976,9 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
>  	ioprio_class = IOPRIO_PRIO_CLASS(bic->ioprio);
>  	switch (ioprio_class) {
>  	default:
> -		dev_err(bfqq->bfqd->queue->backing_dev_info->dev,
> -			"bfq: bad prio class %d\n", ioprio_class);
> +		pr_err("bdi %s: bfq: bad prio class %d\n",
> +				bdi_dev_name(bfqq->bfqd->queue->backing_dev_info),
> +				ioprio_class);
>  		/* fall through */
>  	case IOPRIO_CLASS_NONE:
>  		/*
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index c5dc833212e1..930212c1a512 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -496,7 +496,7 @@ const char *blkg_dev_name(struct blkcg_gq *blkg)
>  {
>  	/* some drivers (floppy) instantiate a queue w/o disk registered */
>  	if (blkg->q->backing_dev_info->dev)
> -		return dev_name(blkg->q->backing_dev_info->dev);
> +		return bdi_dev_name(blkg->q->backing_dev_info);
>  	return NULL;
>  }
>  
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index 481ac97b4d25..dcaed75de9e6 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -271,7 +271,7 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
>  				    &congestion_kb_fops);
>  
>  	snprintf(name, sizeof(name), "../../bdi/%s",
> -		 dev_name(fsc->sb->s_bdi->dev));
> +		 bdi_dev_name(fsc->sb->s_bdi));
>  	fsc->debugfs_bdi =
>  		debugfs_create_symlink("bdi",
>  				       fsc->client->debugfs_dir,
> diff --git a/include/trace/events/wbt.h b/include/trace/events/wbt.h
> index 784814160197..9c66e59d859c 100644
> --- a/include/trace/events/wbt.h
> +++ b/include/trace/events/wbt.h
> @@ -33,7 +33,7 @@ TRACE_EVENT(wbt_stat,
>  	),
>  
>  	TP_fast_assign(
> -		strlcpy(__entry->name, dev_name(bdi->dev),
> +		strlcpy(__entry->name, bdi_dev_name(bdi),
>  			ARRAY_SIZE(__entry->name));
>  		__entry->rmean		= stat[0].mean;
>  		__entry->rmin		= stat[0].min;
> @@ -68,7 +68,7 @@ TRACE_EVENT(wbt_lat,
>  	),
>  
>  	TP_fast_assign(
> -		strlcpy(__entry->name, dev_name(bdi->dev),
> +		strlcpy(__entry->name, bdi_dev_name(bdi),
>  			ARRAY_SIZE(__entry->name));
>  		__entry->lat = div_u64(lat, 1000);
>  	),
> @@ -105,7 +105,7 @@ TRACE_EVENT(wbt_step,
>  	),
>  
>  	TP_fast_assign(
> -		strlcpy(__entry->name, dev_name(bdi->dev),
> +		strlcpy(__entry->name, bdi_dev_name(bdi),
>  			ARRAY_SIZE(__entry->name));
>  		__entry->msg	= msg;
>  		__entry->step	= step;
> @@ -141,7 +141,7 @@ TRACE_EVENT(wbt_timer,
>  	),
>  
>  	TP_fast_assign(
> -		strlcpy(__entry->name, dev_name(bdi->dev),
> +		strlcpy(__entry->name, bdi_dev_name(bdi),
>  			ARRAY_SIZE(__entry->name));
>  		__entry->status		= status;
>  		__entry->step		= step;
> -- 
> 2.26.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
