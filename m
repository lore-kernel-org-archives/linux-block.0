Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA9EC64E7C
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 13:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88241221FC
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 13:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgLBN0e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 08:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbgLBN0d (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 08:26:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74829C0613D4
        for <linux-block@vger.kernel.org>; Wed,  2 Dec 2020 05:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=378gHyUbIIMFXdlPArT55nkvMIfDLv+6cJJJndKtSj4=; b=SswOIraFdp5OPDg+HmFlNUAzFW
        3K05mOGYcyJxWaL9yCnsOQmPcwPELt/1IuDpQLMEImzZAKskR8/Dm9A6rG0wATZ0YM0ghgN/W2165
        FPoTRprmhFTEFuDmMqYI6e1e5feNb10TiTgEsCxTSy9g+OK2LPjnUZySBfze493axvqgemfqpMPqZ
        e3RoG3/JMY4Enttutau4zN2fQAUI0/lknLpTeG+eURr3Oh2YNtBKu9HK6O9OL8iefgB+hpGDHLHRi
        MuZomdwPrvCOZwZ56+snH2mqapZ2FHRkzQWo/1dC+BXoYppCtIDMjUQEXxHmKQzztxHeWpSB+krnM
        U8aSk9Uw==;
Received: from [2001:4bb8:184:6389:740f:6f27:77ba:2250] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkS8k-0000BA-JF; Wed, 02 Dec 2020 13:25:50 +0000
Date:   Wed, 2 Dec 2020 14:25:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] first round of nvme updates for 5.11
Message-ID: <20201202132549.GA2060796@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 48332ff295878b3f4268782f25894dfa44b1f6c1:

  Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.11/drivers (2020-11-30 15:52:19 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.11-20201202

for you to fetch changes up to 2f4c9ba23b887e7a69a474e9d53f38b5833a2119:

  nvme: export zoned namespaces without Zone Append support read-only (2020-12-01 20:36:38 +0100)

----------------------------------------------------------------
nvme updates for 5.11

 - nvmet passthrough improvements (Chaitanya Kulkarni)
 - fcloop error injection support (James Smart)
 - read-only support for zoned namespaces without Zone Append
   (Javier González)
 - improve some error message (Minwoo Im)
 - reject I/O to offline fabrics namespaces (Victor Gladkov)
 - PCI queue allocation cleanups (Niklas Schnelle)
 - remove an unused allocation in nvmet (Amit Engel)
 - a Kconfig spelling fix (Colin Ian King)
 - nvme_req_qid simplication (Baolin Wang)

----------------------------------------------------------------
Amit (1):
      nvmet: remove unused ctrl->cqs

Baolin Wang (1):
      nvme: simplify nvme_req_qid()

Chaitanya Kulkarni (9):
      nvme: centralize setting the timeout in nvme_alloc_request
      nvme: use consistent macro name for timeout
      nvmet: add passthru admin timeout value attr
      nvmet: add passthru io timeout value attr
      block: move blk_rq_bio_prep() to linux/blk-mq.h
      nvme: split nvme_alloc_request()
      nvmet: remove op_flags for passthru commands
      nvmet: use blk_rq_bio_prep instead of blk_rq_append_bio
      nvmet: use inline bio for passthru fast path

Colin Ian King (1):
      nvmet: fix a spelling mistake "incuding" -> "including" in Kconfig

James Smart (1):
      nvme-fcloop: add sysfs attribute to inject command drop

Javier González (4):
      nvme: remove unnecessary return values
      nvme: rename controller base dev_t char device
      nvme: rename bdev operations
      nvme: export zoned namespaces without Zone Append support read-only

Max Gurtovoy (1):
      nvmet: make sure discovery change log event is protected

Minwoo Im (2):
      nvme: improve an error message on Identify failure
      nvme: print a warning for when listing active namespaces fails

Niklas Schnelle (2):
      nvme-pci: drop min() from nr_io_queues assignment
      nvme-pci: don't allocate unused I/O queues

Victor Gladkov (1):
      nvme-fabrics: reject I/O to offline device

 block/blk.h                     |  12 ----
 drivers/nvme/host/core.c        | 150 ++++++++++++++++++++++++++++++----------
 drivers/nvme/host/fabrics.c     |  25 ++++++-
 drivers/nvme/host/fabrics.h     |   5 ++
 drivers/nvme/host/fc.c          |   2 +-
 drivers/nvme/host/lightnvm.c    |   8 +--
 drivers/nvme/host/multipath.c   |   2 +
 drivers/nvme/host/nvme.h        |  11 ++-
 drivers/nvme/host/pci.c         |  27 +++-----
 drivers/nvme/host/rdma.c        |   2 +-
 drivers/nvme/host/tcp.c         |   2 +-
 drivers/nvme/host/zns.c         |  13 ++--
 drivers/nvme/target/Kconfig     |   2 +-
 drivers/nvme/target/configfs.c  |  40 +++++++++++
 drivers/nvme/target/core.c      |  15 +---
 drivers/nvme/target/discovery.c |   1 +
 drivers/nvme/target/fcloop.c    |  81 +++++++++++++++++++++-
 drivers/nvme/target/loop.c      |   2 +-
 drivers/nvme/target/nvmet.h     |   4 +-
 drivers/nvme/target/passthru.c  |  37 +++++-----
 include/linux/blk-mq.h          |  12 ++++
 21 files changed, 336 insertions(+), 117 deletions(-)
