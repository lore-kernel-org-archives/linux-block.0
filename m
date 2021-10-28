Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4492C433EF
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 14:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AAF161108
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 14:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhJ1O1r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 10:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhJ1O1q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 10:27:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94F4C061570
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 07:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=eZtWEg8RFhEVXL60WgstW7U2u2C0E8QASWxDHVHvq6A=; b=ipvx/kZ/sgsS7SQWT4j9zDI8MR
        pBNUJXP1FG1NNyrlIEITpLkESIs/n6kw4lwf2CxfTixVkHFqluskKD+j0G0mqPkxA7C66vwdQQ+fg
        dwGuX3TNrygXnMoz+EG27R9IIgnUZ/aqpFGgPR+RZ9SsMV/6sVlbnhn9kxJneRgYXqEcCgPMDz9BF
        hnvZGZo/j3DqzZbSFfw0lD2QHbvQybt8tJZ4xa2HC1KSGMhX2Y+ofYSOhcdKD0tB0+Aja2OMQi2jj
        ml4mZ303WdwMKMWOpE0ThnUNUrkiWf4x1yMe55Z3rNso44iTbhAB+QONLI5qGim6dIiM1bLyQMYbA
        uC7um1Bw==;
Received: from [2001:4bb8:199:7b1d:487c:3190:e387:3394] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mg6LF-0088Xh-2l; Thu, 28 Oct 2021 14:25:17 +0000
Date:   Thu, 28 Oct 2021 16:25:13 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.15
Message-ID: <YXqyyRRUV4GJis4I@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 9fbfabfda25d8774c5a08634fdd2da000a924890:

  block: fix incorrect references to disk objects (2021-10-18 11:20:38 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.15-2021-10-28

for you to fetch changes up to 86aeda32b887cdaeb0f4b7bfc9971e36377181c7:

  nvmet-tcp: fix header digest verification (2021-10-27 09:20:50 +0200)

----------------------------------------------------------------
nvme fixe for Linux 5.15

 - fix nvmet-tcp header digest verification (Amit Engel)
 - fix a memory leak in nvmet-tcp when releasing a queue
   (Maurizio Lombardi)
 - fix nvme-tcp H2CData PDU send accounting again (Sagi Grimberg)
 - fix digest pointer calculation in nvme-tcp and nvmet-tcp
   (Varun Prakash)
 - fix possible nvme-tcp req->offset corruption (Varun Prakash)

----------------------------------------------------------------
Amit Engel (1):
      nvmet-tcp: fix header digest verification

Maurizio Lombardi (1):
      nvmet-tcp: fix a memory leak when releasing a queue

Sagi Grimberg (1):
      nvme-tcp: fix H2CData PDU send accounting (again)

Varun Prakash (3):
      nvme-tcp: fix possible req->offset corruption
      nvme-tcp: fix data digest pointer calculation
      nvmet-tcp: fix data digest pointer calculation

 drivers/nvme/host/tcp.c   | 9 ++++++---
 drivers/nvme/target/tcp.c | 7 +++++--
 2 files changed, 11 insertions(+), 5 deletions(-)
