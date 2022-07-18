Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AEAC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 12:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiGRMWf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 08:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiGRMWc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 08:22:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C42A8252A5
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 05:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658146946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bvxF+1nm4ejzx/oywUSDx+mIwnBOp0e1gFt2K3gvk8U=;
        b=bsOGmUEm4ShqCtAReHe2rMN9UwdOJ+uXgkDdnEIlXOBUH4D6idPXl1ZHS41d0IfWs1FUb8
        XMgn+EKufdNNh5SZ0mTKjzEnhH42ZmWD8RpANltaDTmGl3ZvPZE5HN9Y0jck17SXTaJHi9
        gRVpBbcvmI4HBp3A+/c3JTIeLheXjug=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-nO59eXNaMdm_2xTcEfERVA-1; Mon, 18 Jul 2022 08:22:25 -0400
X-MC-Unique: nO59eXNaMdm_2xTcEfERVA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC6532919EB7;
        Mon, 18 Jul 2022 12:22:24 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D5D72026D64;
        Mon, 18 Jul 2022 12:22:20 +0000 (UTC)
Date:   Mon, 18 Jul 2022 20:22:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 2/3] ublk_drv: uninitialized error code in
 ublk_ctrl_get_queue_affinity()
Message-ID: <YtVQdxZCXID2eWXH@T590>
References: <YtVAijzg2MTzfMnh@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtVAijzg2MTzfMnh@kili>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 18, 2022 at 02:14:18PM +0300, Dan Carpenter wrote:
> Initialize the "ret" variable so we don't return uninitialized data if
> ublk_get_device_from_id() fails.
> 
> Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/block/ublk_drv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 97725d13e4bd..c0f9a5b4ed58 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1298,13 +1298,12 @@ static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
>  	struct ublk_device *ub;
>  	unsigned long queue;
>  	unsigned int retlen;
> -	int ret;
> +	int ret = -EINVAL;

This one has been fixed in for-5.20/block by "ublk_drv: fix build warning with
-Wmaybe-uninitialized and one sparse warning".


Thanks,
Ming

