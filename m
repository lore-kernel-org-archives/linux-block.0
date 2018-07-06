Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45138 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933525AbeGFRjO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jul 2018 13:39:14 -0400
Received: by mail-lf0-f65.google.com with SMTP id m13-v6so10417642lfb.12
        for <linux-block@vger.kernel.org>; Fri, 06 Jul 2018 10:39:14 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, damien.lemoal@wdc.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH 0/2] null_blk: zone support
Date: Fri,  6 Jul 2018 19:38:37 +0200
Message-Id: <20180706173839.28355-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This series adds support for exposing a zone block device using the
null_blk device driver.

The first patch moves core null_blk data structures to a shared header
file. The second implements the actual zone support. The patchset adds
two new options. One to enable the zone interface, and another to
define the size of the zones to expose.

Thanks,
Matias

Matias Bjørling (2):
  null_blk: move shared definitions to header file
  null_blk: add zone support

 Documentation/block/null_blk.txt |   7 ++
 drivers/block/Makefile           |   5 +-
 drivers/block/null_blk.c         | 124 ++++++++++++--------------------
 drivers/block/null_blk.h         | 108 ++++++++++++++++++++++++++++
 drivers/block/null_blk_zoned.c   | 149 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 315 insertions(+), 78 deletions(-)
 create mode 100644 drivers/block/null_blk.h
 create mode 100644 drivers/block/null_blk_zoned.c

-- 
2.11.0
