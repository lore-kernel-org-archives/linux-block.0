Return-Path: <SRS0=leUH=UL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C6EC31E48
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 16:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CBD2082C
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 16:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbfFLQUH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:20:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:41496 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730745AbfFLQUH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jun 2019 12:20:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53B7EAF90;
        Wed, 12 Jun 2019 16:20:06 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 0/4] Fixes for potential deadlock during reboot
Date:   Thu, 13 Jun 2019 00:19:54 +0800
Message-Id: <20190612161958.2082-1-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi folks,

Recently during my for-4.3 testing, I observe some lockdep warnings for
potential deadlock during reboot the kernel. Such potential deadlocks
are very hard to trigger in real life, but fix them and make lockdep
happy is still worthy IMHO.

This series is an effort to fix the potential deadlock issues, since
they are not critical stability fixes, they won't be CCed to stable
mailing list.

Thanks in advance for any commnet or review.

Coly Li
---

Coly Li (4):
  bcache: avoid a deadlock in bcache_reboot()
  bcache: acquire bch_register_lock later in cached_dev_detach_finish()
  bcache: acquire bch_register_lock later in cached_dev_free()
  bcache: fix potential deadlock in cached_def_free()

 drivers/md/bcache/super.c     | 49 +++++++++++++++++++++++++++++++++++++------
 drivers/md/bcache/sysfs.c     | 26 +++++++++++++++++++++++
 drivers/md/bcache/writeback.c |  4 ++++
 3 files changed, 73 insertions(+), 6 deletions(-)

-- 
2.16.4

