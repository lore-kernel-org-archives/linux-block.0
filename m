Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8C5C433EF
	for <linux-block@archiver.kernel.org>; Sun, 15 May 2022 20:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiEOU6l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 May 2022 16:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiEOU6j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 May 2022 16:58:39 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC272C10A
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 13:58:38 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d5so18107504wrb.6
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 13:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQrx6xhXSM16wrTkkyMiWLyUMIKMm9Gd98cm7zuwaYE=;
        b=ewh/32bVg3iJAUpl6kKCgsWrxg6bJay9w6xmBghNC6CKL7yFBRi7azVe74db1zuvSt
         Fdmm1DmGr3ydfRC0d9jDk8pq8K+bpTlZBODeqtPpwi52mliS8pOemiB85gnU1+DxE+ex
         ASSxrY0X6QfoIIFlphmHZG1b1ie1I0/jfC980vKw0VdO0FB5pwYiNleYqsmRPfwaF00K
         ftpOaEjf+fW1YGWuJj8K9dbaWy6DAP4Bv69BTtf493tXIk+TSpkMFo/Z9AVZin71yb2j
         MoRtFbb0ywaZKLPsZ8eGUYSz8Cfi7JDFtstUtPVwP+j/7e0KcDJlF57iCDwcJFX7lzkK
         1vxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQrx6xhXSM16wrTkkyMiWLyUMIKMm9Gd98cm7zuwaYE=;
        b=EoCSW5EerB/yQ+OkvvT/X7E2+lfX1lB3+YkTo25//DanYjPp8niWKmFE4hvCjGeHXk
         qUrjYPFpaEWKmjNPfIC7q9wGsMJU7tAuYf/9atWJ6lQk/5YOGUmD0eIYWLBSqra4d50W
         r2yU2yJXUaFImJL1IfHj05VTGl62+yr6JxdF70xnO53mV8BKofOBYZ4up1UQTt13dxcB
         1nJJ+osM9c0bZ7nu/TAt1dhr5qoxvAlvK5F1kK//kY7GUYg3JZSQ4bD6riq0jdWRyJnW
         QVexS+VECwb+S8fDRW7K1boZLZVDEHzWJRdrosHyNif4v+pzrIkRkMTPfDq7Jfxt5GFl
         jF5g==
X-Gm-Message-State: AOAM530RXUv9AJ3knLB3mRHFJpTMqfBhuECVoWnY+wIsmu6BtLaXR4Ho
        LhRjhr2f+kffBMjiyjAHNW9sCHhfvcvsXA==
X-Google-Smtp-Source: ABdhPJwJeNC+SfsBdNLBzoJOOgxxyn1esbajj/S11sKB3eQKFaeq2UiuaLUdBxxv3sMYSoess+yXXQ==
X-Received: by 2002:a5d:594e:0:b0:20d:bb7:72b3 with SMTP id e14-20020a5d594e000000b0020d0bb772b3mr280511wri.702.1652648317445;
        Sun, 15 May 2022 13:58:37 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id r17-20020adfbb11000000b0020c5253d920sm8922074wrg.108.2022.05.15.13.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:58:37 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/5] cdrom: mark CDROMGETSPINDOWN/CDROMSETSPINDOWN obsolete
Date:   Sun, 15 May 2022 21:58:31 +0100
Message-Id: <20220515205833.944139-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220515205833.944139-3-phil@philpotter.co.uk>
References: <20220515205833.944139-1-phil@philpotter.co.uk>
 <20220515205833.944139-2-phil@philpotter.co.uk>
 <20220515205833.944139-3-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

These were only implemented by the IDE CD driver, which has since
been removed.  Given that nobody is likely to create new CD/DVD
hardware (and associated drivers) we can mark these appropriately.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Phillip Potter <phil@philpotter.co.uk>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Link: https://lore.kernel.org/all/20220427132436.12795-3-paul.gortmaker@windriver.com
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 Documentation/userspace-api/ioctl/cdrom.rst | 6 ++++++
 include/uapi/linux/cdrom.h                  | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/ioctl/cdrom.rst b/Documentation/userspace-api/ioctl/cdrom.rst
index 682948fc88a3..2ad91dbebd7c 100644
--- a/Documentation/userspace-api/ioctl/cdrom.rst
+++ b/Documentation/userspace-api/ioctl/cdrom.rst
@@ -718,6 +718,9 @@ CDROMPLAYBLK
 
 
 CDROMGETSPINDOWN
+	Obsolete, was ide-cd only
+
+
 	usage::
 
 	  char spindown;
@@ -736,6 +739,9 @@ CDROMGETSPINDOWN
 
 
 CDROMSETSPINDOWN
+	Obsolete, was ide-cd only
+
+
 	usage::
 
 	  char spindown
diff --git a/include/uapi/linux/cdrom.h b/include/uapi/linux/cdrom.h
index 804ff8d98f71..011e594e4a0d 100644
--- a/include/uapi/linux/cdrom.h
+++ b/include/uapi/linux/cdrom.h
@@ -103,7 +103,7 @@
 #define CDROMREADALL		0x5318	/* read all 2646 bytes */
 
 /* 
- * These ioctls are (now) only in ide-cd.c for controlling 
+ * These ioctls were only in (now removed) ide-cd.c for controlling
  * drive spindown time.  They should be implemented in the
  * Uniform driver, via generic packet commands, GPCMD_MODE_SELECT_10,
  * GPCMD_MODE_SENSE_10 and the GPMODE_POWER_PAGE...
-- 
2.35.3

