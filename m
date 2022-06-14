Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5489C43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 07:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353068AbiFNHsl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 03:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353011AbiFNHsl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 03:48:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4283EABD
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 00:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zOcqpRXe0nx5rzCZPtGxeu7EJMlaABiW69k8emIoofU=; b=SwY9N8t1IQ2ppYL+6+FJhsxaUx
        6hKfIfNy1fR70/kRM6nIeiXYoPCiz7UY+U1vJQTaTcPVIPo8Vel1lCu4yvd0Rxbe19mNoG4IoiPQG
        j4ghmYztyBzBYXx6DUuDVO7kogF1KL2lgY8r+p6WGVy0yN9ltgaZs/beivk/xni6qmmcCp0mKEE7v
        6RHbav/qR2I34hCP+XqfpbqffmeYn5dTnhfIObvM8EKmwekuKwBDbE7VZH29n4Y54gQELbgeGctnh
        We+MsITkG+SU+OyHCCyXKE6oR4OE4xVSyNEdN4+8gYRLK8Ug8ZwXTjL7ruvKhGNlolEdtwmxlX22d
        ntwBI1Bg==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o11Hr-0082gv-5I; Tue, 14 Jun 2022 07:48:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org
Subject: fix tag freeing use after free and debugfs name reuse
Date:   Tue, 14 Jun 2022 09:48:23 +0200
Message-Id: <20220614074827.458955-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

the first patch fixes a use after free, and the others deal with debugfs
name reuse that spews warnings and makes debugfs use impossible for
quickly reused gendisk instances.  Both of those are rooted in sloppy
life time rules for block device tear down.

Compared to the previous separate postings this adds a missing queue
quiesce and documents debugfs_mutex better.

Diffstat:
 block/blk-core.c        |   13 -------------
 block/blk-mq-debugfs.c  |   29 ++++++++++++++++++-----------
 block/blk-mq-debugfs.h  |   10 ----------
 block/blk-mq-sched.c    |   11 +++++++++++
 block/blk-rq-qos.c      |    2 --
 block/blk-rq-qos.h      |    7 ++++++-
 block/blk-sysfs.c       |   30 ++++++++++++++----------------
 block/genhd.c           |   42 ++++++++++++------------------------------
 include/linux/blkdev.h  |    8 ++++----
 kernel/trace/blktrace.c |    3 ---
 10 files changed, 65 insertions(+), 90 deletions(-)
