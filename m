Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBA8C433EF
	for <linux-block@archiver.kernel.org>; Sun, 26 Sep 2021 12:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE47060FC2
	for <linux-block@archiver.kernel.org>; Sun, 26 Sep 2021 12:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhIZMtW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Sep 2021 08:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231441AbhIZMtV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Sep 2021 08:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632660465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TIU1SliLHR0gPG253uhvPBnlkJkKd7zvq1PnYr5EWUg=;
        b=KqMbSuLZtpd4EMUZqn3krJZ1ZVV7WInqAv3widCmxOaNNv0PffAOZttRAsqwvkLndp7soj
        Z+P/uKug/FctFDlCqsIug9o7wHgzuznn8bipYQui0CAZ1v5V9ypJMAhssXJUBR0bzk31Db
        0HtG0fS0OGuqpc8KEvYHuMqI+tBMRCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-lrhylb9gPjypIXuBOSCoEw-1; Sun, 26 Sep 2021 08:47:43 -0400
X-MC-Unique: lrhylb9gPjypIXuBOSCoEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0D1A1006AA2;
        Sun, 26 Sep 2021 12:47:41 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57D2F60C04;
        Sun, 26 Sep 2021 12:47:32 +0000 (UTC)
Date:   Sun, 26 Sep 2021 20:47:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Laibin Qiu <qiulaibin@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        hare@suse.de, asml.silence@gmail.com, bvanassche@acm.org
Subject: Re: [PATCH -next] blk-mq: fix tag_get wait task can't be awakened
Message-ID: <YVBr9Km1p7+uDioG@T590>
References: <20210913081248.3201596-1-qiulaibin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913081248.3201596-1-qiulaibin@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Laibin,

On Mon, Sep 13, 2021 at 04:12:48PM +0800, Laibin Qiu wrote:
> When multiple hctx share one tagset. The wake_batch is calculated
> during initialization by queue_depth. But when multiple hctx share one
> tagset. The queue depth assigned to each user may be smaller than
> wakup_batch. This may cause the waiting queue to fail to wakup and leads
> to Hang.

In case of shared tags, there might be more than one hctx which
allocates tag from single tags, and each hctx is limited to allocate
at most:

 	hctx_max_depth = max((bt->sb.depth + users - 1) / users, 4U);

	and

	users = atomic_read(&hctx->tags->active_queues)

See hctx_may_queue().

tag idle detection is lazy, and may be delayed for 30sec, so
there could be just one real active hctx(queue) but all others are
actually idle and still accounted as active because of the lazy
idle detection. Then if wake_batch is > hctx_max_depth, driver
tag allocation may wait forever on this real active hctx.

Correct me if my understanding is wrong.

> 
> Fix this by recalculating wake_batch when inc or dec active_queues.
> 
> Fixes: 0d2602ca30e41 ("blk-mq: improve support for shared tags maps")
> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
> ---
>  block/blk-mq-tag.c      | 44 +++++++++++++++++++++++++++++++++++++++--
>  include/linux/sbitmap.h |  8 ++++++++
>  lib/sbitmap.c           |  3 ++-
>  3 files changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 86f87346232a..d02f5ac0004c 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -16,6 +16,27 @@
>  #include "blk-mq-sched.h"
>  #include "blk-mq-tag.h"
>  
> +static void bt_update_wake_batch(struct sbitmap_queue *bt, unsigned int users)
> +{
> +	unsigned int depth;
> +
> +	depth = max((bt->sb.depth + users - 1) / users, 4U);
> +	sbitmap_queue_update_wake_batch(bt, depth);
> +}

Use the hctx's max queue depth could reduce wake_batch a lot, then
performance may be degraded.

Just wondering why not set sbq->wake_batch as hctx_max_depth if
sbq->wake_batch is < hctx_max_depth?



Thanks,
Ming

