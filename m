Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92B7C433E0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 11:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A8E2083B
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 11:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1akJVMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgG2LxU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 07:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG2LxU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 07:53:20 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247C2C061794;
        Wed, 29 Jul 2020 04:53:19 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id dd12so5650382qvb.0;
        Wed, 29 Jul 2020 04:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dbKVQJEsi5OmCf8gsZhOgLkAF5HCvO25GsJ5HLwdED8=;
        b=D1akJVMB2ic6FJCvXtcIzudguNqpnLRruyjPU8sZzd1/Da8Jj41grupYH1YBvyjZ8Z
         o79A5fLQK0YnmLT/SaG4/tbNPvD1Q1ZnnUyYtgC6S73UCjZWfQcRNCxgN87znrbnHRpZ
         rVQdTG5RTwa3ASIVKxl35FtEQcPvzIbuOy5Eb7i18wTqykLymIicaqWUzTIJgN3PPwYq
         u33/cU12qu8fH9CnJ4QWLs6gbmL21DYOzf+zTSr3I20Gv+zqw+H2rW+tuJddEPwdgAJ1
         o/fHLXOntqrV/8y/a7wy6JOhUgTH784T/g+QZkkL0iPtoqgTfdChi5a8QIPdCe6vO0Do
         rAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dbKVQJEsi5OmCf8gsZhOgLkAF5HCvO25GsJ5HLwdED8=;
        b=IR3WFJf/QFfxF/6uVsSVegbOQt0nZUuC/BD2yE0P29I+mrSwY1xcphK4abS6BvLxYu
         o5428iCs9kMx1kK1MlQcbnv8eAOyXoprxearBqtxmhFAyxbHW3WrJxnhiIy0AgeGrYgp
         aCSZm1yRU76fhnf4JUvmUNMzKm+mjx0LRsqr/S09OMUPvZdagTQACrY5ElBwLzGvTe4R
         lWQ40uvBD4d0mN6aUlJbhw4gNTMGqlTUQaEFI9dm+YGkpLdcT3CatmcOwu6vhUmlsDFc
         G3Qsh+IaI1LCRf3DHbrRvO/NMKzdynEB1N27vM4e0MXuSBn7JiAcQ7P2ZpIvjZSPrrql
         Kt+g==
X-Gm-Message-State: AOAM530D7dtIc14VilcB1O+J12OOaWykh+mrMveZeUN0y2vUeDdASWuE
        aja/CcYP3/mMIQhDRNEzjQ==
X-Google-Smtp-Source: ABdhPJz66BNCjHBTDeXGIlu2MYFSm0jp9sVQTPG9hCtDssdlKFCd++Ii3AmkngoUIVJXrS+Dj+YasA==
X-Received: by 2002:a0c:e5cc:: with SMTP id u12mr32198398qvm.54.1596023598259;
        Wed, 29 Jul 2020 04:53:18 -0700 (PDT)
Received: from localhost.localdomain (c-76-119-149-155.hsd1.ma.comcast.net. [76.119.149.155])
        by smtp.gmail.com with ESMTPSA id o13sm1330478qko.48.2020.07.29.04.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 04:53:17 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH v2] block/floppy: Prevent kernel-infoleak in raw_cmd_copyout()
Date:   Wed, 29 Jul 2020 07:51:57 -0400
Message-Id: <20200729115157.8519-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200728141946.426245-1-yepeilin.cs@gmail.com>
References: <20200728141946.426245-1-yepeilin.cs@gmail.com>
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
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
Change in v2:
    - Remove inappropriate "Fixes:" tag. (Suggested by: Denis Efremov
      <efremov@linux.com>)

Reference: https://lwn.net/Articles/417989/

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

