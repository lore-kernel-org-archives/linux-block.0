Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3321C34964
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DED624712
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfLMOc7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 09:32:59 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:38304 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbfLMOc7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 09:32:59 -0500
Received: by mail-io1-f50.google.com with SMTP id v3so2583884ioj.5
        for <linux-block@vger.kernel.org>; Fri, 13 Dec 2019 06:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1EYBFDT7Yxn9EjoXkexEuSV1/U3eX7W64+vi+cOaK3o=;
        b=gqAWGIet9Msz9g8LS89SMUUnthtFySlpL1aqBi565h3qCcxjIO5b1KPe9XP2Lo6YdT
         WCVLXh1MNdPxRCPVsTScBkmWc/LyDWje5KTTAFEKe3BG/uoqHMGsUxflzXATYdTKNPqz
         G09P7e6amrdaoAgBeIuNHk3L0UC7WaqfrKKBV+Jfq0ua7bzdjQoA5XjC+IaRaZPxq1W0
         g3C0jQWtBjFr3K5wZPzh4HtIt2q/UWc3dL1iMA7tIZy8BD1slfLD3bAHYQQw+0D7iu9h
         DERfl/JJjgJ7C6K2YcXK5oLhGUyL1TLbBblM8zTD8jusvOJbSsNqxBqP2CGXkv+BFw0B
         bHUw==
X-Gm-Message-State: APjAAAWSDJQ0YSVXZPfkytZQaERYdh0HlqsiKYnrTJSEGjzbD/iqJC7h
        tJpJrWcoxJgv3h95m9EQKotzIABX
X-Google-Smtp-Source: APXvYqwNdsaSSfG+8SMhxA/zierVbC0QxtFvqRa0IFz6vkKNs+yy+MRtLPqYPUCoRCLeTKbtxmMOjQ==
X-Received: by 2002:a02:c906:: with SMTP id t6mr13180265jao.75.1576247578496;
        Fri, 13 Dec 2019 06:32:58 -0800 (PST)
Received: from bvanassche-glaptop.ka.ltv ([75.104.68.105])
        by smtp.gmail.com with ESMTPSA id i79sm2785026ild.6.2019.12.13.06.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 06:32:57 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 1/4] common/multipath-over-rdma: Fix expand_ipv6_addr()
Date:   Fri, 13 Dec 2019 09:32:29 -0500
Message-Id: <20191213143232.29899-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191213143232.29899-1-bvanassche@acm.org>
References: <20191213143232.29899-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For IPv6 address ::1, instead of returning
0:0000:0000:0000:0000:0000:0000:0000:0001, return
0000:0000:0000:0000:0000:0000:0000:0001.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 common/multipath-over-rdma | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 545a81e8c18e..15f296ef2ab7 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -61,7 +61,7 @@ get_ipv4_addr() {
 
 # Convert e.g. ::1 into 0000:0000:0000:0000:0000:0000:0000:0001.
 expand_ipv6_addr() {
-	awk -F : 'BEGIN{left=1} { for(i=1;i<=NF;i++) { a=substr("0000", 1+length($i)) $i; if ($i == "") left=0; else if (left) pre = pre ":" a; else suf = suf ":" a }; mid=substr(":0000:0000:0000:0000:0000:0000:0000:0000", (pre!="")+length(pre)+length(suf)); print substr(pre,2) mid suf}'
+	awk -F : '{ left=1; for(i=1;i<=NF;i++) { a=substr("0000", 1+length($i)) $i; if ($i == "") left=0; else if (left) pre = pre ":" a; else suf = suf ":" a }; mid=substr("0000:0000:0000:0000:0000:0000:0000:0000", (pre=="")+length(pre)+length(suf)); print substr(pre,2) mid suf}'
 }
 
 get_ipv6_addr() {
