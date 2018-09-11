Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43958 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeIKQeh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 12:34:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id z27-v6so18959777edb.10
        for <linux-block@vger.kernel.org>; Tue, 11 Sep 2018 04:35:40 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [V2 PATCH 0/2] pblk: retrieve chunk metadata on erase
Date: Tue, 11 Sep 2018 13:35:32 +0200
Message-Id: <1536665734-14305-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Matias,

Here you have a new series. Please refer to for-4.20/pblk for ordering. I left
the OOB extension patch out since Igor will send a version for it. It is on my
branch though for completeness, until we ifnd the patch that should go in.

If we need to do some rebasing then, I would suggest that we do it directly on
core.

Thanks,
Javier

# Changes sinve V1:
  - Remove patches folded into Matias' 1.2 chunck patch
  - Rebase on top of Matias' core

Javier González (2):
  lightnvm: pblk: add helper for printing chunk state
  lightnvm: pblk: retrieve chunk metadata on erase

 drivers/lightnvm/core.c      | 44 ++++++++++++++++++++++++++++++++++++--
 drivers/lightnvm/pblk-core.c | 51 +++++++++++++++++++++++++++++++++-----------
 drivers/lightnvm/pblk.h      |  9 ++++++++
 3 files changed, 89 insertions(+), 15 deletions(-)

-- 
2.7.4
