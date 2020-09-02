Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D064FC2BBD0
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 22:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A266320826
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 22:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIBW3Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 18:29:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44324 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIBW3M (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Sep 2020 18:29:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id 7so437447pgm.11
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2020 15:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GkONzNAsvTgxvPXx9uszYhbGKAkqruQx2Cijke4LS9A=;
        b=WMgu3Vy++Uk8VYFfsRi5x9E9OINm4GHF57hKdjJM7NBa09xNBMgkL6U9Ugt+JnRXdr
         6mPdn2QppVNItVzFRGaY+O8JG8SzV1OKbls2E1jK+4MVZUxkVB3USmQZBMjUNdu0z2hy
         dIE7JUbhhYPl2BV8OwGR77Dm0o6xXKI/rrYGPKyGUMEunnwFBM6mbHzASfWGfUhVgGWn
         ar6zK5rUbZs3SgREJMBB3W+KuPRQi7j9PksSCnqbt+pVjnKFqbbt2gf5J0rMjQfWiaU1
         JytW4m+Zg2Hb5TB2OlEw3sNX3YNC8pz0ws8uyjhOGZ0tnCadGBoG55Y3ZmPN0mOmaXik
         eWjw==
X-Gm-Message-State: AOAM530X+BCNTan1cYL0GJLv0+i4lhQUkTiXR6QOtj2a+9L5YD3RAmWH
        aLen42ShZdA9+FY873MmHfPJru6JMjn1Pg==
X-Google-Smtp-Source: ABdhPJzvSP9UQ2MyM89I5XHfq1cA5jrI5HqdRNmKcuYAVOF83K7iMq0TXAaZcDMQXEYeVGYs2rchsg==
X-Received: by 2002:a62:2d2:: with SMTP id 201mr252115pfc.299.1599085751682;
        Wed, 02 Sep 2020 15:29:11 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net ([2601:647:4802:9070:4025:ed24:701e:8cf3])
        by smtp.gmail.com with ESMTPSA id p184sm569293pfb.47.2020.09.02.15.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 15:29:11 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v5 5/7] nvme: support nvme-tcp when runinng tests
Date:   Wed,  2 Sep 2020 15:28:59 -0700
Message-Id: <20200902222901.408217-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902222901.408217-1-sagi@grimberg.me>
References: <20200902222901.408217-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

run with: nvme_trtype=tcp ./check nvme

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index f18731caef61..972bd0019ec4 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,10 @@ _nvme_requires() {
 	pci)
 		_have_modules nvme nvme-core
 		;;
+	tcp)
+		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp
+		_have_configfs
+		;;
 	*)
 		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
 		return 1
-- 
2.25.1

