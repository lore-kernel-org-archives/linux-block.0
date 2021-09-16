Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D93C433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 08:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E05760F93
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 08:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbhIPIZC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Sep 2021 04:25:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49312 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234904AbhIPIZB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 04:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631780621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2gYTVUstSGum8vCgM4ToltbBv2THH4KeZDSf5iCyLvY=;
        b=JUxM/kBoAJCalOozO5d+OAnytsfe71chzX7PRZxE+dJE5a+Nqj9j9bKRPGMxEeIWzdTvBL
        PrCY8Ef+Nx6V4Ohrw62jofe67OI6tqcF/R/QeBPim3pJkTaz34mE1cWq88ryauBfveZFqR
        0KD0jTajXCHI6iJFkRAqSzZhDtY9HwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-TUBi5zIKMy-P7na6kgC6Ug-1; Thu, 16 Sep 2021 04:23:40 -0400
X-MC-Unique: TUBi5zIKMy-P7na6kgC6Ug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08DCF835DE2;
        Thu, 16 Sep 2021 08:23:39 +0000 (UTC)
Received: from T590 (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0635C6D982;
        Thu, 16 Sep 2021 08:23:28 +0000 (UTC)
Date:   Thu, 16 Sep 2021 16:23:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     pkalever@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, josef@toxicpanda.com, axboe@kernel.dk,
        idryomov@redhat.com, xiubli@redhat.com,
        Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Subject: Re: [PATCH v1 2/2] nbd: reset the queue/io_timeout to default on
 disconnect
Message-ID: <YUL/DGZiUnQQGHVX@T590>
References: <20210806142914.70556-1-pkalever@redhat.com>
 <20210806142914.70556-3-pkalever@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806142914.70556-3-pkalever@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 06, 2021 at 07:59:14PM +0530, pkalever@redhat.com wrote:
> From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> 
> Without any changes to NBD_ATTR_TIMEOUT (default is 30 secs),
> $ rbd-nbd map rbd-pool/image0 --try-netlink
> /dev/nbd0
> $ cat /sys/block/nbd0/queue/io_timeout
> 30000
> $ rbd-nbd unmap /dev/nbd0
> $ cat /sys/block/nbd0/queue/io_timeout
> 30000
> 
> Now user sets NBD_ATTR_TIMEOUT to 60,
> $ rbd-nbd map rbd-pool/image0 --try-netlink --io-timeout 60
> /dev/nbd0
> $ cat /sys/block/nbd0/queue/io_timeout
> 60000
> $ rbd-nbd unmap /dev/nbd0
> $ cat /sys/block/nbd0/queue/io_timeout
> 60000
> 
> Now user doesn't alter NBD_ATTR_TIMEOUT, but sysfs still shows it as 60,
> $ rbd-nbd map rbd-pool/image0 --try-netlink
> /dev/nbd0
> $ cat /sys/block/nbd0/queue/io_timeout
> 60000
> $ rbd-nbd unmap /dev/nbd0
> $ cat /sys/block/nbd0/queue/io_timeout
> 60000
> 
> The problem exists with ioctl interface too.
> 
> Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> ---
>  drivers/block/nbd.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 16a1a14b1fd1..a45aabc4914b 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -158,6 +158,7 @@ static void nbd_connect_reply(struct genl_info *info, int index);
>  static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info);
>  static void nbd_dead_link_work(struct work_struct *work);
>  static void nbd_disconnect_and_put(struct nbd_device *nbd);
> +static void nbd_set_cmd_timeout(struct nbd_device *nbd, u64 timeout);
>  
>  static inline struct device *nbd_to_dev(struct nbd_device *nbd)
>  {
> @@ -1250,7 +1251,7 @@ static void nbd_config_put(struct nbd_device *nbd)
>  			destroy_workqueue(nbd->recv_workq);
>  		nbd->recv_workq = NULL;
>  
> -		nbd->tag_set.timeout = 0;
> +		nbd_set_cmd_timeout(nbd, 0);
>  		nbd->disk->queue->limits.discard_granularity = 0;
>  		nbd->disk->queue->limits.discard_alignment = 0;
>  		blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX);
> @@ -2124,6 +2125,10 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
>  	if (ret)
>  		goto out;
>  
> +	/*
> +	 * On reconfigure, if NBD_ATTR_TIMEOUT is not provided, we will
> +	 * continue to use the cmd timeout provided with connect initially.
> +	 */
>  	if (info->attrs[NBD_ATTR_TIMEOUT])
>  		nbd_set_cmd_timeout(nbd,
>  				    nla_get_u64(info->attrs[NBD_ATTR_TIMEOUT]));
> -- 
> 2.31.1
> 

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

