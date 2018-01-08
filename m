Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:43989 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934227AbeAHUVj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jan 2018 15:21:39 -0500
Received: by mail-pg0-f54.google.com with SMTP id f14so3730102pga.10
        for <linux-block@vger.kernel.org>; Mon, 08 Jan 2018 12:21:39 -0800 (PST)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@fb.com
Subject: [416 PATCH 00/13] Bcache changes for 4.16
Date: Mon,  8 Jan 2018 12:21:17 -0800
Message-Id: <20180108202130.31303-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Jens,

Please pick up the following reviewed changes for 4.16.  There's some
small cleanliness changes, a few minor bug fixes (some in preparation
for larger work), and ongoing work on writeback performance:

 11 files changed, 303 insertions(+), 133 deletions(-)

Coly Li (2):
      bcache: reduce cache_set devices iteration by devices_max_used
      bcache: fix misleading error message in bch_count_io_errors()

Kent Overstreet (2):
      bcache: Fix, improve efficiency of closure_sync()
      bcache: mark closure_sync() __sched

Michael Lyle (3):
      bcache: writeback: properly order backing device IO
      bcache: allow quick writeback when backing idle
      bcache: fix writeback target calc on large devices

Rui Hua (1):
      bcache: ret IOERR when read meets metadata error

Tang Junhui (3):
      bcache: stop writeback thread after detaching
      bcache: segregate flash only volume write streams
      bcache: fix wrong return value in bch_debug_init()

Vasyl Gomonovych (1):
      bcache: Use PTR_ERR_OR_ZERO()

Zhai Zhaoxuan (1):
      bcache: fix unmatched generic_end_io_acct() & generic_start_io_acct()

Thanks,

Mike
