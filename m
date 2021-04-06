Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C722C43460
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643A7613AD
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244184AbhDFHHx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244192AbhDFHHs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 03:07:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F0BC0613D9
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 00:07:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h10so15176958edt.13
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 00:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2s7RNT3LX8gTuZCICYSmyJWDdR3TrhGuTgZQuuJS2r0=;
        b=BTEOV8igl7doqN0wAM4fVRQ/JhTPJ87oFsAv4b4mf+Fx9jI6x+2BJrrwxeonZu3Jlb
         BcDqSJuT8oHXByU3AYxbZXPaEaQxd4OM39nAwjqLexMXsVcWbDbNg4C5GLtAFPejuMHe
         7TaDh+poHfNp1jCsO9Tx6mE7iJ7Pm5Wo8POrN8cooJQ0DMWRtXIAnVXiAilR+RdBKa58
         5usc74sUl/jX4O3KgGAsVTEWfUIGgZ7LRKaITH8MJzrJkvdQM77qyuUP1ZVd3G0yEduM
         EERedtLO1SPJ4NtkVIBQuGZgy00ikaKN5C2bT+RM2KH5BPYfgfKQQW40YMxehO0k8K4o
         w54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2s7RNT3LX8gTuZCICYSmyJWDdR3TrhGuTgZQuuJS2r0=;
        b=FKI/CGlFXNrapuGMKxBn9MbV0HNmJAaV/bJnVD2Y4IGz/XWDWrSBYI8d8y4qXi0lnI
         A/tvrq661VvQqb9nrenEskANjAo7f4kUMmya+nuqZ+7ZULaO9sy7/C6Xi1DPeynYOJCB
         gtB51XpJ0b1+blWRZhBU/sYSOF5egQGoC1aA/AZ9IrfWSA4ihtAhTBPcXigHge6WXYt+
         /pc5+wADHl52G/x6nTntkRKvzkX1zzZLm+DPM5maOcXJx+RjRvppmz6FmafjwQNSY4hX
         xelZSpk9UBF2hP33hLxN041tHJxt73FPeJt/Xp8VsGJEu5RTP4I4etEdrSWUXQLv0Jzz
         BP/Q==
X-Gm-Message-State: AOAM530eJd63BrIEASIi3Z4ZkmZtNM7avzKR7oZDMgmUJGfCUSWsCU3w
        QFbIgPrvp7Rhqn+Aghh/z0Lgya7942GTJ1V6
X-Google-Smtp-Source: ABdhPJxKyfUuGoAxriaXXPYyA/GCVBcWMsEswwJPKeXp7axcs/ycBMnM5KrIWRG7MAXR3eapl7GaQQ==
X-Received: by 2002:a05:6402:394:: with SMTP id o20mr10963660edv.10.1617692854607;
        Tue, 06 Apr 2021 00:07:34 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id rh6sm3976566ejb.39.2021.04.06.00.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 00:07:34 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>,
        Dima Stepanov <dmitrii.stepanov@ionos.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCHv3 for-next 18/19] block/rnbd-clt-sysfs: Remove copy buffer overlap in rnbd_clt_get_path_name
Date:   Tue,  6 Apr 2021 09:07:15 +0200
Message-Id: <20210406070716.168541-19-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406070716.168541-1-gi-oh.kim@ionos.com>
References: <20210406070716.168541-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>

cppcheck report the following error:
  rnbd/rnbd-clt-sysfs.c:522:36: error: The variable 'buf' is used both
  as a parameter and as destination in snprintf(). The origin and
  destination buffers overlap. Quote from glibc (C-library)
  documentation
  (http://www.gnu.org/software/libc/manual/html_mono/libc.html#Formatted-Output-Functions):
  "If copying takes place between objects that overlap as a result of a
  call to sprintf() or snprintf(), the results are undefined."
  [sprintfOverlappingData]
Fix it by initializing the buf variable in the first snprintf call.

Fixes: 91f4acb2801c ("block/rnbd-clt: support mapping two devices")
Signed-off-by: Dima Stepanov <dmitrii.stepanov@ionos.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index 5609b9cdc289..062c52e7a468 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -515,11 +515,7 @@ static int rnbd_clt_get_path_name(struct rnbd_clt_dev *dev, char *buf,
 	while ((s = strchr(pathname, '/')))
 		s[0] = '!';
 
-	ret = snprintf(buf, len, "%s", pathname);
-	if (ret >= len)
-		return -ENAMETOOLONG;
-
-	ret = snprintf(buf, len, "%s@%s", buf, dev->sess->sessname);
+	ret = snprintf(buf, len, "%s@%s", pathname, dev->sess->sessname);
 	if (ret >= len)
 		return -ENAMETOOLONG;
 
-- 
2.25.1

