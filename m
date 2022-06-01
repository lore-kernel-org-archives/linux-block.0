Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3BEC433EF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 00:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346138AbiFAAyo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 20:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiFAAyo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 20:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C34F74DCD
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 17:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654044882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WF1aeQXe+AoCpItsUhJbOEJxvKN1Y7yb5xm6N48x+0Y=;
        b=gjRK8SNz2YroIvqokqeFJcQZBIRngJ30KlXR9GLJvp7Wp5YOPyNSvS/syoR9q2+Xe7Ybz7
        w10W97llTrnb7x9+ZCNu8PvZoaWpYKa+3+GddQXS2GXNf1RfbPVkIji/0WsJ9MOC4pzxEf
        Gl76I38iR4yq1/C+JZV6Q8sMOYnM04U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-HGc-S-7AOkeocRhXnRNMcA-1; Tue, 31 May 2022 20:54:40 -0400
X-MC-Unique: HGc-S-7AOkeocRhXnRNMcA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FCB9803D5B;
        Wed,  1 Jun 2022 00:54:40 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6852D1121314;
        Wed,  1 Jun 2022 00:54:35 +0000 (UTC)
Date:   Wed, 1 Jun 2022 08:54:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: disable the elevator int del_gendisk
Message-ID: <Ypa4xrAHUslpQPhN@T590>
References: <20220531160535.3444915-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531160535.3444915-1-hch@lst.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 31, 2022 at 06:05:35PM +0200, Christoph Hellwig wrote:
> The elevator is only used for file system requests, which are stopped in
> del_gendisk.  Move disabling the elevator and freeing the scheduler tags
> to the end of del_gendisk instead of doing that work in disk_release and
> blk_cleanup_queue to avoid a use after free on q->tag_set from
> disk_release as the tag_set might not be alive at that point.
> 
> Move the blk_qos_exit call as well, as it just depends on the elevator
> exit and would be the only reason to keep the not exactly cheap queue
> freeze in disk_release.
> 
> Fixes: e155b0c238b2 ("blk-mq: Use shared tags for shared sbitmap support")
> Reported-by: syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
> ---
>  block/blk-core.c | 13 -------------
>  block/genhd.c    | 38 ++++++++++----------------------------
>  2 files changed, 10 insertions(+), 41 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 80fa73c419a99..19cfa71e33728 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -322,19 +322,6 @@ void blk_cleanup_queue(struct request_queue *q)
>  		blk_mq_exit_queue(q);
>  	}
>  
> -	/*
> -	 * In theory, request pool of sched_tags belongs to request queue.
> -	 * However, the current implementation requires tag_set for freeing
> -	 * requests, so free the pool now.
> -	 *
> -	 * Queue has become frozen, there can't be any in-queue requests, so
> -	 * it is safe to free requests now.
> -	 */
> -	mutex_lock(&q->sysfs_lock);
> -	if (q->elevator)
> -		blk_mq_sched_free_rqs(q);
> -	mutex_unlock(&q->sysfs_lock);
> -
>  	/* @q is and will stay empty, shutdown and put */
>  	blk_put_queue(q);
>  }
> diff --git a/block/genhd.c b/block/genhd.c
> index 8ff5b187791af..9914d0f24fecd 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -649,6 +649,16 @@ void del_gendisk(struct gendisk *disk)
>  
>  	blk_sync_queue(q);
>  	blk_flush_integrity();
> +	blk_mq_cancel_work_sync(q);
> +
> +	if (q->elevator) {
> +		mutex_lock(&q->sysfs_lock);
> +		elevator_exit(q);
> +		mutex_unlock(&q->sysfs_lock);
> +	}

This way can't be safe, who can guarantee that all sync submission
activities are gone after queue is frozen? We had lots of reports on
blk_mq_sched_has_work() which triggers UAF.

Thanks,
Ming

