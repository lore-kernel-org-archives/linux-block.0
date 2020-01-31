Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED97AC33CB2
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 09:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17DA215A4
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 09:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qw7cjjs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgAaJZE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:25:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52124 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgAaJZE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 04:25:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id t23so7095628wmi.1
        for <linux-block@vger.kernel.org>; Fri, 31 Jan 2020 01:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DCb/xDvlwv6fnMWcXIG/HuzVabukmnqhy19nDjpW0Wc=;
        b=qw7cjjs1E8pWma/72zrvOGI0LqLcmxYxDNX+xebO0ZXD6XnnEZrYR2icMTWMxOo11x
         F+wRvfqULKxmJcGxieJbO086EJay6OGEsbHP6tHgABYafP/Teswf2cZwWrXYsa7SqmbI
         3bb4SNv6etWoSXR/9ozFtALKoJGqTFLxUICBAguPNVkhjtXoXRCf+uvvKvyk6AHNgbkU
         DaJzmtjCJbLCCnejvJ9bAecH55lijryvFRtmRABSNSaMqWMXNiitRQ2SsZd20oAw28M5
         T4AFoEMW+8wabyt5BGv0AeHmdzruE70Hpd+8bQ2XK30FWlM68XNb17vgB/rWvtraOpGx
         buiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DCb/xDvlwv6fnMWcXIG/HuzVabukmnqhy19nDjpW0Wc=;
        b=GBFobLnEF+O/ygdVJvqXCk72SwQZyhXq0apEauWhRqPZNxH4iOmpanKxsGOwVod2u0
         reFA+mkMwMxQB2BQMRSrQY/OvbcFkusFNS9dxEBMy8K+d6XBYr2XOHYBgAyCOjOKx43s
         xBOk7cflLUKa/u5OtF0FI+LoyS1XXNbhZb2KLDDYekUWfE6cmsVNmJWFSkrUL24goLpG
         grPngodZvnShSQRe21OYoUu7kT9AfDY+Sw8rVqOn4P+eGxYspDFw/geowNGuYDYvVzv9
         yWLClhXx0QuG7N9AckJJCwdi1d6Naw8bFirVLeKGYSaY/Fq4oKBVaJLgTlGOenkzKigd
         Ni3g==
X-Gm-Message-State: APjAAAVEOeGJpkbS4lLZNE+HgayaPH2CZ5J+edx404f+pzury7Pcieh9
        cYQAQmofvtLYOtnZ9bnQ5FY/9g==
X-Google-Smtp-Source: APXvYqwccI1zx5QiGLNXp4CTKPCYw4Fm19ZA2sJEKNWeNsHlMN4OdFKxyBQLewXej8EjpkXXtknjmA==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr11728395wmk.68.1580462703028;
        Fri, 31 Jan 2020 01:25:03 -0800 (PST)
Received: from localhost.localdomain (88-147-73-186.dyn.eolo.it. [88.147.73.186])
        by smtp.gmail.com with ESMTPSA id 16sm10144364wmi.0.2020.01.31.01.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 01:25:02 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 6/6] block, bfq: clarify the goal of bfq_split_bfqq()
Date:   Fri, 31 Jan 2020 10:24:09 +0100
Message-Id: <20200131092409.10867-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200131092409.10867-1-paolo.valente@linaro.org>
References: <20200131092409.10867-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The exact, general goal of the function bfq_split_bfqq() is not that
apparent. Add a comment to make it clear.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 28770ec7c06f..347e96292117 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5983,6 +5983,8 @@ static void bfq_finish_requeue_request(struct request *rq)
 }
 
 /*
+ * Removes the association between the current task and bfqq, assuming
+ * that bic points to the bfq iocontext of the task.
  * Returns NULL if a new bfqq should be allocated, or the old bfqq if this
  * was the last process referring to that bfqq.
  */
-- 
2.20.1

