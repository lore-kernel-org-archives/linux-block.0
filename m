Return-Path: <SRS0=qpPD=UU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8D2C43613
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 09:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919B4215EA
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 09:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="sSFnuYhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfFUJMN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:12:13 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40635 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfFUJMM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jun 2019 05:12:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id a9so4504003lff.7
        for <linux-block@vger.kernel.org>; Fri, 21 Jun 2019 02:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k4aXc+WCbb0KX3YXwP2LFgbpd81EOKzrd5cyRZaZTSg=;
        b=sSFnuYhsFN1JD56EIiE1pEfjm6C0QSyZG31411kwJRybXeYFh6pC5C8yQp22lVlwXe
         0RZW82JsiuTifNXgpYfDvor7psQ1a+TZHnK57CSfKwGHg+AeqA4JmUZrBMhfnlvhPGET
         K5cisM7SCV5xW754YlV5rHRAgZN9L262ZefebDu/MTCz8ZLuXTwkkfmzCTXJTdXuO1Ub
         e6Bo+iqKVs6StBtV4THNiGApkGGzW/T9Bnkiacm15kj30YQfuNKOrQcErGQ8y1FS5OOa
         /xzpWU9gkb9vV2I8975rGq7NbVaO18XGeU6FmtFxgNTnIgzW5g/LSYuJzeYPkJrnCn75
         py3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4aXc+WCbb0KX3YXwP2LFgbpd81EOKzrd5cyRZaZTSg=;
        b=IFMlII8dC24KAhJojubpnr5ZgJka6i3ESCKU4AdrmKEBY6sNPjJSIknJ4u+hDhMuaO
         Qx4aO2/clC04In1xbKlYIVfzDyU6YPAjTmYP16hNiQhbQ4HIrkE6XDzNnqwnbCUIRUyW
         JA2z8sp6/8HYJ/factm2LqjU2/e1bv9tpuQl6/ubffUR2PR1mKsAkiv59RLNc1KeltHK
         OaokIOeX/x51PLfnVvfxa26ldL/499oIgOYmGpYNuLhoZBh+Agz4UEfOExx8zgO1i75S
         pu5vwUuej8H4ylxvB91LucVGCjo3lV7Ijrjv7xyHfCUTwJdF3hu8p3IuNUBJPWczODiT
         8OoA==
X-Gm-Message-State: APjAAAVMJTAw0ngaKjv6EjivbmaTjGrB/MRY7IR3G8DOKav/DOH3+fkO
        AKxxcO2gGehaf2lewVbrCPMIy1ny3Go=
X-Google-Smtp-Source: APXvYqzvbOWqaN5hXsBK1NV7YAT9x6a/dav5F34bCxNcV082rL8AhKA+NiD88XxrJVwsEh/8uCeRfA==
X-Received: by 2002:a05:6512:24a:: with SMTP id b10mr65728968lfo.37.1561108330334;
        Fri, 21 Jun 2019 02:12:10 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id z26sm303178ljz.64.2019.06.21.02.12.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 02:12:09 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 2/2] lightnvm: fix uninitialized pointer in nvm_remove_tgt()
Date:   Fri, 21 Jun 2019 11:12:00 +0200
Message-Id: <20190621091200.23168-3-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190621091200.23168-1-mb@lightnvm.io>
References: <20190621091200.23168-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

With gcc 4.1:

    drivers/lightnvm/core.c: In function ‘nvm_remove_tgt’:
    drivers/lightnvm/core.c:510: warning: ‘t’ is used uninitialized in this function

Indeed, if no NVM devices have been registered, t will be an
uninitialized pointer, and may be dereferenced later.  A call to
nvm_remove_tgt() can be triggered from userspace by issuing the
NVM_DEV_REMOVE ioctl on the lightnvm control device.

Fix this by preinitializing t to NULL.

Fixes: 843f2edbdde085b4 ("lightnvm: do not remove instance under global lock")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 7d555b110ecd..a600934fdd9c 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -478,7 +478,7 @@ static void __nvm_remove_target(struct nvm_target *t, bool graceful)
  */
 static int nvm_remove_tgt(struct nvm_ioctl_remove *remove)
 {
-	struct nvm_target *t;
+	struct nvm_target *t = NULL;
 	struct nvm_dev *dev;
 
 	down_read(&nvm_lock);
-- 
2.19.1

