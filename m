Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915A8C001B0
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 14:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbjHJOBg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 10:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbjHJOB3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 10:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0A526AF
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 07:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691676040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+g8mE7QgyEjqn7+5inRH3OtNbDjmawTuNNPPwXzqCuY=;
        b=CuPW25TMK+Ia4C316cy27niD9SssBxnuK+SEaXeCJ6ahKNgU+WC6veYFc4nfUCRkEk3Xp3
        B3g2KVRAQSkz3S262RuAgeRpzhVu2/LfmzmI0fACSRRp/V+Gr/IUf6H1OZp5QeerqE0luN
        YUA8K4itIiEgXMCuLiW5XL4Mki40F0s=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-WyGF6OghP6e0iHJ2JUk9og-1; Thu, 10 Aug 2023 10:00:36 -0400
X-MC-Unique: WyGF6OghP6e0iHJ2JUk9og-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4EAB1C06EFB;
        Thu, 10 Aug 2023 14:00:24 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D164492B0F;
        Thu, 10 Aug 2023 14:00:20 +0000 (UTC)
Date:   Thu, 10 Aug 2023 22:00:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>, ming.lei@redhat.com
Subject: Re: [PATCH V2] ublk: zoned: support REQ_OP_ZONE_RESET_ALL
Message-ID: <ZNTtbpNCiXPvRlvI@fedora>
References: <20230810124326.321472-1-ming.lei@redhat.com>
 <ZNThwMBAqqVUGtek@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNThwMBAqqVUGtek@x1-carbon>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 10, 2023 at 01:10:30PM +0000, Niklas Cassel wrote:
> On Thu, Aug 10, 2023 at 08:43:26PM +0800, Ming Lei wrote:
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
> > Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
> > Cc: Damien Le Moal <dlemoal@kernel.org>
> > Cc: Andreas Hindborg <a.hindborg@samsung.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> > V2:
> > 	- update comment as reported by Niklas
> > 
> >  drivers/block/ublk_drv.c      | 7 +++++--
> >  include/uapi/linux/ublk_cmd.h | 1 +
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index b60394fe7be6..3650ef209344 100644
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
> > @@ -404,9 +408,8 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
> >  		default:
> >  			return BLK_STS_IOERR;
> >  		}
> > -	case REQ_OP_ZONE_RESET_ALL:
> >  	case REQ_OP_DRV_OUT:
> > -		/* We do not support reset_all and drv_out */
> > +		/* We do not support drv_out */
> >  		return BLK_STS_NOTSUPP;
> >  	default:
> >  		return BLK_STS_IOERR;
> > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> > index 2685e53e4752..b9cfc5c96268 100644
> > --- a/include/uapi/linux/ublk_cmd.h
> > +++ b/include/uapi/linux/ublk_cmd.h
> > @@ -245,6 +245,7 @@ struct ublksrv_ctrl_dev_info {
> >  #define		UBLK_IO_OP_ZONE_CLOSE		11
> >  #define		UBLK_IO_OP_ZONE_FINISH		12
> >  #define		UBLK_IO_OP_ZONE_APPEND		13
> > +#define		UBLK_IO_OP_ZONE_RESET_ALL	14
> 
> For some reason, it seems like the UBLK_IO_OP_ZONE_* values
> are identical to the REQ_OP_ZONE_* values in enum req_op:

Yeah.

I think that is zoned interface abstraction, which should be
generic enough to use linux's definition for ublk's UAPI in 1:1.

The same mapping can be found in virtio-blk zoned spec.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/blk_types.h?h=v6.5-rc5#n371
> 
> I don't see any obvious advantage of keeping them the same,

Not sure I follow your idea, and can you share your exact suggestion?

UBLK_IO_OP_ZONE_* is part of ublk UAPI, but REQ_OP_ZONE_* is just kernel
internal definition which may be changed time by time, so we can't use
REQ_OP_ZONE_* directly.

Here you can think of UBLK_IO_OP_ZONE_* as interface between driver and
hardware, so UBLK_IO_OP_ZONE_* has to be defined independently.

> but if you want to keep this pattern, then perhaps you want
> to define UBLK_IO_OP_ZONE_RESET_ALL to 17.

Why do you think that 17 is better than 14?

I'd rather use 14 to fill the hole, meantime the two ZONE_RESET OPs
can be kept together.

Thanks,
Ming

