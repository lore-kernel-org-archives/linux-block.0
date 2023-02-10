Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C48C05027
	for <linux-block@archiver.kernel.org>; Fri, 10 Feb 2023 01:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjBJBGZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 20:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjBJBGY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 20:06:24 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854196BD30
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 17:06:18 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so3002831wms.0
        for <linux-block@vger.kernel.org>; Thu, 09 Feb 2023 17:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iCWKyH/7wWZc1RDLBH2bNGa2a2FXmU0f6XQER0Va6Io=;
        b=Pu3gnUvRiOMTxpXVFZurFfuRqtJnjJnUlBxChE6XDgGyNmINTg/KPfYgGPi+PtZXI1
         fmK5SNVjTcdu7/sMeBF7WdqRFudyqleY6eZ4n9lGvDTkRolh3WSadcy68RjY1pwxsscD
         lWEWnlbIjOzDKpHfhgI47ksvi/U3I5apZ7JxVxkMdU/01yzr6B39BFL9t05GemOqBUoa
         N8Rd/WNRQhUatNArzyaxY0SARVmKtfLCccwx2sWNBb3x3wm4oVBG03GwUMD0kS70RVjX
         pXjwU1ZjXmQpJcGN9stPRpBRwX4iRfWAX97Fiou/kozjsBaF3ZY8P6e2mh8l6L/ng58e
         xd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCWKyH/7wWZc1RDLBH2bNGa2a2FXmU0f6XQER0Va6Io=;
        b=tYrtVcWe7NCPbWwaNHc/KcMTlz2VuT7HgEImRTEVoRkHDhjW91p6Q2vpjMZG24pHGF
         1xEDYgQh3CbKMOigGN1wsuP8Rpa+noY7Rxn+uauwn9ICE2qJi8K9rxhpKyBpA/Flz9qN
         YXHhTfMcQkHZ7lOMSmMkJtzqiadmGhLhhJ5wzml4mkYOfBl9uJgHc9UZ6Ga4+PBAyv1d
         RBk0Ls6N+McCD5jYzakca4rFoq83jh/bPbe8ikzU/C8+Jx6XRzE4evdvUAOlErAAYmK6
         NCdwhtBz+owxdZqXKBFpArZ/QCpVCG5Gz2KqUqlGIscOhsuLDyq11E6QuDdP89wHEne8
         ad2g==
X-Gm-Message-State: AO0yUKVrh88NWr85GceRjaOATUtvJUlqtYiM48Glos8r/LmPo3+rBd6k
        ltBkPrdzjibgtaJiUebiwO2MM7K6iV0=
X-Google-Smtp-Source: AK7set/yulYC87bhTOb5asgKBWBKrBrXCApyDOnUCwLJyMDUpaBeJ/P4f5enaOROgCYidmpfyXnXBw==
X-Received: by 2002:a05:600c:502b:b0:3db:2e6e:7826 with SMTP id n43-20020a05600c502b00b003db2e6e7826mr14783277wmr.5.1675991176600;
        Thu, 09 Feb 2023 17:06:16 -0800 (PST)
Received: from localhost ([2a01:4b00:d307:1000:6f15:7230:d519:3286])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600c2f8800b003ddf2865aeasm6654395wmn.41.2023.02.09.17.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 17:06:15 -0800 (PST)
From:   luca.boccassi@gmail.com
To:     linux-block@vger.kernel.org
Cc:     jonathan.derrick@linux.dev
Subject: [PATCH] sed-opal: add support flag for SUM in status ioctl
Date:   Fri, 10 Feb 2023 01:06:12 +0000
Message-Id: <20230210010612.28729-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Luca Boccassi <bluca@debian.org>

Not every OPAL drive supports SUM (Single User Mode), so report this
information to userspace via the get-status ioctl so that we can adjust
the formatting options accordingly.
Tested on a kingston drive (which supports it) and a samsung one
(which does not).

Signed-off-by: Luca Boccassi <bluca@debian.org>
---
 block/sed-opal.c              | 2 ++
 include/uapi/linux/sed-opal.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 463873f61e01..c320093c14f1 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -487,6 +487,8 @@ static int opal_discovery0_end(struct opal_dev *dev)
 			break;
 		case FC_SINGLEUSER:
 			single_user = check_sum(body->features);
+			if (single_user)
+				dev->flags |= OPAL_FL_SUM_SUPPORTED;
 			break;
 		case FC_GEOMETRY:
 			check_geometry(dev, body);
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 1fed3c9294fc..d7a1524023db 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -144,6 +144,7 @@ struct opal_read_write_table {
 #define OPAL_FL_LOCKED			0x00000008
 #define OPAL_FL_MBR_ENABLED		0x00000010
 #define OPAL_FL_MBR_DONE		0x00000020
+#define OPAL_FL_SUM_SUPPORTED		0x00000040
 
 struct opal_status {
 	__u32 flags;
-- 
2.39.1

