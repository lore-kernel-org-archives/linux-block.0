Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:52073 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbdKCKC6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Nov 2017 06:02:58 -0400
Received: by mail-wm0-f52.google.com with SMTP id b9so380007wmh.0
        for <linux-block@vger.kernel.org>; Fri, 03 Nov 2017 03:02:57 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: hch@lst.de, sagi@grimberg.me, keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/3] nvme: small fixes reported by smatch
Date: Fri,  3 Nov 2017 11:02:47 +0100
Message-Id: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Fix a number of small things reported by smatch on the nvme driver

Javier González (3):
  nvme: do not check for ns on rw path
  nvme: compare NQN string with right size
  nvme: fix eui_show() print format

 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4
