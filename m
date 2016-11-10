Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36573 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754747AbcKJL0m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2016 06:26:42 -0500
Received: by mail-wm0-f45.google.com with SMTP id g23so34689391wme.1
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2016 03:26:41 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@fb.com
Cc: keith.busch@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH] LightNVM fix for 4.9-rc5
Date: Thu, 10 Nov 2016 12:26:30 +0100
Message-Id: <1478777191-10160-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

A small calculation bug sneaked into 4.9, which led to data loss using the rrpc
FTL.

Can the fix be picked up for next -rc, or should I mark it for stable after the
4.9 release?

-Matias

Matias Bjørling (1):
  lightnvm: invalid offset calculation for lba_shift

 drivers/nvme/host/lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.1.4

