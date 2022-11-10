Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4116C433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Nov 2022 10:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiKJKB1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 05:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKJKB1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 05:01:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27132DE
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 02:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=SYPASXJ2jdNa1i8h75ceFWByQEOrF1l7/PE3Mvcjeb0=; b=zZlHLh2q/wx5j5By2Rr9wgTpAF
        vL0BdR0zkSWX7HxIWWiyz+Z8ppDJj3RmrfTnAEQBz6MK+UsrPbdMYBzxkWkRkMMjDSt5meKlY6jBD
        wZV4fJVViaZVwhXrhkH+EmMcy+bE2d4V4nEYG3FznAgu0Rf+N8cqo00e4CmjRv9IyxbDEESzZy2+8
        dWRMqQBNffYHjI3I5IWyKjeJpdsQbfUvpEvQ/0mZB2RwazKFuPg65yvhFf8Ek9qYqcqe8DphoCOzp
        5/0v03aYA3qoJi0IqQg9+xaUWgj8fXtqWErtcPgpwr2zKFnA2hrz7du3yqJY5egvp9oDbqHZfUoS+
        jwQT9DBQ==;
Received: from [89.144.222.196] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ot4N3-004xQs-TQ; Thu, 10 Nov 2022 10:01:18 +0000
Date:   Thu, 10 Nov 2022 11:01:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvmes fixes for Linux 6.1
Message-ID: <Y2zL45ll7KIIc0zF@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit f829230dd51974c1f4478900ed30bb77ba530b40:

  block: sed-opal: kmalloc the cmd/resp buffers (2022-11-08 07:14:35 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.1-2022-11-10

for you to fetch changes up to e65fdf530f55c5e387db14470a59a399faa29613:

  nvmet: fix a memory leak (2022-11-09 14:29:13 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.1

 - quiet user passthrough command errors (Keith Busch)
 - fix memory leak in nvmet_subsys_attr_model_store_locked
 - fix a memory leak in nvmet-auth (Sagi Grimberg)

----------------------------------------------------------------
Aleksandr Miloserdov (1):
      nvmet: fix memory leak in nvmet_subsys_attr_model_store_locked

Keith Busch (1):
      nvme: quiet user passthrough command errors

Sagi Grimberg (1):
      nvmet: fix a memory leak

 drivers/nvme/host/core.c       | 3 +--
 drivers/nvme/host/pci.c        | 2 --
 drivers/nvme/target/configfs.c | 8 ++++++--
 3 files changed, 7 insertions(+), 6 deletions(-)
