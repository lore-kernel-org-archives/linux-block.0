Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1DEC433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C096101A
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbhI0WGu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238092AbhI0WG2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:06:28 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A906C05BD7D;
        Mon, 27 Sep 2021 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=2hMJbdNDgGUFnMCs8zu7W5WuKNHy30EWvai64Mq6zSE=; b=pLmM61/PBv6UUZdUchXfLQTjPe
        nrW9aL4/frnKrC82DyTyBzPmXO5mlZkVKCD8hgjhey0UrkE5UZuPhUkXjj2L9esA1kErnpNIZlRWu
        Dpg5GMHCg5y4Pdxajb4frhPV2wpIUv01EMeE+Vy14aT0lLOwm9qo9kc/TMuwC5fOwPDkyjVJMrIgZ
        SucPI38xvz2JnFnDvtCWThtNm+fNMCWjSl5dpE/ichJGAKarwMXvEY9P/wJOF7hksQBJVJImkt53L
        d8n2+lZiP2EH/v8AXHOqB6Hx4LV6OKHO6rnSPKMArvx1Q00bVQWND0i7zuD+UBwVthCf/wsw0YaKC
        X8kBuqzw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyiF-004VHq-B6; Mon, 27 Sep 2021 22:03:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 00/14] block: 6th batch of add_disk() error handling conversions
Date:   Mon, 27 Sep 2021 15:02:48 -0700
Message-Id: <20210927220302.1073499-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is the 6th series of driver conversions for add_disk() error
handling. This set alog with the other 7th set of driver conversions
can be found on my 20210927-for-axboe-add-disk-error-handling branch[0].

It would seem the floppy world is not so exciting and so
the only change does in this v2 iteration is rebasing the patches onto
linux-next tag 20210927.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210927-for-axboe-add-disk-error-handling

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
  block/ataflop: add error handling support for add_disk()

 drivers/block/amiflop.c |  7 ++++--
 drivers/block/ataflop.c | 47 +++++++++++++++++++++++++----------------
 drivers/block/floppy.c  | 34 +++++++++++------------------
 drivers/block/swim.c    | 35 ++++++++++++++++++------------
 drivers/block/swim3.c   |  4 +++-
 5 files changed, 71 insertions(+), 56 deletions(-)

-- 
2.30.2

