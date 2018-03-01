Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:54555 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032132AbeCAQAM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Mar 2018 11:00:12 -0500
Received: by mail-wm0-f49.google.com with SMTP id z81so13004359wmb.4
        for <linux-block@vger.kernel.org>; Thu, 01 Mar 2018 08:00:11 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH V2] lightnvm: pblk: refactor init/exit sequences
Date: Thu,  1 Mar 2018 16:59:57 +0100
Message-Id: <1519919998-20829-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

# Changes since V1
  - Remove double check for factory initialization

The init/exit sequences have grown in a very bad way. Refactor them to
eliminate dependencies across initialization modules.

One of these dependencies caused a bad double free when introducing a
preparation patch for 2.0 bad block identification. This was reported by
Dan Carpenter and 0-DAY.

Matias,

Since you have not send the PR to Jens, please squash this patch with:
    lightnvm: pblk: refactor bad block identification

You will notice that I had queued this patch on the 2.0 series. I did
the rebase now, which is probably what I should have done from the
beginning. Since I'll be sending a V5 for it, this should not be a
problem.

Thanks,
Javier

Javier González (1):
  lightnvm: pblk: refactor init/exit sequences

 drivers/lightnvm/pblk-init.c | 415 +++++++++++++++++++++----------------------
 1 file changed, 206 insertions(+), 209 deletions(-)

-- 
2.7.4
