Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D7EC433DF
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 07:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B7A20672
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 07:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="MjUZ6RHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgGHH72 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGHH72 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 03:59:28 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F4C08C5DC
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 00:59:28 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dg28so40856469edb.3
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 00:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DRUCw0m6MRFHAU9r2+IyC0j6NTzZrJ1siX12KTm+zWI=;
        b=MjUZ6RHWFN55P93dC82a9yD/gjsPUUjaFLqxknsxkFpTs8HUh20479lW2XamPoR2FI
         OtOVMSWPdbYgDABJ9lHKTu3pYj2UUmELnmimyBxxdcXY0LFB4snFdrNDogrrRetmh6Fe
         JghgMXENwj03syxYJWwSQ9CI/5GGE+mf+5WGlyYbCrn02wtQrji+i/brZCNmAB5AWIet
         KkIJvn74qhfXbFzCsceTSJJacji/39LyPK7pacIdyzxKGVVrjk0WCigcjRxEDlZNvT6V
         exufTaYVxHN5XXo8/FUKaXd0LXjRgCrt4q1PUDT/ROgs7ZYbcQj+hbjtYWhNIZi4jFD9
         G55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DRUCw0m6MRFHAU9r2+IyC0j6NTzZrJ1siX12KTm+zWI=;
        b=B+CZyY954pnoN4sQ52PxDjOsAjp+T1GbrtyECScUkXMyUBvnCqXJ9AvtUUxuJJiddw
         mUrkQQ5E19D6qS1dECuwGNAgYmUHsjAfQlJ2TakwwMeCFjMVSz/4MVJ9MQAf0B3kGByh
         pf1rPsqrIRJ626oYCEN4gX//8C/16jB+lmu94jWhii6xDaWjnSwv9L94MovCLBM8PRZz
         CsaFncBpvK/cTDzr3PQksePxpnT/JfTONalazfl3NPX4bKJWzB0DlbZq7HH/uPnzno2G
         iX1PAy8CwHWcwiQp2jmM74+suIEKlFCntKZOF0LdWha9tQ+RJftmLZHmTUfLuEBrR8eN
         22iQ==
X-Gm-Message-State: AOAM5331tXLOaz0uUEFer1R9/UZbWo91Ntl+76HBFjT8BV7Me9cez8Q0
        IK91d4BeByiWs3irw2aD4iWn2w==
X-Google-Smtp-Source: ABdhPJxkMrsHApw1fbNKnhEuScHZRG4PeWDQhTjeiQpB/JNKtnI/dZJGvSbDOmxWcYbABwjNHoftJQ==
X-Received: by 2002:a05:6402:1a54:: with SMTP id bf20mr65053241edb.69.1594195166763;
        Wed, 08 Jul 2020 00:59:26 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b161:f409:fd1d:3a1f])
        by smtp.gmail.com with ESMTPSA id mj22sm1570858ejb.118.2020.07.08.00.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 00:59:26 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com
Subject: [PATCH RFC 1/5] block: return ns precision from disk_start_io_acct
Date:   Wed,  8 Jul 2020 09:58:15 +0200
Message-Id: <20200708075819.4531-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
References: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently the duration accounting of bio based driver is converted from
jiffies to ns, means it could be less accurate as request based driver.

So let disk_start_io_acct return from ns precision, instead of convert
jiffies to ns in disk_end_io_acct.

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d9d632639bd1..0e806a8c62fb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1466,6 +1466,7 @@ unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 	struct hd_struct *part = &disk->part0;
 	const int sgrp = op_stat_group(op);
 	unsigned long now = READ_ONCE(jiffies);
+	unsigned long start_ns = ktime_get_ns();
 
 	part_stat_lock();
 	update_io_ticks(part, now, false);
@@ -1474,7 +1475,7 @@ unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 	part_stat_local_inc(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
-	return now;
+	return start_ns;
 }
 EXPORT_SYMBOL(disk_start_io_acct);
 
@@ -1484,11 +1485,11 @@ void disk_end_io_acct(struct gendisk *disk, unsigned int op,
 	struct hd_struct *part = &disk->part0;
 	const int sgrp = op_stat_group(op);
 	unsigned long now = READ_ONCE(jiffies);
-	unsigned long duration = now - start_time;
+	unsigned long duration = ktime_get_ns() - start_time;
 
 	part_stat_lock();
 	update_io_ticks(part, now, true);
-	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
+	part_stat_add(part, nsecs[sgrp], duration);
 	part_stat_local_dec(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 }
-- 
2.17.1

