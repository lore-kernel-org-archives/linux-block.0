Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73B2C4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 15:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiKBPUH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 11:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiKBPTi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 11:19:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266DA15A31
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 08:19:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so1509680wmg.2
        for <linux-block@vger.kernel.org>; Wed, 02 Nov 2022 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j3DEAb2BGJ7w4Vu/FAQz4pEj3hdlKJIAqyvp4mjUm2s=;
        b=LTmPIFSJMQ+z2ClHJBpNrvgkC0CJ5rowZHkcjw1xq1SWKXwbvvnoDLQA++jeyGybGR
         3Y8SWad6ZktJkugnXllWnWdQ0tkqA0HhI0kWpj678fh4MAf6D9gR1dhux68DuwOR7wSG
         I6AH8n2ybCMUZyl6aaJqfX766uxze2Rxwp54m0XJQ4rtCQ1o+tO59SFjnx57xpZ44FbR
         KA64a295g1lLgrqDXIUPcI90h6haBvAmh/09AQ6UZWNGdUfML4vd6hU/K/R6B7WqqeDG
         KkiNz+8737dZSQnNMPZwQPnBiyB4vNfirfw3pjIyD50PFG5FsFhK4wA8u5yYXwdSTfFm
         PxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3DEAb2BGJ7w4Vu/FAQz4pEj3hdlKJIAqyvp4mjUm2s=;
        b=DR3TC7ch0CZ/+p/splzRpwFhEIojnPCFXCY0GAOg1mHnwZvTsHGgwl2HNxNXZ6t2KH
         iSmdO0RqONeSJPIhmKNaKsRJo9G+b4BCkjOjTPBCAITLk7tLYvMCW/WUNMO2G7+DBEqx
         fWz+eUeX1uJXZcMJO+lNfvnHiZBkfMymnD+y0SHPWaSFOHDoDzRNdmJGEJglXps8R1Vv
         xagJHCOheXSI7ZK4YkjTGZYFFziROHlrFQvxnnCYvewqj2RaCgpCLr6QrlI4xYHbojk2
         kBR5F1BcbQVrr6TAljxV9XZ9PlxQYlpGFEAtnL3x6qQgbMhc4uxaY3jDFLEYjW9zx11O
         FzuA==
X-Gm-Message-State: ACrzQf0+Tl3u87Y7U2DYv5kJto0NM+ADVWKO3RfoJ5wPwLlL98+4NpDO
        a+MOS0eF5GEX3ezL27iNxpY=
X-Google-Smtp-Source: AMsMyM6+4z5/YLeaYzDEhw5jMJR3DOCo4yf2jDgPTfa1hNuehTlnDxhQq3QF7sa24eQd1bgf+gf8hg==
X-Received: by 2002:a05:600c:6010:b0:3cf:8762:3bf7 with SMTP id az16-20020a05600c601000b003cf87623bf7mr2383635wmb.13.1667402374645;
        Wed, 02 Nov 2022 08:19:34 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.186.241])
        by smtp.gmail.com with ESMTPSA id a14-20020adff7ce000000b0022e66749437sm13043232wrq.93.2022.11.02.08.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:19:34 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH for-next v4 0/6] implement pcpu bio caching for IRQ I/O
Date:   Wed,  2 Nov 2022 15:18:18 +0000
Message-Id: <cover.1667384020.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add bio pcpu caching for IRQ-driven I/O. We extend the currently limited to
iopoll REQ_ALLOC_CACHE infra. Benchmarked with t/io_uring and an Optane SSD:
2.22 -> 2.32 MIOPS for qd32 (+4.5%) and 2.60 vs 2.82 for qd128 (+8.4%).

Works best with per-cpu queues, otherwise there might be some effects at
play, e.g. bios allocated by one cpu but freed by another, but the worst
case (always goes to mempool) doesn't show any performance degradation.

Currently, it's only enabled for previous REQ_ALLOC_CACHE users but will
be turned on system-wide later.

v2: fix botched splicing threshold checks
v3: remove merged patch limit scope of flags var in bio_put_percpu_cache
v4: correct outdated comment
    fix in-irq put -> splice modifying the non-irq safe cache list
    fix alloc null dereference

Pavel Begunkov (6):
  mempool: introduce mempool_is_saturated
  bio: don't rob starving biosets of bios
  bio: split pcpu cache part of bio_put into a helper
  bio: add pcpu caching for non-polling bio_put
  bio: shrink max number of pcpu cached bios
  io_uring/rw: enable bio caches for IRQ rw

 block/bio.c             | 98 +++++++++++++++++++++++++++++++----------
 include/linux/mempool.h |  5 +++
 io_uring/rw.c           |  3 +-
 3 files changed, 82 insertions(+), 24 deletions(-)

-- 
2.38.0

