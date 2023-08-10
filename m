Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C447EC001B0
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 12:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjHJMQn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 08:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbjHJMQl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 08:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C56110
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 05:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691669760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gw++utYIMotaebxJZAmP8owD7ulIc+5KsjUwhLEdisU=;
        b=EJB0/0VVqMZHyx022gefiw4D8UsS23oc4jpUQT8bCu8DiiXShE+7wZy0xMSvq+Wh8actUf
        Ht8p8XDUOfTXJ3Igd9uFxXGT2jkjKKS/9PAOcpfbGvryDeoGQalXAYG6vULCxIH0AYpPiZ
        1zXXS9SPDjAnEol6UjPTQD3+DruEE2E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-DD47KeiOMMuYwZPvIDKjWw-1; Thu, 10 Aug 2023 08:15:56 -0400
X-MC-Unique: DD47KeiOMMuYwZPvIDKjWw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23496101A53C;
        Thu, 10 Aug 2023 12:15:56 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5B82140E96E;
        Thu, 10 Aug 2023 12:15:52 +0000 (UTC)
Date:   Thu, 10 Aug 2023 20:15:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH] ublk: zoned: support REQ_OP_ZONE_RESET_ALL
Message-ID: <ZNTU8/hdhAo6Y/wx@fedora>
References: <20230810092057.288220-1-ming.lei@redhat.com>
 <ZNTPSQTDOgr7Ojn+@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNTPSQTDOgr7Ojn+@x1-carbon>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 10, 2023 at 11:51:38AM +0000, Niklas Cassel wrote:
> Hello Ming,
> 
> On Thu, Aug 10, 2023 at 05:20:57PM +0800, Ming Lei wrote:
> > There isn't any reason to not support REQ_OP_ZONE_RESET_ALL given everything
> > is actually handled in userspace, not mention it is pretty easy to support
> > RESET_ALL.
> > 
> > So enable REQ_OP_ZONE_RESET_ALL and let userspace handle it.
> > 
> > Verified by 'tools/zbc_reset_zone -all /dev/ublkb0' in libzbc[1] with
> > libublk-rs based ublk-zoned target prototype[2], follows command line
> > for creating ublk-zoned:
> > 
> > 	cargo run --example zoned -- add -1 1024	# add $dev_id $DEV_SIZE
> > 
> > [1] https://github.com/westerndigitalcorporation/libzbc
> > [2] https://github.com/ming1/libublk-rs/tree/zoned.v2
> > 
> > Cc: Damien Le Moal <dlemoal@kernel.org>
> > Cc: Andreas Hindborg <a.hindborg@samsung.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c      | 5 ++++-
> >  include/uapi/linux/ublk_cmd.h | 1 +
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 109a5b17537d..939e4584485b 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -251,6 +251,7 @@ static int ublk_dev_param_zoned_apply(struct ublk_device *ub)
> >  	const struct ublk_param_zoned *p = &ub->params.zoned;
> >  
> >  	disk_set_zoned(ub->ub_disk, BLK_ZONED_HM);
> > +	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, ub->ub_disk->queue);
> >  	blk_queue_required_elevator_features(ub->ub_disk->queue,
> >  					     ELEVATOR_F_ZBD_SEQ_WRITE);
> >  	disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
> > @@ -393,6 +394,9 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
> >  	case REQ_OP_ZONE_APPEND:
> >  		ublk_op = UBLK_IO_OP_ZONE_APPEND;
> >  		break;
> > +	case REQ_OP_ZONE_RESET_ALL:
> > +		ublk_op = UBLK_IO_OP_ZONE_RESET_ALL;
> > +		break;
> >  	case REQ_OP_DRV_IN:
> >  		ublk_op = pdu->operation;
> >  		switch (ublk_op) {
> > @@ -404,7 +408,6 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
> >  		default:
> >  			return BLK_STS_IOERR;
> >  		}
> > -	case REQ_OP_ZONE_RESET_ALL:
> >  	case REQ_OP_DRV_OUT:
> >  		/* We do not support reset_all and drv_out */
> 
> I think that you should also drop reset_all from this comment.

Good catch, will do it in v2.

Thanks,
Ming

