Return-Path: <SRS0=wI0I=WY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44CFC3A5A1
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 10:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F6A22DA7
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 10:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="LdiAWQz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfH1Kce (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:32:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35741 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfH1Kcd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Aug 2019 06:32:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id t50so2460269edd.2
        for <linux-block@vger.kernel.org>; Wed, 28 Aug 2019 03:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=42lKVdjnjP4y6DAxlLSWlI9cd0CLM9DFEKL56/c6DVw=;
        b=LdiAWQz8Af5L8jx+Wh3U4VqhqVfqQ2nc41g+8FcxYVXCVZgUhXbvRt4IkV8itEgTBW
         gWFgViHvq+lZ9XXK7aoa9BEnyC+qauttQ/X34wCpfVIVMgf96bcioED+1DFVG6apguD4
         AVpgddIDLb87Or3hp/EnVICZa3P1EsEx1sabaUWZQqJksQ1jHVZhpmquwmb10/Rhj/N8
         tJ7arB02huszVrlcJtqiyIwF10FNfBxFNJSk26FXUdsPlH9Y/qsezyKWZXQ+2yLEYH8H
         DdVYHdquI9Xu/lcf9SDLdVl9EFm8NhN5j4WM+wbL0e6zvmN0lUjIus1My77l9d9ihuhD
         QpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=42lKVdjnjP4y6DAxlLSWlI9cd0CLM9DFEKL56/c6DVw=;
        b=uI8EdCOOfaZBGKLNSBrasIDYkNYDz/simexX8g3/RXfgp05xkWekxb2iaUkRIP2LHo
         1L10a6swyYvjIZOr91xkO0yY7mAoPLVlAnrhU2Cbwzp24eDuJfAboDXEZauiribEeJGc
         sbNPZSp4NBgGLJjnmSaO4i3WoogQmF7BBEPj+g6v4Dk/E07DbDoT/EeEmwEZKoGNdb1D
         RM/Tn7B8Fi8DZKiuVwSjezg5YCHeVWQe4iAfI7ahV1LRHrvWb6xdbTKmQc30SS1WEQgK
         CPu3ldFe/2eD0BswbLNSt2aiO1nGG1c+EM+rSPOqyN4Ws+KHoUnwkqRZndl8HYbRX25J
         xzNA==
X-Gm-Message-State: APjAAAUOtZaCAOPTZmoqF2bXRnxjOvdDBXyFabKBCbNoRBTGRAIMnJ4Q
        xLNhd4neRA0G57ioA6PdRp93RQ==
X-Google-Smtp-Source: APXvYqxtYAhqfsawL7tpy/qloMqvOXRgeb+f/jy3T/I1yom2OrgxLgDW7GEBfCJaXBk5T0R3jZNceg==
X-Received: by 2002:a17:906:1944:: with SMTP id b4mr2528225eje.44.1566988351953;
        Wed, 28 Aug 2019 03:32:31 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id z9sm366543edr.54.2019.08.28.03.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 03:32:31 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundatio.org, kernel-team@android.com,
        narayan@google.com, dariofreni@google.com, ioffe@google.com,
        jiyong@google.com, maco@google.com,
        Martijn Coenen <maco@android.com>
Subject: [PATCH] loop: change queue block size to match when using DIO.
Date:   Wed, 28 Aug 2019 12:32:29 +0200
Message-Id: <20190828103229.191853-1-maco@android.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The loop driver assumes that if the passed in fd is opened with
O_DIRECT, the caller wants to use direct I/O on the loop device.
However, if the underlying filesystem has a different block size than
the loop block queue, direct I/O can't be enabled. Instead of requiring
userspace to manually change the blocksize and re-enable direct I/O,
just change the queue block size to match.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ab7ca5989097a..1138162ff6c4d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -994,6 +994,12 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
 		blk_queue_write_cache(lo->lo_queue, true, false);
 
+	if (io_is_direct(lo->lo_backing_file) && inode->i_sb->s_bdev) {
+		/* In case of direct I/O, match underlying block size */
+		blk_queue_logical_block_size(lo->lo_queue,
+				bdev_logical_block_size(inode->i_sb->s_bdev));
+	}
+
 	loop_update_rotational(lo);
 	loop_update_dio(lo);
 	set_capacity(lo->lo_disk, size);
-- 
2.23.0.187.g17f5b7556c-goog

