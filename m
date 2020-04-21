Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2E8C55182
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 12:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5770D2076C
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 12:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgDUM6L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:58:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41722 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbgDUM6J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 08:58:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id j3so13815857ljg.8;
        Tue, 21 Apr 2020 05:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CzVUK+8+Cyh1jLtMoHSeKW2urHEoxIGPwaTFRn76lTw=;
        b=j0OsekL5Osxppy2wDCC/PZmFUtKjWAGQJSgQNwmgKav/0QzwugYc8biG+e6IMqQUL1
         fH02eqvLuYJBGNu/o538eXrPe0fXNRof40ARKNjWEqZ8/2jLVo1VT2413xOUmnNt5+rS
         sNnQGySkJXpvDzLrNbVY1biW7dJbUPwp/zNzhgV4JrU8l3CFH57LeFGGSbOaIohTefob
         gHuaT7EeGDpbdfbjc6dDJt06ocuiCg0/ljNbrdCvEMnvk/MWewvZyB2flshXsdGlLT4f
         V5TnehzGUbrKM1ezoNuXnwr3Irud0kowYr0EUstyQOx/RZ3F1971xBZ+n+rFdMqRl9+R
         C+VA==
X-Gm-Message-State: AGi0PuaOZHqkwBjwY+pvDaafH+TR/QOVLf6AinkfRdg5JApHmnj0ubqs
        Oh5MA94eKU5qkC6DplgIZVPt4Nwsrfk=
X-Google-Smtp-Source: APiQypKxJtA3MtIiQ2i/vmvcCwJwiT+OXbiq75A5z+5zXbOcOXKA/TW+DDAHJwHMa7mfBXyPaRYD1w==
X-Received: by 2002:a2e:164b:: with SMTP id 11mr12901489ljw.23.1587473887028;
        Tue, 21 Apr 2020 05:58:07 -0700 (PDT)
Received: from localhost.localdomain ([213.87.162.215])
        by smtp.googlemail.com with ESMTPSA id z7sm1902268ljc.17.2020.04.21.05.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 05:58:03 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] floppy: suppress UBSAN warning in setup_rw_floppy()
Date:   Tue, 21 Apr 2020 15:57:22 +0300
Message-Id: <20200421125722.58959-4-efremov@linux.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200421125722.58959-1-efremov@linux.com>
References: <20200421125722.58959-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

UBSAN: array-index-out-of-bounds in drivers/block/floppy.c:1521:45
index 16 is out of range for type 'unsigned char [16]'
Call Trace:
...
 setup_rw_floppy+0x5c3/0x7f0
 floppy_ready+0x2be/0x13b0
 process_one_work+0x2c1/0x5d0
 worker_thread+0x56/0x5e0
 kthread+0x122/0x170
 ret_from_fork+0x35/0x40

From include/uapi/linux/fd.h:
struct floppy_raw_cmd {
	...
	unsigned char cmd_count;
	unsigned char cmd[16];
	unsigned char reply_count;
	unsigned char reply[16];
	...
}

This out-of-bounds access is intentional. The command in struct
floppy_raw_cmd may take up the space initially intended for the reply
and the reply count. It is needed for long 82078 commands such as
RESTORE, which takes 17 command bytes. Initial cmd size is not enough
and since struct setup_rw_floppy is a part of uapi we check that
cmd_count is in [0:16+1+16] in raw_cmd_copyin().

The patch replaces array subscript with pointer arithetic to suppress
UBSAN warning.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/block/floppy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 2169df796d18..63981b1f8d4c 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1518,7 +1518,10 @@ static void setup_rw_floppy(void)
 
 	r = 0;
 	for (i = 0; i < raw_cmd->cmd_count; i++)
-		r |= output_byte(current_fdc, raw_cmd->cmd[i]);
+		/* The command may take up the space initially intended for the
+		 * reply and the reply count.
+		 */
+		r |= output_byte(current_fdc, *(raw_cmd->cmd + i));
 
 	debugt(__func__, "rw_command");
 
-- 
2.25.3

