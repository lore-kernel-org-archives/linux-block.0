Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B875C07E99
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 21:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32CBB6186A
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 21:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhGEVuH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jul 2021 17:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhGEVuH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jul 2021 17:50:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F74C061574;
        Mon,  5 Jul 2021 14:47:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j199so17264148pfd.7;
        Mon, 05 Jul 2021 14:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2ub4axo8oQjLG+aAchaPA5SsxoWA7cHX0lH8tPFAIN8=;
        b=Oe6GkeVlv03C03b2GDeq9xWqWNrhzkLwj5E7FpgaOo0R5LWSO86WmR60GeWoyXbvqE
         jrD+xZdSz8VX6KzQ4nmvo4tewKZyTtorcpaQqDALIX0eW32ghAP89ag63Aro5XTcv9fw
         b2n2I41W2GzVW209tH7AvHeRc3LlAHtE1+ILW1m31QQohkuVH0ukoBc3DwSzTIJ06TjX
         v/LTKK98eSN9qEXiL7Q4dAdgG+4tj+iYEJYssmfjfOpVsw/hsQ+f145qc4tH8AioaOWn
         Jrsxt/JPH3bQpjnqK7h3xnwFprWM6dCAiBRxr4iCblm0P3wcEtH9GJAWdfykplcBygxL
         y8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2ub4axo8oQjLG+aAchaPA5SsxoWA7cHX0lH8tPFAIN8=;
        b=hO5+REMOksLz6uTlp9mxbw1iO01/G1bk2suNOpB9Id9M71bz0v6dIqXl2SYbGddWyr
         BsEMBZcSiNhKxYmQIY1lz3l3HR/ziuBzoJdF2i9sSw46hnWPYw8PhK9F6ZWzADYKMZNW
         Q1gkDSXaRfujo1NwToWicw4q0p6eVAJ4s6+q96bjLYe5uASgQl/u8XcViIxzIUqrAbzj
         58U3fkwEgks1L+kVgS29DQrIruP/w3Pvlk8AHEuR8jNzISJ0M3LWKA5yPtiHF9GYDIlH
         g4CKVgevmG9pN1W4JQByp0RMcHHC00dQrldQPVnafX/G5IILEmSYg8VzgkrvEPJgLfnc
         8ipQ==
X-Gm-Message-State: AOAM532/oskh3dQJpcByqkiyxJhrc91Utk/P5fiP0kyde5KrWK6qumXK
        t212rkr2fCLZFczjqXl40agohdd4pX6Rm6Fr
X-Google-Smtp-Source: ABdhPJxDEma7Cnmx4miYxxYUu8YBqyPi3vgpxbnoy/UN8ATOSUFAwAE+t6F+NOQ6kQ2OJKGztzjVag==
X-Received: by 2002:aa7:8e88:0:b029:310:c85b:fc05 with SMTP id a8-20020aa78e880000b0290310c85bfc05mr17294604pfr.19.1625521649333;
        Mon, 05 Jul 2021 14:47:29 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id g3sm412007pjl.17.2021.07.05.14.47.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jul 2021 14:47:29 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] block: fix the problem of io_ticks becoming smaller
Date:   Tue,  6 Jul 2021 05:47:26 +0800
Message-Id: <1625521646-1069-1-git-send-email-brookxu.cn@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

On the IO submission path, blk_account_io_start() may interrupt
the system interruption. When the interruption returns, the value
of part->stamp may have been updated by other cores, so the time
value collected before the interruption may be less than part->
stamp. So when this happens, we should do nothing to make io_ticks
more accurate? For kernels less than 5.0, this may cause io_ticks
to become smaller, which in turn may cause abnormal ioutil values.

v3: update the commit log
v2: sorry, fix compile error due to the missed ')'

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 514838c..bbf56ae 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1243,7 +1243,7 @@ static void update_io_ticks(struct block_device *part, unsigned long now,
 	unsigned long stamp;
 again:
 	stamp = READ_ONCE(part->bd_stamp);
-	if (unlikely(stamp != now)) {
+	if (unlikely(time_after(now, stamp))) {
 		if (likely(cmpxchg(&part->bd_stamp, stamp, now) == stamp))
 			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
 	}
-- 
1.8.3.1

