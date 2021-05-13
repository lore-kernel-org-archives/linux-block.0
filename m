Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39959C433B4
	for <linux-block@archiver.kernel.org>; Thu, 13 May 2021 11:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84C9613F7
	for <linux-block@archiver.kernel.org>; Thu, 13 May 2021 11:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhEML1U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 May 2021 07:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbhEML1S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 May 2021 07:27:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA59C06174A;
        Thu, 13 May 2021 04:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r9oN4rAfYVkltFP1nqUdIrhELASwJQF3sOXiPvRVsQo=; b=hDwMX6WOwOcFiVtmwICnmhPT+f
        IgyOnHKvIq+Pt8H/edI/WB7n/lztayeU4Mzk9luE9yim4lGtdFWhPd4MY07tBJg2MZvZR2ckXCof4
        zWZBjhX8kPT9Jk9x0alASXqpFgR4/srMCq88LEesSW6tVk1snu/PfnKfZkdRwFXESkppIx8+QjkX2
        p/ob8iqQzdp5+tu3DFh+banaV3Mg1DYLsm3R5Albl0A2gMnDdfIGauty8LkIhxoQ/ofiSqlLxH/z5
        4r+mo1P0pAsA+PNQ+U6Fi12UdEpMraXjpKw61260jrfn3HYoF8wqWmfnmm2nU5cjYKyFYwP483hTT
        M1fnf/IA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lh9Qz-009NfE-A0; Thu, 13 May 2021 11:23:23 +0000
Date:   Thu, 13 May 2021 12:23:17 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     alex_y_xu@yahoo.ca, yi.zhang@redhat.com, jaegeuk@kernel.org,
        bgoncalv@redhat.com, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk, bvanassche@acm.org,
        damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com, osandov@fb.com,
        patchwork-bot@kernel.org, tj@kernel.org, tom.leiming@gmail.com,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
Subject: Re: [PATCH v10 0/1] bio: limit bio max size
Message-ID: <YJ0MJe1Gc5XMV1gB@infradead.org>
References: <CGME20210513102018epcas1p2a69f8e50cdf8380e433aea1a9303d04c@epcas1p2.samsung.com>
 <20210513100205.17965-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513100205.17965-1-nanich.lee@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

FYI, I still think this whole limit is a bad idea, and instead we
need to fix the algorithms to not waste time iterating over the bios
again and again in non-optimal ways.  I still haven't seen an answer
if your original latency problems are reproducable with the iomap
direct I/O implementation, and we've also not even started the work on
making some of the common iterators less stupid.
