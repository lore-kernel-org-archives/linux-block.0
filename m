Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37644C433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 12:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380702AbhLCMLM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 07:11:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380698AbhLCMLK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Dec 2021 07:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638533266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A+aL4b1qbG6ce9e16aJ2C0tZTa3iGfgtYcVuUqFE1/0=;
        b=EcefwPCIL43B2iHwkY37EjOCe/wL6zpuaR54R9RdGnS0oFaLu4Giv0AW0P8mWaeeXjYzd5
        wX2iawf0P0TCg1inth0xSqPbaWZcgmR2Jjo3FSxe88gclDWPVZwOS6cndxfvI2tyEVOnum
        /i/xJ12eiu6q+SnWjaq246BDQtosiac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-Zdv-eWcrNLqZc0seP5QygA-1; Fri, 03 Dec 2021 07:07:42 -0500
X-MC-Unique: Zdv-eWcrNLqZc0seP5QygA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4F1B1023F50;
        Fri,  3 Dec 2021 12:07:41 +0000 (UTC)
Received: from T590 (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2ACF47944B;
        Fri,  3 Dec 2021 12:07:09 +0000 (UTC)
Date:   Fri, 3 Dec 2021 20:07:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: allow zero poll queues
Message-ID: <YaoIaAMSut0UGhy1@T590>
References: <20211203023935.3424042-1-ming.lei@redhat.com>
 <20211203100133.gdut65jrb6z6eodr@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203100133.gdut65jrb6z6eodr@shindev>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Shinichiro,

On Fri, Dec 03, 2021 at 10:01:33AM +0000, Shinichiro Kawasaki wrote:
> On Dec 03, 2021 / 10:39, Ming Lei wrote:
> > There isn't any reason to not allow zero poll queues from user
> > viewpoint.
> > 
> > Also sometimes we need to compare io poll between poll mode and irq
> > mode, so not allowing poll queues is bad.
> > 
> > Fixes: 15dfc662ef31 ("null_blk: Fix handling of submit_queues and poll_queues attributes")
> > Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Hi Ming,
> 
> It is good to know that the zero poll queues is useful. Having said that, I
> observe zero division error [1] with your patch and the commands below. Don' we
> need some more code changes to avoid the error?
> 
> # modprobe null_blk
> # cd /sys/kernel/config/nullb
> # mkdir test
> # echo 0 > test/poll_queues
> # echo 1 > test/power
> Segmentation fault

I guess the following change may fix the error:

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 20534a2daf17..96c55d06401d 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1892,7 +1892,7 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 	if (g_shared_tag_bitmap)
 		set->flags |= BLK_MQ_F_TAG_HCTX_SHARED;
 	set->driver_data = nullb;
-	if (g_poll_queues)
+	if (poll_queues)
 		set->nr_maps = 3;
 	else
 		set->nr_maps = 1;




Thanks,
Ming

