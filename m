Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488EFE7AD6E
	for <linux-block@archiver.kernel.org>; Tue,  3 Oct 2023 15:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjJCPh5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Oct 2023 11:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjJCPh4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2023 11:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E0E83
        for <linux-block@vger.kernel.org>; Tue,  3 Oct 2023 08:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696347429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vV6tJbaxavpVva0WB2mOArL8TJIEb5iZUFF3Dln6v6c=;
        b=ToVJmmMd6W6xNKHw2cuRQhR7F4tJLEXmPI+yaUyG5ZTYOZFZEYDZGtoXsk0ksiQofrSFn4
        GDw7N4qaTMXfIEwcE5X/4rwM4M2rcrzMvBl89q2mWoTpR/wXkTUkA29rmM+PnZWIzD/UG8
        DDiQI+FDDOA/sLCzTVc1gaqYKd1q4o0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-4LFhOI3QOESJ_QOR2pOwdg-1; Tue, 03 Oct 2023 11:37:08 -0400
X-MC-Unique: 4LFhOI3QOESJ_QOR2pOwdg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57030185A79B;
        Tue,  3 Oct 2023 15:37:07 +0000 (UTC)
Received: from fedora (unknown [10.72.120.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF1FDC15BB8;
        Tue,  3 Oct 2023 15:37:03 +0000 (UTC)
Date:   Tue, 3 Oct 2023 23:36:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        Hannes Reinecke <hare@suse.de>, ming.lei@redhat.com
Subject: Re: [PATCH 1/2] ublk: Limit dev_id/ub_number values
Message-ID: <ZRw1GvSwh+49SmL/@fedora>
References: <20231001185448.48893-1-michael.christie@oracle.com>
 <20231001185448.48893-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231001185448.48893-2-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Oct 01, 2023 at 01:54:47PM -0500, Mike Christie wrote:
> The dev_id/ub_number is used for the ublk dev's char device's minor
> number so it has to fit into MINORMASK. This patch adds checks to prevent
> userspace from passing a number that's too large and limits what can be
> allocated by the ublk_index_idr for the case where userspace has the
> kernel allocate the dev_id/ub_number.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/block/ublk_drv.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 630ddfe6657b..18e352f8cd6d 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -470,6 +470,7 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
>   * It can be extended to one per-user limit in future or even controlled
>   * by cgroup.
>   */
> +#define UBLK_MAX_UBLKS (UBLK_MINORS - 1)
>  static unsigned int ublks_max = 64;
>  static unsigned int ublks_added;	/* protected by ublk_ctl_mutex */
>  
> @@ -2026,7 +2027,8 @@ static int ublk_alloc_dev_number(struct ublk_device *ub, int idx)
>  		if (err == -ENOSPC)
>  			err = -EEXIST;
>  	} else {
> -		err = idr_alloc(&ublk_index_idr, ub, 0, 0, GFP_NOWAIT);
> +		err = idr_alloc(&ublk_index_idr, ub, 0, UBLK_MAX_UBLKS,

'end' parameter of idr_alloc() is exclusive, so I think UBLK_MAX_UBLKS should
be defined as UBLK_MINORS?

> +				GFP_NOWAIT);
>  	}
>  	spin_unlock(&ublk_idr_lock);
>  
> @@ -2305,6 +2307,12 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
>  		return -EINVAL;
>  	}
>  
> +	if (header->dev_id != U32_MAX && header->dev_id > UBLK_MAX_UBLKS) {

I guess 'if (header->dev_id >= UBLK_MAX_UBLKS)' should be enough.

Otherwise, this patch looks fine.


On Mon, Oct 2, 2023 at 2:08 PM Hannes Reinecke <hare@suse.de> wrote:
...
> Why don't you do away with ublks_max and switch to dynamic minors once
> UBLK_MAX_UBLKS is reached?

The current approach follows nvme cdev(see nvme_cdev_add()), and I don't
see any benefit with dynamic minors, especially MINORBITS is 20, and max
minors is 1M, which should be big enough for any use cases.

BTW, looks nvme_cdev_add() needs similar fix too.

Thanks,
Ming

