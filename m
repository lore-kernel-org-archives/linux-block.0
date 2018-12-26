Return-Path: <SRS0=oKFV=PD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8976EC43387
	for <linux-block@archiver.kernel.org>; Wed, 26 Dec 2018 05:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594D821741
	for <linux-block@archiver.kernel.org>; Wed, 26 Dec 2018 05:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbeLZFFH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Dec 2018 00:05:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:54918 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbeLZFFH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Dec 2018 00:05:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89896ADF4;
        Wed, 26 Dec 2018 05:05:05 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 0/1] second wave bcache fixes for Linux v4.21 
Date:   Wed, 26 Dec 2018 13:04:54 +0800
Message-Id: <20181226050455.24290-1-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

We have one more patch, which is a fix to avoid unnecessary bogus
failure on staled and dirty btree key of bcache.

This bogus failure does not always happen, but when it happens,
bcache code will take it as critical failure and call
bch_cache_set_error(), which may stop the cache set and bcache device.
If bcache is set to panic on error, this bogus failure can panic the
kernel too. Indeed a staled and dirty key may exist and we can just
report it as a bad key, it is unncessary to panic the whole kernel or
stop the cache set.

Therefore IMHO this is an important fix, we should have it in
Linux v4.21.

Thanks in advance.

Coly Li
---
Tang Junhui (1):
  bcache: treat stale && dirty keys as bad keys

 drivers/md/bcache/extents.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.16.4

