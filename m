Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E37C49ED7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1497E206A5
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP53uxIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404072AbfIMW2S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:28:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34631 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404009AbfIMW2S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 18:28:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id y135so2803982wmc.1;
        Fri, 13 Sep 2019 15:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ngm7w4qbHtlMJdNCG88CXh8nP0Oze5VBvf7zLp4iqzY=;
        b=DP53uxIj2f1aUHm3OCrqBEtN7gs1CRrFzj7FDpS9ztadgKHGf1V0+cNEfIR1pWgSIv
         WriydTHFQd3nCbKCk5BzXZg0Pl64lTywRmw7MUrH7yjPBFOgP5IfCVB8bY6hzrqorysi
         iM3J3cvizmdsOp5PZ6buV3ZNv5XbHa3Gn6UWg3xb5+Hx89VVezevfVNR8x+IT6ZwkXJo
         oFUTmyCDHZwVxxyfFimyyOY9slE0QVL2DwM0LHp5C/oUtP14JvnEm5wqwK7G/XmbMCjh
         bwVsDt1rr19lmsPtUzFUzVor1cf1zuL1MWHFjG+0hYuCZTz5vdfPvE3E6/x6kdOsB5ko
         FlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ngm7w4qbHtlMJdNCG88CXh8nP0Oze5VBvf7zLp4iqzY=;
        b=TV2UfaSyngj4wrB0wQIjTD2gEaEGaR358+Nc5sron1iZuhFl2+v5jKkJm1tw3TK+il
         JQH1JVtWh2MPZ8dHebE7m4GiH+uJ0JCbvIFTYxj+FwqfVb8PkuOBOrU6GxsMj6VHDT9W
         StmSfziUIMLkCHoINcO6LLUT6E4XQUrnkhgQpaWW0d39obCqQNNj+4oYGmCsJP7L4SrE
         HKwyPJtwigHmlqu+SAIWsoaOG8QF+OsibZX9q0kC8Vq6ru+Ic8dav5qrfJ1g2y5lkSrs
         eKhBXaCeAvtigUkHVrazG1BmelA2N/x0pN0eq+A+0K9/NSdjMDjETpQ1OKY4hMHLG/7h
         3c2g==
X-Gm-Message-State: APjAAAXLSMmo6h73VVCTFlZe9L3kfmRVTRrm4+YlIXypUARAlHM/uHOo
        CqRvjI7sidHFQVl/Hsr0CI/ww/qitss=
X-Google-Smtp-Source: APXvYqyGGKLyDU/IaggmOU7bpeYlXV53GMECoqFoYK4Pb++AyM5ValDH+FRJ6oui69yNDKSEVsgsbQ==
X-Received: by 2002:a05:600c:24d2:: with SMTP id 18mr5211248wmu.146.1568413696087;
        Fri, 13 Sep 2019 15:28:16 -0700 (PDT)
Received: from localhost.localdomain ([109.126.151.137])
        by smtp.gmail.com with ESMTPSA id d12sm3456107wme.33.2019.09.13.15.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 15:28:15 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 0/2] Optimise io_uring completion waiting
Date:   Sat, 14 Sep 2019 01:28:00 +0300
Message-Id: <cover.1568413210.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

There could be a lot of overhead within generic wait_event_*() used for
waiting for large number of completions. The patchset removes much of
it by using custom wait event (wait_threshold).

Synthetic test showed ~40% performance boost. (see patch 2)

Pavel Begunkov (2):
  sched/wait: Add wait_threshold
  io_uring: Optimise cq waiting with wait_threshold

 fs/io_uring.c                  | 21 ++++++-----
 include/linux/wait_threshold.h | 64 ++++++++++++++++++++++++++++++++++
 kernel/sched/Makefile          |  2 +-
 kernel/sched/wait_threshold.c  | 26 ++++++++++++++
 4 files changed, 103 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/wait_threshold.h
 create mode 100644 kernel/sched/wait_threshold.c

-- 
2.22.0

