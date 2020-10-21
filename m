Return-Path: <SRS0=zsIv=D4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1F0C4363A
	for <linux-block@archiver.kernel.org>; Wed, 21 Oct 2020 20:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B082415A
	for <linux-block@archiver.kernel.org>; Wed, 21 Oct 2020 20:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEMzpHRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439570AbgJUUtO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Oct 2020 16:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405190AbgJUUtO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Oct 2020 16:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603313351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dSmRk6DRbZmfZbz49ECntur/h+o5gaitgTQRU0HzWa8=;
        b=hEMzpHRdEhnF/4pyvBoICQv32YAX2ZObn1KSlT8fTck4nIr5VKNpefPaeLGmy3MthwsOBr
        UEvuPq++VMNmKNRFDSNs3zl7rGchxczXl3uez8qAFbK8Wh/bmDrxU3lk6lSdudE8C8fb72
        lSRHiHv3f28SFY82RLEbREQZP8bjkvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-rzU7wPlRNAyPKN19amlFKg-1; Wed, 21 Oct 2020 16:49:07 -0400
X-MC-Unique: rzU7wPlRNAyPKN19amlFKg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C99BA5F9C9;
        Wed, 21 Oct 2020 20:49:05 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D39919C4F;
        Wed, 21 Oct 2020 20:49:02 +0000 (UTC)
Date:   Wed, 21 Oct 2020 16:49:01 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, dm-devel@redhat.com,
        joseph.qi@linux.alibaba.com, xiaoguang.wang@linux.alibaba.com,
        haoxu@linux.alibaba.com
Subject: Re: [RFC 3/3] dm: add support for IO polling
Message-ID: <20201021204901.GB10896@redhat.com>
References: <20201020065420.124885-1-jefflexu@linux.alibaba.com>
 <20201020065420.124885-4-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020065420.124885-4-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 20 2020 at  2:54am -0400,
Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

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

You really want to implement the !dm_table_supports_poll case too on the
off chance that a DM table reload swaps in a new mapping that doesn't
support polling (be it the error target or whatever).


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
> +
> +		percpu_ref_put(&q->q_usage_counter);
> +		return ret;
> +	} else
> +		return q->poll_fn(q, cookie);
> +}
> +
> +int dm_io_poll(struct request_queue *q, blk_qc_t cookie)
> +{
> +	struct mapped_device *md = q->queuedata;
> +	struct dm_table *table;
> +	struct dm_dev_internal *dd;
> +	int srcu_idx;
> +	int ret = 0;
> +
> +	table = dm_get_live_table(md, &srcu_idx);
> +	if (!table)
> +		goto out;
> +
> +	list_for_each_entry(dd, dm_table_get_devices(table), list)
> +		ret += dm_poll_one_dev(bdev_get_queue(dd->dm_dev->bdev), cookie);

Definitely need to use ti->type->iterate_devices because otherwise you
could be iterating over non-data devices that have no business being
polled.  Ideally you could use the cookie to find the unique bio in
question to quickly lookup the associated DM target to use
ti->type->iterate_devices

But short of having useful cookies, you should iterate through all
targets in the table and call ti->type->iterate_devices

Mike

