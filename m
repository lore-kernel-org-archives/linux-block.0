Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38411 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeDPQqt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Apr 2018 12:46:49 -0400
Received: by mail-lf0-f68.google.com with SMTP id n14-v6so5493352lfe.5
        for <linux-block@vger.kernel.org>; Mon, 16 Apr 2018 09:46:48 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, Javier Gonzales <javier@cnexlabs.com>,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 0/2] pblk bugfixes
Date: Mon, 16 Apr 2018 18:46:14 +0200
Message-Id: <1523897176-6241-1-git-send-email-hans.ml.holmberg@owltronix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

This is a couple of bugfixes, nothing very urgent.

Hans Holmberg (2):
  lightnvm: pblk: only try to recover lines with written smeta
  lightnvm: pblk: kick writer on new flush points

 drivers/lightnvm/pblk-cache.c    | 10 ++++++----
 drivers/lightnvm/pblk-core.c     |  2 +-
 drivers/lightnvm/pblk-rb.c       |  4 ++--
 drivers/lightnvm/pblk-recovery.c | 30 +++++++++++++++++++++---------
 drivers/lightnvm/pblk.h          |  1 +
 5 files changed, 31 insertions(+), 16 deletions(-)

-- 
2.7.4
