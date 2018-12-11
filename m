Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D35C6783B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0BF20880
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="xkZ1VrXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0BF20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeLKTRR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:17:17 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:36884 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbeLKTRQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:16 -0500
Received: by mail-lj1-f176.google.com with SMTP id e5-v6so14039599lja.4
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 11:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=83ip4AlfR5Un2lF+cYez12uF00TPllhNb2wBd2+wWv4=;
        b=xkZ1VrXiolILHERQyFYo9V65+WV0rU8N5167xMj2kI7czlSqBbOdD1Z17BLZ9tFpog
         hzNug/PVfrv7GIt+JN3XhSFKVccssW9lrXDKf8f3337Oi6i2vLkX+Fa844wXSri7GVNF
         flgKcmhJtXTHmDXGJYzoRe/cpJCAvTQyRQ/YWNOeZqcgR974cFd84oCHT1dmvxmHCqq0
         CxAj5ayP6IR/03/SSXkrSFiCNxkv3ZFgQ40ISA0JAR8706rXxMDvBx+wDKV72AV2jDUx
         xJP1J1903p6MeuB285gzNao6hkFWDGP43racaTVgwRLaug6tUPCn18X+zFs9Fh2glkOX
         SHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=83ip4AlfR5Un2lF+cYez12uF00TPllhNb2wBd2+wWv4=;
        b=nCTlRGFbzSV5FbLKJoQM6OrmJjd/3onAA1isgkTJ9Cw/T0jfFQQVdPEvzuCDI/YeSs
         Ybka0pmIm1qa1kLQvbaIEcMWWgcT625kAPctC1xOkHduMsf5aqtyvXWY8zRDMmGGmDfe
         hkZoByJXWVUBKp9ZFa0XNEiXyGay05z6jN4K+ERy7YfMYpBgnj4LuYxjN2A1Sh0L7ETq
         0g4Jf0CwGhMlGZrEk+4+PCDQ7OlCqezChzsKj+Tzc6kjy+cqP47MFLnjamrh8ShZ/Sw3
         4Xs1d8D+yI20f7E78CZ0YLuqNCv5dSzvQjZ6tqDORP9dxUrsw+f2kuNQ9n/dv6nWpTPq
         BdQg==
X-Gm-Message-State: AA+aEWZfrUb29on6F1QC7TNSpD/L2fdMrBsOjmmoDJe9yh5tGBumZ9AB
        I6kWvRGertO77/z2Tq3AR+8GBg==
X-Google-Smtp-Source: AFSGD/Vr0WEk1cLvVXuqYhXmZu5QLF7AVPdM05Hxk9hoQ6cwHHNJNZ15K4/E2dwN3CliggahhVXrkw==
X-Received: by 2002:a2e:568b:: with SMTP id k11-v6mr10979708lje.105.1544555834746;
        Tue, 11 Dec 2018 11:17:14 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:14 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hua Su <suhua.tanke@gmail.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 12/21] lightnvm: pblk: add lock protection to list operations
Date:   Tue, 11 Dec 2018 20:16:18 +0100
Message-Id: <20181211191627.15542-13-mb@lightnvm.io>
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

Protect the list_add on the pblk_line_init_bb() error
path in case this code is used for some other purpose
in the future.

Signed-off-by: Hua Su <suhua.tanke@gmail.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 6581c35f51ee..44c5dc046912 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1295,15 +1295,22 @@ int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
 
 	ret = pblk_line_alloc_bitmaps(pblk, line);
 	if (ret)
-		return ret;
+		goto fail;
 
 	if (!pblk_line_init_bb(pblk, line, 0)) {
-		list_add(&line->list, &l_mg->free_list);
-		return -EINTR;
+		ret = -EINTR;
+		goto fail;
 	}
 
 	pblk_rl_free_lines_dec(&pblk->rl, line, true);
 	return 0;
+
+fail:
+	spin_lock(&l_mg->free_lock);
+	list_add(&line->list, &l_mg->free_list);
+	spin_unlock(&l_mg->free_lock);
+
+	return ret;
 }
 
 void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line)
-- 
2.17.1

