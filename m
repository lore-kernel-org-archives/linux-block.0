Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA87C5B578
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 21:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D7521479
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 21:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OBA5OPaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfGAV5u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:57:50 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:49962 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGAV5u (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 17:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562018270; x=1593554270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=9J1OfplonnbynoEAMgNYcUvjFmcuTdb/IR5OisFEtak=;
  b=OBA5OPaSvE7ob8A+CYYmji9v3XLt7jWagLW/nMNdbEh798bIOjCW+Jlp
   xd4LHxcdSxCuPcml4+fVTO+sv7U1xD04q/plHxyGn8ZZ4KbFAQgclZUst
   cYQBrKnpLOzJ12GpLTkppAADIk/nimc0+47lGpPUjYNfs8m0H2Yck1pQc
   AY7QdBXvVSOFPMuQ60egEdJQizsb7xPT3msyjQhbYwqOxlAX8VICaduYk
   WAaKTkyq3MJbUN3kfa3YaONPjdfYN8Un/T8fUH1tRdkcfzLsLnKwTibYg
   NAoWVN22g34AB20v9/ClSyaJSSfgjuwhaufUQq3o2X/Kn6yFmJM6jl7XF
   g==;
X-IronPort-AV: E=Sophos;i="5.63,440,1557158400"; 
   d="scan'208";a="113614919"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2019 05:57:50 +0800
IronPort-SDR: y3GDar/WQhP6iyjZiGCCQWrinmOvFnEb/KLly0HKWFMMcVaAJjnJcL6akAMj5zt653pvGkwF3x
 fjbeSDeGsOsUnL03OMz5TeTuoVga0JONjAmIge81e4uTGAo2/xzntqzDHCK1BLVk4gfJq3MiNP
 w2+WUJwJLl0oA1JBHa5dkvd2rf5RLNvuBeC6Whv6XK5ogG4fqCNTxBM6f3NZdE8emKPGSZAfvk
 y1R36f+8QYil4UBVNPkddDPPjdQPwrPrH1qkQ7WsJtIhBjKq91kEE+0o4qoaNKMETbkKVD62Kf
 ASLpWwOHWrHe4PKnoCrb5hwj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 01 Jul 2019 14:56:50 -0700
IronPort-SDR: RUT0zDud5mdeTiDe1oPpuNFjDkJ3uuMy6naMhD7jlFJOo5Lx94cNdS/Nkt7n9zdRsqDaX8I6aS
 kpaO5xs/asgCHLZQqRzj68/bAQY1ftPJ1LuuI+Mm0adufqE1zU2V1QalNgVa5v+cw+tQbBCrsx
 z5HtwnIeWwhelc9wuGhNRmFmJqPGDwu9W68q3GBRjOdrZ8nIYKVL2ZoE53gzE6nYvBvV79r5Oi
 iHsMW4+fL3q2Caum4SGUrUHvk/O18aCQYKP5YevyAbm4yOdXJpq0lIPCo89V0C6rqMGJesnYkn
 MW0=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Jul 2019 14:57:50 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-mm@kvack.org, linux-block@vger.kernel.org
Cc:     bvanassche@acm.org, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/5] block: update error message in submit_bio()
Date:   Mon,  1 Jul 2019 14:57:23 -0700
Message-Id: <20190701215726.27601-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190701215726.27601-1-chaitanya.kulkarni@wdc.com>
References: <20190701215726.27601-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The existing code in the submit_bio() relies on the op_is_write().
op_is_write() checks for the last bit in the bio_op() and we only
print WRITE or READ as a bio_op().

It is hard to understand which bio op based on READ/WRITE in
submit_bio() with addition of newly discussed REQ_OP_XXX. [1]

Modify the error message in submit_bio() to print correct REQ_OP_XXX
with the help of blk_op_str().

[1] https://www.spinics.net/lists/linux-block/msg41884.html. 

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 47c8b9c48a57..5143a8e19b63 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1150,7 +1150,7 @@ blk_qc_t submit_bio(struct bio *bio)
 			char b[BDEVNAME_SIZE];
 			printk(KERN_DEBUG "%s(%d): %s block %Lu on %s (%u sectors)\n",
 			current->comm, task_pid_nr(current),
-				op_is_write(bio_op(bio)) ? "WRITE" : "READ",
+				blk_op_str(bio_op(bio)),
 				(unsigned long long)bio->bi_iter.bi_sector,
 				bio_devname(bio, b), count);
 		}
-- 
2.21.0

