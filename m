Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AD5C77B72
	for <linux-block@archiver.kernel.org>; Fri, 14 Apr 2023 13:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDNNtK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Apr 2023 09:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjDNNtG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2023 09:49:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F91FB45A
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2023 06:48:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a66895aafdso1749925ad.0
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2023 06:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681480131; x=1684072131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmSiKXqvz00zYDgU054mNL1FXOdFpcNC0+3TAl/31Ms=;
        b=pEG0fGbSAa50b7bmERp/Sh2M05tS9uI8wqHyWfMCYiNyKKD7JOIpIGh4fAhE9UKA2r
         Fj5DYBTDX9paTVnhV695vx+pDDGljTh0QNJv5vuhj+3CMmWhJhgja7UVRkYg5k1zof9H
         XXfz02TgkSQkr7j5w4Uq+7EZyzaXn4t2E6jwTMR2uudsZ34YGHMCwAnDZ1Vs0AE8pcF9
         AlrHu9syuWk0qgBQrQgM0ASP7kP8/wWA1/Alv5Awat/LJBe8bQVo4UgFVXGRexKCK/j7
         WGTvDYtLEWWFfXtHC1cztPSMM10C/tblKm3AmUWQx6StCMVK8zBOaqHRtKBn+mrjhJMV
         8DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681480131; x=1684072131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmSiKXqvz00zYDgU054mNL1FXOdFpcNC0+3TAl/31Ms=;
        b=BzIKYRgDYpUUglOvIRaqsP4MJSyCTB2bVqvkPPPyOcpJAEXFMXVsimmYjzN8VpVEgn
         nuka3pF8V5pee1PVKRN4DTtk6xdITC5m0JNYGjo3Oa1B98QaPa1F6spEzAtsjb+BkZDT
         HYQTbhsO1bSXrXbmE0ICTdJ0CKFK8oBgCSDiKoZ08nico4foVkrIsSs7gGwOqFVrdpPe
         0GudF8Jwt+iEFya86flvqXOWRc0S0hGzJ3RtCJzWoVdFNVa2V5LkB6eVYGgqyjTxyNeX
         P3DQXAMBFB08EOgkahpqoH2h8fi4xUe1123eddCYNcryN03aTPgz7jcgVPQxbxWmE/aF
         /AsQ==
X-Gm-Message-State: AAQBX9eFVIRvI83uwXpTUxbOKRUBIC7wepyC28MOwhgizQAnHH/nYn1I
        pzb6Ay436KX8Ns8slJqD3ucoUWSaRiP0blntaD8=
X-Google-Smtp-Source: AKy350acYjSMpHhwcPj5V3g2LtPa1wzhvDzI4EPPACCJ8AGomPb0VyBjeo00MLefK6qrTOmrAKSmbQ==
X-Received: by 2002:a17:902:d482:b0:1a6:93cc:924b with SMTP id c2-20020a170902d48200b001a693cc924bmr3078928plg.3.1681480131486;
        Fri, 14 Apr 2023 06:48:51 -0700 (PDT)
Received: from localhost.localdomain (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902ee5400b001a19bac463fsm3098980plo.42.2023.04.14.06.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 06:48:51 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] block: re-arrange the struct block_device fields for better layout
Date:   Fri, 14 Apr 2023 07:48:47 -0600
Message-Id: <20230414134848.91563-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414134848.91563-1-axboe@kernel.dk>
References: <20230414134848.91563-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This moves struct device out-of-line as it's just used at open/close
time, so we can keep some of the commonly used fields closer together.
On a standard setup, it also reduces the size from 864 bytes to 848
bytes. Yes, struct device is a pig...

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/blk_types.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 99be590f952f..d68d6e951fad 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -40,26 +40,25 @@ struct bio_crypt_ctx;
 struct block_device {
 	sector_t		bd_start_sect;
 	sector_t		bd_nr_sectors;
+	struct gendisk *	bd_disk;
+	struct request_queue *	bd_queue;
 	struct disk_stats __percpu *bd_stats;
 	unsigned long		bd_stamp;
 	bool			bd_read_only;	/* read-only policy */
+	u8			bd_partno;
+	bool			bd_write_holder;
 	dev_t			bd_dev;
 	atomic_t		bd_openers;
+	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
 	struct inode *		bd_inode;	/* will die */
 	struct super_block *	bd_super;
 	void *			bd_claiming;
-	struct device		bd_device;
 	void *			bd_holder;
+	/* The counter of freeze processes */
+	int			bd_fsfreeze_count;
 	int			bd_holders;
-	bool			bd_write_holder;
 	struct kobject		*bd_holder_dir;
-	u8			bd_partno;
-	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
-	struct gendisk *	bd_disk;
-	struct request_queue *	bd_queue;
 
-	/* The counter of freeze processes */
-	int			bd_fsfreeze_count;
 	/* Mutex for freeze */
 	struct mutex		bd_fsfreeze_mutex;
 	struct super_block	*bd_fsfreeze_sb;
@@ -68,6 +67,7 @@ struct block_device {
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	bool			bd_make_it_fail;
 #endif
+	struct device		bd_device;
 } __randomize_layout;
 
 #define bdev_whole(_bdev) \
-- 
2.39.2

