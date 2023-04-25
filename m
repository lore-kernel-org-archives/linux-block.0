Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E05C77B61
	for <linux-block@archiver.kernel.org>; Tue, 25 Apr 2023 03:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjDYD24 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 23:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDYD2y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 23:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44367AA8
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 20:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682393278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lu5nPKdmZ5wIPRCc4xveR2iZye3zi2oc85Ro4BueoZA=;
        b=HR1NBbfrE8GjH4plM+vBU2zbfxmJMhl2MnYqacmjDqdOh3q42Y0LfbVNlzFlnJKeKaGrjN
        lXhBH3d/1tZiDwP1AFjFry/srwZ/w7K/iITeXUepp95YeJO/277v5I6VGHjQb4LkZ0zWoH
        Ly7u2ShyEvfTUULJnnYY+4IMamtsuXA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-975_r3XyMoyOjm9MaobL-g-1; Mon, 24 Apr 2023 23:27:57 -0400
X-MC-Unique: 975_r3XyMoyOjm9MaobL-g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9DF885C064
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 03:27:56 +0000 (UTC)
Received: from ovpn-8-24.pek2.redhat.com (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C66F492C14;
        Tue, 25 Apr 2023 03:27:54 +0000 (UTC)
Date:   Tue, 25 Apr 2023 11:27:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Changhui Zhong <czhong@redhat.com>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [bug report] BUG: kernel NULL pointer dereference, address:
 00000000000000fc
Message-ID: <ZEdItaPqif8fp85H@ovpn-8-24.pek2.redhat.com>
References: <CAGVVp+XSpFsjfzSNxLiK9SFnLvLB-W7bPHk7tySkkX95BM5BoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGVVp+XSpFsjfzSNxLiK9SFnLvLB-W7bPHk7tySkkX95BM5BoQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 25, 2023 at 10:37:05AM +0800, Changhui Zhong wrote:
> Hello,
> 
> Below issue was triggered in my test,it caused system panic ,please
> help check it.
> branch: for-6.4/block
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> 
> mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
> sgdisk -n 0:0:+100MiB /dev/md0
> cat /proc/partitions
> mdadm -S /dev/md0
> mdadm -A /dev/md0 /dev/sda /dev/sdb
> cat /proc/partitions
> 
> 
> [   34.219123] BUG: kernel NULL pointer dereference, address: 00000000000000fc
> [   34.219507] #PF: supervisor read access in kernel mode
> [   34.219784] #PF: error_code(0x0000) - not-present page
> [   34.220039] PGD 0 P4D 0
> [   34.220176] Oops: 0000 [#1] PREEMPT SMP PTI
> [   34.220374] CPU: 8 PID: 1956 Comm: systemd-udevd Kdump: loaded Not
> tainted 6.3.0-rc2+ #1
> [   34.220787] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360
> Gen9, BIOS P89 05/21/2018
> [   34.221188] RIP: 0010:blk_mq_sched_bio_merge+0x6d/0xf0

Hi Changhui,

Please try the following fix:

diff --git a/block/bdev.c b/block/bdev.c
index 850852fe4b78..fa2838ca2e6d 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -419,7 +419,11 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
        bdev->bd_inode = inode;
        bdev->bd_queue = disk->queue;
        bdev->bd_stats = alloc_percpu(struct disk_stats);
-       bdev->bd_has_submit_bio = false;
+
+       if (partno)
+               bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
+       else
+               bdev->bd_has_submit_bio = false;
        if (!bdev->bd_stats) {
                iput(inode);
                return NULL;

Fixes: 9f4107b07b17 ("block: store bdev->bd_disk->fops->submit_bio state in bdev")


Thanks, 
Ming

