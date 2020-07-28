Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94233C433E0
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 14:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B73420663
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 14:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOMKIQEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbgG1OV2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 10:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbgG1OV2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 10:21:28 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50180C061794;
        Tue, 28 Jul 2020 07:21:28 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d27so14912282qtg.4;
        Tue, 28 Jul 2020 07:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0a7riHkmcNZX+GUojwCDuOWs6tGpRZUtzm7Jn91Fp0E=;
        b=aOMKIQEpNlogZ8jiHhzLA/GEKWEn/zHsQjaZvchq/hUuV4/z9G7PYgam7xaPvK+XbC
         +KZJHQ4LQ4Tgx6xDo3Fv31PeriH5Tmo651RamNk/C2F8C7A5PdTDOmnX41aMFCJNhhja
         +KYI6gi38WMbm+HfI9xlHgB7F3MwUBAWDnLK8I5RFngm+BkcO6FCR8ZSgv1jUucUGoPz
         9qz1IY2fipMOicd6bOlYRGokwL8gAQwLcprzyRp9p4ysvGuEoPBbmBLrc+N9m+mxTN50
         2UZOGYCyhqw7eoUQOutmM6w2src1ou6n87VjBVorI7Z3i/kiJm3bR5kZdF2mgRulmCsz
         qyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0a7riHkmcNZX+GUojwCDuOWs6tGpRZUtzm7Jn91Fp0E=;
        b=oC0MnjcX1OEMlMHOVo7kTweT2wwCM/QKVgN8d+/S8cPAu7qGHYtFeVP3WeAvOusOdD
         ofltgpwgOk6xc8UaZ/ncVv1Z0FYMK8sbcphpvYWPl27efLB6FycBda9BwHLHdALjjiJc
         oJuuh5zfFJ7G/hIARbfvymzA7WT/pFNNerAKKJh0VpWiqL7qB0yCIjetQQTz/6dT7Vnp
         XZDKZCA/VS5QeHAbQ38NO/tU4XCLNuN5gE8psrjjnOMIszO3D3tpc++Ujgvze2YEffUH
         9QbE8cFs2VR6YcNkWUenQVp2+a4mlgVxCU+BoGSfi9xVzF2A+DF6WcZYQwSJgRbMRky3
         x8Uw==
X-Gm-Message-State: AOAM5303ZicSvB4Z8UA/dM7lOnlwvA80nZLMfvBfvTqmK1zhCo58vMSH
        NFRPkSJHojKX8E7XSOwGoA==
X-Google-Smtp-Source: ABdhPJzzeiRIQxSjsjqXZ9i0X7fm6CZjBthtL+HGvt4+uWmVX+wcM3G8gwQYvj+9df1rB/Ghk+yOcA==
X-Received: by 2002:ac8:65d3:: with SMTP id t19mr27140594qto.193.1595946087337;
        Tue, 28 Jul 2020 07:21:27 -0700 (PDT)
Received: from localhost.localdomain (c-76-119-149-155.hsd1.ma.comcast.net. [76.119.149.155])
        by smtp.gmail.com with ESMTPSA id 6sm22142009qkj.134.2020.07.28.07.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 07:21:26 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH] block/floppy: Prevent kernel-infoleak in raw_cmd_copyout()
Date:   Tue, 28 Jul 2020 10:19:46 -0400
Message-Id: <20200728141946.426245-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

raw_cmd_copyout() is potentially copying uninitialized kernel stack memory
since it is initializing `cmd` by assignment, which may cause the compiler
to leave uninitialized holes in this structure. Fix it by using memcpy()
instead.

Cc: stable@vger.kernel.org
Fixes: 2145e15e0557 ("floppy: don't write kernel-only members to FDRAWCMD ioctl output")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
$ pahole -C "floppy_raw_cmd" drivers/block/floppy.o
struct floppy_raw_cmd {
	unsigned int               flags;                /*     0     4 */

	/* XXX 4 bytes hole, try to pack */

	void *                     data;                 /*     8     8 */
	char *                     kernel_data;          /*    16     8 */
	struct floppy_raw_cmd *    next;                 /*    24     8 */
	long int                   length;               /*    32     8 */
	long int                   phys_length;          /*    40     8 */
	int                        buffer_length;        /*    48     4 */
	unsigned char              rate;                 /*    52     1 */
	unsigned char              cmd_count;            /*    53     1 */
	union {
		struct {
			unsigned char cmd[16];           /*    54    16 */
			/* --- cacheline 1 boundary (64 bytes) was 6 bytes ago --- */
			unsigned char reply_count;       /*    70     1 */
			unsigned char reply[16];         /*    71    16 */
		};                                       /*    54    33 */
		unsigned char      fullcmd[33];          /*    54    33 */
	};                                               /*    54    33 */

	/* XXX 1 byte hole, try to pack */

	/* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
	int                        track;                /*    88     4 */
	int                        resultcode;           /*    92     4 */
	int                        reserved1;            /*    96     4 */
	int                        reserved2;            /*   100     4 */

	/* size: 104, cachelines: 2, members: 14 */
	/* sum members: 99, holes: 2, sum holes: 5 */
	/* last cacheline: 40 bytes */
};

 drivers/block/floppy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 09079aee8dc4..b8ea98f7a9cb 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3126,7 +3126,9 @@ static int raw_cmd_copyout(int cmd, void __user *param,
 	int ret;
 
 	while (ptr) {
-		struct floppy_raw_cmd cmd = *ptr;
+		struct floppy_raw_cmd cmd;
+
+		memcpy(&cmd, ptr, sizeof(cmd));
 		cmd.next = NULL;
 		cmd.kernel_data = NULL;
 		ret = copy_to_user(param, &cmd, sizeof(cmd));
-- 
2.25.1

