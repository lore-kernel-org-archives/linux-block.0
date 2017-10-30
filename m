Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:56606 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932353AbdJ3Vqy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Oct 2017 17:46:54 -0400
Received: by mail-pg0-f47.google.com with SMTP id m18so12795043pgd.13
        for <linux-block@vger.kernel.org>; Mon, 30 Oct 2017 14:46:54 -0700 (PDT)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@fb.com
Subject: Series of patches for bcache targeting 4.15
Date: Mon, 30 Oct 2017 14:46:30 -0700
Message-Id: <20171030214635.29888-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens--

I have a few last patches for bcache targeting 4.15 if it's
possible to get them in.  I'm sorry this is a bit late.

All are reviewed and have received a moderate amount of test
in my environment (and I'm continuing testing).

[PATCH 1/5] bcache: only permit to recovery read error when cache
[PATCH 2/5] bcache: convert cached_dev.count from atomic_t to
[PATCH 3/5] bcache: update bucket_in_use in real time
[PATCH 4/5] bcache: fix wrong cache_misses statistics
[PATCH 5/5] bcache: explicitly destroy mutex while exiting

Patches 1 and 3 are critical.  The first fixes correctness problems
if a cache volume fails and is being carried in distro trees.  #3
prevents a rare issue that can cause extended hanging of end-user
I/O.  The other three patches are relatively safe cleanup.

Thanks--

Mike
