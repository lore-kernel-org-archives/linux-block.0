Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B10C43441
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 23:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C39F20815
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 23:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xL3ehqkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C39F20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbeKRKLz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Nov 2018 05:11:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44292 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbeKRKLy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Nov 2018 05:11:54 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so3530020pgr.11
        for <linux-block@vger.kernel.org>; Sat, 17 Nov 2018 15:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bqmn0QyhYBPGN1W7Q5Re0uOw0VeGIUIfH7w/ZR44PEY=;
        b=xL3ehqknbcyjRgQDSRh5s9R2zFK+VtDD6CRUx9+zPuqdClKfyxFXFXus9YkH1sQk7S
         AjiQdIa7Iw6ePaYJGykTzo93YBTjFw7TK1oicuN8TBuLXqPbx7B7wEcDoGEhtDJ1KVtr
         819G/MxJJ4tSw5SxJD05Oydhyxpvq/RVk+AHD5oRHZURcvb/vgSX3Rhtdf+Q3HLYjsjJ
         yFFvaAngC2C0ASIMdvT3KnzAd+tQva9PWhZU/GnnMG1QPNl/uu83IyXTiO8IqAG38NVR
         h+YdoEjztp0hN4xIM/6SA9reTDC7QVeCbFHN0kUslSqrCHTevYQU/tORppER5K+aDuMJ
         QNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bqmn0QyhYBPGN1W7Q5Re0uOw0VeGIUIfH7w/ZR44PEY=;
        b=kayikCYOpFW5JoCsYv6Biiu6qfR8we9jb6+BRer6q+1SHzXorGKhSPG56td7GwgD/X
         wl2lxFKa/Hygym7RdXsz2lOC3Pz/pYcGJi9rRyE7y2z2WSiOAp+UUzmXQPWCJ9uyffNh
         7EnhX4spXTXuNvyyWYSnk7lErD3h80y1N4X+zlOTZ17SWkMR0AKEzvraL19bBJjvGQj/
         aG6Fs1aH26esFV4DEAiDV/nt/NDoweOtl/9+w8DEvJVLCSbhK9zrxYWOe2d9MGQOhaRu
         hudkTkGOdOYtYCv+zl8uuXI4t1sky6KAAjvFeAZxDRF3oL8Kh/ZxBGp+2pOoLdYOPGaa
         xWlQ==
X-Gm-Message-State: AGRZ1gI/P32hsudHXk25gdPch4EU6Tky2gGvnCS5jVH2O8LvkB+mVuwL
        aVIoATcfbmfYtO5VmnUAT+2RWDA058o=
X-Google-Smtp-Source: AJdET5fjKuz5NIq3t4nt+V1FrmJ4zYa8f/9J1J+4/fL78wjUAjHJ3oloqqIW2oAYPoq8Og7yLYvq6A==
X-Received: by 2002:a63:50b:: with SMTP id 11mr14719157pgf.411.1542498808769;
        Sat, 17 Nov 2018 15:53:28 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m1sm15812345pgn.9.2018.11.17.15.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 15:53:27 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/5] aio: add iocb->ki_blk_qc field
Date:   Sat, 17 Nov 2018 16:53:15 -0700
Message-Id: <20181117235317.7366-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181117235317.7366-1-axboe@kernel.dk>
References: <20181117235317.7366-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add the field and have the blockdev direct_IO() helpers set it.
This is in preparation for being able to poll for iocb completion.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c     | 2 ++
 include/linux/fs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index d233a59ea364..8a2fed18e3fc 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -236,6 +236,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		bio.bi_opf |= REQ_HIPRI;
 
 	qc = submit_bio(&bio);
+	WRITE_ONCE(iocb->ki_blk_qc, qc);
 	for (;;) {
 		__set_current_state(TASK_UNINTERRUPTIBLE);
 
@@ -396,6 +397,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 				bio->bi_opf |= REQ_HIPRI;
 
 			qc = submit_bio(bio);
+			WRITE_ONCE(iocb->ki_blk_qc, qc);
 			break;
 		}
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c95c0807471f..032761d9b218 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -310,6 +310,7 @@ struct kiocb {
 	int			ki_flags;
 	u16			ki_hint;
 	u16			ki_ioprio; /* See linux/ioprio.h */
+	u32			ki_blk_qc;
 } __randomize_layout;
 
 static inline bool is_sync_kiocb(struct kiocb *kiocb)
-- 
2.17.1

