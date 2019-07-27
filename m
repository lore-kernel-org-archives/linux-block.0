Return-Path: <SRS0=8nuL=VY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE39C433FF
	for <linux-block@archiver.kernel.org>; Sat, 27 Jul 2019 18:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E982087C
	for <linux-block@archiver.kernel.org>; Sat, 27 Jul 2019 18:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM5kJK/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbfG0S0j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Jul 2019 14:26:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38633 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388044AbfG0S0j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Jul 2019 14:26:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id f5so17433895pgu.5;
        Sat, 27 Jul 2019 11:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0/WFTXFh8VdFeha4sOv1sy8hRLL0ZORE8CbLTzAFxDU=;
        b=jM5kJK/QG896IzPX8gLWoIbGB1GZb4bGfTFin1fzKFOk4db0gRJwIe1CP5hvXFVGgz
         JN+iZkM/AstYm00x0Y6l2ey4CN3v1VD285jZ4leXt6IiT+54qApHgq0UaSffo3Fr6Gz6
         WJ5VsVEtmhv4fRe0LgiHx1nnTBlEc95P5H7XMG3fqA/R2o5STmfP8sqe2IoZiRuIz0fr
         xOpIJ3YzycIftBxYSto+u5ZFyZ2bdTrxcS2IDiQpzazSGzSgeizQgG4r2h/RJkVW4r2w
         Hf4B6p2vV6cmdAfMIKIKkGG2bL1bn2HxJu2mvyGVyjOwIG6WnB3l9uj3AMjXM5mQ5sEu
         6asQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0/WFTXFh8VdFeha4sOv1sy8hRLL0ZORE8CbLTzAFxDU=;
        b=KgDVUPJSNFKi6G5iDa8NQ8+k8IU0DsVFdGY0C6iH+zGVqKHiJ2h/ul/MqK8uAYSJjR
         rRwowqvc0qF+odhjA698jfowplrJqPh0nORoqVA6IVNLH78GpfA/Nju9/v6SYx/bgyaR
         Za1NotlA8WMJ5klPNBfyLK5zIws7dAOOfuwubnuFajHg2q//ux9NUZkZQi1aZcg2aKui
         jNhfchBOT2XL+8DYEh9gGrNzpbZpOXlCq7lYRv5qwTFdFW1lYCYTkpodPjok/9QlamZp
         DAYBuRaogANFasmFoG0NUo5F8EdFqtfod0cuzJxXS1NW7nHzell4eQw9nHJrOLSROVSo
         ujGw==
X-Gm-Message-State: APjAAAUR/lodS6KUmMyGkPEiKhhRCGZil1zDl6JooHlsTzil4TbB1WVd
        OzE9V2r74umsxRTYkuSXX5oo8HctNE4=
X-Google-Smtp-Source: APXvYqzW8q1PgFJz1qu0su24N6Jk/O2UxB7FTG/76lB0tPQi6e1h2r2jUUkLDfIuu7O6sMS1A/wkfw==
X-Received: by 2002:a63:d741:: with SMTP id w1mr22068419pgi.155.1564251998108;
        Sat, 27 Jul 2019 11:26:38 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id w4sm75161780pfn.144.2019.07.27.11.26.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 11:26:37 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Klaus Birkelund <klaus@birkelund.eu>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
Subject: [PATCH 2/2] lightnvm: print error when target is not found
Date:   Sun, 28 Jul 2019 03:26:26 +0900
Message-Id: <20190727182626.27991-3-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190727182626.27991-1-minwoo.im.dev@gmail.com>
References: <20190727182626.27991-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If userspace requests target to be removed, nvm_remove_tgt() will
iterate the nvm_devices to find out the given target, but if not
found, then it should print out the error.

Cc: Matias Bjørling <mb@lightnvm.io>
Cc: Javier González <javier@javigon.com>
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/lightnvm/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 4c7b48f72e80..4c89a2420a51 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -494,8 +494,11 @@ static int nvm_remove_tgt(struct nvm_ioctl_remove *remove)
 	}
 	up_read(&nvm_lock);
 
-	if (!t)
+	if (!t) {
+		pr_err("failed to remove target %s not found\n",
+				remove->tgtname);
 		return 1;
+	}
 
 	__nvm_remove_target(t, true);
 	kref_put(&dev->ref, nvm_free);
-- 
2.17.1

