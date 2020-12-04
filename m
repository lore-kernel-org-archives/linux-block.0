Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0358C433FE
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 19:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5595122C9F
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 19:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgLDTOq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbgLDTOq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 14:14:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B04C0613D1
        for <linux-block@vger.kernel.org>; Fri,  4 Dec 2020 11:14:06 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607109244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DJHe4FVUE8V83odrVLG3JJC/hYgCBJt9j/6aNkZhunM=;
        b=Gjp1cjFx+QihOFZtGxA17osHK84hINjqsP7ZWQEBu42xMC4f19/GC078KoFVcw3Alm/ieh
        za+RcInUBb44dHm8KhBoXHCgPG5UCAUWKg4SW9ESNWI3tQjd+LGAryzo0dhuMjW6n6EDBq
        zihR+SG4PR9SYcjX4r5K2rl5N6+9SN4USgBHEBJQqZIEjgUJvzMuoW02ew/R5GyL7ydhc0
        8yiZXdBtP1oECiWLB171k72C6fOmSMCvp1G9YmYrAnjAUVnXVp6WLxiz8wkgtlbEwXVCmi
        W26jORkL6oN57X7TETa7J4uqk9XLCKOl0X3QCQYAREUYO87PunOs6EjZYHAxHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607109244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DJHe4FVUE8V83odrVLG3JJC/hYgCBJt9j/6aNkZhunM=;
        b=+XiDms+waWT1BFUt9sHwHf3jQS0ZA23YmOlpcTss7P8BptRUVHHze+CXBOv0GYG69fZfI3
        zEmrcevhQ0s05IBg==
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 0/3 v2] blk-mq: Don't complete in IRQ, use llist_head
Date:   Fri,  4 Dec 2020 20:13:53 +0100
Message-Id: <20201204191356.2516405-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This a repost of the patches in the old thread [0] which died, rebase again=
st
-next.

The series avoids completing the requests on a remote CPU if booted with
threadirqs. It avoids completing requests in hard-IRQ context on remote
CPU by deferring it to the the softirq context.

One change since the last post: preempt-disable() around llist_add() +
raise_softirq() to ensure that request is added on the same CPU where
the softirq is raised. Some callers (like usb-storage) invoke this
function from preemtible context and this preserves the current "call me
from any context" semantic.
My understanding is that in a later attempt we may change such callers
to complete directly and avoid the softirq ping-pong.

[0] https://lkml.kernel.org/r/20201028141251.3608598-1-bigeasy@linutronix.de

Sebastian


