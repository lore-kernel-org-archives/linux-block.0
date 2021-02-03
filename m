Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB88C433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 16:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC9A64FA4
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 16:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhBCQLv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 11:11:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234974AbhBCQLd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Feb 2021 11:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612368607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Md5deGFTlNwWnMdHSwnNKkej1rIsSFXY3oqRw/3YWT0=;
        b=X6gbIKBafEZd8jRT/mWB4eOU98QBFCFx54FN327P2WNz972oF3SSuwWM3xNB7Gg2MZd+gm
        d9x30K+C3Gk1jILIhLRpAPtb9XInCIWa+lcknirLejAFHVgOFdLd22pEmzWJuXh+Dm/A9j
        /dWqJUUk+uMpkxhi+F9eSA8MRDS/xf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-Cw8jCwDsPEmEHOoAb7OFcw-1; Wed, 03 Feb 2021 11:10:05 -0500
X-MC-Unique: Cw8jCwDsPEmEHOoAb7OFcw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07BEE6D4E0;
        Wed,  3 Feb 2021 16:10:03 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AF005FC3A;
        Wed,  3 Feb 2021 16:09:56 +0000 (UTC)
Date:   Wed, 3 Feb 2021 11:09:55 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Damien.LeMoal@wdc.com, hare@suse.de, ming.lei@redhat.com,
        agk@redhat.com, corbet@lwn.net, axboe@kernel.dk, jack@suse.cz,
        johannes.thumshirn@wdc.com, gregkh@linuxfoundation.org,
        koct9i@gmail.com, steve@sk2.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavgel.tide@veeam.com
Subject: Re: [PATCH v4 3/6] block: add blk_mq_is_queue_frozen()
Message-ID: <20210203160955.GA21359@redhat.com>
References: <1612367638-3794-1-git-send-email-sergei.shtepa@veeam.com>
 <1612367638-3794-4-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612367638-3794-4-git-send-email-sergei.shtepa@veeam.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 03 2021 at 10:53am -0500,
Sergei Shtepa <sergei.shtepa@veeam.com> wrote:

> blk_mq_is_queue_frozen() allow to assert that the queue is frozen.
> 
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> ---
>  block/blk-mq.c         | 13 +++++++++++++
>  include/linux/blk-mq.h |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f285a9123a8b..924ec26fae5f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -161,6 +161,19 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);
>  
> +
> +bool blk_mq_is_queue_frozen(struct request_queue *q)
> +{
> +	bool ret;
> +
> +	mutex_lock(&q->mq_freeze_lock);
> +	ret = percpu_ref_is_dying(&q->q_usage_counter) && percpu_ref_is_zero(&q->q_usage_counter);
> +	mutex_unlock(&q->mq_freeze_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_is_queue_frozen);
> +
>  /*
>   * Guarantee no request is in use, so we can change any data structure of
>   * the queue afterward.
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index d705b174d346..9d1e8c4e922e 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -525,6 +525,7 @@ void blk_freeze_queue_start(struct request_queue *q);
>  void blk_mq_freeze_queue_wait(struct request_queue *q);
>  int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
>  				     unsigned long timeout);
> +bool blk_mq_is_queue_frozen(struct request_queue *q);
>  
>  int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
>  void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
> -- 
> 2.20.1
> 

This needs to come before patch 2 (since patch 2 uses it).

Mike

