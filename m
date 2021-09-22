Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48BFC433F5
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 18:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09906120E
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 18:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhIVSf5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 14:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbhIVSf4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 14:35:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECC9C061574
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=4qmK5NhvGVzzMGRfpnQq6oGtQAHH/DFWMMTjbybRt/U=; b=Qqldk7sdvHBY22jrcIyHKJRXVO
        rLO9aECVrvCFmsuU+l9fCz2wUo/b7pgKdbugrksVqaR3fnZu0rwMa9gqBxJazhdGHmKR6DbPkCAR1
        XYCD4EYZ36/C29cB1GZHfZjytLlhdFw7zEtvsD0mxNkokiRUGrx3Ov3wZzjtR1X0oyHGhLfXAmSIO
        zvnvM5X0jR3GTmqCdPe5HI9JHIUGoKIYePS5HC4/neURVUNQfFgIGFV6AWGHL1APomqyDaxciy9hB
        9ZpRRJ+4GGKaXYPLluMHEMyt8VXYShbD7TJ+Sq/3793Fd9pIIAFr2jRFwvqdxCiiRq83i8vwNEsKs
        WZswe9NQ==;
Received: from [2001:4bb8:184:72db:3a8e:1992:6715:6960] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT73m-0052Ig-5b; Wed, 22 Sep 2021 18:33:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-block@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: fix a dax/block device attribute registration regression
Date:   Wed, 22 Sep 2021 20:33:28 +0200
Message-Id: <20210922183331.2455043-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Dan and Jens,

this series fixed a regression in how the dax/write_cache attribute of the
pmem devices was registere.  It does so by both fixing the API abuse in the
driver and (temporarily) the behavior change in the block layer that made
this API abuse not work anymore.

Diffstat:
 block/genhd.c         |    3 +-
 drivers/dax/super.c   |   64 --------------------------------------------------
 drivers/nvdimm/pmem.c |   48 ++++++++++++++++++++++++++++++++++---
 include/linux/dax.h   |    2 -
 4 files changed, 46 insertions(+), 71 deletions(-)
