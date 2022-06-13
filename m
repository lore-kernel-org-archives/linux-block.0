Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A83AC433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Jun 2022 16:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiFMQfg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jun 2022 12:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244374AbiFMQep (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jun 2022 12:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3DA82E695
        for <linux-block@vger.kernel.org>; Mon, 13 Jun 2022 07:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655130220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/omQrhtKCh0gY0pTreoozcYZAMAMovcyZBqWjqmq8hc=;
        b=EoY/EBsfq9xOkIymQCpBade9IL3JxWMUzOyGK+JPVAwNzpAmwRhVXWSPymOiVeS0RZJFjm
        eAqj2/UG3o/RlS0LHv9ASpbxemsIFjpfdjEhKMPnF3OmzDACOc82WdTy+5n6eHV/XVmZ8W
        lTClyvzju/IZfbQ8Qud0nnU0bYXLXGY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-rrIBOTmpPZO2IYVSWlTIng-1; Mon, 13 Jun 2022 10:23:28 -0400
X-MC-Unique: rrIBOTmpPZO2IYVSWlTIng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D29418E5388;
        Mon, 13 Jun 2022 14:23:28 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07B1AC28118;
        Mon, 13 Jun 2022 14:23:25 +0000 (UTC)
Date:   Mon, 13 Jun 2022 22:23:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] kmemleak observed from blktests on latest
 linux-block/for-next
Message-ID: <YqdIWcgnEylFuSci@T590>
References: <CAHj4cs8iJPnQ+zGHNTapR9HWMk9nBXUPbhYi5k-vKZf4qRmz_A@mail.gmail.com>
 <YqavC8hwLXwPVnor@T590>
 <CAHj4cs8y5HHYjr0FtWm1AmkEY=ZqOL4OmgzrWBEhbRpu5V8dWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs8y5HHYjr0FtWm1AmkEY=ZqOL4OmgzrWBEhbRpu5V8dWA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 13, 2022 at 09:08:11PM +0800, Yi Zhang wrote:
> Hi Ming
> 
> The kmemleak also can be reproduced on 5.19.0-rc2, pls try to enable
> nvme_core multipath and retest.
> 
> # cat /sys/module/nvme_core/parameters/multipath
> Y
>

OK, I can understand the reason now since rqos is only removed for blk-mq queue,
then rqos allocated for bio queue is leaked, see disk_release_mq().

The following patch should fix it:

diff --git a/block/genhd.c b/block/genhd.c
index 556d6e4b38d9..6e7ca8c302aa 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1120,9 +1120,10 @@ static const struct attribute_group *disk_attr_groups[] = {
 	NULL
 };
 
-static void disk_release_mq(struct request_queue *q)
+static void disk_release_queue(struct request_queue *q)
 {
-	blk_mq_cancel_work_sync(q);
+	if (queue_is_mq(q))
+		blk_mq_cancel_work_sync(q);
 
 	/*
 	 * There can't be any non non-passthrough bios in flight here, but
@@ -1166,8 +1167,7 @@ static void disk_release(struct device *dev)
 	might_sleep();
 	WARN_ON_ONCE(disk_live(disk));
 
-	if (queue_is_mq(disk->queue))
-		disk_release_mq(disk->queue);
+	disk_release_queue(disk->queue);
 
 	blkcg_exit_queue(disk->queue);
 

Thanks,
Ming

