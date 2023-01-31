Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FECC38142
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 10:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjAaKQP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 05:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjAaKQL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 05:16:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FD24995A
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 02:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675160124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZAQct07RmXjsPBydkh4gU6qVtTSDWIY2zc/YS0s3Fdw=;
        b=YuQ9RPZIh16WlUVKexA4aJo8g1NgrRSkXRhuJlAqSHgw7ws9W6Kd/Ypae3ylY7c0lAy+GB
        aygA5twQ/dBYVIpenn1/MGbfaODO/JpqVmiLEeeHLG9r0aSDe95z2iFlu/WkhmEWgVNXfS
        chW7zkJAv3AQqXVFuo63IdzpTLJlPG4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-Y5BX3Fx4Pweph0Y3k0Y3Yw-1; Tue, 31 Jan 2023 05:15:20 -0500
X-MC-Unique: Y5BX3Fx4Pweph0Y3k0Y3Yw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B09B800B23;
        Tue, 31 Jan 2023 10:15:20 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE733140EBF4;
        Tue, 31 Jan 2023 10:15:15 +0000 (UTC)
Date:   Tue, 31 Jan 2023 18:15:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Liu Xiaodong <xiaodong.liu@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jim Harris <james.r.harris@intel.com>,
        Ben Walker <benjamin.walker@intel.com>
Subject: Re: [PATCH] block: ublk: extending queue_size to fix overflow
Message-ID: <Y9jqLdZauz9mab4t@T590>
References: <20230131070552.115067-1-xiaodong.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131070552.115067-1-xiaodong.liu@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 31, 2023 at 02:05:52AM -0500, Liu Xiaodong wrote:
> When validating drafted SPDK ublk target, in a case that
> assigning large queue depth to multiqueue ublk device,
> ublk target would run into a weird incorrect state. During
> rounds of review and debug, An overflow bug was found
> in ublk driver.
> 
> In ublk_cmd.h, UBLK_MAX_QUEUE_DEPTH is 4096 which means
> each ublk queue depth can be set as large as 4096. But
> when setting qd for a ublk device,
> sizeof(struct ublk_queue) + depth * sizeof(struct ublk_io)
> will be larger than 65535 if qd is larger than 2728.
> Then queue_size is overflowed, and ublk_get_queue()
> references a wrong pointer position. The wrong content of
> ublk_queue elements will lead to out-of-bounds memory
> access.
> 
> Extend queue_size in ublk_device as "unsigned int".
> 
> Signed-off-by: Liu Xiaodong <xiaodong.liu@intel.com>
> ---
>  drivers/block/ublk_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index e54693204630..6368b56eacf1 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -137,7 +137,7 @@ struct ublk_device {
>  
>  	char	*__queues;
>  
> -	unsigned short  queue_size;
> +	unsigned int	queue_size;
>  	struct ublksrv_ctrl_dev_info	dev_info;

Good catch,

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

