Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C10C3F2CD
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 14:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04AD246AC
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 14:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="CIwTFRGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgB1Ovx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:51:53 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:47400 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726682AbgB1Ovw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 09:51:52 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id DDA3D2E236D;
        Fri, 28 Feb 2020 17:51:49 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id FxdxNCnZlJ-pnO4jPlF;
        Fri, 28 Feb 2020 17:51:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1582901509; bh=3CUipkMt+bSgia8WEU+rF0ciWlpyvyU/3asDSlZSq/Q=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=CIwTFRGLQ/zJ6YWYfz9ON1HCMbQcSRVtiNhvqAutNEWUZM/A9BGhy9QULOCiO0vp0
         4J3ED55V7lOwBB212nXyPghP04JkM4/2coc4s7OnlrvKKql91azLL+NTX8JS34MHm1
         uQPT97lTK+qUsxY1MSvGziYnfgkBn8afE2zs7vKA=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 9otU8atEIs-pnWqkOl7;
        Fri, 28 Feb 2020 17:51:49 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] block: keep bdi->io_pages in sync with max_sectors_kb for
 stacked devices
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Fri, 28 Feb 2020 17:51:48 +0300
Message-ID: <158290150891.4423.13566449569964563258.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Field bdi->io_pages added in commit 9491ae4aade6 ("mm: don't cap request
size based on read-ahead setting") removes unneeded split of read requests.

Stacked drivers do not call blk_queue_max_hw_sectors(). Instead they setup
limits of their devices by blk_set_stacking_limits() + disk_stack_limits().
Field bio->io_pages stays zero until user set max_sectors_kb via sysfs.

This patch updates io_pages after merging limits in disk_stack_limits().

Commit c6d6e9b0f6b4 ("dm: do not allow readahead to limit IO size") fixed
the same problem for device-mapper devices, this one fixes MD RAIDs.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/blk-settings.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index c8eda2e7b91e..66c45fd79545 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -664,6 +664,8 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
 		printk(KERN_NOTICE "%s: Warning: Device %s is misaligned\n",
 		       top, bottom);
 	}
+
+	t->backing_dev_info->io_pages = t->limits.max_sectors >> (PAGE_SHIFT-9);
 }
 EXPORT_SYMBOL(disk_stack_limits);
 

