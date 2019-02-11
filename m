Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE4BC282D7
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 12:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA612075B
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 12:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="hWGNlgok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfBKMZY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:25:24 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44640 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfBKMZX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 07:25:23 -0500
Received: by mail-lj1-f194.google.com with SMTP id a16so4463021ljb.11
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 04:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P5r+7TNRpT4IOWYOkJ4Od3nYrWD71FZGJYmKpbNhmMc=;
        b=hWGNlgok/Afol8f4prcEdIM03knAXuUS0vPIR4Hals6x65dhEhbnf2mQ1g/bMijxYo
         w/bDGAcgT3GK9B3tKPICceWVw6KsFTqmyLhweCa8nYGhjA22iGcI+4+nTajupEJ8mznq
         JcH3K71jvHWI3FDygU3iy2n4HluzEsWWXVcOLhnehicnOmJjdRE0MyO9Tz2rb1dheBBE
         JGwMvzTvuabjkd4RHxiQRVrFBMGexU+0UQqkQGaQhfz02iBIW9PHbj49AiPQ0nY9ZO93
         68WdUOV2nx+V+ygfEwP7qjyKHz/y9QdvTPpyT62SiFpM8TaGJa1EdzNNhQYrQIPKcr+6
         pJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P5r+7TNRpT4IOWYOkJ4Od3nYrWD71FZGJYmKpbNhmMc=;
        b=t3koqk2NOHjWoIRXG4NJp9QzmPlrN1CZUXQj94al7T3x5dgqakZv1j//0ad3Gx9yLP
         fU0QSXhGWhYT3H73Gs5grj5elGrk+9+haf7XewEBMBfYaGaAQNvn1NOPJ9Y2LZj9g3aU
         rm6iXDG7tr/FLpFuqyGoJPD68giCMwpIzM7MAMggzwFe2I4/gkj7HxsXNoMV3zg7GGrH
         gjK2urC1CgXR5OwrwLmiAIl3VXyxuSMGzw+qCfOS+MczpwXVClU/E4EgW2I0MJnWN8y8
         7ryquzkTuu/4pnstW3ZguK1sb9LF5mjheV2z1uoBDARqNti8bnyzL15B0q5q27YlLZNE
         696g==
X-Gm-Message-State: AHQUAuZ7ThgJC2qC2ZaqnWcqaRQ7V6jmagV7dWn2nTXnDFnB0Ji/Pgzn
        boe6mPoB2YcIuxAPS9Mb8Y+IOQ==
X-Google-Smtp-Source: AHgI3IaCLBCua02CbzvdHEmPu3Nkd8IDEQ+Yxcn2u6gB8rwYt+beBOVndsaXB+ZEI2VSY/caHhqSkg==
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr8066565ljk.80.1549887921125;
        Mon, 11 Feb 2019 04:25:21 -0800 (PST)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id d70sm2278481lfe.14.2019.02.11.04.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:25:18 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 3/8] lightnvm: Use u64 instead of __le64 for CPU visible side
Date:   Mon, 11 Feb 2019 13:25:04 +0100
Message-Id: <20190211122509.19910-4-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190211122509.19910-1-mb@lightnvm.io>
References: <20190211122509.19910-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sparse complains about using strict data types:

drivers/lightnvm/pblk-read.c:254:43: warning: incorrect type in assignment (different base types)
drivers/lightnvm/pblk-read.c:254:43:    expected restricted __le64 <noident>
drivers/lightnvm/pblk-read.c:254:43:    got unsigned long long [unsigned] [usertype] <noident>
drivers/lightnvm/pblk-read.c:255:29: warning: cast from restricted __le64
drivers/lightnvm/pblk-read.c:268:29: warning: cast from restricted __le64
drivers/lightnvm/pblk-read.c:328:41: warning: incorrect type in assignment (different base types)
drivers/lightnvm/pblk-read.c:328:41:    expected restricted __le64 <noident>
drivers/lightnvm/pblk-read.c:328:41:    got unsigned long long [unsigned] [usertype] <noident>

In the code it seems explicit that lba_list_mem and lba_list_media members
of struct pblk_pr_ctx are used on CPU side, which means they should not be
of strict types.

Change types of lba_list_mem and lba_list_media members to be u64.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 85e38ed62f85..0dd697ea201e 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -131,8 +131,8 @@ struct pblk_pr_ctx {
 	unsigned int bio_init_idx;
 	void *ppa_ptr;
 	dma_addr_t dma_ppa_list;
-	__le64 lba_list_mem[NVM_MAX_VLBA];
-	__le64 lba_list_media[NVM_MAX_VLBA];
+	u64 lba_list_mem[NVM_MAX_VLBA];
+	u64 lba_list_media[NVM_MAX_VLBA];
 };
 
 /* Pad context */
-- 
2.19.1

