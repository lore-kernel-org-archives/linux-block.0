Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E4AEB64D9
	for <linux-block@archiver.kernel.org>; Fri,  7 Jul 2023 09:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjGGJmy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jul 2023 05:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjGGJmw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jul 2023 05:42:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BB62107
        for <linux-block@vger.kernel.org>; Fri,  7 Jul 2023 02:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=yP9kqclhfC+kpttRlr/pMkXgylBpyDtbwweHLpMy8uo=; b=aOr5VpTkaRG6NQCeHWsu4t83D7
        7uvto/52u66C6jS2fGE7YhPFmr/nEVTSD7IT3A40bP00oQMRcGwGeVKgbRWH5wvsppyGwFw3K9Flq
        RwxLCMhxO/BJm7s4HCFDwYEveI7ggzHh9HY7G911JJRlJSnnEBXmM7fCIvmOx0M/okLQocdeeNx8j
        FcvXeDjtA9tGVlxvYPKg8gek3ogAYWMlLC7e0A1ZcxNi5/XXEm2wcJFN99BlZJgeuRbi/dWxpGb0C
        Rnr1iCEIzJeFHCZe7fox+WLqFr+OkhO3cPcEf6KJteKJT09aqfPne2NP4qxR3lVmDS2/KaeMDMc7n
        Ap6FQCTA==;
Received: from [89.144.223.112] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHhzH-0049IW-1Z;
        Fri, 07 Jul 2023 09:42:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: don't allow enabling a write back cache on devices that don't support it
Date:   Fri,  7 Jul 2023 11:42:37 +0200
Message-Id: <20230707094239.107968-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series fixes a case where a user could enable a write back cache
on a device (driver) that doesn't support it all, potentially leading
to flush requests being sent to a driver that doesn't know whast to
do with them.

diffstat:
 block/blk-settings.c   |    7 +++++--
 block/blk-sysfs.c      |   21 ++++++++-------------
 include/linux/blkdev.h |    1 +
 3 files changed, 14 insertions(+), 15 deletions(-)
