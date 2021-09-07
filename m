Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80469C433F5
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E5561101
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhIGOLs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 10:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhIGOLs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 10:11:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FBAC061575
        for <linux-block@vger.kernel.org>; Tue,  7 Sep 2021 07:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=joojLOVghtAY4SpDPhudBjFXh84mnGtADh74ijXfAho=; b=o9uh0TquyjFTy1lV/gGcfDlOEc
        FASgWAq1SQhjDtRnH59ar1FyQRj6n+gAaGdB/j/9MREa5OeUdWbEraXmXnlYxIsBLRYneLPS0I9W4
        LkYqjRmKgcapGGwG7utJsm8+Yw8vyFP0wvuCuOtIbMtjMpEFWK+HYffvKw4r94OADZRZ1zqx4vXfQ
        8NqElyVc0wwSVMsMHe4BaYVEfrk2yIsMjTaXU7dYRZq8/ZV+3ZwUAfFkVMLzV/iwgu/3jWCSghY/Q
        bI5FfSTcKKBvGlWwsWqtqtbUvtk1YJBsVDG9R6R3kffE/k9cUYA5fzyrenFtpVSxr73ZqO6qpCRCy
        quxocanw==;
Received: from 089144201074.atnat0010.highway.a1.net ([89.144.201.74] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNbnZ-007vh6-R0; Tue, 07 Sep 2021 14:10:10 +0000
Date:   Tue, 7 Sep 2021 16:10:03 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.15
Message-ID: <YTdyu/Y/d9woHINJ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 1c500ad706383f1a6609e63d0b5d1723fd84dab9:

  loop: reduce the loop_ctl_mutex scope (2021-09-03 22:14:40 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.15-2021-09-07

for you to fetch changes up to aff959c2840858d55d9ee155d555b3aa7e068b32:

  nvme: update MAINTAINERS email address (2021-09-06 10:08:09 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.15

 - fix nvmet command set reporting for passthrough controllers
   (Adam Manzanares)
 - updated
 - update a MAINTAINERS email address (Chaitanya Kulkarni)
 - set QUEUE_FLAG_NOWAIT for nvme-multipth (me)
 - handle errors from add_disk() (Luis Chamberlain)
 - update the keep alive interval when kato is modified (Tatsuya Sasaki)
 - fix a buffer overrun in nvmet_subsys_attr_serial (Hannes Reinecke)
 - do not reset transport on data digest errors in nvme-tcp (Daniel Wagner)
 - only call synchronize_srcu when clearing current path (Daniel Wagner)
 - revalidate paths during rescan (Hannes Reinecke)

----------------------------------------------------------------
Adam Manzanares (2):
      nvme: move nvme_multi_css into nvme.h
      nvmet: looks at the passthrough controller when initializing CAP

Chaitanya Kulkarni (1):
      nvme: update MAINTAINERS email address

Christoph Hellwig (2):
      nvme-multipath: set QUEUE_FLAG_NOWAIT
      nvmet: return bool from nvmet_passthru_ctrl and nvmet_is_passthru_req

Daniel Wagner (2):
      nvme-tcp: Do not reset transport on data digest errors
      nvme: only call synchronize_srcu when clearing current path

Hannes Reinecke (2):
      nvme-multipath: revalidate paths during rescan
      nvmet: fixup buffer overrun in nvmet_subsys_attr_serial()

Luis Chamberlain (1):
      nvme: add error handling support for add_disk()

Tatsuya Sasaki (1):
      nvme: update keep alive interval when kato is modified

 MAINTAINERS                     |  2 +-
 drivers/nvme/host/core.c        | 68 ++++++++++++++++++++++++++++++++++-------
 drivers/nvme/host/multipath.c   | 19 +++++++++++-
 drivers/nvme/host/nvme.h        | 10 ++++++
 drivers/nvme/host/tcp.c         | 22 ++++++++++---
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/configfs.c  |  5 +--
 drivers/nvme/target/core.c      | 10 +++---
 drivers/nvme/target/nvmet.h     | 11 ++++---
 drivers/nvme/target/passthru.c  | 14 +++++++--
 10 files changed, 132 insertions(+), 31 deletions(-)
