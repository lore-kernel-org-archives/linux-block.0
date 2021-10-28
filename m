Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B010BC433F5
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 02:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B5260527
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 02:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhJ1Cyr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 22:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJ1Cyr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 22:54:47 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C50C061570;
        Wed, 27 Oct 2021 19:52:21 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id y1so3375192plk.10;
        Wed, 27 Oct 2021 19:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jcnGJtdrqaa1AmyqKqYK6KAUEoUhmNr+Rf2cHbtAGQ0=;
        b=YUgoDPiKp3MhHStufYQZ+0PnS0nsUB4159fpXiGORH1AD355ROMhqTq7sc3SbICgjg
         j853duYB5m7osB/4hWBDIRWyk86cX/diOCWCiNRjoEb1yD1p53h2h8ryjOUHS1sqE+4V
         tc1Gg/GW3zEKMY2DnMKzIC8bdr1YNgoPTwCjVQeDyO98kiWJIZ2lQK+GDl5E8OACiGpa
         RyDmQ7kdZ0GOLpxuZ7ApdfwcTsiSDtdEdj3n635Jew9BCroLTzm1tjSMSIcTbGcQubni
         z8rs9ErbjqLmm0pM5AYnY2NZ0a8VUC/mCvwuXCnk/L+Vwnr3uetwLI8KPLZ1ERAmBAx4
         htpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jcnGJtdrqaa1AmyqKqYK6KAUEoUhmNr+Rf2cHbtAGQ0=;
        b=icPuCojcdM0GRsTg8TzZn2Xa5ljZ+M+FW8Y8rYw4UutvxpkELOxfgwOko7juhVGq1d
         kycKe5iqdVJE0GPe4oc4NPv6w76uSX30nu/saFJiFvHOubQsli+U8GD0uDLM1T8LfODE
         sH2XVzI1y8jhj3jd9BT+Tu+3weDQhpbjrpzphrWP6MGcJXK1gijZK5v+VonpN/wpxvAo
         Kty7bPUZ4rBpZewicf0lGxN1+VcoAzzfOJscqK5HqX8BFxcFtmqBte+q+uNzDKPp1hPj
         Z/xUEK2yRYrr8lr4F5VgB6rJ/28AFlFFlsjrxUafElhjxk6JrmQG0LHxuHbrfEhTdW5M
         Rh+w==
X-Gm-Message-State: AOAM532ggZDNV4eosoGOuEN/hTCAqqPbX+n6v0nRahGKAqXsfLoPf/NN
        hMRVgpM5o1h8kmFosWVA+EE2v2wUlUU=
X-Google-Smtp-Source: ABdhPJwenHZAgCv/dulADK6JKovBLqpDmaLXW2UAdA+cIgUMPX8scwGDbWtCoTsc7KVf7hgIgm1Wgw==
X-Received: by 2002:a17:902:ab50:b0:13f:4c70:9322 with SMTP id ij16-20020a170902ab5000b0013f4c709322mr1233924plb.89.1635389540905;
        Wed, 27 Oct 2021 19:52:20 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b13sm6030673pjl.15.2021.10.27.19.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 19:52:20 -0700 (PDT)
From:   luo penghao <cgel.zte@gmail.com>
X-Google-Original-From: luo penghao <luo.penghao@zte.com.cn>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] loop: Remove duplicate assignments
Date:   Thu, 28 Oct 2021 02:52:16 +0000
Message-Id: <20211028025216.10737-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The assignment and operation there will be overwritten later, so
it should be deleted.

The clang_analyzer complains as follows:

drivers/block/loop.c:2330:2 warning:

Value stored to 'err' is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 drivers/block/loop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1f91bd4..941b482 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2329,7 +2329,6 @@ static int loop_add(int i)
 		goto out_free_dev;
 	i = err;
 
-	err = -ENOMEM;
 	lo->tag_set.ops = &loop_mq_ops;
 	lo->tag_set.nr_hw_queues = 1;
 	lo->tag_set.queue_depth = 128;
-- 
2.15.2


