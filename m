Return-Path: <SRS0=SOzO=D5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85449C388F7
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 03:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264E82063A
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 03:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTvLNpZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895313AbgJVDPA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Oct 2020 23:15:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2895318AbgJVDPA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Oct 2020 23:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603336498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=umsnH84+PDM7ZGwyi7HysBs+SYUuznU2DNOaV+tgCl8=;
        b=GTvLNpZdIswR4XSY+/auDhqOSWH1J7ABTNxQAVGE7EEqkvFm5iUkdH+fNuQ6+/63s2iPYt
        YXI/z5HRUcx0OQpmua59xo+s6xxdl08VLCRS1ySAnpbjNOQ5zBn/PkKp36GW4k5GU5POJt
        uF2bkpmJK8KvoGAFk7ZIEpU64pIpmxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-GbB2fAm_PySjIaqP4Ud-_A-1; Wed, 21 Oct 2020 23:14:56 -0400
X-MC-Unique: GbB2fAm_PySjIaqP4Ud-_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5279D1084D69;
        Thu, 22 Oct 2020 03:14:55 +0000 (UTC)
Received: from T590 (ovpn-12-46.pek2.redhat.com [10.72.12.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A019A19728;
        Thu, 22 Oct 2020 03:14:38 +0000 (UTC)
Date:   Thu, 22 Oct 2020 11:14:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     snitzer@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        dm-devel@redhat.com, joseph.qi@linux.alibaba.com,
        xiaoguang.wang@linux.alibaba.com, haoxu@linux.alibaba.com
Subject: Re: [RFC 3/3] dm: add support for IO polling
Message-ID: <20201022031434.GA1643586@T590>
References: <20201020065420.124885-1-jefflexu@linux.alibaba.com>
 <20201020065420.124885-4-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020065420.124885-4-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 20, 2020 at 02:54:20PM +0800, Jeffle Xu wrote:
> Design of cookie is initially constrained as a per-bio concept. It
> dosn't work well when bio-split needed, and it is really an issue when
> adding support of iopoll for dm devices.
> 
> The current algorithm implementation is simple. The returned cookie of
> dm device is actually not used since it is just the cookie of one of
> the cloned bios. Polling of dm device is actually polling on all
> hardware queues (in poll mode) of all underlying target devices.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  drivers/md/dm-core.h  |  1 +
>  drivers/md/dm-table.c | 30 ++++++++++++++++++++++++++++++
>  drivers/md/dm.c       | 39 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 70 insertions(+)
> 
> diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> index d522093cb39d..f18e066beffe 100644
> --- a/drivers/md/dm-core.h
> +++ b/drivers/md/dm-core.h
> @@ -187,4 +187,5 @@ extern atomic_t dm_global_event_nr;
>  extern wait_queue_head_t dm_global_eventq;
>  void dm_issue_global_event(void);
>  
> +int dm_io_poll(struct request_queue *q, blk_qc_t cookie);
>  #endif
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index ce543b761be7..634b79842519 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1809,6 +1809,31 @@ static bool dm_table_requires_stable_pages(struct dm_table *t)
>  	return false;
>  }
>  
> +static int device_not_support_poll(struct dm_target *ti, struct dm_dev *dev,
> +					   sector_t start, sector_t len, void *data)
> +{
> +	struct request_queue *q = bdev_get_queue(dev->bdev);
> +
> +	return q && !(q->queue_flags & QUEUE_FLAG_POLL);
> +}
> +
> +bool dm_table_supports_poll(struct dm_table *t)
> +{
> +	struct dm_target *ti;
> +	unsigned int i;
> +
> +	/* Ensure that all targets support DAX. */
> +	for (i = 0; i < dm_table_get_num_targets(t); i++) {
> +		ti = dm_table_get_target(t, i);
> +
> +		if (!ti->type->iterate_devices ||
> +		    ti->type->iterate_devices(ti, device_not_support_poll, NULL))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>  			       struct queue_limits *limits)
>  {
> @@ -1901,6 +1926,11 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>  #endif
>  
>  	blk_queue_update_readahead(q);
> +
> +	if (dm_table_supports_poll(t)) {
> +		q->poll_fn = dm_io_poll;
> +		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
> +	}
>  }
>  
>  unsigned int dm_table_get_num_targets(struct dm_table *t)
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index c18fc2548518..4eceaf87ffd4 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1666,6 +1666,45 @@ static blk_qc_t dm_submit_bio(struct bio *bio)
>  	return ret;
>  }
>  
> +static int dm_poll_one_dev(struct request_queue *q, blk_qc_t cookie)
> +{
> +	/* Iterate polling on all polling queues for mq device */
> +	if (queue_is_mq(q)) {
> +		struct blk_mq_hw_ctx *hctx;
> +		int i, ret = 0;
> +
> +		if (!percpu_ref_tryget(&q->q_usage_counter))
> +			return 0;
> +
> +		queue_for_each_poll_hw_ctx(q, hctx, i) {
> +			ret += q->mq_ops->poll(hctx);
> +		}

IMO, this way may not be accepted from performance viewpoint, .poll()
often requires per-hw-queue lock. So in case of > 1 io thread,
contention/cache ping-pong on hw queue resource can be very serious.

I guess you may have to find one way to pass correct cookie to ->poll().


Thanks,
Ming

