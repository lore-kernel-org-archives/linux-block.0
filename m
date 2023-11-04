Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BF7C4332F
	for <linux-block@archiver.kernel.org>; Sat,  4 Nov 2023 12:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjKDMSr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Nov 2023 08:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDMSr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Nov 2023 08:18:47 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993FF9D
        for <linux-block@vger.kernel.org>; Sat,  4 Nov 2023 05:18:44 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6c311ca94b4so2751440b3a.3
        for <linux-block@vger.kernel.org>; Sat, 04 Nov 2023 05:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699100323; x=1699705123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ck0FN+jg0Y3n7z4N6YgB4r812RXsDn85gQF60zF4DZo=;
        b=OB+phE5IVv/zlkufMSj84SF3l33TlkOsOuJP6Gh2hw0iW7V6J9/GOkGQb+J/XxnV3l
         Xl+XN7GDeY0EWacaemFwzQqLqoHsvvYDVQy6my0mmF26DEze+J4Wif55e7r1KE2W0mUK
         N4ZpjJBkGO00QkunsZEIX0j3JBvMNGGhhIX8nSobahvyNQNz30qq3npv4w0Ix3UzwrBD
         YVZLHJuiCxzq4B4LLe4r8hRxp9Kncfr8mCaxBUP3oz6SbZaWDkx1CH0wVg70DVMwmUns
         at7jmB0zMaV/dibKqab3JIdPIdCwRu8mhlt4AdXd86tLNKau/aTPp7q0a79X8lH3GauY
         PbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699100323; x=1699705123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ck0FN+jg0Y3n7z4N6YgB4r812RXsDn85gQF60zF4DZo=;
        b=nSUScCXnw9eMWEmytwxAAkmUyISHNdm7IK0v1IGeYMGDaIsyrvHxjmCyWCzGF2yAXv
         ZhTCvBJf0BTZukJEP0xv36KAX748Uzapgen+XCh/vfIkSkdKtihwnAV/efNiH8mBYipU
         6wduGFIVX8pWpNimOD8QGSwebwgL8tScV437HGMmfC9eefY0RNPsJIxSYtrHtZ3g3B9v
         OTREm0r+5bs4Tgda3jpK2oU8x2v+c5Bvn01WEbozpUm+pZrDR3zAAOcRXP54r+6NLI6l
         gk0ZWklm6oJG73jMGNlFWxPbqWtJOYBnf6BzUaq2JtpsAf6HxEuOhwk1TAngHwEhaJom
         PT2w==
X-Gm-Message-State: AOJu0Yz4zMbUnqbPuc25fbhzeuvT4Fji5spn/NktNofPT4RPyAnzINrY
        HUSO0yUgNqP2e8Gt5Gu8Xz+nbqiVq58=
X-Google-Smtp-Source: AGHT+IHDXbEPPYJyqr1PM4aqJ8ykcoxhBzTDWaajFSRdEnvPqzBt15tQfYB4tEmJAr7vJFRdvY8CmA==
X-Received: by 2002:a05:6a20:548b:b0:14e:a1f0:a8ea with SMTP id i11-20020a056a20548b00b0014ea1f0a8eamr27563749pzk.3.1699100322873;
        Sat, 04 Nov 2023 05:18:42 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:b43e:ad43:421c:7c22])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902bd8200b001cc3f9b70e9sm2886316pls.220.2023.11.04.05.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 05:18:41 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     akinobu.mita@gmail.com, shinichiro.kawasaki@wdc.com,
        ming.lei@redhat.com
Subject: [PATCH blktests] src/miniublk: fix logical block size setting
Date:   Sat,  4 Nov 2023 21:17:42 +0900
Message-Id: <20231104121742.178081-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The miniublk always sets the logical block size to 512 bytes when setting
a regular file-backed loop target.
A test fails if the regular file is on a filesystem built on a block
device with a logical block size of 4KB.

$ cd blktests
$ modprobe -r scsi_debug
$ modprobe scsi_debug sector_size=4096 dev_size_mb=2048
$ mkfs.ext4 /dev/sdX
$ mount /dev/sdX results/
$ ./check ublk/003

The logical block size of the ublk block device is set to 512 bytes,
so a request that is not 4KB aligned may occur, and the miniublk will
attempt to process it with direct IO and fail.

The original ublk program already fixed this problem by determining
the logical block size to set based on the block device to which the
target regular file belongs.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 src/miniublk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/miniublk.c b/src/miniublk.c
index 1c97668..565aa60 100644
--- a/src/miniublk.c
+++ b/src/miniublk.c
@@ -1440,6 +1440,8 @@ static int ublk_loop_tgt_init(struct ublk_dev *dev)
 		p.basic.physical_bs_shift = ilog2(pbs);
 	} else if (S_ISREG(st.st_mode)) {
 		bytes = st.st_size;
+		p.basic.logical_bs_shift = ilog2(st.st_blksize);
+		p.basic.physical_bs_shift = ilog2(st.st_blksize);
 	} else {
 		bytes = 0;
 	}
@@ -1512,6 +1514,8 @@ static int ublk_loop_tgt_recover(struct ublk_dev *dev)
 			return -1;
 	} else if (S_ISREG(st.st_mode)) {
 		bytes = st.st_size;
+		bs = st.st_blksize;
+		pbs = st.st_blksize;
 	} else {
 		bytes = 0;
 	}
-- 
2.34.1

