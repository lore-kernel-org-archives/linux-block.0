Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399A9C433F5
	for <linux-block@archiver.kernel.org>; Thu,  7 Apr 2022 06:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiDGGRR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Apr 2022 02:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiDGGRR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Apr 2022 02:17:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D9C1EC9A8;
        Wed,  6 Apr 2022 23:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=zelM0W3roF2hyF5IfymbR30q0/P/DpF9Q12I1M+1k/o=; b=DU87k1kT9d2X5nqsU2v/XFoOZu
        0fa4hJhHKNsQsEEWrgdP3Mdlwfllx/h+7zKSoH6OXOlpe7QGrlBHyVqZeZEeL/ngq157/GVDWQ+oz
        CM+KmdmZROokCN0nGPRGepcyo+cxjrV7XlsdXYXPDvjMDvJpJO+ibRl3C4VaLpXP2kRL9/i92HhIF
        F2GH5TOlLD5HN0KKQYhGOln/vVjeZAjY7ncDvnuukO5Rqoo+aQ8VBEOhZwGBqezHM7dCweRtxVZWC
        7twZ8DZRyRtZPjyqpZImvVr4mYnv2QSv12KyKBHjv4sWmle0BbZS/gtVnWuoLP4p/tz0Wu+dURiyl
        DMLrq1+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncLQJ-009dnj-SU; Thu, 07 Apr 2022 06:15:15 +0000
Date:   Wed, 6 Apr 2022 23:15:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph@boehmwalder.at>
Subject: Re: [PATCH 3/3] drbd: set QUEUE_FLAG_STABLE_WRITES
Message-ID: <Yk6Bc7lvjCsmlkoq@infradead.org>
References: <20220406190445.1937206-1-christoph.boehmwalder@linbit.com>
 <20220406190445.1937206-4-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220406190445.1937206-4-christoph.boehmwalder@linbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 06, 2022 at 09:04:45PM +0200, Christoph Böhmwalder wrote:
> From: Christoph Böhmwalder <christoph@boehmwalder.at>
> 
> We want our pages not to change while they are being written.

Please document the _why_.  A commit like that will leave everyone
looking at this code in the future rather puzzled.
