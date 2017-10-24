Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:57236 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbdJXN4V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Oct 2017 09:56:21 -0400
Received: by mail-wm0-f52.google.com with SMTP id z3so9526506wme.5
        for <linux-block@vger.kernel.org>; Tue, 24 Oct 2017 06:56:20 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: axboe@fb.com
Cc: mb@lightnvm.io, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: fix pblk testing leftover
Date: Tue, 24 Oct 2017 15:56:12 +0200
Message-Id: <1508853373-17796-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

I just noticed a testing leftover that made it in one of this window's
patches. Can you pick this up (and eventually squash it)?

Thanks,
Javier

Javier González (1):
  lightnvm: pblk: remove testing leftover

 drivers/lightnvm/pblk.h | 5 -----
 1 file changed, 5 deletions(-)

-- 
2.7.4
