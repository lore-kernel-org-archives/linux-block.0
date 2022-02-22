Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DC2C433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 18:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiBVS2P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbiBVS2P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 13:28:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58BC5EDF0A
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 10:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645554467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8o8ifDV4Wsp9MNzW990jQZJGn8aGjNxzSGrWcKFlJGk=;
        b=iP8WQtFS6Sjt1r9GUSffS/+tSzPvXzbD3bnj1S9D2WJhQpOdOcNeBWcHb82LdTVAvRtPWS
        lksfo7Jq2otO9iySKbQueeVruES6fVVfH0zHch7wsQfVgxmZUjDaP1oPjVRlDhD7Yw/aX8
        t87cv249fABoWKIGFBd72RlEY7Fqj/4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-iZeqdBm-PySpXvIDGLyrcQ-1; Tue, 22 Feb 2022 13:27:46 -0500
X-MC-Unique: iZeqdBm-PySpXvIDGLyrcQ-1
Received: by mail-qk1-f200.google.com with SMTP id r20-20020a37a814000000b00648f4cddf6bso551099qke.5
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 10:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8o8ifDV4Wsp9MNzW990jQZJGn8aGjNxzSGrWcKFlJGk=;
        b=mt36UC2P7BVL1mAq9UUNoXjtdqRoeNsLZe2pl1ZWw1Bg4XSyHLDgs6ioVWM+GnyA4E
         36ZvOY6yTtMb+nIxajiFcrl8l9bfcLCBYwma3n5bmyxnk3DaP4XHZhBk/sufgwL2JLlm
         UoIFrxKsOQOATO9dRCzBASAdnX1poN/MUcf3Vqrh+MKQCUAX2x0Y9nyRco2ar1plCqsE
         QidJuN+z/SZPLsBRiJXgtiFUrzmQZRkhH2BOcHc6prmdthIY61thgp9f+t+w9mv7oazf
         orcEBBlGU47J/8/NyW3VMKgJUipHunak1t4VAdAPihMwNUl9m+3bMvY1f1sVwNzRf2xY
         Tn7Q==
X-Gm-Message-State: AOAM532Ud8qg6im63vhnLMlgquW4yop6vYwme//JQMWEXwrTHeZMJCx2
        Pd+yO2Uzqf4cVdFW8KnQE0FYUzyAYydQ3o3sBOnHlWGAKKkO+7MaAiJidFpRDm0LRMrnJ1BPRoE
        yYcM96uqBDrbNEqF7TrwJow==
X-Received: by 2002:a37:f903:0:b0:648:ca74:b7dc with SMTP id l3-20020a37f903000000b00648ca74b7dcmr8244566qkj.666.1645554465561;
        Tue, 22 Feb 2022 10:27:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJwe2A38a6zFFVbDJ5FVEGv+t77RVoOuoYWwujx17APD/tpCaZ1mdM7EjHGn9xFuEOZjYRuA==
X-Received: by 2002:a37:f903:0:b0:648:ca74:b7dc with SMTP id l3-20020a37f903000000b00648ca74b7dcmr8244554qkj.666.1645554465307;
        Tue, 22 Feb 2022 10:27:45 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id h18sm169800qkl.90.2022.02.22.10.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:27:44 -0800 (PST)
Date:   Tue, 22 Feb 2022 13:27:43 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org, agk@redhat.com,
        axboe@kernel.dk, yukuai3@huawei.com
Subject: Re: dm: make sure dm_table is binded before queue request
Message-ID: <YhUrH7UfBN3Uw5HP@redhat.com>
References: <20220209093751.2986716-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209093751.2986716-1-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 09 2022 at  4:37P -0500,
Zhang Yi <yi.zhang@huawei.com> wrote:

> We found a NULL pointer dereference problem when using dm-mpath target.
> The problem is if we submit IO between loading and binding the table,
> we could neither get a valid dm_target nor a valid dm table when
> submitting request in dm_mq_queue_rq(). BIO based dm target could
> handle this case in dm_submit_bio(). This patch fix this by checking
> the mapping table before submitting request.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  drivers/md/dm-rq.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
> index 579ab6183d4d..af2cf71519e9 100644
> --- a/drivers/md/dm-rq.c
> +++ b/drivers/md/dm-rq.c
> @@ -499,8 +499,15 @@ static blk_status_t dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>  
>  	if (unlikely(!ti)) {
>  		int srcu_idx;
> -		struct dm_table *map = dm_get_live_table(md, &srcu_idx);
> -
> +		struct dm_table *map;
> +
> +		map = dm_get_live_table(md, &srcu_idx);
> +		if (!map) {
> +			DMERR_LIMIT("%s: mapping table unavailable, erroring io",
> +				    dm_device_name(md));
> +			dm_put_live_table(md, srcu_idx);
> +			return BLK_STS_IOERR;
> +		}
>  		ti = dm_table_find_target(map, 0);
>  		dm_put_live_table(md, srcu_idx);
>  	}
> -- 
> 2.31.1
> 

I think both dm_submit_bio() and now dm_mq_queue_rq() should _not_
error the IO.  This is such a narrow race during device setup that it
best to requeue the IO.

I'll queue this for 5.18:

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 6948d5db9092..3dd040a56318 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -491,8 +491,13 @@ static blk_status_t dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	if (unlikely(!ti)) {
 		int srcu_idx;
-		struct dm_table *map = dm_get_live_table(md, &srcu_idx);
+		struct dm_table *map;
 
+		map = dm_get_live_table(md, &srcu_idx);
+		if (unlikely(!map)) {
+			dm_put_live_table(md, srcu_idx);
+			return BLK_STS_RESOURCE;
+		}
 		ti = dm_table_find_target(map, 0);
 		dm_put_live_table(md, srcu_idx);
 	}
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 082366d0ad49..c70be6e5ed55 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1533,15 +1533,10 @@ static void dm_submit_bio(struct bio *bio)
 	struct dm_table *map;
 
 	map = dm_get_live_table(md, &srcu_idx);
-	if (unlikely(!map)) {
-		DMERR_LIMIT("%s: mapping table unavailable, erroring io",
-			    dm_device_name(md));
-		bio_io_error(bio);
-		goto out;
-	}
 
-	/* If suspended, queue this IO for later */
-	if (unlikely(test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags))) {
+	/* If suspended, or map not yet available, queue this IO for later */
+	if (unlikely(test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags)) ||
+	    unlikely(!map)) {
 		if (bio->bi_opf & REQ_NOWAIT)
 			bio_wouldblock_error(bio);
 		else if (bio->bi_opf & REQ_RAHEAD)

