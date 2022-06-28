Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224F9C43334
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 17:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiF1RS4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 13:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiF1RSz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 13:18:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52E22F650
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=oICxSPwFcGNI7r7yBmUmphTJOlMdqgOaZ47GtsOVz3A=; b=rEkIpGeDi9xzHwK8wz0/conW+v
        gqq2QdaZPKE044gPWuNPH3/47JgAa+Y3KA5WX/vmhmY3HIe2jG+gLoecg9h0f21oP4Z84B4BhMHt8
        T5+/SKJllPN+wcUWjAL1Ow3rEpVAoAbZUoWpEu/WOaB8iwzC+b0eSSm7VN4aSBqKOsWtTJ9k0BAnO
        ygDNmT7M89W1IgXD4KK5VJgduT79x4hTVs02rI0ai0ztdjQgnt/rCzskpBHQ68KP4vQyVa9Cvfw44
        K6RS0y8jMBoHJfXH+pdaaEYyRFHvY0HnR5nPKHKTiuI8adpMg92QuFwOFV9w7pFtiX3YbfzOq2VO+
        1i+y2Z0A==;
Received: from [2001:4bb8:199:3788:e965:1541:b076:2977] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6ErV-007NS4-Oy; Tue, 28 Jun 2022 17:18:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: cleanup block layer sysfs handling v2
Date:   Tue, 28 Jun 2022 19:18:44 +0200
Message-Id: <20220628171850.1313069-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series cleans up various loose ends in the block layer sysfs handling.

Changes since v1:
 - trivial whitespace and spelling fixes

Diffstat:
 block/blk-mq-sysfs.c         |   45 +++++++++++++++++++++----------------------
 block/blk-mq.c               |    4 +--
 block/blk-mq.h               |    7 +++---
 block/blk-sysfs.c            |   36 ++++++++++------------------------
 block/blk.h                  |    2 +
 block/genhd.c                |    3 ++
 block/partitions/core.c      |    1 
 include/linux/blk-mq.h       |    1 
 include/linux/blktrace_api.h |   10 ---------
 kernel/trace/blktrace.c      |   11 ----------
 10 files changed, 44 insertions(+), 76 deletions(-)
