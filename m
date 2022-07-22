Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8BEC43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 03:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiGVD22 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 23:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGVD22 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 23:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DB8E9368C
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 20:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658460506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pVIRn0+j8e5+CJURGMpEQCgInFInD1tV+yNNY1rqPfI=;
        b=ZJRH0r/yugv9111Nfltfos4VGpz90wZFimkyNcwt0qF0qalxpFi+kdhCCelrK3TxsRMOU5
        M6NsQCxGHQh3Vu1cQnfT6IKE/vz0tfVBWtbY5UpHMU3WFI8YTGWhCmVQmzQeW9GYDzYvr4
        dP21ntlqLCksdFTTknPwBn3XNVCBGQ0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-wi96vCtEO3KsYnbxStk3LA-1; Thu, 21 Jul 2022 23:28:24 -0400
X-MC-Unique: wi96vCtEO3KsYnbxStk3LA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48DEA1C04B42;
        Fri, 22 Jul 2022 03:28:24 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A1E2C2812B;
        Fri, 22 Jul 2022 03:28:20 +0000 (UTC)
Date:   Fri, 22 Jul 2022 11:28:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        ming.lei@redhat.com
Subject: Re: [PATCH 1/2] ublk_drv: move destroying device out of ublk_add_dev
Message-ID: <YtoZUBiT61yvKNDZ@T590>
References: <20220722023638.601667-1-ming.lei@redhat.com>
 <20220722023638.601667-2-ming.lei@redhat.com>
 <5bb0cf22-fee8-e5fd-8f8b-93c866e522f0@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bb0cf22-fee8-e5fd-8f8b-93c866e522f0@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 22, 2022 at 10:58:59AM +0800, Ziyang Zhang wrote:
> On 2022/7/22 10:36, Ming Lei wrote:
> > ublk_device is allocated in ublk_ctrl_add_dev(), so code will become more
> > readable by just letting ublk_ctrl_add_dev() destroy ublk_device in case
> > of ublk_add_dev() failure.
> > 
> > Meantime ub->mutex is destroyed in __ublk_destroy_dev(), but it may
> > not be initialized when ublk_add_dev() fails, so fix it by moving
> > mutex_init(ub->mutex) before any failure path.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index f058f40b639c..d03563286c76 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1106,9 +1106,10 @@ static int ublk_add_dev(struct ublk_device *ub)
> >  
> >  	INIT_WORK(&ub->stop_work, ublk_stop_work_fn);
> >  	INIT_DELAYED_WORK(&ub->monitor_work, ublk_daemon_monitor_work);
> > +	mutex_init(&ub->mutex);
> >  
> >  	if (ublk_init_queues(ub))
> > -		goto out_destroy_dev;
> > +		return err;
> >  
> >  	ub->tag_set.ops = &ublk_mq_ops;
> >  	ub->tag_set.nr_hw_queues = ub->dev_info.nr_hw_queues;
> > @@ -1122,7 +1123,6 @@ static int ublk_add_dev(struct ublk_device *ub)
> >  		goto out_deinit_queues;
> >  
> >  	ublk_align_max_io_size(ub);
> > -	mutex_init(&ub->mutex);
> >  	spin_lock_init(&ub->mm_lock);
> >  
> >  	/* add char dev so that ublksrv daemon can be setup */
> > @@ -1130,8 +1130,6 @@ static int ublk_add_dev(struct ublk_device *ub)
> >  
> >  out_deinit_queues:
> >  	ublk_deinit_queues(ub);
> > -out_destroy_dev:
> > -	__ublk_destroy_dev(ub);
> >  	return err;
> >  }
> >  
> > @@ -1331,8 +1329,10 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
> >  	ub->dev_info.dev_id = ub->ub_number;
> >  
> >  	ret = ublk_add_dev(ub);
> > -	if (ret)
> > +	if (ret) {
> > +		__ublk_destroy_dev(ub);
> >  		goto out_unlock;
> > +	}
> 
> Hi, Ming.
> 
> Now, if ublk_add_dev() returns failure, __ublk_destroy_dev() is called anyway.
> 
> However, in current ublk_drv:ublk_add_dev():
> 
> ...
> 	return ublk_add_chdev(ub);   <---- here
> out_deinit_queues:
> 	ublk_deinit_queues(ub);
> out_destroy_dev:
> 	__ublk_destroy_dev(ub);
> 	return err;
> 
> 
> ublk_add_chdev() returns and the returned value(maybe a failure) directly
> pass to ublk_ctrl_add_dev which does NOT call __ublk_destroy_dev()
> 
> please check it is correct to call __ublk_destroy_dev() if ublk_add_chdev() fails.

If ublk_add_chdev fails, we shouldn't call __ublk_destroy_dev() any
more, since ublk_add_chdev() does handle the cleanup, so this patch
is wrong.

will fix it in V2.


Thanks,
Ming

