Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E9EC433FE
	for <linux-block@archiver.kernel.org>; Fri, 11 Nov 2022 18:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiKKSIG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Nov 2022 13:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiKKSIG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Nov 2022 13:08:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C4FEA1
        for <linux-block@vger.kernel.org>; Fri, 11 Nov 2022 10:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668190029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=80TYJDe6hNYBM09PGXA70+IGuQTIUVRClbkoMTJ8nZQ=;
        b=hJq0Lp8EvjXhJnK/8NFyiDRvKRtxRhdm0lcatstdOmx6ZHH0FrVJg1LkByZQ4Jv+OsSids
        jgMCma2vq/3VTKYFa71rNHuZXcWqrtTfVQ5ATPV9ovtxg81Ntqd+Wnk0QI/TspjRacWVCp
        MR85pUqlIXfTx+jjq8mvT24NxNYjwyg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-610-9UJtExzINQqk_etH9J_hjw-1; Fri, 11 Nov 2022 13:07:07 -0500
X-MC-Unique: 9UJtExzINQqk_etH9J_hjw-1
Received: by mail-qt1-f198.google.com with SMTP id cd6-20020a05622a418600b003a54cb17ad9so4109197qtb.0
        for <linux-block@vger.kernel.org>; Fri, 11 Nov 2022 10:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80TYJDe6hNYBM09PGXA70+IGuQTIUVRClbkoMTJ8nZQ=;
        b=fjcdmt61Ozmoh9AZq2WQWpeMODBj9fNUgZDjxU6RApQkasH1Si6PSnx/U2UA0HOm4T
         wm/5djq/EwYbSbByYxmjjItt+Fy7t4vVetozDCy1r4FdYNdzG56Xk1Fe2nyQVl1mEusa
         FwxWNwT2o2zAtcaZMH66n85wAvAQQ7uxTU19zrZkrzOF6lj6O5yQg/lJtQC0k9H9ETur
         blftT07kGwapyeS5xG2PzLEFeS/yAs2YGdRgQqfHxLoQz+nCmQp4rFyUwBelH/x8dlV0
         6/bCY3xFJecW/LbsnHaSj56LKqovx3HU5ZY8dl1++j1Ul363HOdDjNoQluayyflyRrLM
         OxuQ==
X-Gm-Message-State: ANoB5pnVobUfJZV8xNfXXs71zhehS004UFZfZiuNvd8TsGJ6JhWPxcf3
        O/kfgG6XTMHaJGaD+EzelDodrrhbr7WhQoztpIyB7+PmpWGewO/pZcc1Q1KpuIuRQrZ/i20KYfq
        SO01GGqs4aG5/luiAlvlAfg==
X-Received: by 2002:ac8:4257:0:b0:3a5:26c3:22f4 with SMTP id r23-20020ac84257000000b003a526c322f4mr2380861qtm.681.1668190027399;
        Fri, 11 Nov 2022 10:07:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7hoDB0jA1KI7h3boViFSMj/k4NHjJYIWttoM9rA6UOU1phvdLcQ47QpLgkD9SRefYi9kG5kQ==
X-Received: by 2002:ac8:4257:0:b0:3a5:26c3:22f4 with SMTP id r23-20020ac84257000000b003a526c322f4mr2380841qtm.681.1668190027174;
        Fri, 11 Nov 2022 10:07:07 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id z2-20020ae9c102000000b006eeae49537bsm1727165qki.98.2022.11.11.10.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 10:07:06 -0800 (PST)
Date:   Fri, 11 Nov 2022 13:07:05 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        stefanha@redhat.com, ebiggers@kernel.org, me@demsh.org,
        mpatocka@redhat.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 0/5] fix direct io device mapper errors
Message-ID: <Y26PSYu2nY/AE5Xh@redhat.com>
References: <20221110184501.2451620-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110184501.2451620-1-kbusch@meta.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 10 2022 at  1:44P -0500,
Keith Busch <kbusch@meta.com> wrote:

> From: Keith Busch <kbusch@kernel.org>
> 
> The 6.0 kernel made some changes to the direct io interface to allow
> offsets in user addresses. This based on the hardware's capabilities
> reported in the request_queue's dma_alignment attribute.
> 
> dm-crypt, -log-writes and -integrity require direct io be aligned to the
> block size. Since it was only ever using the default 511 dma mask, this
> requirement may fail if formatted to something larger, like 4k, which
> will result in unexpected behavior with direct-io.
> 
> Changes since v1: Added the same fix for -integrity and -log-writes
> 
> The first three were reported successfully tested by Dmitrii Tcvetkov,
> but I don't have an official Tested-by: tag.
> 
>   https://lore.kernel.org/linux-block/20221103194140.06ce3d36@xps.demsh.org/T/#mba1d0b13374541cdad3b669ec4257a11301d1860
> 
> Keitio errors on Busch (5):
>   block: make dma_alignment a stacking queue_limit
>   dm-crypt: provide dma_alignment limit in io_hints
>   block: make blk_set_default_limits() private
>   dm-integrity: set dma_alignment limit in io_hints
>   dm-log-writes: set dma_alignment limit in io_hints
> 
>  block/blk-core.c           |  1 -
>  block/blk-settings.c       |  9 +++++----
>  block/blk.h                |  1 +
>  drivers/md/dm-crypt.c      |  1 +
>  drivers/md/dm-integrity.c  |  1 +
>  drivers/md/dm-log-writes.c |  1 +
>  include/linux/blkdev.h     | 16 ++++++++--------
>  7 files changed, 17 insertions(+), 13 deletions(-)
> 
> -- 
> 2.30.2
> 

There are other DM targets that override logical_block_size in their
.io_hints hook (writecache, ebs, zoned). Have you reasoned through why
those do _not_ need updating too?

Is there any risk of just introducing a finalization method in block
core (that DM's .io_hints would call) that would ensure limits that
are a funtion of another are always in sync?  Would avoid whack-a-mole
issues in the future.

Thanks,
Mike

