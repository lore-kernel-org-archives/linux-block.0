Return-Path: <SRS0=zlmp=6K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93930C54FD0
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 12:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA9920700
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 12:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIYrkagM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDZMWy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Apr 2020 08:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgDZMWy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 08:22:54 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EA7C061A0E;
        Sun, 26 Apr 2020 05:22:54 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k18so5790734pll.6;
        Sun, 26 Apr 2020 05:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4S8zgV7XFaPRlIUcL6FdOxo2c6BERJKn7P5owdMD51w=;
        b=UIYrkagM8A+vY0jCDIzlzjcYA3gn1/9l36CcVVkpsh2vq2kD3S54r/eGwl8mZxChCn
         FvPULi7I89o3uQrS1llT7ul9kIrJIK8JsHLmKEZTG80QNiu7QCEtHMkQ/NmHvwN/moeT
         w78EMsaImenuhFvTd7N6PTNjTpMsRym9zYaQh1PFf/Dqdjgol6OFK8+hiWbRc+KFm676
         DwMFu6uWOfr0fa+gz6uTjnY4A2xG9VHYUG3qGw4TkifrPrHVM5oKb1WWXLXbycVKGNqU
         sPKUcpAMQvVjvjLwcIYhhBWbZSTi2SWQndW/3WP5lzWxVN/ibfo4oF0doctX/T268jNU
         o4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4S8zgV7XFaPRlIUcL6FdOxo2c6BERJKn7P5owdMD51w=;
        b=XV6uIkPn0c3rpYokxiWgs0kpPWlrLwpRLtWaeadb8kJKC2eu3DPZmlpzs4S8BlSTru
         Dle37RBqFnr2+4Kqvp+4CQIWG5ybrE2mqgZ6RirhOvs/FfA1Op2AfXWCYF6WT4p3wVWo
         wkg+/S6z4eKAIpfMHyKKcm5bzeN9JwQOJaEZY7UqWO+1NWg5bZ8KVYVXWHWumgxU2YCG
         8OwNX409QRtLEg2Ns50qAELyE9mU88B0gwZ9osdobopvZiN2JTn8WTbpa1X3m+f3S52l
         5SGYItXgqP+xG86R8nQ0qscWYPhmv+9T/+M9BzvHYWwpVLd+0vW5/Q9VXAM7JqvwylQ0
         3uow==
X-Gm-Message-State: AGi0PuaisWsrrIdk5ddT8OriAb24M2sXtrHBMoNGTj9R/zgbPOyMDZe3
        cw0qbjKVokg9F0XbDyUZN0k=
X-Google-Smtp-Source: APiQypL9ctpEP1iqDyJ1Hld+OLaScFvnWLGgjEdQgr1I3xLriI/KIOSCHlB6o9Q0wE4Jj9kurhLVSQ==
X-Received: by 2002:a17:90a:fd89:: with SMTP id cx9mr17229092pjb.64.1587903773587;
        Sun, 26 Apr 2020 05:22:53 -0700 (PDT)
Received: from debian.debian-2 ([154.223.71.61])
        by smtp.gmail.com with ESMTPSA id gl4sm9265433pjb.42.2020.04.26.05.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Apr 2020 05:22:52 -0700 (PDT)
Date:   Sun, 26 Apr 2020 20:22:45 +0800
From:   Bo YU <tsu.yubo@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next] block/genhd: align title and output
Message-ID: <20200426122237.j2ah64uoivp26ioj@debian.debian-2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before the patch:

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

