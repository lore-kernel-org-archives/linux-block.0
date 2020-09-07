Return-Path: <SRS0=p3ox=CQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0829BC43461
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 11:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90447215A4
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 11:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMvw2vfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgIGL3P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgIGL3B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Sep 2020 07:29:01 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96021C061575;
        Mon,  7 Sep 2020 04:29:01 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o8so4577236ejb.10;
        Mon, 07 Sep 2020 04:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kQGNEdq+cDwHylTqbs6BpkRXROVfkl3/tiDlpY9PKjg=;
        b=LMvw2vfIFlo+Cv7Q+U1LP91HBerow08Yy9+2U7FUmVxuEwMXRjAGo/vrnHyCRYJSEe
         RfG3x+kOxP9GaXo+av8MSARiQ1s1RaNCmzlQzDyKaKPTz/3VniGXgFJFec15gPuGso1o
         8sGOMcizLzmoGh9heEaK+9G+eJ5kvvF/FMrLcyHiuhInZb1pyHro+8tsbTtEy5toqh5d
         oWK4GKkN9VFdgCSYgWQOhI7y9qSHDvhnMnqJzMJfGm2RBTfXTo14qHPAlKJFSo+VnUes
         lx6s8xNDFCLGLHqSeYbalJWr3XOEDq0Q3/64gtQir5rSlj34T2peipvjfSB59gmSTtvh
         dgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kQGNEdq+cDwHylTqbs6BpkRXROVfkl3/tiDlpY9PKjg=;
        b=D2TyFBJCIX3D1JwjEqlxyrK4T2HcysshP6fNeuhPGJXVPJn22iZ85ybpsfonTIqV1j
         T9YUuK7M7F89JwbO1a9iGe1P2J7f35P0Lqsz02aZ4uUnHYnX708dLnIEf+WAt0/wN1Sf
         OfT90HLzN1oj6kbfptXFakmgSeG2hXmI6EeqfwVtTlqTnLp5lKBSMaw8eJcdbACOUwsP
         UqHg45zWrFW1Now7BjZhQ1F6wAFCtQaOdriVtGGrLEPCCM9LxRVUbFuTxab1H4ryOZaL
         u1aokKFMSxBo2oNEogeKQ7wis7EAivL6FdV/dtOXFumiljTGK4SHp84EHHcsZVaIZHNi
         vSow==
X-Gm-Message-State: AOAM533r/n9AQAkNlaq8YY2l3I6iARVcuWTwFiw+IT+nWvVxh8kho9Q5
        w8g28m1jZKgZk9oqhNiO8/w=
X-Google-Smtp-Source: ABdhPJyJxk/i2Mt+3kd2Kcc6jyfxcUA8iEeifyT1g06whWiFnZyRns2udxwRseJhkD5B+60VxISReg==
X-Received: by 2002:a17:906:3bca:: with SMTP id v10mr19919515ejf.57.1599478140293;
        Mon, 07 Sep 2020 04:29:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:598:b902:e05f:7139:914b:4eed:99b3])
        by smtp.gmail.com with ESMTPSA id k6sm13826528edj.93.2020.09.07.04.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 04:28:59 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH v2 2/2] fs: isofs: fix incorrect comment in zisofs_readpage()
Date:   Mon,  7 Sep 2020 13:28:45 +0200
Message-Id: <20200907112845.3420-3-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907112845.3420-1-huobean@gmail.com>
References: <20200907112845.3420-1-huobean@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

do_generic_file_read() has been renamed to eneric_file_buffered_read()
since commit 47c27bc46946 ("fs: pass iocb to do_generic_file_read"), so
relpace it with generic_file_buffered_read() in the comment.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 fs/isofs/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index bc12ac7e2312..7541581c1064 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -312,7 +312,7 @@ static int zisofs_readpage(struct file *file, struct page *page)
 	end_index = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	/*
 	 * If this page is wholly outside i_size we just return zero;
-	 * do_generic_file_read() will handle this for us
+	 * generic_file_buffered_read() will handle this for us
 	 */
 	if (index >= end_index) {
 		SetPageUptodate(page);
-- 
2.17.1

