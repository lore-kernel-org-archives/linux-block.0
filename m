Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07200C433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 03:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F8064F7D
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 03:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhCJDa1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 22:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhCJDa1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Mar 2021 22:30:27 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442C6C06174A;
        Tue,  9 Mar 2021 19:30:27 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id x29so10451756pgk.6;
        Tue, 09 Mar 2021 19:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KsPyOsOWykQSW/wZox8JwY/zrLDLcr1mLpWiPatGTzg=;
        b=hMHLoOlcQkV2ajxAFqORwvFAdOqf1XMg/v+yD9IBRA1SIOtlREO+9cACeK+llfZFBH
         7kcnQaI0Y+VNkOjb+erV8MzGNq01AuoG/HUGYQtggegZl47uQ9ECMGNCdv7MKN3IiyM4
         eUF67eSPxKgYf2f+Gp7j97U5JmrPilX0tVVMcJUPCJ/qnEIr9QxuqBcegiP1uNwufpv5
         66G3N49sxOCTZODWNR8FeGDm9eTsC/oUNJqtxjwf8HgXlZnWkwlTbL6RAD6ruKHCL3MJ
         HvWORF06hAwn3R3EfxuvsN7ypVZicCnPyNQik5F2zrefPAKNYgObGB+DAvL9LigwX+dO
         z+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KsPyOsOWykQSW/wZox8JwY/zrLDLcr1mLpWiPatGTzg=;
        b=MT0ePL6eGgkdor/E1OC5i7cf3g3TQ9xVJWeq/fZ4NJ4UDB3369Qp4r7/fnefKY0Vyn
         h4X9plMsCuMyKiLvaefTNT1OJ9qvvwhJ5KMNNLLgf8pssdVP2vvS189g4fKDwxUcQ9Em
         wT9SVnh0EC+e0a+m/OhTZZRwC9ZEmxNW6K9LGDtSmTENvYrPs7EytyfeNISksOuygDXC
         EPyubSAekDiljeZLKU7MixjS0H8vNcGkWDu/4vd/7IpwQ+e/7UnNo65SgdYOrKKUza6R
         3HSgVoLf5+x7CcA2dsrAFKsS+mfQe1Dty7zdsB9745kV+wrVrFkPdt70A6l/vOEdvsG1
         aJfw==
X-Gm-Message-State: AOAM533pP/9hfrWoh6cVH1Oc2a9p6RbafHrBYUhsS47j+GUpHfOieT2c
        tumM+osAqGS49WxRQK/8oes=
X-Google-Smtp-Source: ABdhPJxY+rd5l3F04CRhpwvTl6X4qVemty/qeILAHZJZxZbOEal7IQtFg0OJk1WS7k0Bi9TtXU6OTA==
X-Received: by 2002:aa7:9614:0:b029:1fa:e77b:722 with SMTP id q20-20020aa796140000b02901fae77b0722mr1030633pfg.2.1615347026675;
        Tue, 09 Mar 2021 19:30:26 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.89])
        by smtp.gmail.com with ESMTPSA id mm12sm4215193pjb.49.2021.03.09.19.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 19:30:25 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     josh.h.morris@us.ibm.com, pjk1939@linux.ibm.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] block: rsxx: fix error return code of rsxx_pci_probe()
Date:   Tue,  9 Mar 2021 19:30:17 -0800
Message-Id: <20210310033017.4023-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When create_singlethread_workqueue returns NULL to card->event_wq, no
error return code of rsxx_pci_probe() is assigned.

To fix this bug, st is assigned with -ENOMEM in this case.

Fixes: 8722ff8cdbfa ("block: IBM RamSan 70/80 device driver")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Drop wrong parts that make no sense.
  Thank Jens Axboe for good advice.

---
 drivers/block/rsxx/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 63f549889f87..d7e2416112ec 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -869,6 +869,7 @@ static int rsxx_pci_probe(struct pci_dev *dev,
 	card->event_wq = create_singlethread_workqueue(DRIVER_NAME"_event");
 	if (!card->event_wq) {
 		dev_err(CARD_TO_DEV(card), "Failed card event setup.\n");
+		st = -ENOMEM;
 		goto failed_event_handler;
 	}
 
-- 
2.17.1

