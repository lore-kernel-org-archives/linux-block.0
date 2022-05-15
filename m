Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12168C433FE
	for <linux-block@archiver.kernel.org>; Sun, 15 May 2022 20:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiEOU6k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 May 2022 16:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiEOU6j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 May 2022 16:58:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326E12C109
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 13:58:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u3so18120779wrg.3
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 13:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o7UgcRxa6R7yPbSvN+oP7olg7rDsqP0whKsr2ay+0og=;
        b=mIhV95ic6915yaiHdhr8kPbISQq64OSAT1Rx+oKacjY89LYBmayR1HPan/Qu28ty5X
         iyALrvBH6S+3oBFJ7XKeziOWmdYFtPR4QXM1ylclF9VcE1hG372fq6LjcXBC7zjSNCuu
         kwLjBZeO++LpJ9NEy6r80PdOdqoaTOczc9/N6GcvH77omGgEa0oy2JVBEqoG3oFszlyK
         j6zD9T6iDMloxeoW5+Tnm78/gkGXEtB2NPpiS7uiDwg8vP6IUjm+IMLAblPE7JEEuund
         WoqbGA12FrdPfeBEizr6LRkTJdjVI2SPKaynoDXgYKldqTEcDEIzQ3XcQdd6C69LHgaL
         djyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o7UgcRxa6R7yPbSvN+oP7olg7rDsqP0whKsr2ay+0og=;
        b=P3SG4LwZXmFooY0wcNjBWOPG5HPA1Jv5IHzr58A74VV5PTBxUR0HIaQsZ60F34L2k4
         7Kr7l/VQFkEb5DlU64xaEbw0TjZ+Ur2n7ohIFajKh8MSiteaZQMIYgXjTo4cegM9OJ+4
         +cKSjTx7um37O5N1q4fIQC9mETCB9tWUHcu5xUkNsL0G54rxEH75h5ShpCXlkkthRzew
         DYIP2RIkFMlseHe0C4OVsT4a4SnTlUrWKEC+2RLBlteWcbO2UO0/2C9Qs+XiAHram6ki
         n28L0ZP96gJxtMkuKl9MlY8NO4oEIVyBA2vrhXCzeYJWa9fcgLKXi0R0JE8BDAbqwZFx
         R0ng==
X-Gm-Message-State: AOAM53304tSTQQBI2amgrZgPb6jk6EEQ0WVpeVyowlP+IaVfT7kkxqbv
        tixfkm+BUN/V1Ptz6rHxGEYZvA==
X-Google-Smtp-Source: ABdhPJzMn0hiBqmMGroZCfe1j9XH1JZvMDNvyTmah/QWSU2ZFU6+7dk/bSb/5tv3zi7UeM4UTM1xmA==
X-Received: by 2002:a5d:620c:0:b0:20c:f50a:dafa with SMTP id y12-20020a5d620c000000b0020cf50adafamr8813288wru.460.1652648316782;
        Sun, 15 May 2022 13:58:36 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id r17-20020adfbb11000000b0020c5253d920sm8922074wrg.108.2022.05.15.13.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:58:36 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/5] cdrom: remove the unused driver specific disc change ioctl
Date:   Sun, 15 May 2022 21:58:30 +0100
Message-Id: <20220515205833.944139-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220515205833.944139-2-phil@philpotter.co.uk>
References: <20220515205833.944139-1-phil@philpotter.co.uk>
 <20220515205833.944139-2-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

This was only used by the ide-cd driver, which went away in
commit b7fb14d3ac63 ("ide: remove the legacy ide driver")
so we might as well take advantage of that and get rid of
this hook as well.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Phillip Potter <phil@philpotter.co.uk>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Link: https://lore.kernel.org/all/20220427132436.12795-2-paul.gortmaker@windriver.com
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 Documentation/cdrom/cdrom-standard.rst | 10 ----------
 drivers/cdrom/cdrom.c                  |  8 --------
 include/linux/cdrom.h                  |  1 -
 3 files changed, 19 deletions(-)

diff --git a/Documentation/cdrom/cdrom-standard.rst b/Documentation/cdrom/cdrom-standard.rst
index 52ea7b6b2fe8..7964fe134277 100644
--- a/Documentation/cdrom/cdrom-standard.rst
+++ b/Documentation/cdrom/cdrom-standard.rst
@@ -218,7 +218,6 @@ current *struct* is::
 		int (*tray_move)(struct cdrom_device_info *, int);
 		int (*lock_door)(struct cdrom_device_info *, int);
 		int (*select_speed)(struct cdrom_device_info *, int);
-		int (*select_disc)(struct cdrom_device_info *, int);
 		int (*get_last_session) (struct cdrom_device_info *,
 					 struct cdrom_multisession *);
 		int (*get_mcn)(struct cdrom_device_info *, struct cdrom_mcn *);
@@ -419,15 +418,6 @@ this `auto-selection` capability, the decision should be made on the
 current disc loaded and the return value should be positive. A negative
 return value indicates an error.
 
-::
-
-	int select_disc(struct cdrom_device_info *cdi, int number)
-
-If the drive can store multiple discs (a juke-box) this function
-will perform disc selection. It should return the number of the
-selected disc on success, a negative value on error. Currently, only
-the ide-cd driver supports this functionality.
-
 ::
 
 	int get_last_session(struct cdrom_device_info *cdi,
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 7e2174f597f3..e43bb071fe92 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2452,14 +2452,6 @@ static int cdrom_ioctl_select_disc(struct cdrom_device_info *cdi,
 			return -EINVAL;
 	}
 
-	/*
-	 * ->select_disc is a hook to allow a driver-specific way of
-	 * seleting disc.  However, since there is no equivalent hook for
-	 * cdrom_slot_status this may not actually be useful...
-	 */
-	if (cdi->ops->select_disc)
-		return cdi->ops->select_disc(cdi, arg);
-
 	cd_dbg(CD_CHANGER, "Using generic cdrom_select_disc()\n");
 	return cdrom_select_disc(cdi, arg);
 }
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 0a89f111e00e..67caa909e3e6 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -77,7 +77,6 @@ struct cdrom_device_ops {
 	int (*tray_move) (struct cdrom_device_info *, int);
 	int (*lock_door) (struct cdrom_device_info *, int);
 	int (*select_speed) (struct cdrom_device_info *, int);
-	int (*select_disc) (struct cdrom_device_info *, int);
 	int (*get_last_session) (struct cdrom_device_info *,
 				 struct cdrom_multisession *);
 	int (*get_mcn) (struct cdrom_device_info *,
-- 
2.35.3

