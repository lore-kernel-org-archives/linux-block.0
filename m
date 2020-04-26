Return-Path: <SRS0=zlmp=6K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED566C54FCB
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 13:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B6120700
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 13:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgDZNIT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Apr 2020 09:08:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39313 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDZNIS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 09:08:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id m2so11493196lfo.6;
        Sun, 26 Apr 2020 06:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HT2BCSWgzxUdrlLCBm0qqAESIN+EGNUthAVxzQxAcj8=;
        b=Js4PY6eA7BqbPLWqtiWL5cninSkIY/HZhSwEJNH3rYGAZaAboOgalP9GAhjA+6epNI
         vYbRPQD4Yt5K8IKYMzQ2t7GI3ua8NFKDkvyf2TOzOdu68FjsOqTUyZ7C4cNpanBZPkcD
         Alzjg7sSDACC8gSxSXhm2cJ7FXZFS8E0hJIZ17IOWSmqEohXxKNfconwMJ0daiOgWrTB
         xmiqRgovOT++cI1n/QjxmLATy+S4n5MHG3eOJQwlKfZ1LNc6PEclkQCSaT9jJjou+/kX
         FZd7uizqe9iWI/c5MDhNTXNe564ihV6Cj69a0VNjKaI57+9H+nNMl8TiIwdfJfZKKF9E
         fhUg==
X-Gm-Message-State: AGi0PubHftkHMv/LuY2+KsYdtuXeOzHq6Xz+/XuPe/dVc9NqJ2ib8JxN
        5vQtzxUg+sp1N6ZgGl9y5bEeZuinSFg=
X-Google-Smtp-Source: APiQypJMEtsE5XE2fYqdbfbyQGVTVlbrLJ0IODli+VwrLEl1i6FzIdmpAY3ict9US+kr3I5KwMb8kA==
X-Received: by 2002:ac2:551e:: with SMTP id j30mr12701110lfk.179.1587906495848;
        Sun, 26 Apr 2020 06:08:15 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.211])
        by smtp.googlemail.com with ESMTPSA id l8sm7983371ljo.5.2020.04.26.06.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 06:08:15 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, Willy Tarreau <w@1wt.eu>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] floppy: add FD_AUTODETECT_SIZE define for struct floppy_drive_params
Date:   Sun, 26 Apr 2020 16:07:26 +0300
Message-Id: <20200426130728.63399-2-efremov@linux.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200426130728.63399-1-efremov@linux.com>
References: <20200426130728.63399-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use FD_AUTODETECT_SIZE for autodetect buffer size in struct
floppy_drive_params instead of a magic number.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/block/floppy.c  | 9 +++++----
 include/uapi/linux/fd.h | 5 ++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 2817170dd403..ac2023c757e3 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2076,7 +2076,8 @@ static int next_valid_format(int drive)
 
 	probed_format = drive_state[drive].probed_format;
 	while (1) {
-		if (probed_format >= 8 || !drive_params[drive].autodetect[probed_format]) {
+		if (probed_format >= FD_AUTODETECT_SIZE ||
+			!drive_params[drive].autodetect[probed_format]) {
 			drive_state[drive].probed_format = 0;
 			return 1;
 		}
@@ -3445,13 +3446,13 @@ static int fd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	return 0;
 }
 
-static bool valid_floppy_drive_params(const short autodetect[8],
+static bool valid_floppy_drive_params(const short autodetect[FD_AUTODETECT_SIZE],
 		int native_format)
 {
 	size_t floppy_type_size = ARRAY_SIZE(floppy_type);
 	size_t i = 0;
 
-	for (i = 0; i < 8; ++i) {
+	for (i = 0; i < FD_AUTODETECT_SIZE; ++i) {
 		if (autodetect[i] < 0 ||
 		    autodetect[i] >= floppy_type_size)
 			return false;
@@ -3676,7 +3677,7 @@ struct compat_floppy_drive_params {
 	struct floppy_max_errors max_errors;
 	char		flags;
 	char		read_track;
-	short		autodetect[8];
+	short		autodetect[FD_AUTODETECT_SIZE];
 	compat_int_t	checkfreq;
 	compat_int_t	native_format;
 };
diff --git a/include/uapi/linux/fd.h b/include/uapi/linux/fd.h
index 90fb94712c41..3f6b7be4c096 100644
--- a/include/uapi/linux/fd.h
+++ b/include/uapi/linux/fd.h
@@ -172,7 +172,10 @@ struct floppy_drive_params {
  * used in succession to try to read the disk. If the FDC cannot lock onto
  * the disk, the next format is tried. This uses the variable 'probing'.
  */
-	short autodetect[8];		/* autodetected formats */
+
+#define FD_AUTODETECT_SIZE 8
+
+	short autodetect[FD_AUTODETECT_SIZE]; /* autodetected formats */
 	
 	int checkfreq; /* how often should the drive be checked for disk 
 			* changes */
-- 
2.25.3

