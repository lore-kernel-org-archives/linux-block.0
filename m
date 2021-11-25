Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DB7C433EF
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 16:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbhKYQsI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240328AbhKYQqI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 11:46:08 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0F3C0613F4;
        Thu, 25 Nov 2021 08:21:10 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z6so4889449plk.6;
        Thu, 25 Nov 2021 08:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DrbLxcTRIr7XI7NN202x3ewaW1KuzI3sJcKCkLAzcmM=;
        b=eA+6e4w/ezBqGCpY3Pun4HZFK3eTUelIhd2INadnJK6U9EDT0C2iuabO21nkJe7co3
         o5cnx02pBObO8CBFHp+4nQAxZtRV+0H5kD6VUPvhLZmpx6akXCOJA8GKPPxP5Ql+vSOF
         nvxTyVPQ/fllOZ2YtphAylFiTdHV4IYu0vryeC4hi1mlXBAHQPtWAUE80DPmoi6hQvJS
         3PVPw1zLVmtK3nBJTyCnTJOYBZniHlMa0fy2gs93Mxvkj3AbC9vzDByLYuIcKYTfDgXF
         zCQIGN/R+W/w01EZWn/ismo/gEdG7hQ7+HERbjCWy5xFk0F0PZOE72redURGw3+cAx//
         9B7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DrbLxcTRIr7XI7NN202x3ewaW1KuzI3sJcKCkLAzcmM=;
        b=3bYhYAbskmVBMGSEmdo84eItD2wNoCCPhJQaCC2ryVMml9zvyShqPEI6FT7VWOWBLy
         3wXUQJ8ynXyjREo6C6aUNc3VOaN3gUPMmOMwWBuIIn1O3GRghAkmjtyI+2O0yMERkSBr
         oPmdTXn4cyWYpSN+6M0tQD6CKifLn9W8LjmpMEhWPWtCJXUXIexYZz2erlU62aqnEUVp
         LvgU0zhpa84Wk7O2gjSleR6pChKvc+w4VkMBkjE1fepD4/tmMdf7v7fTa10Q4vXkoJhW
         Y+RYWaVPQ8D+nsbenpTnbALqzxxip1+cy7EwsBuP3ZeY3z67foemkSd2PqgYBkgllqHj
         RAUQ==
X-Gm-Message-State: AOAM532Fg/6iYJwUVJB59R2aEe27o636faeBeWrGtUOjEyehrPA9lCzI
        g+SAHxgQ8Nn+5ItvgX9/TTA=
X-Google-Smtp-Source: ABdhPJxsPhjikOXxK/FanZR/y7bHOeNPfej/eLeGxgNWY3N8O9RzC7HzghgJhix7hGxdN6Eco7ovtg==
X-Received: by 2002:a17:902:c745:b0:143:d220:9196 with SMTP id q5-20020a170902c74500b00143d2209196mr31489461plq.74.1637857269919;
        Thu, 25 Nov 2021 08:21:09 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id 63sm3919685pfz.119.2021.11.25.08.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 08:21:09 -0800 (PST)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     axboe@kernel.dk
Cc:     davidcomponentone@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] block: fix parameter not described warning
Date:   Fri, 26 Nov 2021 00:20:55 +0800
Message-Id: <acf6fdca867ff78a13099ea6615ac39d69bbfc9b.1637825871.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

The build warning:
block/blk-core.c:968: warning: Function parameter or member 'iob'
not described in 'bio_poll'.

Fixes: 5a72e899ceb4 ("block: add a struct io_comp_batch argument to fops->iopoll()")
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>

---

Changes in v2:
- Add fixes tag
---
 block/blk-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 143cc21db5ef..b0660c9df852 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -958,6 +958,7 @@ EXPORT_SYMBOL(submit_bio);
 /**
  * bio_poll - poll for BIO completions
  * @bio: bio to poll for
+ * @iob: batches of IO
  * @flags: BLK_POLL_* flags that control the behavior
  *
  * Poll for completions on queue associated with the bio. Returns number of
-- 
2.30.2

