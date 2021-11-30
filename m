Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98F0C433FE
	for <linux-block@archiver.kernel.org>; Tue, 30 Nov 2021 12:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhK3Mum (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Nov 2021 07:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhK3MuR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Nov 2021 07:50:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9769CC061746
        for <linux-block@vger.kernel.org>; Tue, 30 Nov 2021 04:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=PshPPcN0MdgHNYNMeFY7YTqxneZspkrNuVwCqas0vd8=; b=LnnAbvnM+vR+tVdVhCi/RufsOy
        yWUWyr5Ty30Dk4VcN4hqBh27WkgqrQsIzkC29i/7bjbuDxpoCN4Hh+2ENgfLSUKmMYf10aiPRwHB+
        WbCf6SjYb6qe1EFPZtEZ5SKiFOlTAJRD1GNCvJ+0npul2aEeOivZNiaHqGQSlmxs/2MCT1n+7chAL
        Wh0OjLYJ9SEKD/l7C+kDMpaQZNRMpKeLQK3IVKwvATpjvVAvTK2TEIE2a/tTvcn82ywzANY35pPg4
        4tYmbXsPNDlS/HBWwrWx+Ev7xVefBRDyzI5d0Hl9nUB6io9GDjeh1E9Fw6V1KFt6lTVcGGkjLtBIp
        FpzleApw==;
Received: from [2001:4bb8:184:4a23:f08:7851:5d49:c683] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ms2Wt-00CFa2-CJ; Tue, 30 Nov 2021 12:46:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: more I/O context cleanup
Date:   Tue, 30 Nov 2021 13:46:29 +0100
Message-Id: <20211130124636.2505904-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series dusts off a few more bits in the I/O context handling, and
makes a chunk of code only needed by the BFQ I/O scheduler optional.

Diffstat:
 block/Kconfig             |    3 
 block/Kconfig.iosched     |    1 
 block/blk-ioc.c           |  153 +++++++++++++++++++---------------------------
 block/blk.h               |    6 +
 include/linux/iocontext.h |    7 +-
 5 files changed, 80 insertions(+), 90 deletions(-)
