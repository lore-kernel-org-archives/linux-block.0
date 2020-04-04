Return-Path: <SRS0=MH8N=5U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ADBC2BA16
	for <linux-block@archiver.kernel.org>; Sat,  4 Apr 2020 12:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A384B206F7
	for <linux-block@archiver.kernel.org>; Sat,  4 Apr 2020 12:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgDDMGu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Apr 2020 08:06:50 -0400
Received: from [106.54.107.2] ([106.54.107.2]:56984 "EHLO mail.kaowomen.cn"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgDDMGu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 4 Apr 2020 08:06:50 -0400
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Apr 2020 08:06:47 EDT
Received: by mail.kaowomen.cn (Postfix, from userid 1001)
        id E863841329; Sat,  4 Apr 2020 19:57:59 +0800 (CST)
Date:   Sat, 4 Apr 2020 19:57:59 +0800
From:   Bo YU <tsu.yubo@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuzibode@126.com, tsu.yubo@gmail.com
Subject: [PATCH -next] block/genhd: Align the label with the content of the
 /proc/partitions
Message-ID: <20200404115759.yo4u52vdzsvox6wc@kaowomen.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before the patch,cat /proc/partitions:

major minor  #blocks  name

 254        0   57671680 vda
 254        1   57670656 vda1

After the patch:

major minor   #blocks    name

254   0       57671680   vda
254   1       57670656   vda1

According to LDD3,major device maximun number is 12 bit,as it has 4 char
placeholders.minor device maximum number is 20 bit(7 char palceholders)
and keeping 10 char palceholders for blocks tag.If want to keep
palceholder's numbers dynamiclly, There is more tricks to do that.  So i
keep it simple.

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 block/genhd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 06b642b23a07..63a483cf76b9 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1151,7 +1151,7 @@ static void *show_partition_start(struct seq_file *seqf, loff_t *pos)

 	p = disk_seqf_start(seqf, pos);
 	if (!IS_ERR_OR_NULL(p) && !*pos)
-		seq_puts(seqf, "major minor  #blocks  name\n\n");
+		seq_puts(seqf, "major minor   #blocks    name\n\n");
 	return p;
 }

@@ -1172,7 +1172,7 @@ static int show_partition(struct seq_file *seqf, void *v)
 	/* show the full disk and all non-0 size partitions of it */
 	disk_part_iter_init(&piter, sgp, DISK_PITER_INCL_PART0);
 	while ((part = disk_part_iter_next(&piter)))
-		seq_printf(seqf, "%4d  %7d %10llu %s\n",
+		seq_printf(seqf, "%-4d  %-7d %-10llu %s\n",
 			   MAJOR(part_devt(part)), MINOR(part_devt(part)),
 			   (unsigned long long)part_nr_sects_read(part) >> 1,
 			   disk_name(sgp, part->partno, buf));
--
2.11.0

