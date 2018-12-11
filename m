Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804ECC5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD522133F
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="GkumARpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD522133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeLKTS3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:18:29 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42248 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeLKTRP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so11620459lfh.9
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 11:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XvM5yaWT8Noh9xOWJxub156kMevtf+l9tCAyCJZjREU=;
        b=GkumARpyDNus03M8/j5pWF9iEbHoJx3PI0/KtdPR7D4xYKbheMEQn0b+EnVGL/Ly27
         zVF9ONtm5YCMVQvzoZdrGD5PdWhB49LF9DxVuIUM2F20L06OyX4z+fR5MVyan8LmTzjj
         rpJ1H/hWwTThuYEkfkdLglW1yZT0ZN3vE04eB/HalZYGrSzc6zV4YEI3srtYC5O+pF6O
         8xl11nYzrK9mw+WWjKX+YzXMji/PztYO5o0oWu+qdXr4XYDiyR+1PwQqefq77wirqd4A
         8s2i36QkytoPWvnjlE0/d6oPtb3iTwTsut5ksIz5Uievwa541PSdtvm3Y7K6shxREBfW
         R7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XvM5yaWT8Noh9xOWJxub156kMevtf+l9tCAyCJZjREU=;
        b=GzD7hAnReJ0JI0nnzUjMGAhOGeHULb06w472OyuubjcnLIcYKGgAqJYTvieGTu6reJ
         crjyAQUU4Uacu4xECXSgGSh1zvHRXSCJNms0iAPg1HjBsF/7oI1+jZphavuVOcAEwKHt
         Uybk/rERnoZxAyj0XZfeaEER3cQAMTj5vpPviCHD9rlJlBnOetB8wwzGun8UtXBLPMv4
         Znrz2MVlvXk4ZM7qCsZfn4Ktuee1O6CRTR7j09rgzM5HT6aVowIdwO20xpTlG/BK7vL+
         i1w3dLpN3hDQTPkq8M3AIA+gdHciWVjiOj9l5djolxCzWZ1hbckXjgwb5BhxVI+TPoos
         V0WA==
X-Gm-Message-State: AA+aEWayOkTx6yOry2nQvQTsJvi+GEBv/Ax7CSkfIajahC4n2l3qKf4M
        lznOm02GBpgcTXpGOXO/RhGFHiakp+k=
X-Google-Smtp-Source: AFSGD/Xp5IefDk/RJPFJFHxREQTIrQHs60STV2GoAeXSV93B5ITyYVlxt84L8tKHat1MYYUez+VCGQ==
X-Received: by 2002:a19:1d0d:: with SMTP id d13mr9734570lfd.74.1544555833115;
        Tue, 11 Dec 2018 11:17:13 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:12 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hua Su <suhua.tanke@gmail.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 11/21] lightnvm: pblk: fix spelling in comment
Date:   Tue, 11 Dec 2018 20:16:17 +0100
Message-Id: <20181211191627.15542-12-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211191627.15542-1-mb@lightnvm.io>
References: <20181211191627.15542-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hua Su <suhua.tanke@gmail.com>

Signed-off-by: Hua Su <suhua.tanke@gmail.com>
Updated description.
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-rb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index b1f4b51783f4..9f7fa0fe9c77 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -147,7 +147,7 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int threshold,
 
 	/*
 	 * Initialize rate-limiter, which controls access to the write buffer
-	 * but user and GC I/O
+	 * by user and GC I/O
 	 */
 	pblk_rl_init(&pblk->rl, rb->nr_entries);
 
-- 
2.17.1

