Return-Path: <SRS0=FZnh=BK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FF5C433DF
	for <linux-block@archiver.kernel.org>; Fri, 31 Jul 2020 02:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4900320829
	for <linux-block@archiver.kernel.org>; Fri, 31 Jul 2020 02:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdU6oHW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbgGaCSm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 22:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbgGaCSm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 22:18:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E36C061574
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2020 19:18:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p1so15978345pls.4
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2020 19:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=lQ3lWAINRJRjy5au1VGopLAjMxEWcbYv5PQS/68KYNI=;
        b=AdU6oHW2rP+yqezO+132J4he76+hAvmsZI+cULbjr52VRHYH18tWlo4vE1zTFccSfU
         PBPT3HKmLf81JNfpDxpTIrCFT6BYaj8cikAvImPZdwEKl7BnZi/RxsCY5oGXhiTEBaxw
         wZC3AkfI3LdAT3urKaykN6ZB/nFFkiijdd69rY8TUWgjQavCm01U8OGU11Eb6pob8HrA
         wl7/CM/gYEMr/izCD4I6H9TH68BqPymtkwwmzuP6UOiezRa9BKjwOl1YTx+9jJvgs3Nt
         +Anzrc5AjDAtDHW2jeP8wYGuXadwpduXZwn15v7V1K9AZXSFUenWcbR0UlcOUgwC59p/
         gBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=lQ3lWAINRJRjy5au1VGopLAjMxEWcbYv5PQS/68KYNI=;
        b=S29RUmUkv8qpdQcJaXyWWrpBTMZp9GruXN9EzICifwN9/iGGGXbM/o5VTy4a8o+6fE
         r41KwVqSpLutVG+3fp3g5PyYNyKRT0ckDdwEV4UoBp+893i3d8r4Stfa+Wn8h0F3uSwK
         /9Vvf1mGaEGhBm/xNVcLns+4iv2dW/6b5j3Hq3ZDJK4fA/6RPtyd5VRt886uDK5dJWtR
         Vn9/pAZ91TEKpMt4n/IzPaT2li7zEuhaisLR1W7KqynKalr80cOdpy9gyrp3iClC9HRu
         D6m4NyXNoZC3C3zF8WW2BrZNhByUwhLK0IhY4qQl9iXeFWjBZ2KJy9OZ1vSUwp7ZYWLR
         2YcA==
X-Gm-Message-State: AOAM533GW07o9n9MDQET/vmPFbOfAJNccXbzoX/sFs7QKm/QyWbZHVdn
        UxYYXZCvL53B0/FVacmU4Xtgq6yXhJ4=
X-Google-Smtp-Source: ABdhPJykbQkQOZZvfYFEaBYHyG+4wSpnl6yS8OcMqL9Fl64vqJ/n+zpT+/A3d7ZIGCVGE53DPUQrXg==
X-Received: by 2002:aa7:92c7:: with SMTP id k7mr1695561pfa.101.1596161921649;
        Thu, 30 Jul 2020 19:18:41 -0700 (PDT)
Received: from [10.8.0.10] ([203.205.141.60])
        by smtp.gmail.com with ESMTPSA id t2sm5514573pfb.123.2020.07.30.19.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 19:18:41 -0700 (PDT)
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
From:   brookxu <brookxu.cn@gmail.com>
Subject: blk: delete the redundant NULL judgment in put_io_context()
Message-ID: <6b0b6924-e83b-4a66-2574-5a43a1761e2a@gmail.com>
Date:   Fri, 31 Jul 2020 10:18:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The context of calling put_io_context() will determine whether the ioc
is NULL or the ioc is obtained from icq, which can ensure that the ioc
is not NULL, so the repeated judgment here may be redundant.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/blk-ioc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 9df50fb..b34eae5 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -138,9 +138,6 @@ void put_io_context(struct io_context *ioc)
     unsigned long flags;
     bool free_ioc = false;
 
-    if (ioc == NULL)
-        return;
-
     BUG_ON(atomic_long_read(&ioc->refcount) <= 0);
 
     /*
-- 
1.8.3.1

