Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCFAC433F5
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B70B861211
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244799AbhJQBkK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244796AbhJQBkJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:40:09 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFA3C061768
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:38:00 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id j8so11216294ila.11
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ERBT8VF2wyOK8Bo9ixt5H3WSIawANolkBAaKtj+zNU8=;
        b=ql2sVcnScaNVaSQlNWeQafIoKnOprfZd/oGZwfkW9H1y8JosRl4J+DjlPeWNZVA8kC
         WeXsVjG/jQJcY41HO6bbSkLkNh/xguS3NvxYBWIr3cfwibIm5EEQjtR6qwau7+Hw9yJs
         DwlarUN7QCDssGxQCI1/Ykdr/GEqagb8HgTzlSKEncv1hx/KN+evxgLce26ETYZCOT3w
         YzsbOnEo0kfDtu/BOHLYxd0n+2Oi8sP6UN3aZSjePNjp06nQxZNEdz9NkXDOHaWjny5W
         D/SOZ4QSxhg8bolacNRFd9Uz7ws5WrwcvPhJOs7/eSROYHChmxGZ4OrS4mXECXowaurW
         28ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ERBT8VF2wyOK8Bo9ixt5H3WSIawANolkBAaKtj+zNU8=;
        b=apubhKFoE6oCzYX1hF3PtCVkXVO2z0APG9UxJ+Oyt5FQS2bv22vuL+cSj8gMiDWpZz
         6KJTMfEHIy6iGGblgtqkxvHOpuw90Tk0NXmS/VRSQLI+O5NwW4I7f2BCppIvlTH48Xq9
         C3XXb0s9ers46/YUU9fVw3uaA+RNbrr0iPTOeH6wJ7n0zFGAlgMC0/8R50uteVEjMBSa
         jkd2Unz7IHYxtHjOeYIYXCvWVz8MHn68eFZkLypicIVn76J97bqmjM+5cRIVc+LDVM5+
         HMG3jxatN8PsTsSkHfGpqSXdBkuo18jtC1WJ5+dygf4nwlcGD7pzFL/+Il9L14fj9DWG
         W8xg==
X-Gm-Message-State: AOAM530NnihtfDayP8ttx40sCvW2RvhG66kxcbAnvuLGz103qMz2NS34
        l+A9jfIWhhe5y2hIILxrwzC0VLPFKftG/w==
X-Google-Smtp-Source: ABdhPJzfCpsQvn4xo4wEw6an6pEQFhLo/FeuRssw3zcmzZC+ED45j40jq9LftmOBwHKWHJ+cqKxmRw==
X-Received: by 2002:a92:cbc2:: with SMTP id s2mr9469430ilq.228.1634434679867;
        Sat, 16 Oct 2021 18:37:59 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j17sm4934383ilq.1.2021.10.16.18.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 18:37:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/14] block: align blkdev_dio inlined bio to a cacheline
Date:   Sat, 16 Oct 2021 19:37:46 -0600
Message-Id: <20211017013748.76461-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017013748.76461-1-axboe@kernel.dk>
References: <20211017013748.76461-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We get all sorts of unreliable and funky results since the bio is
designed to align on a cacheline, which it does not when inlined like
this.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 1d4f862950bb..7eebd590342b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -137,7 +137,7 @@ struct blkdev_dio {
 	size_t			size;
 	atomic_t		ref;
 	unsigned int		flags;
-	struct bio		bio;
+	struct bio		bio ____cacheline_aligned_in_smp;
 };
 
 static struct bio_set blkdev_dio_pool;
-- 
2.33.1

