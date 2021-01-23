Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F80AC433DB
	for <linux-block@archiver.kernel.org>; Sat, 23 Jan 2021 20:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F128922EBE
	for <linux-block@archiver.kernel.org>; Sat, 23 Jan 2021 20:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbhAWULX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Jan 2021 15:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbhAWULT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Jan 2021 15:11:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20425C0613D6;
        Sat, 23 Jan 2021 12:10:39 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611432634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=snbBb8jbhWawsw2GQsoMHEAKGubaOMjN8g5bGgFLep8=;
        b=b6HbygbiVP2lcXA+lKmy7IiN+6FqeUJFUkgeR5UelMv2N8aINVYMIQ1tcLOoHrvmv3ePTT
        n61hiRZhsU+Jyy4YJs35a16Hc+W8wzgRoHhYKEBn3FRgrgwa3LODg074Tc+6p6cwgbPphb
        8OKYLYwLwiqp6yDPk7ZS9VH0r1e1iVGElLKoTsVd5939d8eOxoHzIcxj50F72PUfI2Iqdj
        I3kWF89xRZf3Ydl4RTtqjVXRpIwF7dtl/EeB2/cA1OWP1+SUVaCzcobhxTn3kq3N2uRwVT
        Um3G8+5ZuxMFbXlG6JXNUXhoSO9raFovDkJSVCaaZWfOCU981ilwa+lJFx+xSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611432634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=snbBb8jbhWawsw2GQsoMHEAKGubaOMjN8g5bGgFLep8=;
        b=jdIEwID/4bQ3nmAPbaZAtu9xC+D1aOSxyJaF/RtW1fqRhdcS97ZAwgx+WYKCfdSVq1i24b
        jFlK7OZgy37YMDDQ==
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v3 0/3] blk-mq: Don't complete in IRQ, use llist_head
Date:   Sat, 23 Jan 2021 21:10:24 +0100
Message-Id: <20210123201027.3262800-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Patch 2+3 were applied and then dropped by Jens due to a NOHZ+softirq
related warning [0]. Turns out a successful wakeup via
set_nr_if_polling() will not process any softirqs and the CPU may go
back to idle. This is addressed by patch #1.

smpcfd_dying_cpu() will also invoke SMP-functions calls via
flush_smp_call_function_queue() but the block layer shouldn't queue
anything because the CPU isn't online anymore.
The two caller of flush_smp_call_function_from_idle() look fine with
opening interrupts from within do_softirq().

[0] https://lkml.kernel.org/r/1ee4b31b-350e-a9f5-4349-cfb34b89829a@kernel.dk

Sebastian


