Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542C2C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 13:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiGNNBH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 09:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbiGNNBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 09:01:06 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5545B04A
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 06:01:05 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f11so1473118pgj.7
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r/8zyWfZCvNbLpmSSP7gthGFGvc5Hlv8LoSGYxVx1nQ=;
        b=jVVC+lJtbuKGOvZkRtgpYjXpzMVxBDEk2XHZD4FADnm2dji0WUwE54qx08UWpkmxFg
         Lr7bfES+kJ4jfGmlXdtHs3jxS1HcHbTbChtBW2kKNs7HFwQu/2MFAAFPIXwcUKaRiDR8
         3TyT5fJVs9eTTJ7J4Z6GjYlLRA/9A8QDmj8qh2bXCuzyZqPtqlkc+c5rosEEdqEg9GGn
         mr+JjGjBkENWPzO1E68rNi4JcdLlEZpCNqpyks5e6eRNX/4bxANeqa2e61vAZaTvRUnG
         VbZdSQUD9wc+Y8BOqtTkNVgmSaF6IsJEfWE2HbR0kGJvrgMrUMhGcBnsPMn+uS6Nb6Q1
         /vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r/8zyWfZCvNbLpmSSP7gthGFGvc5Hlv8LoSGYxVx1nQ=;
        b=uD8mp9oiEUOKiTvTtPkjtht1S8fxN6oJS6QEPztQkH9yFCsD/R+i67lB2wvNSgpoze
         FbThKacl65vtqyz8tvrtLjYHk8McEsFHQ9rsGs+J6vNTJyN7M5UNfVjqcowsdngVVFnd
         Me2kHq2yEzqzmwjextdexeRrRN8rbnqXADVo+9O19TwPNMxTv9c1nZzW31TpyL0Dmt+y
         RZGwWlWgmzTA7eNYpyxakjETdHqxhsqEiSjqrXBhfo4ro1WU/GEx7QTibFr7pmBQkAWn
         +DrHdifLNC4c35K+J5Sy8ks4Ph70SmjRXp4H0VwuarrvvPX6oCWwErllYyoXvkeeUJH7
         LXPg==
X-Gm-Message-State: AJIora8pYQTl3VfPfcBSAbq8xnYtZTzLauyUeXF9VzWg1cpEhzj8bp6u
        50TdcocrXWkkHC6xyWd/vju8Q4ccZijfkQ==
X-Google-Smtp-Source: AGRyM1ucxXLv3oJ3FkNgOlrzes0pVUKBC+bLnQaB4f3FZs/xQz9i8DDmAjlHsieeF5B2qWkNvejb5w==
X-Received: by 2002:a65:6d1a:0:b0:3fb:2109:7b87 with SMTP id bf26-20020a656d1a000000b003fb21097b87mr7471169pgb.127.1657803661001;
        Thu, 14 Jul 2022 06:01:01 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h3-20020a63c003000000b00416018b5bbbsm1271156pgg.76.2022.07.14.06.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 06:01:00 -0700 (PDT)
Message-ID: <47f6931d-5bb3-bc7e-51db-ef2e9d54d01b@kernel.dk>
Date:   Thu, 14 Jul 2022 07:00:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ublk_drv: fix request queue leak
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20220714103201.131648-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220714103201.131648-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/14/22 4:32 AM, Ming Lei wrote:
> Call blk_cleanup_queue() in release code path for fixing request
> queue leak.
> 
> Also for-5.20/block has cleaned up blk_cleanup_queue(), which is
> basically merged to del_gendisk() if blk_mq_alloc_disk() is used
> for allocating disk and queue.
> 
> However, ublk may not add disk in case of starting device failure, then
> del_gendisk() won't be called when removing ublk device, so blk_mq_exit_queue
> will not be callsed, and it can be bit hard to deal with this kind of
> merge conflict.
> 
> Turns out ublk's queue/disk use model is very similar with scsi, so switch
> to scsi's model by allocating disk and queue independently, then it can be
> quite easy to handle v5.20 merge conflict by replacing blk_cleanup_queue
> with blk_mq_destroy_queue.

