Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30802C77B6F
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 14:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbjDFOnK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239386AbjDFOmf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:42:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBA6AF0D
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hQanMhh8zwbKAF2OwSHuBoBEWxA4OX9V6+kl+QBB/zo=; b=UsAVwqT6emqgOj//VZVXrBC+Sv
        aMmrYsqdsAJ9G8qaSFMRh8tyn9ovrv/tW9Dm09tHHA6BsbappAItSY1vxn2fUlJUqwD3fBF35fsMf
        JUZHWvfHwQa3TWOqbq39ZroJzj2NPttsb6I4ggeozWNo/4u+eynAWOPGl1H7g17Cc4m2utTMBopvP
        YqKmi1F4Ws4FQkZoIKHP4N4QDO1R3RJrCubnjPCbnxbb3J2UCyGAJLDyH4nhvW2KBfoN/vTACBVYC
        j30Ql7WbvhnrXF1DCLGyvPgFn5iT4SOTHjnYyTNmsULE6jOPocLKoTagsAKgthmOTnJeDLAirihfY
        My+OqBGA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkQnS-007fei-2z;
        Thu, 06 Apr 2023 14:41:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: zram I/O path cleanups and fixups v2
Date:   Thu,  6 Apr 2023 16:40:46 +0200
Message-Id: <20230406144102.149231-1-hch@lst.de>
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

Changes since v1:
 - fix failed read vs write accounting
 - minor commit log and comment improvements
 - cosmetic change to use a break instead of a return in the main switch
   in zram_submit_bio

Diffstat:
 zram_drv.c |  377 ++++++++++++++++++++++---------------------------------------
 zram_drv.h |    1 
 2 files changed, 137 insertions(+), 241 deletions(-)
