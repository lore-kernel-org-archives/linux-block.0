Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9206C71153
	for <linux-block@archiver.kernel.org>; Sat,  2 Sep 2023 16:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjIBQlb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Sep 2023 12:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjIBQlb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Sep 2023 12:41:31 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF5DCDD;
        Sat,  2 Sep 2023 09:41:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68a56ed12c0so31834b3a.0;
        Sat, 02 Sep 2023 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693672888; x=1694277688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Dai6Rn13iIFlOKODTu21yMH7mTPIAobImIUwb+rr64=;
        b=k+OGeA+ziqa4YmrN9Kx8LhXlc95JmK88xVGME32wcPQHr/DCNmkHb4w53V6fJGrurZ
         a3QEUPZ2aconp2fdjseOvd3FacdInxFcWJZS12SvWZYqhZZ0JBn+7tiyXRQgaTFIhmfL
         Aff5qLLH4xzcj8ghjJMZ5k1DoupWqn7mb6m1dbfiT3Lrf3AYTeW/bvAlCZZQZXoDCPps
         oLK1scNJ7X1tpvJij9iedSC5p/I9anHxVg6i+BGW0D7V1K8+ThoHRcUgFyUSrc76twYC
         eUZbTRYtRtSpGih9AldKX8ISTAY3TWzlXPeO7oGMVNskQgo6sHyhEKKLR/mbLyiIelhg
         LwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693672888; x=1694277688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Dai6Rn13iIFlOKODTu21yMH7mTPIAobImIUwb+rr64=;
        b=QBFyzC0PSHMEJp+Hk2G/pLecFlFbD6romFCz3Fe/5XOv+xMnI4YPKFro4MSllyeE3p
         C8HcCMvQ8HIOE7Z4G05/pVdgcp6v9PGJC7XSynwXyvHbE+qt1FcAAWMeZDC7QGjSM9+4
         o4WCeyxVyFot0a8qieLr5wu3dWbF2mh7BeTBSMeMAPFYQdh0dkEMZ3kAbjmCMdVv24Xi
         7A3QuoaFB7ArYwOZYlEqXHZj3zotP79DvDNiQImMHob8qzHO51y+NUcaflhcZHkIO6si
         P4sO7wgvE/9JUd65LVwtzMsqJtJXg/i2obevATY6E1EiCQISA3qIkyUCOZyxMNOhRy+n
         8Aew==
X-Gm-Message-State: AOJu0YwKh8cNlgY8myM9TjJCEO5uGf0IuzMiAHe2XB0hL5FZ/MYGHE7j
        Yg/C2ZJw3qVW+MFXPHJzW24=
X-Google-Smtp-Source: AGHT+IHQencBwVyU06k7HcFKjui6Tn7z7XBah7CJH8uDoYk6g9lnMrVbn9Zvc3qPnc1WmZy1bCSbrw==
X-Received: by 2002:a05:6a00:1d87:b0:68a:4bf9:3b21 with SMTP id z7-20020a056a001d8700b0068a4bf93b21mr6537476pfw.0.1693672887667;
        Sat, 02 Sep 2023 09:41:27 -0700 (PDT)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id m19-20020aa78a13000000b0068a3e7634d0sm4744089pfa.129.2023.09.02.09.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 09:41:27 -0700 (PDT)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     axboe@kernel.dk
Cc:     corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] docs: block: blk-mq.rst: correct places -> place
Date:   Sun,  3 Sep 2023 00:41:21 +0800
Message-Id: <20230902164121.2653109-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Corrected a typo in the blk-mq.rst documentation where 'places' was
incorrectly used instead of 'place'.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 Documentation/block/blk-mq.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/block/blk-mq.rst b/Documentation/block/blk-mq.rst
index 31f52f326971..fc06761b6ea9 100644
--- a/Documentation/block/blk-mq.rst
+++ b/Documentation/block/blk-mq.rst
@@ -56,7 +56,7 @@ sent to the software queue.
 Then, after the requests are processed by software queues, they will be placed
 at the hardware queue, a second stage queue where the hardware has direct access
 to process those requests. However, if the hardware does not have enough
-resources to accept more requests, blk-mq will places requests on a temporary
+resources to accept more requests, blk-mq will place requests on a temporary
 queue, to be sent in the future, when the hardware is able.
 
 Software staging queues
-- 
2.25.1

