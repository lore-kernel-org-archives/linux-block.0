Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53858 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750825AbcKLXdj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Nov 2016 18:33:39 -0500
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Subject: [GIT PULL] More block fixes for 4.9-rc
Message-ID: <22971f86-33ad-4b1d-ce33-51bd6a1ccf73@fb.com>
Date: Sat, 12 Nov 2016 16:33:11 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus,

Since I mistakenly left out the lightnvm regression fix yesterday and
the aoeblk seems adequately tested at this point, might as well send out
another pull to make -rc5.

Please pull!


   git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Jens Axboe (1):
       aoe: fix crash in page count manipulation

Matias Bjørling (1):
       lightnvm: invalid offset calculation for lba_shift

  drivers/block/aoe/aoecmd.c   | 41 
-----------------------------------------
  drivers/nvme/host/lightnvm.c |  2 +-
  2 files changed, 1 insertion(+), 42 deletions(-)

-- 
Jens Axboe

