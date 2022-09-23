Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DAEECAAD8
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 03:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiIWDDk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 23:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiIWDDL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 23:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5FE11CB21
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 20:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663902118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mOUbwOVwoS4tvADVKdclHC5ioKuaABY326oj+/kvkPI=;
        b=CD1TNY2QPAnrvB/+5BtdBgROioSLOM7naN+pKOSu9tRcM3HzKCSdPZnc2JUGgWq4Ku2m4P
        snBtIER2K/lYwRrkkW4Pca0l1sxNGpyWXQrW9+K+bS5i4Vq5LSA+fjOpXHyQwFeauVIcCF
        P4iYawMFIYB/CszEslBiSOayaLLAi8Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-8jqRBZQ_P3G2OSyJ5Uu1EQ-1; Thu, 22 Sep 2022 23:01:47 -0400
X-MC-Unique: 8jqRBZQ_P3G2OSyJ5Uu1EQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E637E101E14F;
        Fri, 23 Sep 2022 03:01:46 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F23FB2024CBB;
        Fri, 23 Sep 2022 03:01:42 +0000 (UTC)
Date:   Fri, 23 Sep 2022 11:01:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH V5 2/7] ublk_drv: define macros for recovery feature and
 check them
Message-ID: <Yy0hkf3lWWxfSzmN@T590>
References: <20220922061734.21625-1-ZiyangZhang@linux.alibaba.com>
 <20220922061734.21625-3-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922061734.21625-3-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 22, 2022 at 02:17:29PM +0800, ZiyangZhang wrote:
> Define some macros for recovery feature.
> 
> UBLK_S_DEV_QUIESCED implies that ublk_device is quiesced
> and is ready for recovery. This state can be observed by userspace.
> 
> UBLK_F_USER_RECOVERY implies that:
> (1) ublk_drv enables recovery feature. It won't let monitor_work to
>     automatically abort rqs and release the device.
> (2) With a dying ubq_daemon, ublk_drv ends(aborts) rqs issued to
>     userspace(ublksrv) before crash.
> (3) With a dying ubq_daemon, in task work and ublk_queue_rq(),
>     ublk_drv requeues rqs.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

