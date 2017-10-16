Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53217 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752284AbdJPN7X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Oct 2017 09:59:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id k4so3660736wmc.1
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2017 06:59:22 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
Subject: [PATCH v3 0/2] block: cope with WRITE ZEROES failing in blkdev_issue_zeroout()
Date: Mon, 16 Oct 2017 15:59:08 +0200
Message-Id: <1508162350-21978-1-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Christoph, Martin,

blkdev_issue_zeroout() now checks for any error.  This required a minor
refactor, so I dropped the stable tag, Jens can add it back if needed.

v2 -> v3:
- another code flow change in blkdev_issue_zeroout() suggested by
  Christoph -- no functional changes

v1 -> v2:
- changed code flow in blkdev_issue_zeroout() according to Christoph's
  suggestion
- this required adding additional checks to blkdev_issue_zeroout() and
  __blkdev_issue_zero_pages(), the latter is no longer void

Previous version at

  https://marc.info/?l=linux-block&m=150712940922089&w=2

Thanks,

                Ilya


Ilya Dryomov (2):
  block: factor out __blkdev_issue_zero_pages()
  block: cope with WRITE ZEROES failing in blkdev_issue_zeroout()

 block/blk-lib.c | 108 +++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 72 insertions(+), 36 deletions(-)

-- 
2.4.3
