Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F70DC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 13:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbiGNNK2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 09:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbiGNNKZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 09:10:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E3753B97F
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 06:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657804223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C5pvSvPxJ8YLKjo6JUOmuZyY11J8hFCHddKCvDY7Itg=;
        b=jHq7jN2xZKmRBIhEyOm9iKbCblThTrqJtZ4cKS/+DXWXa+MucKHD7Uj5rYGTDuaBLh68kt
        EJCyoFtWfkpR5k6zN7pPMFAY9j8Jy2uzglx16aXZfSF/HTpkUwMehlteNvPSrHKtkc5w1q
        aRDdrwHZMtaSQG/XMKz1sHf+U7LfSDI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-8pyM_wpzM6eP3nKA19Mb0g-1; Thu, 14 Jul 2022 09:10:15 -0400
X-MC-Unique: 8pyM_wpzM6eP3nKA19Mb0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A514A1815CFF;
        Thu, 14 Jul 2022 13:10:13 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C593A140EBE3;
        Thu, 14 Jul 2022 13:10:10 +0000 (UTC)
Date:   Thu, 14 Jul 2022 21:10:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH] ublk_drv: fix request queue leak
Message-ID: <YtAVraMgY9XsJ8JU@T590>
References: <20220714103201.131648-1-ming.lei@redhat.com>
 <47f6931d-5bb3-bc7e-51db-ef2e9d54d01b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47f6931d-5bb3-bc7e-51db-ef2e9d54d01b@kernel.dk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 14, 2022 at 07:00:59AM -0600, Jens Axboe wrote:
> On 7/14/22 4:32 AM, Ming Lei wrote:
> > Call blk_cleanup_queue() in release code path for fixing request
> > queue leak.
> > 
> > Also for-5.20/block has cleaned up blk_cleanup_queue(), which is
> > basically merged to del_gendisk() if blk_mq_alloc_disk() is used
> > for allocating disk and queue.
> > 
> > However, ublk may not add disk in case of starting device failure, then
> > del_gendisk() won't be called when removing ublk device, so blk_mq_exit_queue
> > will not be callsed, and it can be bit hard to deal with this kind of
> > merge conflict.
> > 
> > Turns out ublk's queue/disk use model is very similar with scsi, so switch
> > to scsi's model by allocating disk and queue independently, then it can be
> > quite easy to handle v5.20 merge conflict by replacing blk_cleanup_queue
> > with blk_mq_destroy_queue.
> 
> Tried this with the below incremental added to make it compile with
> the core block changes too, and it still fails for me:
> 
> [   22.488660] WARNING: CPU: 0 PID: 11 at block/blk-mq.c:3880 blk_mq_release+0xa4/0xf0
> [   22.490797] Modules linked in:
> [   22.491762] CPU: 0 PID: 11 Comm: kworker/0:1 Not tainted 5.19.0-rc6-00322-g42ed61fe42f3-dirty #1609
> [   22.494659] Hardware name: linux,dummy-virt (DT)
> [   22.496171] Workqueue: events blkg_free_workfn
> [   22.497652] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   22.499965] pc : blk_mq_release+0xa4/0xf0
> [   22.501386] lr : blk_mq_release+0x44/0xf0
> [   22.502748] sp : ffff80000af73cb0
> [   22.503880] x29: ffff80000af73cb0 x28: 0000000000000000 x27: 0000000000000000
> [   22.506263] x26: 0000000000000000 x25: ffff00001fe47b05 x24: 0000000000000000
> [   22.508655] x23: ffff0000052b6cb8 x22: ffff0000031e1c38 x21: 0000000000000000
> [   22.511035] x20: ffff0000031e1cf0 x19: ffff0000031e1bf0 x18: 0000000000000000
> [   22.513427] x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffa8000b80
> [   22.515814] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000001
> [   22.518209] x11: ffff80000945b7e8 x10: 0000000000006cb9 x9 : 00000000ffffffff
> [   22.520600] x8 : ffff800008fb5000 x7 : ffff80000860cf28 x6 : 0000000000000000
> [   22.522987] x5 : 0000000000000000 x4 : 0000000000000028 x3 : ffff80000af73c14
> [   22.525363] x2 : ffff0000071ccaa8 x1 : ffff0000071ccaa8 x0 : ffff0000071cc800
> [   22.527624] Call trace:
> [   22.528473]  blk_mq_release+0xa4/0xf0
> [   22.529724]  blk_release_queue+0x58/0xa0
> [   22.530946]  kobject_put+0x84/0xe0
> [   22.531821]  blk_put_queue+0x10/0x18
> [   22.532716]  blkg_free_workfn+0x58/0x84
> [   22.533681]  process_one_work+0x2ac/0x438
> [   22.534872]  worker_thread+0x1cc/0x264
> [   22.535829]  kthread+0xd0/0xe0
> [   22.536598]  ret_from_fork+0x10/0x20
> 
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index eeeac43e1dc1..d818da818c00 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1078,7 +1078,7 @@ static void ublk_cdev_rel(struct device *dev)
>  {
>  	struct ublk_device *ub = container_of(dev, struct ublk_device, cdev_dev);
>  
> -	blk_cleanup_queue(ub->ub_queue);
> +	blk_put_queue(ub->ub_queue);

I guess you run test on for-next, and it should work by just replacing
two blk_cleanup_queue with blk_mq_destroy_queue().


Thanks,
Ming

