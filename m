Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE15C6FD1D
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 15:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbjDDPFt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjDDPFs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:05:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A259C2708
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=j+vrRarzpa658udQEhVhNLpPjH13QSyRrx5Il2k/TzQ=; b=DRtNCug0WCbVCUeZ8qx+HIZGs3
        X/MsPAnRJkR62bXnQe7e0yFgEH5lrcCeLm9ffH8sqZlX6fnBAWenEfRS1I3k7lNv03AVAe7e8Uxx1
        Fcp3KH3utYS7Jd29GdAC9wpctFDPw5VaxUAiVe7YGIW/ikXJO4ZfvERgJtsFWtkaj5FnyDOMMs5eu
        3YGq0a3w3gay2RX3Hquk8Z14WdHzfLQaXvQnc0rjHvwDVZ+ETupAUHIYpFNz49ruKym/umXyQeyfH
        1Kts5m2lKCsKPKjHuTI6g7hk/teHzCPkFLGvgi2vjcy6BhlqxPhYG30JhORJdSFQLjvjV/SYKc/GR
        g4BQtPwQ==;
Received: from [2001:4bb8:191:a744:23e5:e88f:5622:7c79] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiE7-001vpG-1H;
        Tue, 04 Apr 2023 15:05:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: zram I/O path cleanups and fixups
Date:   Tue,  4 Apr 2023 17:05:20 +0200
Message-Id: <20230404150536.2142108-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series cleans up the zram I/O path, and fixes the handling of
synchronous I/O to the underlying device in the writeback_store
function or for > 4K PAGE_SIZE systems.

The fixes are at the end, as I could not fully reason about them being
safe before untangling the callchain.

This survives xfstests on two zram devices on x86, but I don't actually
have a large PAGE_SIZE system to test that path on.

Diffstat:
 zram_drv.c |  375 ++++++++++++++++++++++---------------------------------------
 zram_drv.h |    1 
 2 files changed, 136 insertions(+), 240 deletions(-)
