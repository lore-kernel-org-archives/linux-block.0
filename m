Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC3CC433EF
	for <linux-block@archiver.kernel.org>; Sat, 29 Jan 2022 07:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349216AbiA2HQD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jan 2022 02:16:03 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56739 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243344AbiA2HQD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jan 2022 02:16:03 -0500
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20T7FWoB082091;
        Sat, 29 Jan 2022 16:15:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Sat, 29 Jan 2022 16:15:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20T7FSNl082068
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 29 Jan 2022 16:15:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
Subject: loop: make autoclear operation synchronous again
Date:   Sat, 29 Jan 2022 16:14:53 +0900
Message-Id: <20220129071500.3566-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is based on ideas from https://lkml.kernel.org/r/20220128130022.1750906-1-hch@lst.de
but also kills "disk->open_mutex => lo->lo_mutex" dependency.

Since __loop_clr_fd() runs synchronously from lo_release(),
the reported regressions should be fixed.

We can apply Christoph's

  [PATCH 1/8] loop: de-duplicate the idle worker freeing code
  [PATCH 2/8] loop: initialize the worker tracking fields once
  [PATCH 3/8] loop: remove the racy bd_inode->i_mapping->nrpages asserts

patches after this series.

I'm surprised with a lot of "if (!release)" usage in __loop_clr_fd() needed
for avoid waiting for I/O request. By the way, does bdev_disk_changed() from
__loop_clr_fd() involve I/O request which we are trying to avoid?
