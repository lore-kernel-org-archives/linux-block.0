Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EB5C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 22:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 126532078E
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 22:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592949807;
	bh=SbeSgz7v6uBQIzoqF6XiYGjKMBmakNkx/iX86iDtDbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lBzK4GdxdkyXTwGamN1vFS91Y6cTLuYLmQY8qDQb72Gx35NReTkvXTo4zvulk17+9
	 md8RQAe5we2CT9jlKLVqwRWCY0ClL7UPdfbwbWSEiADz6KGJBE7fVDy6yZP7lWDBCD
	 vLkmyyGnmuU20IdFliaoPasdN/9HC6h8HPAxNMvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389708AbgFWWDV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:03:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35465 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389662AbgFWWDT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 18:03:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id f3so240241pgr.2;
        Tue, 23 Jun 2020 15:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3dklPLNvPzEh3iXYi0YDYu40yfaLzsdX2IYuzaoImXQ=;
        b=l8kSIsgp3NYh5LA6CSeI3TLHFTpBpJpALBt55Of5QqQOdHOWochLP/JW9SRB2dnwLw
         1NCMuDc66Lpz2q5pbn/zaH1LcHUspQAK0Y4t8THXPGcRvVNWYGcwymDKJMwa1FX884hP
         Gkigrr8BY99VB6UMjNnutDEiM65z0k7CwRrhdHHFNVgKAzngtUL5sq/kXOYDIFuEbIjh
         QHZao53KkfFdD4ug7NDNRlefVL+Uu4By7VHSVf31MbgA4/XDqOoKScDCrqxvUduzqszY
         Y0mArTv+CoIBJIc0R2OMikoJBW5h05llkhHZ3/ONENIiPFLwDJoXOdSDzu9sNsvizLtD
         zS6Q==
X-Gm-Message-State: AOAM530AZ5Af9UikaalrLpXE+e6fbzOjpJc0ZmJHfcQ0OcrVM5hLsVC/
        OKUrTB1i7BFU6CwZ+zc+YewnGAnI824=
X-Google-Smtp-Source: ABdhPJz5h56kg+5VK/e7VmzMOUTHSlu4XpkenlEa5bmDf4qHT2YCJnK7rpKCfW9fbzAXFA5QFUnfXg==
X-Received: by 2002:a63:5509:: with SMTP id j9mr12175387pgb.195.1592949797738;
        Tue, 23 Jun 2020 15:03:17 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id o1sm3185397pjf.17.2020.06.23.15.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 15:03:13 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D885E418C0; Tue, 23 Jun 2020 22:03:12 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, damien.lemoal@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, martin.petersen@oracle.com, satyat@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/2] block: add initial kdoc over the request_queue
Date:   Tue, 23 Jun 2020 22:03:10 +0000
Message-Id: <20200623220311.8033-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200623220311.8033-1-mcgrof@kernel.org>
References: <20200623220311.8033-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We start off with an initial description of the request_queue data
structure, followed by describing the purpose of the debugfs_mutex
debugfs_dir, and blk_trace.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/blkdev.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 70461b347169..ea319c2b0593 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -394,6 +394,26 @@ static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
 
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+/**
+ * struct request_queue - block device driver request queue
+ * @debugfs_mutex: used to protect access to the @debugfs_dir
+ * @blk_trace: used by blktrace to keep track of setup / tracing
+ * @debugfs_dir: directory created to place debugfs information. This is always
+ *	created for make_request and request-based block drivers upon
+ *	initialization. blktrace requires for this directory to be created,
+ *	and so it will be created on demand if its block driver type does not
+ *	create it opon initialization.
+ *
+ * The request_queue is used to manage incoming block layer device driver
+ * requests. We have three main type of block driver types which end up making
+ * use of the request_queue:
+ *
+ *   o make_request block drivers (multiqueue)
+ *   o request-based block drivers
+ *   o custom solutions such as scsi-generic
+ *
+ * All partitions share the same request_queue data structure.
+ */
 struct request_queue {
 	struct request		*last_merge;
 	struct elevator_queue	*elevator;
-- 
2.26.2

