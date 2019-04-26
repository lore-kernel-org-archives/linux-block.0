Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9857C43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 14:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873F62077B
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 14:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FPGPS534"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfDZOsN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:48:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZOsN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 10:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V30cs9Eb8+M2FCisKv6i6XdeJiMBqjyIgNiNQk3fScU=; b=FPGPS534RZ/45PlCY3BPYpapVm
        vskWE7RtXukPmQitX0wxv1wxXeBhZzM/u30PSg7hFUY2N4oOLKG2ofwuJWxDuqLZuNvv7IWI2OIEX
        es7A9o1O1YvHMqfdVU04XSltzP4+7LHro+VvAE6DDoEmQVxqlBvoAuGTY0sX2j12Yh6Cn52BSgx50
        n11SaJDPR16VyfoRkHARhMi6neLEZLh1RPAu7MG9gfHn1EqaLccdy4UEOCnxXRSsC4+CjA5jTJaHQ
        hPlrKBX0ZmYHIq/Zy5KCnaZZA5H9tAvdqxBkpdnbyhGVkl0Gzpfh60I3GWBNKuyJwxXJtRX/H8r0p
        1K0Cpt7w==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hK295-000157-U5; Fri, 26 Apr 2019 14:48:12 +0000
Date:   Fri, 26 Apr 2019 16:47:44 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for 5.2
Message-ID: <20190426144744.GA28094@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 95f18c9d1310730d075499a75aaf13bcd60405a7:

  bcache: avoid potential memleak of list of journal_replay(s) in the CACHE_SYNC branch of run_cache_set (2019-04-24 10:56:29 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.2

for you to fetch changes up to 01fa017484ad98fccdeaab32db0077c574b6bd6f:

  nvme: set 0 capacity if namespace block size exceeds PAGE_SIZE (2019-04-25 16:51:42 +0200)

----------------------------------------------------------------
Enrico Weigelt, metux IT consult (1):
      nvmet: include <linux/scatterlist.h>

Max Gurtovoy (2):
      nvmet-rdma: remove p2p_client initialization from fast-path
      nvmet: rename nvme_completion instances from rsp to cqe

Ming Lei (1):
      nvme-loop: kill timeout handler

Minwoo Im (2):
      nvmet: return a specified error it subsys_alloc fails
      nvme-rdma: fix typo in struct comment

Sagi Grimberg (6):
      nvmet-file: clamp-down file namespace lba_shift
      nvmet-tcp: don't fail maxr2t greater than 1
      nvme-tcp: fix a NULL deref when an admin connect times out
      nvme-rdma: fix a NULL deref when an admin connect times out
      nvme-tcp: rename function to have nvme_tcp prefix
      nvme: set 0 capacity if namespace block size exceeds PAGE_SIZE

 drivers/nvme/host/core.c          |  7 ++++++-
 drivers/nvme/host/rdma.c          | 10 ++++++----
 drivers/nvme/host/tcp.c           | 18 ++++++++++--------
 drivers/nvme/target/Kconfig       |  1 +
 drivers/nvme/target/configfs.c    |  4 ++--
 drivers/nvme/target/core.c        | 29 +++++++++++++++--------------
 drivers/nvme/target/discovery.c   |  4 ++--
 drivers/nvme/target/fabrics-cmd.c | 16 ++++++++--------
 drivers/nvme/target/fc.c          |  2 +-
 drivers/nvme/target/io-cmd-file.c |  7 ++++++-
 drivers/nvme/target/loop.c        | 22 +++-------------------
 drivers/nvme/target/nvmet.h       |  4 ++--
 drivers/nvme/target/rdma.c        | 21 ++++++++++-----------
 drivers/nvme/target/tcp.c         | 14 ++++----------
 include/linux/nvme-rdma.h         |  2 +-
 15 files changed, 77 insertions(+), 84 deletions(-)
