Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CE7C7EE25
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 04:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjEDEDk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 May 2023 00:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEDEDi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 00:03:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8955719A8;
        Wed,  3 May 2023 21:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B4E162B68;
        Thu,  4 May 2023 04:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E84C433EF;
        Thu,  4 May 2023 04:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683173015;
        bh=L4Uw4T4l8XEHhc70zj7rKQfhgtmfnlbFKzVB2Spkrk0=;
        h=From:To:Cc:Subject:Date:From;
        b=SX8N+xoiaoDLgfFICiGJfnFG/1LdVOWIUV5u1/9NKfBwumGccLdoNUZ9TQBYhc8N+
         H912WiSX6MKzcZNZn9CEVEDF/ysbGgn8mxk8D0OwnAxBGBkacUFwlNTaaKPcBpYLLA
         rttULuWBosbQvGjFZJDm5upVX1GMYhG1f8uW0UGM5xX+GSpQbW4u1S+Up+kds8c6Ce
         Dagmkdopn2QMYo/8oMPFC0EvCUe0GHZzMeZWjJHqqVQcj3V/bOpz7pMoVer99CI6xc
         ubxV+5jnmWNZkbcE+IeUfB76P66ujVA66jkEWtBUIlSHOQstJ2L6c996FfNwMpNIJH
         MP+NcuDqTNErg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 5.15 0/3] blk-crypto fixes for 5.15
Date:   Wed,  3 May 2023 21:03:26 -0700
Message-Id: <20230504040329.106127-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series backports some blk-crypto fixes to 5.15.

Eric Biggers (3):
  blk-mq: release crypto keyslot before reporting I/O complete
  blk-crypto: make blk_crypto_evict_key() return void
  blk-crypto: make blk_crypto_evict_key() more robust

 block/blk-core.c            |  7 ++++
 block/blk-crypto-internal.h | 25 +++++++++++---
 block/blk-crypto.c          | 69 +++++++++++++++++++++----------------
 block/blk-merge.c           |  2 ++
 block/blk-mq.c              |  2 +-
 block/keyslot-manager.c     | 43 +++++++++++------------
 drivers/md/dm-table.c       | 19 +++-------
 include/linux/blk-crypto.h  |  4 +--
 8 files changed, 99 insertions(+), 72 deletions(-)


base-commit: 8a7f2a5c5aa1648edb4f2029c6ec33870afb7a95
-- 
2.40.1

