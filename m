Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39217 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934500AbcKLALo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Nov 2016 19:11:44 -0500
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Subject: [GIT PULL] Block fixes for 4.9-rc
Message-ID: <21b1c040-ea27-847d-326a-266224516814@fb.com>
Date: Fri, 11 Nov 2016 17:11:26 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus,

Three small (really, one liners all of them!) fixes that should go into
this series:

- Request allocation error handling fix for nbd, from Christophe, fixing
   a regression in this series.

- lightnvm fix for a bad offset calculation, also a regression in this
   series. From Matias.

- Finally, an oops fix for drbd. Not a regression in this series, but
   stable material. From Richard.

Please pull!


   git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Christophe JAILLET (1):
       nbd: Fix error handling

Matias Bjørling (1):
       lightnvm: invalid offset calculation for lba_shift

Richard Weinberger (1):
       drbd: Fix kernel_sendmsg() usage - potential NULL deref

  drivers/block/drbd/drbd_main.c | 2 +-
  drivers/block/nbd.c            | 2 +-
  drivers/nvme/host/lightnvm.c   | 2 +-
  3 files changed, 3 insertions(+), 3 deletions(-)

-- 
Jens Axboe

