Return-Path: <SRS0=Rcc/=XO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6180C3A5A6
	for <linux-block@archiver.kernel.org>; Thu, 19 Sep 2019 15:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817DE21848
	for <linux-block@archiver.kernel.org>; Thu, 19 Sep 2019 15:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZnLJExZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391409AbfISPtB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:49:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38337 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390065AbfISPtA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Sep 2019 11:49:00 -0400
Received: by mail-io1-f66.google.com with SMTP id k5so8865448iol.5
        for <linux-block@vger.kernel.org>; Thu, 19 Sep 2019 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=00so/6NStvavOkympAOpUd03xufg92UJhhksYm+0Ua0=;
        b=ZnLJExZLsJFj9HK3PptgO3qTuXhgf+rYVbVtn25wgMr0rwfemMT4p9joiNfLLqUmA2
         4FSZ1mkwOPZkW3y1MbMBGhTyZa75kCwTropnXFqMuP7VCb4mB2TWJKadTK8TzPbcrx6t
         BWhwDaycX9XnD8+TdJl/iYs2AcOxaZTGJEdHYE7qyyla96IXEBTNpz42Q7FVUnw0JEw4
         X7nuxKNtks/IyZuj1Ml+DxY7NcEhCEyh4TDw2Hpm21ZKisQI5YCdt3hVy8c5Q6Pt1ogl
         zH3HZt7QXLK4HTZW5XGtJDnRnpJ2e7a6sf7oEeTuIwJs/YrsDjUgI4k5fNJe2pZvCrCI
         H1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=00so/6NStvavOkympAOpUd03xufg92UJhhksYm+0Ua0=;
        b=aKmqZKPn/MgpNX1IhfXM2f9auwIoS1b+FbUS5g3KII2emGA9TwPuonWaDlZvCvDHyx
         TFzsgGo9jYNp7XuyKDH6c8njJcxEn0S0+6D9y8dFyuYCZX5pqu3zO71k5yofMl8zapBh
         +SqdtpK8hL5jtObC1KVhsDzLVoj2k+FzTzVk8InWX+gQ7JAMexUknL3LNjWSSI2HQXMA
         QVd9S5pUCVsDD3CbjZF3GvJOIQRr6RnXTvV1rphg+9AxvxMm9290um3yBxETqgewGyyN
         qnAfGfmSMsyTH6leRUn3WIr7fVges5w9U2Keh2Fg+deakz3HG1Ksn8zwqZUzi/R7yuDX
         1osQ==
X-Gm-Message-State: APjAAAXkwxrnWbTTvsPxXEUCYoNSi9hdWY/8uzP4xOKnIpVDEwah4dzE
        Q+pb2yacgIc7jdPTJiLniinue0LGpyqVdw==
X-Google-Smtp-Source: APXvYqwk0tAGt6fI0+q/P6SfvUZBs7bQtiXFlnf+2KIs1CdGVk5KQzRNEl/9PQwlq5qBHAT9XmSYgg==
X-Received: by 2002:a02:7f49:: with SMTP id r70mr12678047jac.85.1568908137777;
        Thu, 19 Sep 2019 08:48:57 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h70sm15243974iof.48.2019.09.19.08.48.56
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 08:48:56 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: use cond_resched() in sqthread
Message-ID: <d591d8c1-fb35-8ac3-0a4f-cb3a01aba114@kernel.dk>
Date:   Thu, 19 Sep 2019 09:48:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If preempt isn't enabled in the kernel, we can run into hang issues with
sqthread submissions. Use cond_resched() to play nice instead of
cpu_relax(), if we end up starting the loop and not having any events
pending for submissions.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 854dedd885fa..05a299e80159 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2438,7 +2438,7 @@ static int io_sq_thread(void *data)
 			 * to sleep.
 			 */
 			if (inflight || !time_after(jiffies, timeout)) {
-				cpu_relax();
+				cond_resched();
 				continue;
 			}
 
-- 
Jens Axboe

