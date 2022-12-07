Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A29C352A1
	for <linux-block@archiver.kernel.org>; Wed,  7 Dec 2022 02:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiLGCdD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 21:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLGCdC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 21:33:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95BB54375
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 18:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670380331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4X+7im9lAvgRY16a9M1eDI0bu6hBlAZ0o9PutKyZYok=;
        b=WiJkGw4YnU5DDj8jSkoohftbRaMNRW66HUa2IjpOCTADrz6iOp1ry7JcQnXhjAe4yhk/e+
        JDF8Klbu2dBowO4wXg7ypy6q+weduN92nnvB68pAEDP3oHjFaja+iciZCe8ER71SLnXTzn
        aoOdqoCeeuL9AKUr7NZ6UEbzA75HSFI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-vkUceayeMGWEM2SMSSQ3dQ-1; Tue, 06 Dec 2022 21:32:07 -0500
X-MC-Unique: vkUceayeMGWEM2SMSSQ3dQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37BA51C05AB9;
        Wed,  7 Dec 2022 02:32:07 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6F7740C2064;
        Wed,  7 Dec 2022 02:32:03 +0000 (UTC)
Date:   Wed, 7 Dec 2022 10:31:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH V2 4/6] ublk_drv: add device parameter
 UBLK_PARAM_TYPE_DEVT
Message-ID: <Y4/7HRzoDW0VeNid@T590>
References: <20221124030454.476152-1-ming.lei@redhat.com>
 <20221124030454.476152-5-ming.lei@redhat.com>
 <2ec739a3-f7ba-0e97-0df6-0d198c6689b5@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ec739a3-f7ba-0e97-0df6-0d198c6689b5@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 25, 2022 at 03:13:58PM +0800, Ziyang Zhang wrote:
> On 2022/11/24 11:04, Ming Lei wrote:
> > Userspace side only knows device ID, but the associated path of ublkc* and
> > ublkb* could be changed by udev, and that depends on userspace's policy, so
> > add parameter of UBLK_PARAM_TYPE_DEVT for retrieving major/minor of the
> > ublkc* and ublkb*, then user may figure out major/minor of the ublk disks
> > he/she owns. With major/minor, it is easy to find the device node path.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c      | 24 +++++++++++++++++++++++-
> >  include/uapi/linux/ublk_cmd.h | 13 +++++++++++++
> >  2 files changed, 36 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 9d1578384cba..04a28a2f2e1f 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -54,7 +54,8 @@
> >  		| UBLK_F_USER_RECOVERY_REISSUE)
> >  
> >  /* All UBLK_PARAM_TYPE_* should be included here */
> > -#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
> > +#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
> > +		UBLK_PARAM_TYPE_DISCARD | UBLK_PARAM_TYPE_DEVT)
> >  
> >  struct ublk_rq_data {
> >  	struct llist_node node;
> > @@ -255,6 +256,10 @@ static int ublk_validate_params(const struct ublk_device *ub)
> >  			return -EINVAL;
> >  	}
> >  
> > +	/* dev_t is read-only */
> > +	if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
> > +		WARN_ON_ONCE(1);
> Hi, Ming
> 
> ublk_validate_params() is only called by ublk_ctrl_set_params().
> Why not return -EINVAL here since UBLK_PARAM_TYPE_DEVT is not
> allowed in ublk_ctrl_set_params(). Then the user may know he has
> made a mistake.

Yeah, it is better to return -EINVAL here.

Thanks,
Ming

