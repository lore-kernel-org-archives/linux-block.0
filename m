Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2A7C43215
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 17:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA5520728
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 17:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfKORHW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:07:22 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:43264 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfKORHW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 12:07:22 -0500
Received: by mail-pl1-f169.google.com with SMTP id a18so5058697plm.10
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2019 09:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1EYBFDT7Yxn9EjoXkexEuSV1/U3eX7W64+vi+cOaK3o=;
        b=RU53n+lC8QD0C0C0pUxlROkzobnez5jdrAWM2yasmpzMghvmvOsniNQ3OEbQ2q+GfN
         NxTcHNsn8t2DZ6Kv6/4hwuhaQJakuNwp1SNUvECraJLn+4QY3kkViiaNYJssl+K76qXr
         ZEeCeVoigOqjOPMQr5c71W3wiqry+YKJ3cjenlKhE2c/RrgswVv5l3VZG9VYiBfgWNy+
         yAN4cioDEX0ZQDG19F72gIGGPJkVkcGhdWhEkm91Fbogg1WFQSZCYoeDJ8lX3hGUx7Cu
         DD7hgkjjXej74hhPgJOVaOyab8LXzzTIFk+8v00E2Dhv3myyQv6ntAKMt3dIaU2vNabV
         8TuA==
X-Gm-Message-State: APjAAAVsms1CTTyfhDinQF4/B5Xo7cZfiOIlJFa/9e9qdRvRpnQro0af
        NOZGW7BqxxV4PlxnNjq5c1LPw+rZ
X-Google-Smtp-Source: APXvYqxOSvLLP1IEFERAI+pkuPs53GSHWY92wy9ztmoV8KdCIuIjJx6hKfhwcWBGYp4tBpvYtSEG3A==
X-Received: by 2002:a17:902:9689:: with SMTP id n9mr16445323plp.222.1573837641218;
        Fri, 15 Nov 2019 09:07:21 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id m7sm2364793pfb.153.2019.11.15.09.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 09:07:20 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 1/4] common/multipath-over-rdma: Fix expand_ipv6_addr()
Date:   Fri, 15 Nov 2019 09:07:08 -0800
Message-Id: <20191115170711.232741-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191115170711.232741-1-bvanassche@acm.org>
References: <20191115170711.232741-1-bvanassche@acm.org>
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
