Return-Path: <SRS0=wI0I=WY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61207C3A5A3
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 01:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3498B20856
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 01:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFvxbBFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfH1BS5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Aug 2019 21:18:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36827 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfH1BS5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Aug 2019 21:18:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id d23so993808qko.3;
        Tue, 27 Aug 2019 18:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4UMoPJbaS+HILDC/GqKxBvU1ofhLXKohaWmvXThn4dw=;
        b=vFvxbBFaOIXzzfbp7BKHJquxQgB9Mq3c1GbH85ihrV40TAdrL85HF3kXFWbhLQDmcc
         PzMZrXY2SPg0z5gFrUidN8hnExad9hfC2y12psAbzp7YCCBX6tgSVVJ2MmqZgJq70NPo
         uplnrCAzJ4cBrb3gU7KYisbTnyjGlmNlBtpo29qNy7dr5eiXSdQKIWWyK4eWKAOZBOa/
         aPPrTXAaLHeXHBgi1EQCPqUvg4oF/FIRH6UrkcCUWIs0VVyr2puAl+nnQE0i83GJ7sEd
         vEnJbM1iMMOuRGNPqL4jiUvTz8XguRdVl17D9V2LUxvXy4sWp428pDJpwuMD4uNHcJco
         9eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4UMoPJbaS+HILDC/GqKxBvU1ofhLXKohaWmvXThn4dw=;
        b=pgL73/+l28scOfn72h+i3maDzaTJDVmrf2Ghm49h+v19eejri+cQxbO8hefD+XPa6V
         je6sRAPQjPrQJNxRJF8IaTBWdgBWMi9ZyiDjgLh1akcNIaJdSn9Z4kWtPeJtuRyMjzZ6
         zzeoMMTVl+wS6KfGsO5RVsw26z6o7yS1rXuBrCXw6hSPmA/W8sd6uoQqHNQtQB1Oilzu
         ClQzlVjGLrjzQdq1CxNkJJ+pPqykoaTHybHLZtYY7lsdo5/1NVF4hcxdwEekm616TIgw
         CUxYHUAwWiVwgHdQhcCOCs0skhczbS7oXtzqSZdNZh+e5ZzcileqoGTdKAge1SfGo4MF
         /Otg==
X-Gm-Message-State: APjAAAUite6hTGvkrlZ1KjQJnGiQimZNiQbrwcV1Y2sZqSOwRVMOPIMe
        nieWusx0cZmFLFGb0lSABY+/EYQgicA=
X-Google-Smtp-Source: APXvYqzEWI3AdOwIBSkqqG4zyoM76vYakiIvHxJYvC6LtOKR8/JjkNvPy0WcnEySh1XNXZQ62YZ5tA==
X-Received: by 2002:a37:91c6:: with SMTP id t189mr1557506qkd.59.1566955136070;
        Tue, 27 Aug 2019 18:18:56 -0700 (PDT)
Received: from localhost.localdomain ([186.212.48.84])
        by smtp.gmail.com with ESMTPSA id c201sm499231qke.128.2019.08.27.18.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 18:18:55 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Hannes Reinecke <hare@suse.com>, Bob Liu <bob.liu@oracle.com>
Subject: [RESEND PATCH 1/4] block: elevator.c: Remove now unused elevator= argument
Date:   Tue, 27 Aug 2019 22:19:27 -0300
Message-Id: <20190828011930.29791-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190828011930.29791-1-marcos.souza.org@gmail.com>
References: <20190828011930.29791-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the inclusion of blk-mq, elevator argument was not being
considered anymore, and it's utility died long with the legacy IO path,
now removed too.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Bob Liu <bob.liu@oracle.com>
---
 block/elevator.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 2f17d66d0e61..f56d9c7d5cbc 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -135,20 +135,6 @@ static struct elevator_type *elevator_get(struct request_queue *q,
 	return e;
 }
 
-static char chosen_elevator[ELV_NAME_MAX];
-
-static int __init elevator_setup(char *str)
-{
-	/*
-	 * Be backwards-compatible with previous kernels, so users
-	 * won't get the wrong elevator.
-	 */
-	strncpy(chosen_elevator, str, sizeof(chosen_elevator) - 1);
-	return 1;
-}
-
-__setup("elevator=", elevator_setup);
-
 static struct kobj_type elv_ktype;
 
 struct elevator_queue *elevator_alloc(struct request_queue *q,
-- 
2.22.0

