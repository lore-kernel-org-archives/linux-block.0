Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4A8C433EF
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 20:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiC2UUI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 16:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiC2UUI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 16:20:08 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EF9E04
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 13:18:24 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a68-20020a621a47000000b004fb74bed1e7so2946290pfa.5
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2yu8s9+twNetMt5NlS8zweMIK4+TQmaTJETl40EHRC8=;
        b=UJdrFqjz6mv1eWLT+cULEAVSnhcS8zxCK76eCqtdWNA6Ki8oEwlK36rOX+hQEhBt4y
         FZ9bXQA24D+oVI/6Sb4zjevkkBiZKgv7nPDn8fqPvL1vuR58GAVxJ6tzA6uk9OPyyXTp
         1979NShvvW5VTDnB0xh/1ZosnVo0H9M0sY/BJw64cwMxIwdWeiZ+VVFE5eYybX/23uS1
         WfPZog6jE8ROUlTWixI9EkjPKaotx040NUKw4YHZ5LW/S3uJHXNShjVSIdi8uLvyxi0c
         WRGjXLNycnDFqMxR2xBUaunL4vY/u1nIoK1SzStwunxqn8Q/JEQgtELs9AaRO4viUik4
         49nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2yu8s9+twNetMt5NlS8zweMIK4+TQmaTJETl40EHRC8=;
        b=zj4G2FNZZDPRqrMy9+NpKLF1fd2efCApzz9Ukom4SrGGEwH+Mj+kx4yj/UUi0x1JnZ
         qUk3+gIyZDFFEsxKVS9VCAzaA01mRz+URgN/V2c9KTXy1RYFnkub7vFXMIrICqNEGq6C
         VHbFur3pgmJm0Dzk+0zyLVvhMXpcu+XuIUvbmSOrZpz0KnSfshX8t9S62Cm5/Ug1EYKb
         dQf/VJkP49MdY3JCeFpibzdHHvaf0A8uqiQviwaBHQJ4Kkkj1KrjoXYc0d2k53SHF0Bo
         8F4W4B93jQld31NzSM5b01KjfxjTahz9N/zoyGdthl7J24J9iuHOJV3whzGxS+7i3Frb
         UjPQ==
X-Gm-Message-State: AOAM5315QrAz5o2vPU3dQR4DED+2fAd3c/UGBuNZD3WUHePnRDNo0fwu
        mWMn23LMx5f5h4zdyUY9IcDkdf4E28eueGZmEkE0VDyJ6EjmVA0c4Tu/Wr7DaIKax4F9Sie9U3X
        uDI+jwYz8NQBgwIYPnIUcRoM93goIHHRWL76KVf0lTtAmJpLjCXSfrZbcinS1+wAYtLp9GPNkNA
        ==
X-Google-Smtp-Source: ABdhPJwfNMsqPO4NDOdl7Uoh2n5Oc64Lgkdf5ZR1Iv67xwzfC5UEY4jtUcq84/fNGxzwTQmP5VDGdqu0Rnbqzg==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a17:902:f78d:b0:14f:ce61:eaf2 with SMTP
 id q13-20020a170902f78d00b0014fce61eaf2mr31997558pln.124.1648585103681; Tue,
 29 Mar 2022 13:18:23 -0700 (PDT)
Date:   Tue, 29 Mar 2022 20:18:15 +0000
Message-Id: <20220329201815.1347500-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH] loop: fix ioctl calls using compat_loop_info
From:   Carlos Llamas <cmllamas@google.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Support for cryptoloop was deleted in commit 47e9624616c8 ("block:
remove support for cryptoloop and the xor transfer"), making the usage
of loop_info->lo_encrypt_type obsolete. However, this member was also
removed from the compat_loop_info definition and this breaks userspace
ioctl calls for 32-bit binaries and CONFIG_COMPAT=y.

This patch restores the compat_loop_info->lo_encrypt_type member and
marks it obsolete as well as in the uapi header definitions.

Fixes: 47e9624616c8 ("block: remove support for cryptoloop and the xor transfer")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/block/loop.c      | 1 +
 include/uapi/linux/loop.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3e636a75c83a..a58595f5ee2c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1591,6 +1591,7 @@ struct compat_loop_info {
 	compat_ulong_t	lo_inode;       /* ioctl r/o */
 	compat_dev_t	lo_rdevice;     /* ioctl r/o */
 	compat_int_t	lo_offset;
+	compat_int_t	lo_encrypt_type;        /* obsolete, ignored */
 	compat_int_t	lo_encrypt_key_size;    /* ioctl w/o */
 	compat_int_t	lo_flags;       /* ioctl r/o */
 	char		lo_name[LO_NAME_SIZE];
diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
index 24a1c45bd1ae..98e60801195e 100644
--- a/include/uapi/linux/loop.h
+++ b/include/uapi/linux/loop.h
@@ -45,7 +45,7 @@ struct loop_info {
 	unsigned long	   lo_inode; 		/* ioctl r/o */
 	__kernel_old_dev_t lo_rdevice; 		/* ioctl r/o */
 	int		   lo_offset;
-	int		   lo_encrypt_type;
+	int		   lo_encrypt_type;		/* obsolete, ignored */
 	int		   lo_encrypt_key_size; 	/* ioctl w/o */
 	int		   lo_flags;
 	char		   lo_name[LO_NAME_SIZE];
@@ -61,7 +61,7 @@ struct loop_info64 {
 	__u64		   lo_offset;
 	__u64		   lo_sizelimit;/* bytes, 0 == max available */
 	__u32		   lo_number;			/* ioctl r/o */
-	__u32		   lo_encrypt_type;
+	__u32		   lo_encrypt_type;		/* obsolete, ignored */
 	__u32		   lo_encrypt_key_size;		/* ioctl w/o */
 	__u32		   lo_flags;
 	__u8		   lo_file_name[LO_NAME_SIZE];
-- 
2.35.1.1021.g381101b075-goog

