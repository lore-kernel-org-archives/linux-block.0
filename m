Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39043C433FE
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 07:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D1361355
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 07:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhJSHjD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 03:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhJSHjC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 03:39:02 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4014C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 00:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tggAfzLakoiLo+c6QdPmG/HwrQInFVNf4bngospVsnQ=; b=Dju723BnHucsP8eMAncoDbijpC
        Df1SeTL8pKfm5y+RlERZPwuBoylwK45Ewjf895e1ewk7gyrZmRg3yMA4paaHYLJvzTs2ibUbinmsl
        SzTVAHwjOzjOfDvEO+SEkfPQ+hT8EflFLKx4kPJW08YAtP+2CcLskzYeBP168sNnhI2ueIoTVCDTZ
        KwjNc9ykhzKdMqs2ueaGlv8HebAoGulYJBBNUZhaMMysGVHXV+BRFXV1e2rfUwTywb8diVaObqTLd
        foLYWZnZTLeDIjhCYq5wt7h2/vBHfQ801QtOTgwwClgtYH5CansiLqPIGuXXkttYmInCHESzIGRTE
        X52/d2GA==;
Received: from 089144192247.atnat0001.highway.a1.net ([89.144.192.247] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcjfx-000QVy-Ta; Tue, 19 Oct 2021 07:36:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org
Subject: fix a pmem regression due to drain the block queue in del_gendisk
Date:   Tue, 19 Oct 2021 09:36:39 +0200
Message-Id: <20211019073641.2323410-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Dan,

this series fixes my recently introduced regression in the pmem driver by
removing the usage of q_usage_count as the external pgmap refcount in the
pmem driver and then removes the now unused external refcount
infrastructure.

Diffstat:
 drivers/nvdimm/pmem.c             |   33 +--------------------
 include/linux/memremap.h          |   18 +----------
 mm/memremap.c                     |   59 +++++++-------------------------------
 tools/testing/nvdimm/test/iomap.c |   43 +++++++--------------------
 4 files changed, 29 insertions(+), 124 deletions(-)
