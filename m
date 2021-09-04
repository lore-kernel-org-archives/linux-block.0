Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F98C4332F
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E573C60FA0
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350748AbhIDBgu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Sep 2021 21:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350923AbhIDBgq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Sep 2021 21:36:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D281C0613CF;
        Fri,  3 Sep 2021 18:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=cGJBDDMa+wCOTAoBx2X4rM3BSK+QMBxNlmwyNZGWrto=; b=4g05rU+dRwu1uN1G9hh4EJRgnO
        iK78qlSSGnVyujAe2wLb0Jnefjju/4YaE4KOKtj5Cn1RMRt8uRE9one/i3jZJC1cTTdLm8w/1Tq2P
        Ebys9YL/JtluXvqgz0+pSHRzpErvfO2OfzFheLKrVT/ReVinzeaoXWjCbRIzWACUuXVhYDyCMCXc7
        asS40hNzAmO/oIBu9A57VlO47SKIfNeVh86cxfmKwWak1zY3sdCK3P3toPUSz4nlku46fIUGT1sZ3
        P+H/bxv0I+PJLuFMexCactUxvd5+VSh9RgmQ3vYVHGemzIlsv4pNg987/VZgRaHe4U+d2x1OEwcEn
        NhX4MoLQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMKan-00DLb0-2p; Sat, 04 Sep 2021 01:35:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 00/14] block: 6th batch of add_disk() error handling conversions
Date:   Fri,  3 Sep 2021 18:35:22 -0700
Message-Id: <20210904013536.3181237-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is the 6th of 7 batch of driver conversions over to use the
new add_disk() error handling. This series addresses the wonderful
and extremely exciting world of floppy drivers. You can find the full
set of my patches on my 20210901-for-axboe-add-disk-error-handling
branch [0]. This is based on axboe/master.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210901-for-axboe-add-disk-error-handling

Luis Chamberlain (14):
  block/swim3: add error handling support for add_disk()
  floppy: fix add_disk() assumption on exit due to new developments
  floppy: use blk_cleanup_disk()
  floppy: fix calling platform_device_unregister() on invalid drives
  floppy: add error handling support for add_disk()
  amiflop: add error handling support for add_disk()
  swim: simplify using blk_cleanup_disk() on swim_remove()
  swim: add helper for disk cleanup
  swim: add a floppy registration bool which triggers del_gendisk()
  swim: add error handling support for add_disk()
  block/ataflop: use the blk_cleanup_disk() helper
  block/ataflop: add registration bool before calling del_gendisk()
  block/ataflop: provide a helper for cleanup up an atari disk
  block/ataflop add error handling support for add_disk()

 drivers/block/amiflop.c |  7 ++++--
 drivers/block/ataflop.c | 47 +++++++++++++++++++++++++----------------
 drivers/block/floppy.c  | 34 +++++++++++------------------
 drivers/block/swim.c    | 35 ++++++++++++++++++------------
 drivers/block/swim3.c   |  4 +++-
 5 files changed, 71 insertions(+), 56 deletions(-)

-- 
2.30.2

