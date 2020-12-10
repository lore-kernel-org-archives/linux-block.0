Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1D9C433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 07:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 371F123D4D
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 07:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733155AbgLJH41 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 02:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgLJH41 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 02:56:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A4BC0613CF
        for <linux-block@vger.kernel.org>; Wed,  9 Dec 2020 23:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=nAtYSAJneh8r8tbHX9oHt2BXy2J8DrJzZuGIbziXAHQ=; b=mrD35PwcTHBBajp+RFtjNP2uBN
        wk6xwzaYO4u+vW0I62zavgS1jAOaWcTzSkpuqmKs31oHF01iOFEBDM/2/XnoUCKVYsmj+LrnRCSM6
        yl14RlpsY3EibQlbEOgB4mZwfpvPEBLUmDyyFJusmmLH7p8ytQZCHaQkg0NY+qrBg3Y4GYZV2E1hW
        I6c7Ge1ILj41gVqTvUq0H5RBzJluSwJaKwD1BYa2dFfb/OxYfDCxWV1qprAcct2HPAGserPs2Pj3A
        LCflk2YyeUOhI4oWxL4Mh3riMAiY5ybuMPzUrqXUHI/PaDjMbw2ZNMD2lwUZvts0u/26Xil/+HOvG
        ZFLRD26A==;
Received: from [2001:4bb8:199:f14c:a24a:d231:8d9c:a947] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knGnh-0002ZE-2g; Thu, 10 Dec 2020 07:55:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: small MAINTAINERS and copyright updates
Date:   Thu, 10 Dec 2020 08:55:41 +0100
Message-Id: <20201210075544.2715861-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

a small touchup for MAINTAINERS and Copyright updates for some of my
larger rewrites in the last years.
