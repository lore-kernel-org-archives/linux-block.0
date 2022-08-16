Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949CCC2BB41
	for <linux-block@archiver.kernel.org>; Tue, 16 Aug 2022 06:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiHPG5n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Aug 2022 02:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiHPG5S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Aug 2022 02:57:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 453371DB14C
        for <linux-block@vger.kernel.org>; Mon, 15 Aug 2022 20:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660618967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=boevX/q+ztSlBdilhp2Gzk2aT8iYMMM3yaEx9boiakw=;
        b=amMIbuc6+FFp3NHBDaB/6f5Mf1/yNrqtEIELYpdO9MnxpW9TpZwc48j0f/j+YiVb9Ly0lu
        XnysqkgYB1wk//D8ObSLi+UmWJnXdcIqELtEdLo5T4ENOtJoodJO61eMqvIOrE2ixgXG3J
        ieAaH4I7sleo/UEq2uVlIlYbusie6Pg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-COZ8vY0INk27cDVSyIHoeQ-1; Mon, 15 Aug 2022 23:02:43 -0400
X-MC-Unique: COZ8vY0INk27cDVSyIHoeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E51D8032FB;
        Tue, 16 Aug 2022 03:02:43 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F1192026D4C;
        Tue, 16 Aug 2022 03:02:38 +0000 (UTC)
Date:   Tue, 16 Aug 2022 11:02:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH V2 3/3] ublk_drv: do not add a re-issued request aborted
 previously to ioucmd's task_work
Message-ID: <YvsIxlulhyam3Z0j@T590>
References: <20220815023633.259825-1-ZiyangZhang@linux.alibaba.com>
 <20220815023633.259825-4-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815023633.259825-4-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 15, 2022 at 10:36:33AM +0800, ZiyangZhang wrote:
> In ublk_queue_rq(), Assume current request is a re-issued request aborted
> previously in monitor_work because the ubq_daemon(ioucmd's task) is
> PF_EXITING. For this request, we cannot call
> io_uring_cmd_complete_in_task() anymore because at that moment io_uring
> context may be freed in case that no inflight ioucmd exists. Otherwise,
> we may cause null-deref in ctx->fallback_work.
> 
> Add a check on UBLK_IO_FLAG_ABORTED to prevent the above situation. This
> check is safe and makes sense.
> 
> Note: monitor_work sets UBLK_IO_FLAG_ABORTED and ends this request
> (releasing the tag). Then the request is restarted(allocating the tag)
> and we are here. Since releasing/allocating a tag implies smp_mb(),
> finding UBLK_IO_FLAG_ABORTED guarantees that here is a re-issued request
> aborted previously.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

