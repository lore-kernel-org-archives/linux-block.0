Return-Path: <SRS0=DC0a=XA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1EAC43140
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 19:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA531206BA
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 19:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="uRIJnd9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbfIETFA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Sep 2019 15:05:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45524 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfIETEv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Sep 2019 15:04:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id r134so2909552lff.12
        for <linux-block@vger.kernel.org>; Thu, 05 Sep 2019 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AC8KgIe4I7rl1Y9J8H47wCl1hvzWhHksXFFSMwfg7Kk=;
        b=uRIJnd9txX+OH9zCEWQr7/dlRYQBxnJMan0+PSBz7Dlf5LYejzl8XmcdYmyGZQzyXH
         ZkEKIe+qNzkYdGU9ruhH49Djly4L5AJ92znRVMxFOixF164+nVdru1Al1ERLaMRvMYzX
         Nigbbqb9NZf5b+1xaZ4JOELzfEsIjMtUY1q1kfuli5/NOSBEv2XMbj06SUpZEG1C7Qk0
         YmMrBoYov8lfgmMBLbqem1fMhZgCDAOJ4buI9xyep/TxEno3jIqDskvnSCmOcqTqj3xI
         cN3yZsSPcmN5345m9dzwL6NO9vDHko0nHnsuxDxPN5tXIKtkpi7LHHUXs/+NwCyGuCSj
         KfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AC8KgIe4I7rl1Y9J8H47wCl1hvzWhHksXFFSMwfg7Kk=;
        b=hc0TKIaLX5CNFSC+6IKJVmBGv4DMOOfp1mP+hA1T25cqzSFIf0Q+7Xe+iS25FqvGBK
         1/zxMM+iqwqnao9TfRbU5tCEFxIdW+lpo/0QzCZ7cg/MT6OH6yUEyzc1MHEz+AT/Golv
         BqvBfQNsRpRaOkRlkRpX+e09pHTGj6tAqSVRV6RsgEQkIlHJjYdCdofFnMrx6oy+/5XX
         II7OXTK0ndZlm5Ig5aqDf2/TzUjg1CevippZUTkRCT0jd+mwTlTj5tL2lXl1vvzAOzkj
         7tg5KfE23gSQvOgJsBOjCUsDoUj/NeyEnxla92WCU0jdcUe3PITGueA5+RnS3Y/q2cAt
         aePw==
X-Gm-Message-State: APjAAAXHbZoWDGVTA3EMPDPqdhH5tdohyvreuOgEx+W14z46SMSoXHe+
        jrhKVIkt4iAckf0k5W2kI6R2lw==
X-Google-Smtp-Source: APXvYqzhbW5wYGXm1TidPCZIsQJ3itdNp6WmZYAM1OnVEmjREx5ULvto3nGRPRtzFhk70zZ4BFBtDg==
X-Received: by 2002:ac2:4359:: with SMTP id o25mr3456523lfl.147.1567710289343;
        Thu, 05 Sep 2019 12:04:49 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id 6sm599037ljr.63.2019.09.05.12.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 12:04:48 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 2/2] lightnvm: print error when target is not found
Date:   Thu,  5 Sep 2019 21:04:33 +0200
Message-Id: <20190905190433.8247-3-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190905190433.8247-1-mb@lightnvm.io>
References: <20190905190433.8247-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Minwoo Im <minwoo.im.dev@gmail.com>

If userspace requests target to be removed, nvm_remove_tgt() will
iterate the nvm_devices to find out the given target, but if not
found, then it should print out an error.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
Updated output string and patch description.
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index f88d4e57cff8..7543e395a2c6 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -495,8 +495,11 @@ static int nvm_remove_tgt(struct nvm_ioctl_remove *remove)
 	}
 	up_read(&nvm_lock);
 
-	if (!t)
+	if (!t) {
+		pr_err("failed to remove target %s\n",
+				remove->tgtname);
 		return 1;
+	}
 
 	__nvm_remove_target(t, true);
 	kref_put(&dev->ref, nvm_free);
-- 
2.19.1

