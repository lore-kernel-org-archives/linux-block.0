Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA18C433F5
	for <linux-block@archiver.kernel.org>; Thu, 20 Jan 2022 17:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiATRaf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jan 2022 12:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiATRad (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jan 2022 12:30:33 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40092C06161C
        for <linux-block@vger.kernel.org>; Thu, 20 Jan 2022 09:30:33 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id r204so4064035iod.10
        for <linux-block@vger.kernel.org>; Thu, 20 Jan 2022 09:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bxtqlKFii/Ze07YEVaoqKAsRrgbSJJtO1EeuLx3wqJY=;
        b=pK4pxBJ7S2N7ZVO81pToUsyxvZJREOvc4ZIkHqDdIp2zEo0lqeKMAo3/HZ36lRveJ2
         jhgDtX+QdN3OXjnHv7cLiGs0XyLdlzmj81JnbHcFCvpEbQc/VrAxWihm0oMib7xqj20e
         nUu5Nw5MAdCnHNW3O243J30MFAByRDOq0nHlS3DgacLLT8jALuSMkA7TMbTQakfhWUBh
         Jtr7FZxc4OcDx8nTc3HI+jhW95Lru33X/IN81QBW4XNi2uK//NYnrZ2AwbcZDaontRmf
         QwbfRsDbw1DwDeAWJ+8dhpIDB7Q8+E+xaXJwAApHPdI+Wv1XGmDC4OrEDJkMDjxNrxeG
         xWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bxtqlKFii/Ze07YEVaoqKAsRrgbSJJtO1EeuLx3wqJY=;
        b=2iyf02KcGbavwcoE6m7LwEVnPSx3yaUxi32S5xm/BPQzPwbtSeQpj7H/Y5XWlUC7IZ
         jWjSTRG8xF9NVyM9jzWvJxjqTp+jdtpnU6HKgn4B5w56OAyCYElN6bWtZHv81KAmeJ+s
         r30rAKq3BhJpYU8/AtwVaUFw7cK/VGxoxtE1gre73mWobE7rgvZmO123n/dqWbTHwiLS
         FnbjkSRIk4C92OwecLXSGyQiYiuW2m6B70fTC7q9zXl5LhGsLVmTEPPF/dBfNOrj8pSO
         TFWstfmA+IRn9jHbIVMQdktqzik7a4CDSfbUzpj/S7ppFDxtJXA25NzfjtCWF8knUmJn
         wfFA==
X-Gm-Message-State: AOAM533lCXNmx46i2C7d8iH9NTztHv169Yl9ChQWeC4+N4sgegoU4Gd7
        HGLbthndZwnurpfWyKWJZNeZvLTLYLQ+EA==
X-Google-Smtp-Source: ABdhPJwndJR7XN48877EsYopEdw620Dg2se01szcjyOmhBkZykrdj+D6Ch060+vA54Y7ffIeXDqJyw==
X-Received: by 2002:a6b:f212:: with SMTP id q18mr19087200ioh.150.1642699832143;
        Thu, 20 Jan 2022 09:30:32 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i3sm1727552ilu.28.2022.01.20.09.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 09:30:31 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: fix async_depth sysfs interface for mq-deadline
Message-ID: <f8b01f4c-f8d5-8fcb-dba4-6d37f0db5622@kernel.dk>
Date:   Thu, 20 Jan 2022 10:30:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A previous commit added this feature, but it inadvertently used the wrong
variable to show/store the setting from/to, victimized by copy/paste. Fix
it up so that the async_depth sysfs interface reads and writes from the
right setting.

Fixes: 07757588e507 ("block/mq-deadline: Reserve 25% of scheduler tags for synchronous requests")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215485
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 85d919bf60c7..3ed5eaf3446a 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -865,7 +865,7 @@ SHOW_JIFFIES(deadline_write_expire_show, dd->fifo_expire[DD_WRITE]);
 SHOW_JIFFIES(deadline_prio_aging_expire_show, dd->prio_aging_expire);
 SHOW_INT(deadline_writes_starved_show, dd->writes_starved);
 SHOW_INT(deadline_front_merges_show, dd->front_merges);
-SHOW_INT(deadline_async_depth_show, dd->front_merges);
+SHOW_INT(deadline_async_depth_show, dd->async_depth);
 SHOW_INT(deadline_fifo_batch_show, dd->fifo_batch);
 #undef SHOW_INT
 #undef SHOW_JIFFIES
@@ -895,7 +895,7 @@ STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MA
 STORE_JIFFIES(deadline_prio_aging_expire_store, &dd->prio_aging_expire, 0, INT_MAX);
 STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX);
 STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);
-STORE_INT(deadline_async_depth_store, &dd->front_merges, 1, INT_MAX);
+STORE_INT(deadline_async_depth_store, &dd->async_depth, 1, INT_MAX);
 STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);
 #undef STORE_FUNCTION
 #undef STORE_INT

-- 
Jens Axboe

