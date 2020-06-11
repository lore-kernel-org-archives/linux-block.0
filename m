Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FE5C433DF
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE3A20820
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZbrGNUpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgFKGo7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgFKGo7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 02:44:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3209EC08C5C1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 23:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=RRzxfuKllagE+XxHTauinHUBDbK82z6/O2MoiQ8L6+U=; b=ZbrGNUprhR0ePowjciU5Ll2kO9
        S67YHI1EB4HWaqGjJaM2xdzjtYwRRs20LUjVi0LoDBjppyFyuTqG+1VMIToMLIeHcrkcMuvOTWWA8
        wrobOm2iF7ec7T3EbkmVLF7VaeNzkGND0ojQzVGRLRj0Nkn1o/GxkSsgm7AdddYr2vz5cKMpr3kXv
        2ixMWiQxc3NoEoQHCbaApEpcRfaJY86EY0F1Zvu9WKVSjGWmCf+RGHhNvsr+Gw88IQwWAn8P5Uyx4
        qgGIOJNGzmVc/HU2o8IuoHmnvAscRcN3AKAe+fmRu9XpW5kEFZNedSHsI+c32TTf+HWB6ZXbkQS39
        ooUg4WiQ==;
Received: from [2001:4bb8:18c:317f:efe9:d6fc:cdd9:b4ec] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjGxK-0004sm-S0; Thu, 11 Jun 2020 06:44:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infrdead.org
Subject: blk_mq_complete_request overhaul
Date:   Thu, 11 Jun 2020 08:44:40 +0200
Message-Id: <20200611064452.12353-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Peters recent inquiry made me dust off various bits of unfinished work
around blk_mq_complete_request and massage it into a coherent series.

This does three different things all touching the same area:

 - merge the softirq based single queue completion into the main
   blk-mq completion mechanism, as there is a lot of duplicate logic
   between the two
 - move the error injection that just fails to complete requests out into
   the drivers.  The fact that blk_mq_complete_request just wouldn't
   complete when called from the error handle has been causing all kinds
   of pain
 - optimize the fast path by allowing drivers to avoid the indirect call
   with a little more work for polled or per-CPU IRQ completions.  With
   this a polled block device I/O only has two indirect calls let, one for
   the file operation that ends up in the block device code, and another
   one for disptching to the nvme driver
