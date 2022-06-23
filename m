Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19011C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiFWTAx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiFWTAa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:30 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D1A10CD3B
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:53 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id d129so151604pgc.9
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCfdY54E0YpQf9NQo2iEL3i0DfKluI5hrZD6kzUYhhs=;
        b=iq51Fr0VAxCdxLqMm7RYLumlWLUkDgmkyodgeB0e0GLxIkyO0kEVRBGlIJlJD3eH3v
         QfSTqGZkmepvy5CUkrJlG/SVnQjvt/E+yCzXbrzT/uP53CW+9wSMY+pcGD2n9i7yCoWt
         iuWpcicIhS8B614l20x9xg+ssMwlTXYPpGGJiHb+0weyFVg/vHstxi84JY3798CLfRJJ
         b9uRPKHVt0Dk7RL2vzTxFWyWOvnhwadiHz4+YLhahor2CC7DTggm04IjPzx8uD0/FKhh
         UYeOErDSX2qhPcuN4gNIZ77enR8KRhQyNc3D7dAjuPuQtWcUcReIBaIhymFaDZaiI/QW
         UECA==
X-Gm-Message-State: AJIora9tu25IH2555a/wVZsurjngznsluokjr6S/WNuqiQG6KhI5Dt0M
        wNkHcTMfR8w8ZiVP1S6mivo=
X-Google-Smtp-Source: AGRyM1szxafbZCYS6RlRWWim5d7G9WmghAD0i9A0W/cBCi+88Nft6nzqbR1DNstmPQ6zz3uOcsOkCQ==
X-Received: by 2002:a63:b1e:0:b0:3fd:43d9:5354 with SMTP id 30-20020a630b1e000000b003fd43d95354mr8530167pgl.294.1656007552472;
        Thu, 23 Jun 2022 11:05:52 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:05:51 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 12/51] block/null_blk: Fix sparse warnings in tracing code
Date:   Thu, 23 Jun 2022 11:04:49 -0700
Message-Id: <20220623180528.3595304-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the tracing infrastructure does not support bitwise types, store
the request operation as an int. This patch does not change any
functionality.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/trace.h b/drivers/block/null_blk/trace.h
index 6b2b370e786f..f79467e5310f 100644
--- a/drivers/block/null_blk/trace.h
+++ b/drivers/block/null_blk/trace.h
@@ -36,19 +36,19 @@ TRACE_EVENT(nullb_zone_op,
 	    TP_ARGS(cmd, zone_no, zone_cond),
 	    TP_STRUCT__entry(
 		__array(char, disk, DISK_NAME_LEN)
-		__field(enum req_op, op)
+		__field(int, op)
 		__field(unsigned int, zone_no)
 		__field(unsigned int, zone_cond)
 	    ),
 	    TP_fast_assign(
-		__entry->op = req_op(cmd->rq);
+		__entry->op = (__force int)req_op(cmd->rq);
 		__entry->zone_no = zone_no;
 		__entry->zone_cond = zone_cond;
 		__assign_disk_name(__entry->disk, cmd->rq->q->disk);
 	    ),
 	    TP_printk("%s req=%-15s zone_no=%u zone_cond=%-10s",
 		      __print_disk_name(__entry->disk),
-		      blk_op_str(__entry->op),
+		      blk_op_str((__force enum req_op)__entry->op),
 		      __entry->zone_no,
 		      blk_zone_cond_str(__entry->zone_cond))
 );
