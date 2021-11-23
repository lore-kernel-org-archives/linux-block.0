Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B322C433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 18:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhKWS4Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhKWS4Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 13:56:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D27C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 10:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xeSC7Gu3KKvGAJw8lYE6mkM7awqhjiV0E8X55NZcraY=; b=OFK2yEXE/MId7/+u+faqf6NCr5
        aOxSqXjEPbsaJGLzRY0ThmK8DplIJM2HKbCz050WjyFm+yi+MTZTNVYg8zBWv09iARnFQ769JCK9y
        0v8De5vy+mM9huFZGnhNDR8llSHs1rOOoI5Wtty4wAXqppU1R+C8Fec5DPZd/D6e23+gKprV4rje2
        zlLW+bjzroWPNq0nm4aRYR5avjvvt/+UItyvH5WGzviw9Sr58BWgnhr+nBh5w0uxHc1h0aQGtO2Uq
        e4ZBXsquaacfw7Zh0oMb4oA/vd5z6zFMxDEt7xcNpB8ftvYPMeVP1eNiwaJvPKqyLegNd7FK2jKUA
        XkZ8yEyQ==;
Received: from [2001:4bb8:191:f9ce:a710:1fc3:2b4:5435] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpaun-00FzQr-CC; Tue, 23 Nov 2021 18:53:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: decruft blk.h
Date:   Tue, 23 Nov 2021 19:53:04 +0100
Message-Id: <20211123185312.1432157-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series cleans up blk.h by moving various bits that are not needed
out of it.

Diffstat:
 blk-cgroup.c     |    1 +
 blk-core.c       |    2 ++
 blk-flush.c      |    7 +++++++
 blk-ioc.c        |    1 +
 blk-merge.c      |    2 ++
 blk-mq-debugfs.c |    1 +
 blk-mq.c         |    1 +
 blk-sysfs.c      |    3 ++-
 blk-throttle.c   |    1 +
 blk.h            |   22 +---------------------
 elevator.c       |   10 +++++++---
 genhd.c          |    2 ++
 12 files changed, 28 insertions(+), 25 deletions(-)
