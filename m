Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F60C433EF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 07:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343893AbiFAHJm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 03:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiFAHJm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 03:09:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F128468FAC
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 00:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654067379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fw4lOwD0HrVvsL+S/LACz/d4a4llH41/ZwVMcXeiK2c=;
        b=IBpwdcG1FJ9p5ZOZvIkq418EZCZSFUoqDJm+SN87af9yR1G0Xf7b4Ri3vG/H6jzfbweDXU
        tQkFFe8QzZeiwGs4uyo+QCj43Gt8dAnXBB19nBLGRMw3ihI8fmFB5oT1KZYkZU3lGhAFhB
        ggeJFzCHxC9bjIoZ0e2pnbDrexG5yfw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-IEPG4JzlOUqUDs6r5srduA-1; Wed, 01 Jun 2022 03:09:36 -0400
X-MC-Unique: IEPG4JzlOUqUDs6r5srduA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 178B580A0B5;
        Wed,  1 Jun 2022 07:09:36 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 35A90414A7E7;
        Wed,  1 Jun 2022 07:09:31 +0000 (UTC)
Date:   Wed, 1 Jun 2022 15:09:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: disable the elevator int del_gendisk
Message-ID: <YpcQpjUlX/CTORmp@T590>
References: <20220531160535.3444915-1-hch@lst.de>
 <Ypa4xrAHUslpQPhN@T590>
 <20220601064329.GB22915@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601064329.GB22915@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 01, 2022 at 08:43:29AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 01, 2022 at 08:54:30AM +0800, Ming Lei wrote:
> > This way can't be safe, who can guarantee that all sync submission
> > activities are gone after queue is frozen? We had lots of reports on
> > blk_mq_sched_has_work() which triggers UAF.
> 
> Yes, we probably need a blk_mq_quiesce_queue call like in the incremental
> patch below.  Do you have any good reproducer, though?

blktests block/027 should cover this.

> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 9914d0f24fecd..155b64ff991f6 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -652,9 +652,13 @@ void del_gendisk(struct gendisk *disk)
>  	blk_mq_cancel_work_sync(q);
>  
>  	if (q->elevator) {
> +		blk_mq_quiesce_queue(q);
> +
>  		mutex_lock(&q->sysfs_lock);
>  		elevator_exit(q);
>  		mutex_unlock(&q->sysfs_lock);
> +
> +		blk_mq_unquiesce_queue(q);
>  	}
>  

I am afraid the above way may slow down disk shutdown a lot, see
the following commit, that is also the reason why I moved it into disk
release handler, when any sync io submission are done.

commit 1311326cf4755c7ffefd20f576144ecf46d9906b
Author: Ming Lei <ming.lei@redhat.com>
Date:   Mon Jun 25 19:31:49 2018 +0800

    blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()

    SCSI probing may synchronously create and destroy a lot of request_queues
    for non-existent devices. Any synchronize_rcu() in queue creation or
    destroy path may introduce long latency during booting, see detailed
    description in comment of blk_register_queue().

    This patch removes one synchronize_rcu() inside blk_cleanup_queue()
    for this case, commit c2856ae2f315d75(blk-mq: quiesce queue before freeing queue)
    needs synchronize_rcu() for implementing blk_mq_quiesce_queue(), but
    when queue isn't initialized, it isn't necessary to do that since
    only pass-through requests are involved, no original issue in
    scsi_execute() at all.

    Without this patch and previous one, it may take more 20+ seconds for
    virtio-scsi to complete disk probe. With the two patches, the time becomes
    less than 100ms.



Thanks,
Ming

