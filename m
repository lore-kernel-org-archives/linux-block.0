Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:41003 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932491AbeF1JMh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jun 2018 05:12:37 -0400
Received: by mail-pf0-f169.google.com with SMTP id a11-v6so2307157pff.8
        for <linux-block@vger.kernel.org>; Thu, 28 Jun 2018 02:12:36 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: hans.holmberg@cnexlabs.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
Date: Thu, 28 Jun 2018 11:12:00 +0200
Message-Id: <1530177121-24908-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Matias,

As discussed, here you have the patch reconstructing the state for 1.2
devices.

As mentioned in the patch itself, we make a tradeoff by doing this, as
writes might fail (or be more unstable) in case that a block has been
erased long before it is in used, and 1.2 does not have a way to
communicate this. The only thing the device can do is force an erase on
write when this happens, but if the device is responsible for this, one
could argue that it could prevent double-erases - which follows better
the predictability model we seek in Open-Channel.

Thoughts?

If we go this way, I will push a patch to the qemu 1.2 branch, as in the
initialization, we need to match empty page reporting with the block
metadata representing that the block is indeed erased. Ping me if you
want this patch in advance for testing.

Thanks,
Javier

Javier González (1):
  lightnvm: pblk: recover chunk state on 1.2 devices

 drivers/lightnvm/pblk-init.c | 138 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 124 insertions(+), 14 deletions(-)

-- 
2.7.4
