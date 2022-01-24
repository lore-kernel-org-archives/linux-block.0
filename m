Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD58C433F5
	for <linux-block@archiver.kernel.org>; Mon, 24 Jan 2022 09:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiAXJjR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jan 2022 04:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiAXJjR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jan 2022 04:39:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DA5C06173B
        for <linux-block@vger.kernel.org>; Mon, 24 Jan 2022 01:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=IbOZmd7+FmKYxFAsqw9x47JNrhdtgBPglAdJfJxjbtI=; b=vi93eNkIsfg3LKxSj/PvO4Wqo5
        vIiDpfnxpM3ys8Q3H2IpTGsWkYXrHqmmE4VVdDKPSSe7sBB4Eq8XNfjKRoG6JP0Cwzg7j6oyudJJO
        sCAkV5h4ELGVRhr/GhPgUcEcXLTZQeB0KW02dGj3b2zqJC4q9NQ+R+uZ64RieIX0t/cz4pp6o/zZ/
        g1ywrvPdMm1a++l/u7veJ6xGTYkctP41SlEH62nuCO0Sy48uMrpDnc5ERFEhZONYigR31roJJMxRv
        fiWPVGwWP7z5aqYPyo1A2HCBoRz+aksyC6PUsq2hoCg5PjFEvDkbWykveIQ0l91REoc+fw5rRq5Oc
        56rTk5cQ==;
Received: from [2001:4bb8:184:72a4:a337:a75f:a24e:7e39] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBvoi-002pVI-Dd; Mon, 24 Jan 2022 09:39:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: remove <linux/genhd.h>
Date:   Mon, 24 Jan 2022 10:39:10 +0100
Message-Id: <20220124093913.742411-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this patchset removes the <linux/genhd.h> header, which has no clearly
split responsibilities from <linux/blkdev.h> and is included by the
latter.
