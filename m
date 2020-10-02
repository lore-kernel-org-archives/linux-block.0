Return-Path: <SRS0=oVJv=DJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F7DC4363D
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 14:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04639206FA
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 14:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQgyxL8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387939AbgJBOXe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Oct 2020 10:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJBOXe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Oct 2020 10:23:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDB5C0613D0;
        Fri,  2 Oct 2020 07:23:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so1318369pfp.11;
        Fri, 02 Oct 2020 07:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OjNQvI2ijIO/M2pfT2smqs+ynvGtDPzeT8cJRRsXgHA=;
        b=XQgyxL8NJ6EiknRfuDKYULLI52Ibs2uLUiO6B6vlyBB+ov5yWWDoKMk1wvbfEhqziB
         cjY7Yv6hyXrGj9EbqxQM8bFCRQ9UHhuFuwQc/WDIhQOMElOsiUaKfVpK+H1J5GxIfhQJ
         W01i0uNznz0D96s0WOyNlnAOtHl+U70MpfaFFdpO34u6TwH8lqtpMIhbeUE8dYltT57i
         UwLjaFz6nTl0SQ4fA8bu7nP9GxRHbraFpFtm+ZjcabA5R6IIYcSqU3V7QZ9XmXEDt1gC
         9zUp0/D4n7NwevTNapoSi57vEk8Ms6o3lws3V3eSl1IWMy+VYhziNL6MALzJyNzKasFK
         9aMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OjNQvI2ijIO/M2pfT2smqs+ynvGtDPzeT8cJRRsXgHA=;
        b=GJ/NMj7iIbn700XwMe5ou55FovI/GMnd2w3OI1PuvNaFT3wurA1TgHZ8YCVVAPgjHz
         FHS4cfk8vMGb0KjHOs8FQmpBasMFty7xTwmafu4IT4oFL/D2cUlHhIFV8CXIuY4UgwgG
         1NmJFn9kI8zGuB249HGM1cJfAgYJgGe/WJDbZtSMegOBg4KtNNbPi8eHPbkM9XfVQLYn
         VUb0T+4YyD06kMIG/QuP/6+9a2BrVXrGB0q1b8aFAADQChrFcmK+3LFiOoGqh0lVhaDl
         QwXbn5otXthkJL2yCXgduvUIUT/IsGv71orLHyc44UpecOowG5+lnjkEObI4/LZoR8ky
         PklA==
X-Gm-Message-State: AOAM530bOPkEpirx+RqpVGXkPfBkedo/C8lqFNnP4P1d28Qt4D6YE7ao
        beP+KtnkOb5rbhHkiWT3rg==
X-Google-Smtp-Source: ABdhPJxV0D5CAPrY5aLgnnIaonU6JK0L9yfh1hftGF3Vuyfk6tWfcImIpm0lhbKAf6hbESmEjhP2Zw==
X-Received: by 2002:aa7:8d15:0:b029:142:2501:39fe with SMTP id j21-20020aa78d150000b0290142250139femr2979520pfe.77.1601648613591;
        Fri, 02 Oct 2020 07:23:33 -0700 (PDT)
Received: from localhost.localdomain ([161.117.41.183])
        by smtp.gmail.com with ESMTPSA id gi20sm1786628pjb.28.2020.10.02.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:23:32 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+85433a479a646a064ab3@syzkaller.appspotmail.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        glider@google.com, Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-block@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] block/scsi-ioctl: Fix kernel-infoleak in scsi_put_cdrom_generic_arg()
Date:   Fri,  2 Oct 2020 10:22:23 -0400
Message-Id: <20201002142223.9482-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <000000000000a24fa705ae29dc6c@google.com>
References: <000000000000a24fa705ae29dc6c@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

scsi_put_cdrom_generic_arg() is copying uninitialized stack memory to
userspace, since the compiler may leave a 3-byte hole in the middle of
`cgc32`. Fix it by adding a padding field to `struct
compat_cdrom_generic_command`.

Cc: stable@vger.kernel.org
Fixes: f3ee6e63a9df ("compat_ioctl: move CDROM_SEND_PACKET handling into scsi")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: syzbot+85433a479a646a064ab3@syzkaller.appspotmail.com
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
v3: https://lore.kernel.org/lkml/20200909095057.1214104-1-yepeilin.cs@gmail.com/

Changes in v4:
    - Change "Prevent" in the title to "Fix", and improve the commit
      message, since syzbot has reported it as a "real" bug.
    - Add syzbot Reported-by: tag.

Changes in v3:
    - Improve commit message. scsi_put_cdrom_generic_arg() does not
      *always* leak kernel information. It is compiler dependent.
      Reference: https://www.nccgroup.com/us/about-us/newsroom-and-events/blog/2019/october/padding-the-struct-how-a-compiler-optimization-can-disclose-stack-memory/
    - Base the patch against mainline 5.9-rc4.

Change in v2:
    - Add a padding field to `struct compat_cdrom_generic_command`,
      instead of doing memset() on `cgc32`. (Suggested by Jens Axboe
      <axboe@kernel.dk>)

$ # before
$ pahole -C "compat_cdrom_generic_command" !$
pahole -C "compat_cdrom_generic_command" block/scsi_ioctl.o
struct compat_cdrom_generic_command {
	unsigned char              cmd[12];              /*     0    12 */
	compat_caddr_t             buffer;               /*    12     4 */
	compat_uint_t              buflen;               /*    16     4 */
	compat_int_t               stat;                 /*    20     4 */
	compat_caddr_t             sense;                /*    24     4 */
	unsigned char              data_direction;       /*    28     1 */

	/* XXX 3 bytes hole, try to pack */

	compat_int_t               quiet;                /*    32     4 */
	compat_int_t               timeout;              /*    36     4 */
	compat_caddr_t             reserved[1];          /*    40     4 */

	/* size: 44, cachelines: 1, members: 9 */
	/* sum members: 41, holes: 1, sum holes: 3 */
	/* last cacheline: 44 bytes */
};
$ # after
$ pahole -C "compat_cdrom_generic_command" block/scsi_ioctl.o
struct compat_cdrom_generic_command {
	unsigned char              cmd[12];              /*     0    12 */
	compat_caddr_t             buffer;               /*    12     4 */
	compat_uint_t              buflen;               /*    16     4 */
	compat_int_t               stat;                 /*    20     4 */
	compat_caddr_t             sense;                /*    24     4 */
	unsigned char              data_direction;       /*    28     1 */
	unsigned char              pad[3];               /*    29     3 */
	compat_int_t               quiet;                /*    32     4 */
	compat_int_t               timeout;              /*    36     4 */
	compat_caddr_t             reserved[1];          /*    40     4 */

	/* size: 44, cachelines: 1, members: 10 */
	/* last cacheline: 44 bytes */
};
$ _

 block/scsi_ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index ef722f04f88a..72108404718f 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -651,6 +651,7 @@ struct compat_cdrom_generic_command {
 	compat_int_t	stat;
 	compat_caddr_t	sense;
 	unsigned char	data_direction;
+	unsigned char	pad[3];
 	compat_int_t	quiet;
 	compat_int_t	timeout;
 	compat_caddr_t	reserved[1];
-- 
2.25.1

