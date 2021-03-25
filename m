Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37821C433DB
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 18:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFDEF61A3E
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 18:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhCYSpp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 14:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229670AbhCYSpa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 14:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616697930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bCAqCNGzNfOldSFqoi8GAW6s9xnIg83pgEh6OZd8lLQ=;
        b=g+kib3LmxJhHrcahmdKz7TQrbgAnfo3UHrYY0RdZ1zXaODuL0qOf3ht8V9FBXIGY0YLhLj
        yYJVfc5ERt0kMeZJCn+WzfdRz6WySnatSqAwqrhDe6SadtofOIK9Xt6CQrPKxjbHdEobKQ
        UBZyUZwtG8p6YJcNLUEzng5WjQpotw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-PampCmZ-Mfmso2j8u-3JDg-1; Thu, 25 Mar 2021 14:45:26 -0400
X-MC-Unique: PampCmZ-Mfmso2j8u-3JDg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3967E1007467;
        Thu, 25 Mar 2021 18:45:25 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7506E77520;
        Thu, 25 Mar 2021 18:45:19 +0000 (UTC)
Date:   Thu, 25 Mar 2021 14:45:19 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com
Subject: Re: [PATCH V3 13/13] dm: support IO polling for bio-based dm device
Message-ID: <20210325184519.GB17820@redhat.com>
References: <20210324121927.362525-1-ming.lei@redhat.com>
 <20210324121927.362525-14-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324121927.362525-14-ming.lei@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 24 2021 at  8:19am -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> From: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> IO polling is enabled when all underlying target devices are capable
> of IO polling. The sanity check supports the stacked device model, in
> which one dm device may be build upon another dm device. In this case,
> the mapped device will check if the underlying dm target device
> supports IO polling.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/md/dm-table.c         | 24 ++++++++++++++++++++++++
>  drivers/md/dm.c               | 14 ++++++++++++++
>  include/linux/device-mapper.h |  1 +
>  3 files changed, 39 insertions(+)
> 

...

> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 50b693d776d6..fe6893b078dc 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1720,6 +1720,19 @@ static blk_qc_t dm_submit_bio(struct bio *bio)
>  	return ret;
>  }
>  
> +static bool dm_bio_poll_capable(struct gendisk *disk)
> +{
> +	int ret, srcu_idx;
> +	struct mapped_device *md = disk->private_data;
> +	struct dm_table *t;
> +
> +	t = dm_get_live_table(md, &srcu_idx);
> +	ret = dm_table_supports_poll(t);
> +	dm_put_live_table(md, srcu_idx);
> +
> +	return ret;
> +}
> +

I know this code will only get called by blk-core if bio-based but there
isn't anything about this method's implementation that is inherently
bio-based only.

So please rename from dm_bio_poll_capable to dm_poll_capable

Other than that:

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

>  /*-----------------------------------------------------------------
>   * An IDR is used to keep track of allocated minor numbers.
>   *---------------------------------------------------------------*/
> @@ -3132,6 +3145,7 @@ static const struct pr_ops dm_pr_ops = {
>  };
>  
>  static const struct block_device_operations dm_blk_dops = {
> +	.poll_capable = dm_bio_poll_capable,
>  	.submit_bio = dm_submit_bio,
>  	.open = dm_blk_open,
>  	.release = dm_blk_close,

