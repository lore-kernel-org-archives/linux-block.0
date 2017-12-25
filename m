Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35109 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbdLYCoc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Dec 2017 21:44:32 -0500
From: xuejiufei <xuejiufei@gmail.com>
To: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@fb.com>,
        Shaohua Li <shli@kernel.org>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: [RFC] distinguish foreground and background IOs in block throttle
Message-ID: <1fa623a6-e374-de5e-477e-e604cb760f82@gmail.com>
Date: Mon, 25 Dec 2017 10:44:26 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi all,

Cgroup writeback is supported since v4.2. I found there exists a
problem in the following case.

A cgroup may send both buffer and direct/sync IOs. The foreground
thread will be stalled when periodic writeback IOs is flushed because
the service queue already has a plenty of writeback IOs, then
foreground IOs should be enqueued with its FIFO policy.

I wonder if we can distinguish foreground and background IOs in block
throttle to fix the above problem.

Any suggestion are always appreciated.


Thanks,
Jiufei
