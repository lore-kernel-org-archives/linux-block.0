Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32BEC433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 01:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB6E60F70
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 01:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbhJZBSo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 21:18:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58103 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235244AbhJZBSn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 21:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635210980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jfiPujvajSt/Eqv/RmBTO+98PuBtkyX6dQIgXln24os=;
        b=BDoerQDmTPXGrcYxyFzd/g4SimMLz/RyxxzDh2bgMBiT3StW27x4jqb/b6vxJBxxf6M49z
        NYl2DC/Oj9ly6abLaXbvmj4renr/d2Hn1OUBnZ+LDAOVpj5Q96qTPd7LZHS429vJ8YX8+Z
        h2Bty6YrcZdZaCygyFJoa2HMWVLFbM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-MXMeZOZmOpSKBFY7l5OBSg-1; Mon, 25 Oct 2021 21:16:18 -0400
X-MC-Unique: MXMeZOZmOpSKBFY7l5OBSg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D21AB1006ADE
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 01:15:59 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF1E560CA1;
        Tue, 26 Oct 2021 01:15:56 +0000 (UTC)
Date:   Tue, 26 Oct 2021 09:15:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        skt-results-master@redhat.com, ming.lei@redhat.com
Subject: Re: [bug report] WARNING: CPU: 109 PID: 739473 at
 block/blk-stat.c:218 blk_free_queue_stats+0x3c/0x80
Message-ID: <YXdWx2oDmKJBRsBa@T590>
References: <CAHj4cs9w7_thDw-DN11GaoA+HH9YVAMHmrAZhi_rA24xhbTYOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs9w7_thDw-DN11GaoA+HH9YVAMHmrAZhi_rA24xhbTYOA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 12:13:22PM +0800, Yi Zhang wrote:
> Hello
> Below WARNING was triggered with blktests block/001 on ppc64le/aarch64
> during CKI tests, pls help check it, thanks.
> 
>   Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>             Commit: b199567fe754 - Merge branch 'for-5.16/bdev-size'
> into for-next
> 

Hello Yi,

Can you try the following patch?


diff --git a/block/genhd.c b/block/genhd.c
index 80943c123c3e..45143af78d90 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -589,16 +589,6 @@ void del_gendisk(struct gendisk *disk)
 	 * Prevent new I/O from crossing bio_queue_enter().
 	 */
 	blk_queue_start_drain(q);
-	blk_mq_freeze_queue_wait(q);
-
-	rq_qos_exit(q);
-	blk_sync_queue(q);
-	blk_flush_integrity();
-	/*
-	 * Allow using passthrough request again after the queue is torn down.
-	 */
-	blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
-	__blk_mq_unfreeze_queue(q, true);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
@@ -621,6 +611,18 @@ void del_gendisk(struct gendisk *disk)
 		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
 	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
 	device_del(disk_to_dev(disk));
+
+	blk_mq_freeze_queue_wait(q);
+
+	rq_qos_exit(q);
+	blk_sync_queue(q);
+	blk_flush_integrity();
+	/*
+	 * Allow using passthrough request again after the queue is torn down.
+	 */
+	blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
+	__blk_mq_unfreeze_queue(q, true);
+
 }
 EXPORT_SYMBOL(del_gendisk);
 


-- 
Ming

