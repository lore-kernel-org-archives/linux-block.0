Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BF1C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiFWTCE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiFWTBr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:47 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3E910FA44
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:56 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id c4so2631707plc.8
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnE/YgHw2EtnT+Jh86RbozgbnpRo/XT0jIlRtsTryeI=;
        b=tx9iUthFYoGqPek20anf1HBQ3wynnyPwn572hKAw4sDaIuhlTI5lnhJ9Vj/Z4FDFb+
         tvHh6ls8C4KEjtJY78zc6INpHiG79lD7OfGcsByyQ6wexixN4wZihxFNEBLL5tTUhg0S
         0bPOSfdZR8d+92zqHwXLHDVt9o24DRTXNSakwIzQcnc5YdM5BIMocuOyS2dtyO+QqwdO
         0/NPzWamUBHkLA41nEY6EWSZ8RXN1MY5FBPVO7y6QEIe1CfxqHhIvxXrkL7Z2xnnC1W5
         FDX0D7UedPS16VaKBjg9V+5dD8SVb34j7RW02rto8AlbI88f7yo4DJNl+UXXG17gl1w5
         uaaA==
X-Gm-Message-State: AJIora9nfa+gInQLBx8jPwcyirHerVg0d5SBZijQZbbl1CRfy1M0tThb
        cjI3I013rc0tuQc3AeFMPy8=
X-Google-Smtp-Source: AGRyM1tAYewKTneU/+C8hYri0jY6hO1rRRpJkGdGDJVQmCETpyEQjqo2/wM3H61jjxW1OZ9vTa1GiA==
X-Received: by 2002:a17:902:ec83:b0:16a:3029:a44 with SMTP id x3-20020a170902ec8300b0016a30290a44mr17907037plg.141.1656007615605;
        Thu, 23 Jun 2022 11:06:55 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:55 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 51/51] fs/zonefs: Fix sparse warnings in tracing code
Date:   Thu, 23 Jun 2022 11:05:28 -0700
Message-Id: <20220623180528.3595304-52-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since __bitwise types are not supported by the tracing infrastructure, store
the operation type as an int in the tracing event.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Cc: Johannes Thumshirn <jth@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/zonefs/trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h
index 21501da764bd..8707e1c3023c 100644
--- a/fs/zonefs/trace.h
+++ b/fs/zonefs/trace.h
@@ -32,15 +32,15 @@ TRACE_EVENT(zonefs_zone_mgmt,
 	    TP_fast_assign(
 			   __entry->dev = inode->i_sb->s_dev;
 			   __entry->ino = inode->i_ino;
-			   __entry->op = op;
+			   __entry->op = (__force int)op;
 			   __entry->sector = ZONEFS_I(inode)->i_zsector;
 			   __entry->nr_sectors =
 				   ZONEFS_I(inode)->i_zone_size >> SECTOR_SHIFT;
 	    ),
 	    TP_printk("bdev=(%d,%d), ino=%lu op=%s, sector=%llu, nr_sectors=%llu",
 		      show_dev(__entry->dev), (unsigned long)__entry->ino,
-		      blk_op_str(__entry->op), __entry->sector,
-		      __entry->nr_sectors
+		      blk_op_str((__force enum req_op)__entry->op),
+		      __entry->sector, __entry->nr_sectors
 	    )
 );
 
