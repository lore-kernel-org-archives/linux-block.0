Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF3BC77B7C
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 03:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjEDDyy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 23:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjEDDyv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 23:54:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A115B1FDB;
        Wed,  3 May 2023 20:54:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28B8E62F64;
        Thu,  4 May 2023 03:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C38C433D2;
        Thu,  4 May 2023 03:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683172487;
        bh=39Zob00AERTZ91qH22GlORPcwLg/J3Sxa0y947hyAQg=;
        h=From:To:Cc:Subject:Date:From;
        b=fDvdf0NVO9C61tlLh+D9jnIlz7wkZVrdzFfvmhEkdP2JkfPen0Z65e7Qdxw5nGPdb
         J0EQd3D/HYSnQ0I5QZtnoiNI4C/jr6VuhU0rpOdiVa9EOMfxi62My4vasjHZykop8E
         xYn/SlIvgi9KbfDMdM5NtnoIkfGS9Ly88D6z1dYyQ1tzeg2SSbyJzGfPO2Kn2SycEW
         4fA1b0z0muX0i8mI/K2hO+tWguPN/F6P3JIfm+DtM5eUd7HUSIC86cyJVwwTolhQZQ
         LI6Q/EMapS/cFvNOIvB5kacF0jHuR/XshOW0TvOKnsGfECWjl5rweI2J83bnAgcV+R
         gSkOo9nt7oK+g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 6.1 0/7] blk-crypto fixes for 6.1
Date:   Wed,  3 May 2023 20:54:10 -0700
Message-Id: <20230504035417.61435-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series backports a couple blk-crypto fixes and their prerequisites
to 6.1-stable.  All are clean cherry-picks, but I'm sending this out
explicitly since the prerequisites might not have been obvious.

Bart Van Assche (1):
  blk-crypto: Add a missing include directive

Christoph Hellwig (3):
  blk-crypto: don't use struct request_queue for public interfaces
  blk-crypto: add a blk_crypto_config_supported_natively helper
  blk-crypto: move internal only declarations to blk-crypto-internal.h

Eric Biggers (3):
  blk-mq: release crypto keyslot before reporting I/O complete
  blk-crypto: make blk_crypto_evict_key() return void
  blk-crypto: make blk_crypto_evict_key() more robust

 Documentation/block/inline-encryption.rst | 12 +--
 block/blk-crypto-internal.h               | 37 ++++++++-
 block/blk-crypto-profile.c                | 47 ++++++-----
 block/blk-crypto.c                        | 95 +++++++++++++----------
 block/blk-merge.c                         |  2 +
 block/blk-mq.c                            | 15 +++-
 drivers/md/dm-table.c                     | 19 ++---
 fs/crypto/inline_crypt.c                  | 14 ++--
 include/linux/blk-crypto-profile.h        | 12 ---
 include/linux/blk-crypto.h                | 15 ++--
 10 files changed, 150 insertions(+), 118 deletions(-)


base-commit: ca48fc16c49388400eddd6c6614593ebf7c7726a
-- 
2.40.1

