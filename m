Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37182 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbdIURNE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 13:13:04 -0400
Received: by mail-wr0-f194.google.com with SMTP id u48so3470332wrf.4
        for <linux-block@vger.kernel.org>; Thu, 21 Sep 2017 10:13:03 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 0/2] block: cope with WRITE ZEROES failing in blkdev_issue_zeroout()
Date: Thu, 21 Sep 2017 19:12:50 +0200
Message-Id: <1506013972-23049-1-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Christoph, Martin,

blkdev_issue_zeroout() now checks for any error.  This required a minor
refactor, so I dropped the stable tag, Jens can add it back if needed.

Previous patch and discussion at

  https://marc.info/?l=linux-block&m=150471953327942&w=2

Thanks,

                Ilya


Ilya Dryomov (2):
  block: factor out __blkdev_issue_zero_pages()
  block: cope with WRITE ZEROES failing in blkdev_issue_zeroout()

 block/blk-lib.c | 85 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 32 deletions(-)

-- 
2.4.3
