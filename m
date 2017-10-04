Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:43301 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbdJDPD2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Oct 2017 11:03:28 -0400
Received: by mail-wm0-f47.google.com with SMTP id m72so14739978wmc.0
        for <linux-block@vger.kernel.org>; Wed, 04 Oct 2017 08:03:27 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
Subject: [PATCH v2 0/2] block: cope with WRITE ZEROES failing in blkdev_issue_zeroout()
Date: Wed,  4 Oct 2017 17:03:14 +0200
Message-Id: <1507129396-20458-1-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Christoph, Martin,

blkdev_issue_zeroout() now checks for any error.  This required a minor
refactor, so I dropped the stable tag, Jens can add it back if needed.

v1 -> v2:
- changed code flow in blkdev_issue_zeroout() according to Christoph's
  suggestion
- this required adding additional checks to blkdev_issue_zeroout() and
  __blkdev_issue_zero_pages(), the latter is no longer void

Previous patch(es) and discussion at

  https://marc.info/?l=linux-block&m=150471953327942&w=2
  https://marc.info/?l=linux-block&m=150601399031909&w=2

Thanks,

                Ilya


Ilya Dryomov (2):
  block: factor out __blkdev_issue_zero_pages()
  block: cope with WRITE ZEROES failing in blkdev_issue_zeroout()

 block/blk-lib.c | 104 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 68 insertions(+), 36 deletions(-)

-- 
2.4.3
