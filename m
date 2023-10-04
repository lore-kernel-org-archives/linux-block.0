Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505D8E7B608
	for <linux-block@archiver.kernel.org>; Wed,  4 Oct 2023 12:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjJDMkP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Oct 2023 08:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjJDMkP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Oct 2023 08:40:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F55BA6
        for <linux-block@vger.kernel.org>; Wed,  4 Oct 2023 05:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696423171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uU/dAodkZnm1dtRSOlykhrpIsgQBzP60Gn6tUCYv60k=;
        b=IUk9OmK36vP6OPxHXZzU/PwLx0x71LE+6qFithn2to3nWxQ2iVr88rtCFgNhTqMLtl9R8U
        XN5yySxSIbC8ZrozI6HY9yGupSwowt2v4D1Qm6Q9O0JJ0u5WUsQzcTCN74MOkm4DfsCalL
        +C+v2NGfKfdJ/I/4Wcj2XMwa1LJKyRk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-OqeeLCT_NK6C0E6lBgxrAQ-1; Wed, 04 Oct 2023 08:39:23 -0400
X-MC-Unique: OqeeLCT_NK6C0E6lBgxrAQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F600811E92;
        Wed,  4 Oct 2023 12:39:23 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9550040C6EA8;
        Wed,  4 Oct 2023 12:39:19 +0000 (UTC)
Date:   Wed, 4 Oct 2023 20:39:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        Hannes Reinecke <hare@suse.de>, ming.lei@redhat.com
Subject: Re: [PATCH 1/2] ublk: Limit dev_id/ub_number values
Message-ID: <ZR1c8mAwmgaG0ynV@fedora>
References: <20231001185448.48893-1-michael.christie@oracle.com>
 <20231001185448.48893-2-michael.christie@oracle.com>
 <ZRw1GvSwh+49SmL/@fedora>
 <8c37dabb-46e9-4f8c-ad19-eee3163e3075@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c37dabb-46e9-4f8c-ad19-eee3163e3075@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 03, 2023 at 11:07:37AM -0500, Mike Christie wrote:
> On 10/3/23 10:36 AM, Ming Lei wrote:
> > On Sun, Oct 01, 2023 at 01:54:47PM -0500, Mike Christie wrote:
> >> The dev_id/ub_number is used for the ublk dev's char device's minor
> >> number so it has to fit into MINORMASK. This patch adds checks to prevent
> >> userspace from passing a number that's too large and limits what can be
> >> allocated by the ublk_index_idr for the case where userspace has the
> >> kernel allocate the dev_id/ub_number.
> >>
> >> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> >> ---
> >>  drivers/block/ublk_drv.c | 10 +++++++++-
> >>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> >> index 630ddfe6657b..18e352f8cd6d 100644
> >> --- a/drivers/block/ublk_drv.c
> >> +++ b/drivers/block/ublk_drv.c
> >> @@ -470,6 +470,7 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
> >>   * It can be extended to one per-user limit in future or even controlled
> >>   * by cgroup.
> >>   */
> >> +#define UBLK_MAX_UBLKS (UBLK_MINORS - 1)
> >>  static unsigned int ublks_max = 64;
> >>  static unsigned int ublks_added;	/* protected by ublk_ctl_mutex */
> >>  
> >> @@ -2026,7 +2027,8 @@ static int ublk_alloc_dev_number(struct ublk_device *ub, int idx)
> >>  		if (err == -ENOSPC)
> >>  			err = -EEXIST;
> >>  	} else {
> >> -		err = idr_alloc(&ublk_index_idr, ub, 0, 0, GFP_NOWAIT);
> >> +		err = idr_alloc(&ublk_index_idr, ub, 0, UBLK_MAX_UBLKS,
> > 
> > 'end' parameter of idr_alloc() is exclusive, so I think UBLK_MAX_UBLKS should
> > be defined as UBLK_MINORS?
> 
> We can use UBLK_MINORS. I just used UBLK_MAX_UBLKS because it was only
> a difference of one device and I thought using UBLK_MAX_UBLKS in the
> all the checks was more consistent.
> 
> But yeah, I can see the opposite where it's more clear to use the
> exact limit and will change it.
> 
> 
> > 
> >> +				GFP_NOWAIT);
> >>  	}
> >>  	spin_unlock(&ublk_idr_lock);
> >>  
> >> @@ -2305,6 +2307,12 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
> >>  		return -EINVAL;
> >>  	}
> >>  
> >> +	if (header->dev_id != U32_MAX && header->dev_id > UBLK_MAX_UBLKS) {
> > 
> > I guess 'if (header->dev_id >= UBLK_MAX_UBLKS)' should be enough.
> 
> I can't drop the first part of the check because header->dev_id is a
> u32:

Your are right, let's keep the check.

> 
> struct ublksrv_ctrl_cmd {
>         /* sent to which device, must be valid */
>         __u32   dev_id;
> 
> and userspace is passing in:
> 
> dev_id = U32_MAX
> 
> to indicate for the kernel to allocate the dev_id.
> 
> 
> The weirdness is that we convert dev_id to a int later:
> 
> ret = ublk_alloc_dev_number(ub, header->dev_id);
> 
> ....
> 
> static int ublk_alloc_dev_number(struct ublk_device *ub, int idx)
> 
> so the header->dev_id gets converted to a signed int and in
> ublk_alloc_dev_number U32_MAX gets turned into -1. There
> we check the idx/dev_id more similar to what you suggested above.

The thing is that '-1' means auto-id-allocation, and the .dev_id field
should have been defined as -1 from beginning, but it can't change now.

thanks,
Ming

