Return-Path: <SRS0=HXqG=57=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27176C2BB85
	for <linux-block@archiver.kernel.org>; Wed, 15 Apr 2020 09:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0177E20768
	for <linux-block@archiver.kernel.org>; Wed, 15 Apr 2020 09:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="AP01Fz+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895334AbgDOJV6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405298AbgDOJV5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Apr 2020 05:21:57 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E61C061A0F
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2020 02:21:55 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k11so17609856wrp.5
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2020 02:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lsw/Iaiux+MLh4zGmzRDP0c55QH0mpEc78oqXzNiG98=;
        b=AP01Fz+J3iar2E8zAzRwSbGq6J5btXocj1naiyK6aV6oO2naqSE3EQZ3ZRr6JeqT0C
         YNfSOjiXOgYT030rl1G8vLdrb5iVUsISZkvKL2AvDIWK6hWPglbg3jDKoYveRo2xTlSU
         sHXOrYhBuMqfXbIPABFtsM6AOu7xVsX1pBW15pI0mEXvvNLYD48d0yYZMWkhjL8NyTOJ
         NAHwRZlhKQ36mSBqQ2QMV4DyfczF0Fb8asvbogbkytqebyvo+omP3WqWQX/XuosNxkIe
         kIIzu1c8XrcOeltLaJ53JvMlTgtvlQfWdacIaPTkN1hlotbcOaUUwOCbiL2MELj+BK3k
         2D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lsw/Iaiux+MLh4zGmzRDP0c55QH0mpEc78oqXzNiG98=;
        b=lUIQwTPzNYSFym3rUam25Ttn2GSBV15lao/41bc4ggcVzBhTLlW7DrM3oYQ4e+mPZx
         Th3iFR0/ydVFSRh52EM53zKh1SE6B8NpGLXVo/7CQcZwqEfWU9r9KCYw2y1U8aYSpL0r
         /vJyFGGCDY54n8k73AYtyL1muAC9gCvoRdWCC70sfZRg1hRDp2C7bCeJk/5ikueBgzii
         4Haoe6JY4bVnHTI10iYUPiUbHhxUjYBf96N50YcRIn4gYZVGfUhmkgmAVPMNFi+tkkhT
         3vZyE7s8+cyKOmB83v7Dzk0EgM8fBWWYT0yYgbmoKvbvHS+uCxaNZhXNfBDLufwDSOP3
         K6Lw==
X-Gm-Message-State: AGi0PuY9EpBNlkIyIXl+BAg44w4KzYblJ+Y14tDH8dXoGcR38OMu6yPW
        Ikbawb8bMH81CUizoAbXTBcXzTsF0BjJWKQ=
X-Google-Smtp-Source: APiQypLsqG22QZWeFoVMXZG8q5JrTXXNY5wde4LPzpchrO/6FZiARk3OSMxWx53p8sQ3RQF2n6+qAw==
X-Received: by 2002:adf:e3ca:: with SMTP id k10mr11353040wrm.53.1586942514244;
        Wed, 15 Apr 2020 02:21:54 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-231-072.002.204.pools.vodafone-ip.de. [2.204.231.72])
        by smtp.gmail.com with ESMTPSA id v7sm22534615wmg.3.2020.04.15.02.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:21:53 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v12 01/25] sysfs: export sysfs_remove_file_self()
Date:   Wed, 15 Apr 2020 11:20:21 +0200
Message-Id: <20200415092045.4729-2-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Function is going to be used in transport over RDMA module
in subsequent patches, so export it to GPL modules.

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
[jwang: extend the commit message]
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/sysfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 26bbf960e2a2..d81f9f974a35 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -492,6 +492,7 @@ bool sysfs_remove_file_self(struct kobject *kobj, const struct attribute *attr)
 	kernfs_put(kn);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(sysfs_remove_file_self);
 
 void sysfs_remove_files(struct kobject *kobj, const struct attribute * const *ptr)
 {
-- 
2.20.1

