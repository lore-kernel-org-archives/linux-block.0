Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C75BC28CC3
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 00:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562432597B
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 00:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfEaABD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 20:01:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41515 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfEaABD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 20:01:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so4968316pfq.8
        for <linux-block@vger.kernel.org>; Thu, 30 May 2019 17:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r19IWQwRW84cjiSL7CP+zx4l2sEwisSbCZliomBxBIE=;
        b=hal526OrlKpthD2Cf+V//0Ur/C1dw8qxf5nsbV44nYnXuSJmCrmf5Sdz/Fam6YKxPi
         RCgub9H4tV3RCOYDWAsBojP/SVfPUjl2EfGyfLAErDqpgcU8F3CdFxrqRORxV9+gB656
         y3BA/87LuzgOdEsAqoi7J4AzbVGbOo5ubTjPf+xoPNVUMg90dwSZpA8uqzCpEOttIEtf
         vEo/mGAxCUfre3g6zMSerTeJ0HfO3Ha4mbr1RAl1V4QBHAjuS4j0Nk1M8XB1RPIigEJ9
         fbbtBQGcYktTxEDxQvVXtpS02ShapGjRZFYc1yP5KiosSvxVSSUKJ7tfdfpGu9OVhXgx
         /q+A==
X-Gm-Message-State: APjAAAUc9txGIk9sjTlx9mQjJDQWnEEsLdcYQCx2b8BIqlLmx8Z99mbh
        miRcoEHOh3pIWRSX+vZhkU8=
X-Google-Smtp-Source: APXvYqx0iVzruuloMbRtmi6b3iiBzOwyQmrOcOdHHs1I6S3Hc6lB49pzUBMiwFgkcRjjDwf1+13IEw==
X-Received: by 2002:a63:484f:: with SMTP id x15mr3201600pgk.162.1559260862202;
        Thu, 30 May 2019 17:01:02 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g8sm3539851pjp.17.2019.05.30.17.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 17:01:01 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/8] block/partitions/ldm: Convert a kernel-doc header into a non-kernel-doc header
Date:   Thu, 30 May 2019 17:00:46 -0700
Message-Id: <20190531000053.64053-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190531000053.64053-1-bvanassche@acm.org>
References: <20190531000053.64053-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch avoids that the kernel-doc tool warns about this function
header when building with W=1.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/partitions/ldm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index 6db573f33219..fe5d970e2e60 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -19,7 +19,7 @@
 #include "check.h"
 #include "msdos.h"
 
-/**
+/*
  * ldm_debug/info/error/crit - Output an error message
  * @f:    A printf format string containing the message
  * @...:  Variables to substitute into @f
-- 
2.22.0.rc1

