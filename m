Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E0BEB64DA
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 09:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjGTJsg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 05:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjGTJsK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 05:48:10 -0400
Received: from out-14.mta0.migadu.com (out-14.mta0.migadu.com [91.218.175.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADAE26BF
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 02:47:12 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689846430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IWsEdoCST2RLmfVQaJhpZTZMKhLTaQ2FtZavGotVcwk=;
        b=ArIuxhs1r2s5cqxco09D6B5rx6QvqHCe/RVtqG9xHgrhTTe3P6anSMkPsaV7TAdgKySdlp
        wWKwzvzJ+s7pDJXcQzBeMdD0NKeQzvAnDXznzmeB3hiZ83Rv9teoKiC3fOZZWs4zp5LVrX
        MA4XhAe/raHLdU4dPf7IHKLJ4hcdw4w=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, osandov@fb.com, ming.lei@redhat.com,
        kbusch@kernel.org, krisman@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 0/6] sbitmap: fix offset hint wrap and some optimizations
Date:   Thu, 20 Jul 2023 17:45:49 +0800
Message-ID: <20230720094555.1397621-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Hello,

This series aim to fix and simplify the offset hint wrap logic, also
include some minor optimizations.

patch 01,02 fix offset hint wrap logic in strict round-robin mode.

patch 03,04 simplify the sbitmap_find_bit() code by removing wrap logic.

patch 05,06 are two minor optimizations.

Thanks!

Chengming Zhou (6):
  sbitmap: fix hint wrap in the failure case
  sbitmap: fix round-robin non-wrap find with hint > 0
  sbitmap: don't loop twice in find_next_zero_bit()
  sbitmap: remove offset wrap logic when finding bit in word
  sbitmap: wake_index doesn't need to be atomic_t
  sbitmap: check ws_active before check waitqueues

 include/linux/sbitmap.h |  2 +-
 lib/sbitmap.c           | 66 ++++++++++++++++++++---------------------
 2 files changed, 33 insertions(+), 35 deletions(-)

-- 
2.41.0

