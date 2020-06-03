Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F39C433E2
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 14:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3D320738
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 14:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgFCOuJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgFCOuE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jun 2020 10:50:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5C8C08C5C0;
        Wed,  3 Jun 2020 07:50:04 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1jgUiE-0001uB-Jj; Wed, 03 Jun 2020 16:49:50 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/6] seqlock: seqcount_t call sites bugfixes
Date:   Wed,  3 Jun 2020 16:49:43 +0200
Message-Id: <20200603144949.1122421-1-a.darwish@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Since patch #7 and #8 from the series:

   [PATCH v1 00/25] seqlock: Extend seqcount API with associated locks
   https://lore.kernel.org/lkml/20200519214547.352050-1-a.darwish@linutronix.de

are now pending on the lockdep/x86 IRQ state tracking patch series:

   [PATCH 00/14] x86/entry: disallow #DB more and x86/entry lockdep/nmi
   https://lkml.kernel.org/r/20200529212728.795169701@infradead.org

   [PATCH v3 0/5] lockdep: Change IRQ state tracking to use per-cpu variables
   https://lkml.kernel.org/r/20200529213550.683440625@infradead.org

This is a repost only of the seqcount_t call sites bugfixes that were on
top of the seqlock patch series.

These fixes are independent, and can thus be merged on their own. I'm
reposting them now so they can at least hit -rc2 or -rc3.

Changelog-v2:

  - patch #1: Add a missing up_read() on netdev_get_name() error path
              exit. Thanks to Dan/kbuild-bot report.

  - patch #4: new patch, invalid preemptible context found by the new
              lockdep checks added in the seqlock series + kbuild-bot.

Thanks,

8<--------------

Ahmed S. Darwish (6):
  net: core: device_rename: Use rwsem instead of a seqcount
  net: phy: fixed_phy: Remove unused seqcount
  u64_stats: Document writer non-preemptibility requirement
  net: mdiobus: Disable preemption upon u64_stats update
  block: nr_sects_write(): Disable preemption on seqcount write
  dma-buf: Remove custom seqcount lockdep class key

 block/blk.h                    |  2 ++
 drivers/dma-buf/dma-resv.c     |  9 +------
 drivers/net/phy/fixed_phy.c    | 26 ++++++++------------
 drivers/net/phy/mdio_bus.c     |  2 ++
 include/linux/dma-resv.h       |  2 --
 include/linux/u64_stats_sync.h | 43 ++++++++++++++++++----------------
 net/core/dev.c                 | 40 ++++++++++++++-----------------
 7 files changed, 56 insertions(+), 68 deletions(-)

base-commit: 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162
--
2.20.1
