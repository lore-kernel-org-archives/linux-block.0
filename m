Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:29432 "EHLO
        BJEXMBX011.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750722AbdJMQ0F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 12:26:05 -0400
Date: Sat, 14 Oct 2017 00:24:59 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH 0/2] Update the usage hints of submit_queues and
Message-ID: <20171013162453.GA12557@source.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

no_sched
Message-ID: <cover.1507911414.git.zhangweiping@didichuxing.com>
Reply-To: 

Hi Jens,
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
These two misc patch update the usage hints of null_blk module
parameter.

Because submit_queues was changed to 1 by default, so update it's
description.

The second patch add usage hints for no_sched.


weiping zhang (2):
  null_blk: update usage hints for submit_queues
  null_blk: add usage hints for no_sched

 Documentation/block/null_blk.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.14.2
