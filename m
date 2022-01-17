Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97E8C433EF
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 03:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbiAQDdF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Jan 2022 22:33:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25951 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236944AbiAQDdF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Jan 2022 22:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642390384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ccZ+oKNF9ScPDegB7MEDqYsfYM+gZw4I1frllwTtQlg=;
        b=BbEzYp5N9wg/BkFE3jKS1/HPVpYoFnr3PUKZHpqk1sVhgqgZCKucHCZi5iXmDUz0CbXycH
        A1T5w+OvB8s8sOEZO3seqapOLD0t2x3Sije+sL/74rYRZfdG/zr9u4stJ7ZGvpL9hnCLhk
        57VeiBReXJmw/sZvKwMqnwO2Ri85Ciw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-CI-xJHTIODe8jFVZ-UQhiA-1; Sun, 16 Jan 2022 22:33:03 -0500
X-MC-Unique: CI-xJHTIODe8jFVZ-UQhiA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B2D51853026;
        Mon, 17 Jan 2022 03:33:02 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44FED4BC57;
        Mon, 17 Jan 2022 03:32:54 +0000 (UTC)
Date:   Mon, 17 Jan 2022 11:32:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: cleanup q->srcu
Message-ID: <YeTjYU3KVeU1sstH@T590>
References: <20220111123401.520192-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111123401.520192-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 11, 2022 at 08:34:01PM +0800, Ming Lei wrote:
> srcu structure has to be cleanup via cleanup_srcu_struct(), so fix it.
> 
> Reported-by: syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com
> Fixes: 704b914f15fb ("blk-mq: move srcu from blk_mq_hw_ctx to request_queue")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-sysfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index e20eadfcf5c8..8d8549f71311 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -811,6 +811,9 @@ static void blk_release_queue(struct kobject *kobj)
>  
>  	bioset_exit(&q->bio_split);
>  
> +	if (blk_queue_has_srcu(q))
> +		cleanup_srcu_struct(q->srcu);
> +
>  	ida_simple_remove(&blk_queue_ida, q->id);
>  	call_rcu(&q->rcu_head, blk_free_queue_rcu);

Hello Jens,

Can we make it into mainline to fix the recent syzbot report?


Thanks,
Ming

