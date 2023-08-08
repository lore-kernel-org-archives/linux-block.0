Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A9EC04E69
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 17:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjHHR5X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjHHR4j (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 13:56:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C8BBF572
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 09:25:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5AB362552
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 13:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55CEC433C8;
        Tue,  8 Aug 2023 13:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691503024;
        bh=hCiafJIuo132SXYA3rNC1rHWchmn0aURcRNHrvQTYCs=;
        h=From:To:Subject:Date:From;
        b=lUqgRRA5AoKobOp2VbZ3iM2dueovDtClQ58TGMX1XsNHUUDqxGkjw8vH4aSLX+TU7
         1roS/3bZZ3W04J4WWH6zoBfjSBQ7bZwQQ2+ozk4YZZslDci1RrXZqz/5UBkoqUBv0P
         mskfsqePlUXgaaUKuPp62JQ+2ZJ9gJqbBeUBs/rI19PGO8czfjqawE5UZKVl4ld5tA
         9SDgl+PzVseGfP65Vb9Wfn4lf5EVF8bJvRn5QGX58pjkJQIZOCaKm5gSl9I5vq+jpY
         HAa0NU40ui010XUQ3w4SGn1Wipj6BTigZnSKK+X5IRVOyReYE7PaycFKQVFMYNNfT/
         WzQxYDZTsfnwg==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 0/5] Some minor cleanups
Date:   Tue,  8 Aug 2023 22:56:57 +0900
Message-ID: <20230808135702.628588-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Patch 1 changes the blk-settings code to use PAGE_SECTORS_SHIFT instead
of "PAGE_SHIFT - 9". The following patches swith calls to printk() to
the equivalent pr_XXX() calls.

No functional changes overall.

Damien Le Moal (5):
  block: use PAGE_SECTORS_SHIFT to set limits
  block: use pr_xxx() instead of printk()
  block: use pr_xxx() instead of printk() in partition code
  block: Improve efi partition debug messages
  block: switch ldm partition code to use pr_xxx() functions

 Documentation/admin-guide/ldm.rst |  7 +++----
 arch/m68k/configs/virt_defconfig  |  1 -
 block/bio-integrity.c             | 11 ++++++----
 block/blk-ioc.c                   |  5 ++++-
 block/blk-mq.c                    | 25 ++++++++++++----------
 block/blk-settings.c              | 25 ++++++++++++----------
 block/bsg.c                       |  7 +++++--
 block/elevator.c                  |  5 ++++-
 block/genhd.c                     |  7 +++++--
 block/partitions/Kconfig          | 10 ---------
 block/partitions/atari.c          | 11 ++++++----
 block/partitions/check.h          |  1 +
 block/partitions/core.c           | 33 ++++++++++++++---------------
 block/partitions/efi.c            |  3 +++
 block/partitions/ldm.c            | 35 +++++++------------------------
 block/partitions/sgi.c            |  7 +++++--
 block/partitions/sun.c            |  5 ++++-
 17 files changed, 99 insertions(+), 99 deletions(-)

-- 
2.41.0

