Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA318C433FE
	for <linux-block@archiver.kernel.org>; Fri, 18 Nov 2022 11:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiKRLw1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiKRLw0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 06:52:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB919922F4
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 03:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668772285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fPduHJrBCa3JS3Ltxfexz4XZCB17ZsjU+vVnLwMTCgo=;
        b=XVLnECh37I+5d87qQREUfm53IneI3sbfY0DwePe3jAoteVfX5tbX6q2GgqXTB0XOR94sPn
        kWiCxP2IMSwlGzxe3QPAinioegt/v3B0fNw1V/PNOWT2c2N+q5AQm9WP/ungt73wvtzWZK
        N9qC4TwJ2sWpzCvVUSBLYX3ZDE9Iao4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-d9cWhQ8sOAqhR3ZYccHdow-1; Fri, 18 Nov 2022 06:51:22 -0500
X-MC-Unique: d9cWhQ8sOAqhR3ZYccHdow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24C0E811E75;
        Fri, 18 Nov 2022 11:51:22 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A213140EBF3;
        Fri, 18 Nov 2022 11:51:16 +0000 (UTC)
Date:   Fri, 18 Nov 2022 19:51:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>, ming.lei@redhat.com
Subject: Re: [PATCH 2/6] ublk_drv: don't probe partitions if the ubq daemon
 isn't trusted
Message-ID: <Y3dxrwUM06SqX/tg@T590>
References: <20221116060835.159945-1-ming.lei@redhat.com>
 <20221116060835.159945-3-ming.lei@redhat.com>
 <9512a7d2-8109-95bd-ba88-f6256b0ea292@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9512a7d2-8109-95bd-ba88-f6256b0ea292@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 18, 2022 at 06:03:48PM +0800, Ziyang Zhang wrote:
> On 2022/11/16 14:08, Ming Lei wrote:
> > If any ubq daemon is unprivileged, the ublk char device is allowed
> > for unprivileged user, and we can't trust the current user, so not
> > probe partitions.
> > 
> > Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index fe997848c1ff..a5f3d8330be5 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -149,6 +149,7 @@ struct ublk_device {
> >  
> >  #define UB_STATE_OPEN		0
> >  #define UB_STATE_USED		1
> > +#define UB_STATE_PRIVILEGED	2
> >  	unsigned long		state;
> >  	int			ub_number;
> >  
> > @@ -161,6 +162,7 @@ struct ublk_device {
> >  
> >  	struct completion	completion;
> >  	unsigned int		nr_queues_ready;
> > +	unsigned int		nr_privileged_daemon;
> >  
> >  	/*
> >  	 * Our ubq->daemon may be killed without any notification, so
> > @@ -1184,9 +1186,15 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
> >  		ubq->ubq_daemon = current;
> >  		get_task_struct(ubq->ubq_daemon);
> >  		ub->nr_queues_ready++;
> > +
> > +		if (capable(CAP_SYS_ADMIN))
> > +			ub->nr_privileged_daemon++;
> >  	}
> > -	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
> > +	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues) {
> > +		if (ub->nr_privileged_daemon == ub->nr_queues_ready)
> 
> Hi, Ming.
> 
> Just like nr_queues_ready, ub->nr_privileged_daemon should be reset
> to zero in ublk_ctrl_start_recovery(). otherwise new ubq_daemons are
> always treated as unprivileged.

Good catch!

> 
> > +			set_bit(UB_STATE_PRIVILEGED, &ub->state);
> >  		complete_all(&ub->completion);
> > +	}
> >  	mutex_unlock(&ub->mutex);
> >  }
> >  
> > @@ -1540,6 +1548,10 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
> >  	if (ret)
> >  		goto out_put_disk;
> >  
> > +	/* don't probe partitions if any one ubq daemon is un-trusted */
> > +	if (!test_bit(UB_STATE_PRIVILEGED, &ub->state))
> > +		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> 
> Can we simply check if nr_queues_ready == nr_privileged_daemon here
> instead of adding a new bit UB_STATE_PRIVILEGED?

Good idea!

> 
> BTW, I think exposing whether ub's state is privileged/unprivileged
> to users(./ublk list) is a good idea.

It is actually not a state, but a flag of UBLK_F_UNPRIVILEGED_DEV, which
won't be changed for one device and is shown in 'ublk list'.

For root user, maybe we should clear the flag from UBLK_CMD_ADD_DEV.

Thanks,
Ming

