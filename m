Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C02C43219
	for <linux-block@archiver.kernel.org>; Mon, 30 May 2022 14:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbiE3OWX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 May 2022 10:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241374AbiE3ORc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 May 2022 10:17:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7688FF81
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 06:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=3oaQ97hSRcPBX4I2W067rJtsaAaQB4H5fudDoWoYUVA=; b=PzcpSGMp75p4sQArvPvq2gLOty
        TVosH5MT5EcfyUgnc4RGEkH2YKnz8tFilOBSHSaOR21FECrAUQ79OgVfrbpAnJX9pppwjeJc33ZLU
        xzBHpF91IyCDivvKqGWlXCrcdGIoFlZpwRW/KfuV0o23I1hrLWG04GdJ2B5K+2bH5FKHqd7T1Mo2B
        qnpyo/0lemQk4T2+WCGQ8QNG94Rf5m50xoIE37oZerUgJ0Wz3l0M9dDVoPeAFgmagoTmAHFwMWtgM
        ndU1RMj8AV+JRqAUHHM7RFFtHA+E+Y6L4sXd+qlDsuKOPsAmze4J5qfGqwvk76g52CzKWnkKGh92K
        APybp+xQ==;
Received: from [2001:4bb8:185:a81e:fda9:da32:3b0c:8358] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvfiQ-006rMI-4M; Mon, 30 May 2022 13:45:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org
Subject: fix debugfs name reuse for remove disks
Date:   Mon, 30 May 2022 15:45:45 +0200
Message-Id: <20220530134548.3108185-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series aims to primarily fix the debugfs name reuse when a disk
is removed while there are outstanding references to it and then a
new one with the same name is created.

Diffstat:
 block/blk-mq-debugfs.c  |   23 ++++++++++++-----------
 block/blk-mq-debugfs.h  |   10 ----------
 block/blk-mq-sched.c    |   11 +++++++++++
 block/blk-rq-qos.c      |    2 --
 block/blk-rq-qos.h      |    7 ++++++-
 block/blk-sysfs.c       |   30 ++++++++++++++----------------
 block/genhd.c           |    3 +--
 include/linux/blkdev.h  |    3 ---
 kernel/trace/blktrace.c |    3 ---
 9 files changed, 44 insertions(+), 48 deletions(-)
