Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01D8C7EE37
	for <linux-block@archiver.kernel.org>; Fri,  9 Jun 2023 20:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjFIUBI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Jun 2023 16:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjFIUBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Jun 2023 16:01:06 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5683598
        for <linux-block@vger.kernel.org>; Fri,  9 Jun 2023 13:00:27 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-3f9b2b7109dso16496361cf.0
        for <linux-block@vger.kernel.org>; Fri, 09 Jun 2023 13:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686340826; x=1688932826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFxNC6AwIefC8h+OVa9YMEjCXThkDxxKP8p9zX4LNFY=;
        b=ZUIbH4SLqtq+ljGBGTJtzLKAQOdTNJnCCwJfJF1MQsBTjTMzHWS4oeWTZH8B9pn6cN
         ufgiycdGLgskp/iLT+FrX3jaKS9C8s+yCYmqT8Ms47DQoCHOkrAIJ6wvUa/LRR2itb78
         8w3GuEoHIwZt3pDu+RjHZmmSnIZEorM295jx40WL/UMC7EiKVMCNkyucfx6mN8UQyr/+
         E9dcEHimXW+XBjjQUs5va3QA5l6rNz8feg8CXvKXqXeLGs8NWVBXuGALDpw113Z9kOtR
         LQCu+ZPxDKWjP/OJFzOMzUAyIrBrUUQavA0QqQZ2sgzw0xqmaa6Bv3J/N3zAoIsQSeRt
         ZdkA==
X-Gm-Message-State: AC+VfDzwGUO4hWfRinPBzOP3/YdCBTTpNunDDAstxR3pt8QZWoKNaaiE
        CSgLKXkzXVkLbOQxu10Kaitn
X-Google-Smtp-Source: ACHHUZ6f5D0na1vDQSbLNkOIR7VVTt7ADDPvJzshNMQToGx2m/jPA4IIyjKZFD+hGnfTs+abIWzkWA==
X-Received: by 2002:ac8:7e88:0:b0:3f8:6c15:c3a5 with SMTP id w8-20020ac87e88000000b003f86c15c3a5mr3039832qtj.33.1686340826214;
        Fri, 09 Jun 2023 13:00:26 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id d3-20020ac85343000000b003f740336bb9sm1418338qto.9.2023.06.09.13.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:00:25 -0700 (PDT)
Date:   Fri, 9 Jun 2023 16:00:24 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v7 2/5] block: Introduce provisioning primitives
Message-ID: <ZIOE2ASeUAXxzpRO@redhat.com>
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
 <20230518223326.18744-3-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518223326.18744-3-sarthakkukreti@chromium.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 18 2023 at  6:33P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> Introduce block request REQ_OP_PROVISION. The intent of this request
> is to request underlying storage to preallocate disk space for the given
> block range. Block devices that support this capability will export
> a provision limit within their request queues.
> 
> This patch also adds the capability to call fallocate() in mode 0
> on block devices, which will send REQ_OP_PROVISION to the block
> device for the specified range,
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
...
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 896b4654ab00..d303e6614c36 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -59,6 +59,7 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->zoned = BLK_ZONED_NONE;
>  	lim->zone_write_granularity = 0;
>  	lim->dma_alignment = 511;
> +	lim->max_provision_sectors = 0;
>  }
>  
>  /**
> @@ -82,6 +83,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
>  	lim->max_dev_sectors = UINT_MAX;
>  	lim->max_write_zeroes_sectors = UINT_MAX;
>  	lim->max_zone_append_sectors = UINT_MAX;
> +	lim->max_provision_sectors = UINT_MAX;
>  }
>  EXPORT_SYMBOL(blk_set_stacking_limits);
>  
> @@ -578,6 +594,9 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>  	t->max_segment_size = min_not_zero(t->max_segment_size,
>  					   b->max_segment_size);
>  
> +	t->max_provision_sectors = min_not_zero(t->max_provision_sectors,
> +						b->max_provision_sectors);
> +

This needs to use min() since max_provision_sectors also serves to
indicate if the device supports REQ_OP_PROVISION.  Otherwise, if I set
max_provision_sectors to 0 on a dm thin-pool the blk_stack_limits()
will ignore my having set it to 0 (to disable) and it'll remain as
UINT_MAX (thanks to blk_set_default_limits).

Mike
