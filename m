Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60720 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754735AbdBGXHX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Feb 2017 18:07:23 -0500
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Subject: [GIT PULL] WRITE_SAME regression fix for 4.10
Message-ID: <6b425212-705d-d346-6ab1-f84307f03754@fb.com>
Date: Tue, 7 Feb 2017 16:07:17 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus,

Please pull the below branch for a single fix that should go into 4.10,
fixing a regression on some devices with the WRITE_SAME command.


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Christoph Hellwig (1):
      block: don't try Write Same from __blkdev_issue_zeroout

 block/blk-lib.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
Jens Axboe
