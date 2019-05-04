Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941B5C43219
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D14205F4
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="RwHJ7dZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfEDSiq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 May 2019 14:38:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43854 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbfEDSiq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 May 2019 14:38:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id z5so2743714lji.10
        for <linux-block@vger.kernel.org>; Sat, 04 May 2019 11:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b49wfhLOumPQgXr+cfKeJZHxCawjUFOzEyK1tzSAUts=;
        b=RwHJ7dZfVpqpBAYmi/ibFYlbZ/kYATHVpdcdtU9nc74g9me2OD/iV5iS4GzSkemCag
         VRd+qudbu3Iaz4JvKMCP3ayuscMbX9TFON/RoABmjyntW7MWjmkLraeLrn2zAevlyn5Q
         xC9fOwEVZRUQCB0NoYL5y5FCQhOdLss33UR12iyMiR3XD4g01iim+DVGQsmb07ceauVQ
         jojWtBBkILKBbRpNYwh2gABontBTZbK6mBkvrrwL/FSz40Wp7N9P+kgQruqH1ueDWOL8
         pgR1pIc1eEodYMUqMdfRPhTfKG2wLDpB2qI2OvCxiuRO8gldtHTKdVhBwV8qwkwVfldk
         cSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b49wfhLOumPQgXr+cfKeJZHxCawjUFOzEyK1tzSAUts=;
        b=r0uL+32sMbXKDFWtdty+3UEf6bA6Z5vsKYIkmUlkpSRCsdf/9XcAjWKOrlKVrAGVpZ
         CzqWRazBFmNjippfKjUEoSKgbtNtHCF1/yvaCVrARGCvIxs7crGw1Rm3vzoJYTvbl2rk
         XDNu6gGN/kSfAgZu7Rzp3GJ/hyLOAUNVMZNuTNKlCb1/fi3GUxfej2v7s/+nlnRHEhKW
         m1kvp04RwljXlQcdzmpLAQ7Vv5kazhuwrkD95Gy0An4aiF93UYAdPXt2LuIGJPTGHc4V
         IYs9FeXB8gBAoLEOU1HHib1XTdGTcVWIO2NOzMDeMpRzU77UjXXWdoEpS0yWcCH8ToSw
         naeg==
X-Gm-Message-State: APjAAAUnZnpqPbbIEx3tPJiM2xQjnzUJXOU91fQYn7ox5j/tbpHv91gy
        JnOdY+f/pChDPL1izb1CodMLzA==
X-Google-Smtp-Source: APXvYqwwDDNDkYh/TIm9iL///KR7uA/jAIJx0/jMK8G2ANYER2hGicp76hXUrishFf8onWBWUqwkFg==
X-Received: by 2002:a2e:2f0e:: with SMTP id v14mr2823075ljv.77.1556995123997;
        Sat, 04 May 2019 11:38:43 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:43 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 19/26] lightnvm: pblk: remove internal IO timeout
Date:   Sat,  4 May 2019 20:38:04 +0200
Message-Id: <20190504183811.18725-20-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

Currently during pblk padding, there is internal IO timeout introduced,
which is smaller than default NVMe timeout. This can lead to various
use-after-free issues. Since in case of any IO timeouts NVMe and block
layer will handle timeout by themselves and report it back to use,
there is no need to keep this internal timeout in pblk.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-recovery.c | 7 +------
 drivers/lightnvm/pblk.h          | 2 --
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 137e963cd51d..865fe310cab4 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -290,12 +290,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 
 fail_complete:
 	kref_put(&pad_rq->ref, pblk_recov_complete);
-
-	if (!wait_for_completion_io_timeout(&pad_rq->wait,
-				msecs_to_jiffies(PBLK_COMMAND_TIMEOUT_MS))) {
-		pblk_err(pblk, "pad write timed out\n");
-		ret = -ETIME;
-	}
+	wait_for_completion(&pad_rq->wait);
 
 	if (!pblk_line_is_full(line))
 		pblk_err(pblk, "corrupted padded line: %d\n", line->id);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 381f0746a9cf..90c703d3f84c 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -43,8 +43,6 @@
 
 #define PBLK_CACHE_NAME_LEN (DISK_NAME_LEN + 16)
 
-#define PBLK_COMMAND_TIMEOUT_MS 30000
-
 /* Max 512 LUNs per device */
 #define PBLK_MAX_LUNS_BITMAP (4)
 
-- 
2.19.1

