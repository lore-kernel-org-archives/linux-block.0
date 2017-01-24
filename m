Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35430 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdAXKSH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 05:18:07 -0500
Received: by mail-lf0-f53.google.com with SMTP id n124so107878813lfd.2
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2017 02:18:06 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/6] mmc: block: command issue cleanups
Date: Tue, 24 Jan 2017 11:17:51 +0100
Message-Id: <20170124101757.19676-1-linus.walleij@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The function mmc_blk_issue_rw_rq() is hopelessly convoluted and
need to be refactored to it can be understood by humans.

In the process I found some weird magic return values passed
around for no good reason.

Things are more readable after this.

This work is done towards the goal of breaking the function in
two parts: one just submitting the requests and one checking the
result and possibly resubmitting the command on error, so we
can make the usual path (non-errorpath) smooth and quick, and
be called directly when the driver completes a request.

That in turn is a prerequisite for proper blk-mq integration
with the MMC/SD stack.

All that comes later.

Linus Walleij (6):
  mmc: block: break out mmc_blk_rw_cmd_abort()
  mmc: block: break out mmc_blk_rw_start_new()
  mmc: block: do not assign mq_rq when aborting command
  mmc: block: inline command abortions
  mmc: block: introduce new_areq and old_areq
  mmc: block: stop passing around pointless return values

 drivers/mmc/core/block.c | 108 ++++++++++++++++++++++++++---------------------
 drivers/mmc/core/block.h |   2 +-
 2 files changed, 60 insertions(+), 50 deletions(-)

-- 
2.9.3