Tried this with the below incremental added to make it compile with
the core block changes too, and it still fails for me:

[   22.488660] WARNING: CPU: 0 PID: 11 at block/blk-mq.c:3880 blk_mq_release+0xa4/0xf0
[   22.490797] Modules linked in:
[   22.491762] CPU: 0 PID: 11 Comm: kworker/0:1 Not tainted 5.19.0-rc6-00322-g42ed61fe42f3-dirty #1609
[   22.494659] Hardware name: linux,dummy-virt (DT)
[   22.496171] Workqueue: events blkg_free_workfn
[   22.497652] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   22.499965] pc : blk_mq_release+0xa4/0xf0
[   22.501386] lr : blk_mq_release+0x44/0xf0
[   22.502748] sp : ffff80000af73cb0
[   22.503880] x29: ffff80000af73cb0 x28: 0000000000000000 x27: 0000000000000000
[   22.506263] x26: 0000000000000000 x25: ffff00001fe47b05 x24: 0000000000000000
[   22.508655] x23: ffff0000052b6cb8 x22: ffff0000031e1c38 x21: 0000000000000000
[   22.511035] x20: ffff0000031e1cf0 x19: ffff0000031e1bf0 x18: 0000000000000000
[   22.513427] x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffa8000b80
[   22.515814] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000001
[   22.518209] x11: ffff80000945b7e8 x10: 0000000000006cb9 x9 : 00000000ffffffff
[   22.520600] x8 : ffff800008fb5000 x7 : ffff80000860cf28 x6 : 0000000000000000
[   22.522987] x5 : 0000000000000000 x4 : 0000000000000028 x3 : ffff80000af73c14
[   22.525363] x2 : ffff0000071ccaa8 x1 : ffff0000071ccaa8 x0 : ffff0000071cc800
[   22.527624] Call trace:
[   22.528473]  blk_mq_release+0xa4/0xf0
[   22.529724]  blk_release_queue+0x58/0xa0
[   22.530946]  kobject_put+0x84/0xe0
[   22.531821]  blk_put_queue+0x10/0x18
[   22.532716]  blkg_free_workfn+0x58/0x84
[   22.533681]  process_one_work+0x2ac/0x438
[   22.534872]  worker_thread+0x1cc/0x264
[   22.535829]  kthread+0xd0/0xe0
[   22.536598]  ret_from_fork+0x10/0x20


diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index eeeac43e1dc1..d818da818c00 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1078,7 +1078,7 @@ static void ublk_cdev_rel(struct device *dev)
 {
 	struct ublk_device *ub = container_of(dev, struct ublk_device, cdev_dev);
 
-	blk_cleanup_queue(ub->ub_queue);
+	blk_put_queue(ub->ub_queue);
 
 	put_disk(ub->ub_disk);
 
@@ -1174,8 +1174,8 @@ static int ublk_add_dev(struct ublk_device *ub)
 		goto out_cleanup_tags;
 	ub->ub_queue->queuedata = ub;
 
-	disk = ub->ub_disk = __alloc_disk_node(ub->ub_queue, NUMA_NO_NODE,
-			&ublk_bio_compl_lkclass);
+	disk = ub->ub_disk = blk_mq_alloc_disk_for_queue(ub->ub_queue,
+						 &ublk_bio_compl_lkclass);
 	if (IS_ERR(disk)) {
 		err = PTR_ERR(disk);
 		goto out_free_request_queue;
@@ -1212,7 +1212,7 @@ static int ublk_add_dev(struct ublk_device *ub)
 	return 0;
 
 out_free_request_queue:
-	blk_cleanup_queue(ub->ub_queue);
+	blk_put_queue(ub->ub_queue);
 out_cleanup_tags:
 	blk_mq_free_tag_set(&ub->tag_set);
 out_deinit_queues:


-- 
Jens Axboe

