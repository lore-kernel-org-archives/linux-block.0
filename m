Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:54706 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbeH2OF7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 10:05:59 -0400
Received: by mail-it0-f65.google.com with SMTP id f14-v6so6840554ita.4
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 03:09:50 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/3] lightnvm: pblk: support variable OOB size
Date: Wed, 29 Aug 2018 12:09:27 +0200
Message-Id: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patchset adds pblk support for variable metadata sizes on the out
of bound area.

Igor, Marcin, you sent a patch some time ago implementing a similar
functionality, but it never got re-posted after review. Can you test
this and see if it works for your case? I did not implement support for
outlined metadata for the case where the reported OOB area is 0. It
should be pretty simple to do that on top of these patches though.

Thanks,
Javier

Javier González (3):
  lightnvm: use internal allocation for chunk log page
  lightnvm: do no update csecs and sos on 1.2
  lightnvm: pblk: support variable OOB size

 drivers/lightnvm/pblk-core.c     | 60 ++++++++++++++++++++++++++++++----------
 drivers/lightnvm/pblk-init.c     | 16 ++++++++++-
 drivers/lightnvm/pblk-map.c      | 19 +++++++++----
 drivers/lightnvm/pblk-read.c     | 55 ++++++++++++++++++++++--------------
 drivers/lightnvm/pblk-recovery.c | 34 ++++++++++++++++-------
 drivers/lightnvm/pblk.h          | 18 +++++++++---
 drivers/nvme/host/lightnvm.c     | 26 +++++++++++------
 7 files changed, 164 insertions(+), 64 deletions(-)

-- 
2.7.4
