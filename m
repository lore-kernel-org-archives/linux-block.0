Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F40C2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 14:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555532087D
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 14:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fi9V2yvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgJ2Ovu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 10:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgJ2Ovu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 10:51:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A31C0613CF
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2020 07:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=obxEWvN336dPaDHa6MJeNd09PKjNPNgrbqvoiKWiDiA=; b=Fi9V2yvmNP2/jBHyITiygG/kwD
        57me0XiysYc8ZpezPw1CLmKj4Z1ueRyNksn+KgNaEAw5e6ONQOhsk/mgT4F7VfsXF+h4F0m47fRfv
        6DIs6drTZa2PhXf/x40AXryrZwCdRGmITJsuynJiog/6UI5a1HPRSDaA27vQvXWcYK5+9wQVf2rYp
        hJIAiUZsTLbX1kEa7MQXp+fVrjCPKpCUD4knuzx+jNhUddVyRGSHU7nOI1rIoEOAm5POp1WihijOy
        xh+2yZuzH8G2X2QggGTIGLYRKEsC846Qeb/rpE6oQOHZcT3Xf7uCQIeMiTVL34bFPLVkmUEBHeqeX
        SUvWQzAQ==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kY9HF-0004jx-QR; Thu, 29 Oct 2020 14:51:46 +0000
Date:   Thu, 29 Oct 2020 15:49:34 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.10
Message-ID: <20201029144934.GA143642@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit f255c19b3ab46d3cad3b1b2e1036f4c926cb1d0c:

  blk-cgroup: Pre-allocate tree node on blkg_conf_prep (2020-10-26 07:57:47 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-29

for you to fetch changes up to 3c3751f2daf6675f6b5bee83b792354c272f5bd2:

  nvmet: fix a NULL pointer dereference when tracing the flush command (2020-10-27 10:02:50 +0100)

----------------------------------------------------------------
nvme updates for 5.10:

 - improve zone revalidation (Keith Busch)
 - gracefully handle zero length messages in nvme-rdma (zhenwei pi)
 - nvme-fc error handling fixes (James Smart)
 - nvmet tracing NULL pointer dereference fix (Chaitanya Kulkarni)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvmet: fix a NULL pointer dereference when tracing the flush command

James Smart (4):
      nvme-fc: track error_recovery while connecting
      nvme-fc: remove err_work work item
      nvme-fc: eliminate terminate_io use by nvme_fc_error_recovery
      nvme-fc: remove nvme_fc_terminate_io()

Keith Busch (1):
      nvme: ignore zone validate errors on subsequent scans

zhenwei pi (1):
      nvme-rdma: handle unexpected nvme completion data length

 drivers/nvme/host/core.c    |   2 +-
 drivers/nvme/host/fc.c      | 270 ++++++++++++++++++--------------------------
 drivers/nvme/host/rdma.c    |   8 ++
 drivers/nvme/target/core.c  |   4 +-
 drivers/nvme/target/trace.h |  21 ++--
 5 files changed, 127 insertions(+), 178 deletions(-)
