Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFCCC433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 15:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381795AbhLCPvi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 10:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbhLCPvh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 10:51:37 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC115C061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 07:48:13 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id x10so4212832ioj.9
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 07:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=t2bN3F7oqoSjZAwsulJk98loMpOyO12UfxzfXla3UbQ=;
        b=w9Ow/wcOG08uDdfPo5Neh8pZgC3d6sZsrm/g1fkh2nFFZguhpy2i0fCcLl7osjBKk3
         D95tY+wcveLpiqJtfhwH8zO3XsHget1H1oseuvQGJfNjud0pywbmBg2zvKWIbK1Ruaos
         nSrBCdYhMwis2YuD2gJT1XbbSkXhqt+y84L97/cQupJAdUT7FjIDCraGtWhTipCWHQAf
         Q4rTCvkdR/RljFpecgaX+OZGwzKJfCjf4QNH3lBMYckVhP26OPG3feIZvcgu6aNwPuL2
         L4Xcu4oWR1GLu86a/tqq1JNq5BwYBrFqHIp0zqbstsBCkIQ8xin6/o24bNeJNCdXJ2vb
         3o4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=t2bN3F7oqoSjZAwsulJk98loMpOyO12UfxzfXla3UbQ=;
        b=Pf2cFbeeSaKgRs8ItwF2b5d7Z/UlEeErh5nyGQlqhfp6hbWzAo420S4yYxsw5aVfb6
         JGtsV6JO9aSEEGO3PK8EjW8ZPi/+dhA1afzqAT5ogT5jdzn1r0G1yaqmAeO7qnzSjbaG
         pKSZKYWx2kQjKUDgM37OxdyTSFKEXnILs+mBx5vwrbN/99gI3ODTCocIL15ACrGDBvcA
         u8GDlBlFjkN8c/z+Qcgm4iKcJyImmKHYJPCT/fF1sxYUYu3tMIa3RG0s2gk5+GdfBrbD
         JWx6b1zAw9R0ePi1ZFK06V/P5meuPgreJa8WG/rhXRdmYjyPkeC5qQ76qrbFJkoIx8nO
         uV3Q==
X-Gm-Message-State: AOAM532QN+ri6A89mkTtIT30yTlCla63M7f9ENXw9B9a+VvNSbN23l5T
        TaROMzhmRJldDW5drenRk3wGCnrtfoDE3cfa
X-Google-Smtp-Source: ABdhPJzKeMKq2kYJJ7gl4ByLjIjeozUVc7OaesXILtY+O1pmhJpkKThbuqs7woRlzvRN9KTYctkqFw==
X-Received: by 2002:a05:6638:d46:: with SMTP id d6mr24412593jak.129.1638546493028;
        Fri, 03 Dec 2021 07:48:13 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f11sm2345027ila.17.2021.12.03.07.48.12
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 07:48:12 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: avoid clearing blk_mq_alloc_data unnecessarily
Message-ID: <1ba89cb7-e53c-78c3-1fe4-db9908851e63@kernel.dk>
Date:   Fri, 3 Dec 2021 08:48:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We already set almost all of what we need here, just the non-plug
path needs to set nr_tags and clear cached.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4dc0837f874d..eba34af1c5eb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2664,7 +2664,7 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 {
 	struct blk_mq_alloc_data data = {
 		.q		= q,
-		.nr_tags	= 1,
+		.shallow_depth	= 0
 	};
 	struct request *rq;
 
@@ -2683,6 +2683,9 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 		data.nr_tags = plug->nr_ios;
 		plug->nr_ios = 1;
 		data.cached_rq = &plug->cached_rq;
+	} else {
+		data.nr_tags = 1;
+		data.cached_rq = NULL;
 	}
 
 	rq = __blk_mq_alloc_requests(&data);

-- 
Jens Axboe

