Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7949C3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 22:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8D920856
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 22:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfHUWsU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 18:48:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38621 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbfHUWsT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 18:48:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id m125so3739295wmm.3
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2019 15:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=nsaNYtRQIiJ1ti6tzeDQppUUI9XdKjdVpoIwWkW09B0=;
        b=PbrDjF8HesSzUB8xJIlXbYrF/+MO3O5otGW+wLsxqiTOqgQ53gsxKCNhIt20ixAR8I
         gdl6g/cTYz640biteGBkvJNiEXBDSnqDNWquBeWJpiiaLg2dxa26a9w3UzQmPRV8D7F6
         xPpXxzdtBBNjGKVRTav3YeFWFqqLmY8zQCapTMPlELAwqZmPzatYvVN313LLbYFhtUOB
         JSfMp0nIVvuzPZxXy/kuKbO6wVAGxr/Si1TfE5E92Ww7YTl77TEIV+v4G/YHlDkW9PRh
         xb1tyo9ZYKCL3ZounibIc1RbLpuNupTSYqtD/P+zmR/MoJcwvK2OuG0AnBJ0OQqPw2u8
         Xx3A==
X-Gm-Message-State: APjAAAXLFHZbC3Krl+qT37gTM6M9Xoxk/pSIheZ7wi4f45zTd9OFjcz6
        k0+7tAimGbHsRew4BWCIjFAtAJI5
X-Google-Smtp-Source: APXvYqwCRZUcb+bk7tz2rWzKKfE1yIBrnkQqhO0ATyXBEmrgSH34LsYbEdXylEA57dH28ppqD8eVLA==
X-Received: by 2002:a05:600c:551:: with SMTP id k17mr2431792wmc.53.1566427697657;
        Wed, 21 Aug 2019 15:48:17 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id a142sm1216759wme.2.2019.08.21.15.48.16
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 15:48:16 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Subject: soft lockup with io_uring
Message-ID: <2f87ee3f-d61f-e572-08f5-96a8ef8843b0@grimberg.me>
Date:   Wed, 21 Aug 2019 15:48:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey,

Just ran io-uring-bench on my VM to /dev/nullb0 and got the following 
soft lockup [1], the reproducer is as simple as:

modprobe null_blk
tools/io_uring/io_uring-bench /dev/nullb0

It looks like io_iopoll_getevents() can hog the cpu, however I don't
yet really know what is preventing it from quickly exceeding min and
punting back...

Adding this makes the problem go away:
--
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 8b9dbf3b2298..aba03eee5c81 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -779,6 +779,7 @@ static int io_iopoll_getevents(struct io_ring_ctx 
*ctx, unsigned int *nr_events,
                         return ret;
                 if (!min || *nr_events >= min)
                         return 0;
+               cond_resched();
         }

         return 1;
--

But I do not know if this is the correct way to fix this, or what
exactly is the issue, but thought I send it out given its so
easy to reproduce.


[1]:
--
[1032930.615999] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! 
[io_uring-bench:21221]
[1032930.626182] RIP: 0010:io_iopoll_getevents+0xaf/0x260
[...]
[1032930.626942] Call Trace:
[1032930.627598]  io_iopoll_check+0x34/0x70
[1032930.627601]  __x64_sys_io_uring_enter+0x183/0x300
[1032930.627729]  do_syscall_64+0x55/0x130
[1032930.627911]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[1032930.627927] RIP: 0033:0x7fa4641d7839
[...]
[1032958.615873] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! 
[io_uring-bench:21221]
[1032958.720822] RIP: 0010:blkdev_iopoll+0x0/0x30
[...]
[1032958.721116] Call Trace:
[1032958.721624]  io_iopoll_getevents+0xaa/0x260
[1032958.721635]  io_iopoll_check+0x34/0x70
[1032958.721637]  __x64_sys_io_uring_enter+0x183/0x300
[1032958.721642]  do_syscall_64+0x55/0x130
[1032958.721649]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[1032958.721654] RIP: 0033:0x7fa4641d7839
[...]
--
