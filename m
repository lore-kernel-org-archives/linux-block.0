Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39012 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391193AbeHPOca (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Aug 2018 10:32:30 -0400
Received: by mail-pl0-f66.google.com with SMTP id w14-v6so1967745plp.6
        for <linux-block@vger.kernel.org>; Thu, 16 Aug 2018 04:34:32 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [RFC PATCH v2 0/1] lightnvm: move bad block and chunk state logic to core
Date: Thu, 16 Aug 2018 13:34:16 +0200
Message-Id: <20180816113417.3641-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch moves the 1.2 and 2.0 block/chunk metadata retrieval to
core.

Hi Javier, I did not end up using your patch. I had misunderstood what
was implemented. Instead I implemented the detection of the each chunk by
first sensing the first page, then the last page, and if the chunk
is sensed as open, a per page scan will be executed to update the write
pointer appropriately.

Note that one needs a real drive to test the implementation. The 1.2
qemu implementation is lacking. I did update it a bit, such that
it defaults to all blocks being free. It can be picked up in the ocssd
qemu repository.

Changes since v1:

  - Add sensing of chunks wrt to free/open/closed
  - Add update of write pointer if chunk state is open

Matias Bjørling (1):
  lightnvm: move bad block and chunk state logic to core

 drivers/lightnvm/core.c      | 310 +++++++++++++++++++++++++++++++++++--------
 drivers/lightnvm/pblk-core.c |   6 +-
 drivers/lightnvm/pblk-init.c | 116 +---------------
 drivers/lightnvm/pblk.h      |   2 +-
 drivers/nvme/host/lightnvm.c |   4 +-
 include/linux/lightnvm.h     |  15 +--
 6 files changed, 266 insertions(+), 187 deletions(-)

-- 
2.11.0
