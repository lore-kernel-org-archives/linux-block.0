Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADDFC76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjDKRPN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDKRPL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:15:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829D959CA
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=KeRX9dVFiawqgcjLXOKWEHv54ZDkU0M22Q8Q50GOkhE=; b=sFqOP+Z9iqYQMRrF1jeV7QiO3Y
        /30bikyoQMqWrztea1YlqlJ2ySiYTfvO2SvJra8MzzpcfQpUI64HXCqfP6+E5zJF/QQhRcMEhIRNj
        SE0sTxhH+uC/to2m4Znp1tb7LRT3bRBGYnlIH/481hUlZh4kMuv2H7OzbdTvpEa/fikbdpDf0cT2c
        9d38G2Poen45bekbkz62S3miA2/24Wppwf6tKCK7ae+iZpXhnlPObHTLWhmdE8tUrtYEpwzzs6BfU
        BNJQOY3z6oAkxw3mALEBE8hC5GIWQPXCbNrY93RdPJ7L9ta5GgygkpWbMOHOeJibUHoa0PJgUga4g
        NukqRxKw==;
Received: from [2001:4bb8:192:2d6c:e384:cbad:b189:57c6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmHa8-000gjM-2c;
        Tue, 11 Apr 2023 17:15:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: zram I/O path cleanups and fixups v3
Date:   Tue, 11 Apr 2023 19:14:42 +0200
Message-Id: <20230411171459.567614-1-hch@lst.de>
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

Changes since v2:
 - add a patch to always compile the synchronous reads path
 - fix a compile error in said path

Changes since v1:
 - fix failed read vs write accounting
 - minor commit log and comment improvements
 - cosmetic change to use a break instead of a return in the main switch
   in zram_submit_bio

Diffstat:
 zram_drv.c |  384 +++++++++++++++++++++----------------------------------------
 zram_drv.h |    1 
 2 files changed, 138 insertions(+), 247 deletions(-)
