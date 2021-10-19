Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCFDC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3734660FDA
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbhJSNmD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 09:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhJSNmC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 09:42:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E99C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 06:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=BOtckbbTD/wmgjgDl96XCMrQ9ag9uZu3q1KiyU8eJbA=; b=mE4JJ8ROqU2izklVgHbBHAIFgQ
        2rblx1k2j1OjLJnFOyQKb7AxmjrRoJ5IIbTEgYVMkk19c8YTu0nkSxdfRcTAUNRJ5j5ocQCym4aw5
        C+l53UUT4oHuyybjG8Z4ZijaB9YLyFzsTeIBjC/WDhMHIdf+dlOcI5Ymcjqcmy3u9NIqjz313wb/+
        iJP99rdye5jPt6FsUgYXY+OHrA06SOYFKPXFmI/iG6IjW0iQbm5YGmh/OaiCTTzN5XtSgXjIPUtaw
        7P7hBgx0W4qe9UDuYJlhrYNOY849EaUD9kSPyPwnMQZye3RENA6e5//rFcKNVxUr8mOO5RRUh9UwU
        yFvbL3rQ==;
Received: from [2001:4bb8:180:8777:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcpLI-001Ro9-4b; Tue, 19 Oct 2021 13:39:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: remove RQF_ELVPRIV
Date:   Tue, 19 Oct 2021 15:39:42 +0200
Message-Id: <20211019133944.2500822-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series removes the RQF_ELVPRIV flag which isn't really needed
anymore.

Diffstat;
 block/blk-mq-debugfs.c |    1 -
 block/blk-mq-sched.h   |    5 ++---
 block/blk-mq.c         |    3 +--
 include/linux/blk-mq.h |    2 --
 4 files changed, 3 insertions(+), 8 deletions(-)
