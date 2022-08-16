Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C859C2BB41
	for <linux-block@archiver.kernel.org>; Tue, 16 Aug 2022 06:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiHPG6P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Aug 2022 02:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiHPG5w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Aug 2022 02:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 206681D18FA
        for <linux-block@vger.kernel.org>; Mon, 15 Aug 2022 20:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660618889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DQD7QPgLqK8iEFwgC16M0tkJqhc3twUkG42+1MolP6U=;
        b=EqRuLZ7K76ClhLBYqr5mCTBpQY86VSNKT7+OiX5WtGVAv/29w2lH/uYrUom39F028G3m+P
        oZCZtUGEfHKfK/ZoMBpoVLGeQRNBIHtcS43RzbTIZvwcE0vV28IacjTjFXCG/eypfrLP6W
        777mD9ouGEYfqB26EA4AvaQEw3djphQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-cHgfgqppMLmaknLTMFCN_Q-1; Mon, 15 Aug 2022 23:01:26 -0400
X-MC-Unique: cHgfgqppMLmaknLTMFCN_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7993685A581;
        Tue, 16 Aug 2022 03:01:25 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DFCA9458A;
        Tue, 16 Aug 2022 03:01:20 +0000 (UTC)
Date:   Tue, 16 Aug 2022 11:01:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH V2 2/3] ublk_drv: update comment for __ublk_fail_req()
Message-ID: <YvsIeo/Cb9R6xItd@T590>
References: <20220815023633.259825-1-ZiyangZhang@linux.alibaba.com>
 <20220815023633.259825-3-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815023633.259825-3-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 15, 2022 at 10:36:32AM +0800, ZiyangZhang wrote:
> Since __ublk_rq_task_work always fails requests immediately during
> exiting, __ublk_fail_req() is only called from abort context during
> exiting. So lock is unnecessary.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 17896172b0fe..685a43b7ae6e 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -605,8 +605,9 @@ static void ublk_complete_rq(struct request *req)
>  }
>  
>  /*
> - * __ublk_fail_req() may be called from abort context or ->ubq_daemon
> - * context during exiting, so lock is required.
> + * Since __ublk_rq_task_work always fails requests immediately during
> + * exiting, __ublk_fail_req() is only called from abort context during
> + * exiting. So lock is unnecessary.
>   *
>   * Also aborting may not be started yet, keep in mind that one failed
>   * request may be issued by block layer again.
> -- 
> 2.27.0
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

