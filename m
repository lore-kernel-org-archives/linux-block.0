Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32127C282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 22:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9BF222C7
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 22:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K3FBCroj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfBLWzF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:55:05 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:56636 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfBLWzF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 17:55:05 -0500
Received: by mail-it1-f199.google.com with SMTP id 135so685169itb.6
        for <linux-block@vger.kernel.org>; Tue, 12 Feb 2019 14:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=KjNhG0POKcODcquT3yAek3QXMouSJzo7JdLuo1R8jCc=;
        b=K3FBCrojOBj+AULGeeagiyj2tWTLvWqC3Jw0oR6M26/d4060eYDWgzYRPOI4Frjpyo
         RPPJmzDMCXZwyN5K9Y6J1JcISAdd1vd0iKluguGMwkW6cvmpKzIH32CJbwMD1OK19Cp5
         g+88UJyiX8qkXmztMCWT56GEfm+0CgsEkKWKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=KjNhG0POKcODcquT3yAek3QXMouSJzo7JdLuo1R8jCc=;
        b=lYBvI4/jM/Kq5N5hosn4YdB0kS4ojxZfxj8na6D2x120cpllbWSjHzLenZLA339md4
         4dODYyV1qsLAnaXBmbty/AUD4GtVQQ7TeqGQ0Ag+hNPeJ9ROcp/gaArLsT/LA2juS8F8
         8gNfwdVGDLsk5XtVlaviN9Cu5wwZG9Em48KrKywaYfROnGXqIhWtROhTYL6jOW2+h6qb
         QKUMg+E/9Bl9pHiEwGnNoTS6hlgT8Gw31r40R02qr8JZ6/lZJyApJsSaFy0e2Y/8EbFp
         D2FNOmFdUkuC84DqhxI49vEqlIMG5G4yq/AKnFDn0u0wl39qMgPY+p6VKa85a9SCcRfL
         6OXg==
X-Gm-Message-State: AHQUAuaMs6pHilCJbGqz+bEkGIc4s8hbul6hopMNa4MntC3sWLoi4c19
        ImJ7WPvMLNCw1QFEt3bw33wGqqrAItbsSFFT
X-Google-Smtp-Source: AHgI3Iav/a1u4qH2Ks7pHRy4yIf4LJnBbab6ZiPNYtuV5ynjjsIxON3uYKn/33URsjVDqSJKIeQnL7TNVzMIk3RY
X-Received: by 2002:a24:394f:: with SMTP id l76mr793867ita.23.1550012104207;
 Tue, 12 Feb 2019 14:55:04 -0800 (PST)
Date:   Tue, 12 Feb 2019 15:54:24 -0700
Message-Id: <20190212225424.139232-1-bmgordon@chromium.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH] loop: properly observe rotational flag of underlying device
From:   Benjamin Gordon <bmgordon@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?q?Holger=20Hoffst=C3=A4tte?=" 
        <holger.hoffstaette@googlemail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, holger@applied-asynchrony.com,
        Gwendal Grignou <gwendal@chromium.org>,
        Benjamin Gordon <bmgordon@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Holger Hoffst=C3=A4tte <holger.hoffstaette@googlemail.com>

The loop driver always declares the rotational flag of its device as
rotational, even when the device of the mapped file is nonrotational,
as is the case with SSDs or on tmpfs. This can confuse filesystem tools
which are SSD-aware; in my case I frequently forget to tell mkfs.btrfs
that my loop device on tmpfs is nonrotational, and that I really don't
need any automatic metadata redundancy.

The attached patch fixes this by introspecting the rotational flag of the
mapped file's underlying block device, if it exists. If the mapped file's
filesystem has no associated block device - as is the case on e.g. tmpfs -
we assume nonrotational storage. If there is a better way to identify such
non-devices I'd love to hear them.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: holger@applied-asynchrony.com
Signed-off-by: Holger Hoffst=C3=A4tte <holger.hoffstaette@googlemail.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Benjamin Gordon <bmgordon@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---
 This is a resend of Holger's original patch from
 https://lkml.org/lkml/2015/11/11/288 with the _unlocked functions
 updated.  We keep running into the same problem on Chrome OS that this
 originally solved; any chance it can go in?

 drivers/block/loop.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cf5538942834..6c0fc0d49dc0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -900,6 +900,24 @@ static int loop_prepare_queue(struct loop_device *lo)
 	return 0;
 }
=20
+static void loop_update_rotational(struct loop_device *lo)
+{
+	struct file *file =3D lo->lo_backing_file;
+	struct inode *file_inode =3D file->f_mapping->host;
+	struct block_device *file_bdev =3D file_inode->i_sb->s_bdev;
+	struct request_queue *q =3D lo->lo_queue;
+	bool nonrot =3D true;
+
+	/* not all filesystems (e.g. tmpfs) have a sb->s_bdev */
+	if (file_bdev)
+		nonrot =3D blk_queue_nonrot(bdev_get_queue(file_bdev));
+
+	if (nonrot)
+		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
+}
+
 static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 		       struct block_device *bdev, unsigned int arg)
 {
@@ -963,6 +981,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t =
mode,
 	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
 		blk_queue_write_cache(lo->lo_queue, true, false);
=20
+	loop_update_rotational(lo);
 	loop_update_dio(lo);
 	set_capacity(lo->lo_disk, size);
 	bd_set_size(bdev, size << 9);
--=20
2.20.1.791.gb4d0f1c61a-goog

