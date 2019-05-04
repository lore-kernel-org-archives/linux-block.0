Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513AEC43219
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CC12084B
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="Nbwf3XKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfEDSin (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 May 2019 14:38:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44152 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfEDSik (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 May 2019 14:38:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id c6so2433137lji.11
        for <linux-block@vger.kernel.org>; Sat, 04 May 2019 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5O6MLyuJzTZCFkCSq5yloQt0fdGoVw3zgENohA8hO08=;
        b=Nbwf3XKwBmJoTj14dk59ALfYH+iU3xwyWgEGC+X7Ci+hsaGlkaVIlZgpOcGhqqR8xe
         C+fkUeJAEeOWFsrtujSTwNLkxdcZOdeffxyPNAtHHdTGfsudMB7xVpkaiacGaaaUP/ZO
         f2/jpfMkyv/FjymZbTk3WMj96GfndLQGfKeGP+8Ke5sWPPlEYOW6JpGouslht/hImfm+
         NExUJyFd7A06vSvOQ9YbxDUUfwzSYNTTnCsRebIZG3/xrqbT6sjH3rgDUNwMHdVCJwUT
         bMDyeudN8TEfx5hebgcy+N1SgFwBIYoGSkneT/D5YnwyXW59mPDdfAtn5eMEt0pwU+Cz
         SU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5O6MLyuJzTZCFkCSq5yloQt0fdGoVw3zgENohA8hO08=;
        b=ZdlrM0mUcXyKGrh7+LHvb4UCY03qwY/GBg9n8TSP1RzY+czvmKdQwL4t9zO1B2580Q
         uFE3lkgNtK6hPAdtcXFxImfF0m1T6lq24/k5Q74iPqMTYIytvF/JIK3lev27sTX8xUEJ
         luQHxLhu082mtv83XcQJ7lffuCPj2a+4Y09Xgexri0IYFBsbfdSDU728rxJOrKkQq7SS
         dD72wbbGBCCbY91yxMQVYV1dCL9YDsS4qHj7itcyWqwA+cZaJiB6gJB55ZvJp7rwKgbB
         ppIWRojKHuxJFH5mYgfqbj0d/yVq1aJVltU+XMkX+snyOlQjMvHwwxObeL4eAPfxwWKA
         ev1g==
X-Gm-Message-State: APjAAAXIhpWJFCMWL3lnmIz1e7Uyh/QOJtBezOlHHF6QIgT3eVUR5YFj
        W7qVUIigsjL00oalDOKR3sOWuQ==
X-Google-Smtp-Source: APXvYqxulArf5fnY87m4TK4QnGXQiIo3lPF8Za4+XQ+vQ2loWp9Fgs21Ekh3wK6iNhdRM9+5SJP50A==
X-Received: by 2002:a2e:97c1:: with SMTP id m1mr2669190ljj.59.1556995118365;
        Sat, 04 May 2019 11:38:38 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:37 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 13/26] lightnvm: prevent race condition on pblk remove
Date:   Sat,  4 May 2019 20:37:58 +0200
Message-Id: <20190504183811.18725-14-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Marcin Dziegielewski <marcin.dziegielewski@intel.com>

When we trigger nvm target remove during device hot unplug, there is
a probability to hit a general protection fault. This is caused by use
of nvm_dev thay may be freed from another (hot unplug) thread
(in the nvm_unregister function).

Introduce lock in nvme_ioctl_dev_remove function to prevent this
situation.

Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index c01f83b8fbaf..e2abe88a139c 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1340,11 +1340,13 @@ static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
 		return -EINVAL;
 	}
 
+	down_read(&nvm_lock);
 	list_for_each_entry(dev, &nvm_devices, devices) {
 		ret = nvm_remove_tgt(dev, &remove);
 		if (!ret)
 			break;
 	}
+	up_read(&nvm_lock);
 
 	return ret;
 }
-- 
2.19.1

