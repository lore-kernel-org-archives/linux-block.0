Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3374C64E8A
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 15:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842AA22256
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 15:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgLBPDB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 10:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgLBPDA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 10:03:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C6CC0617A7;
        Wed,  2 Dec 2020 07:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Yo/K0qSiyVTQyb2ULngB6Dhf+Y
        Dy9/LE1mbGP5WbS6xxfBdTipfKB023hD1bSWHSdksLma8eeKaH9nmtAiVrxdDtw2XD2QuF70ETOde
        5xGlIAV/jSDMiMnVWCfqvsQa8Pk8js2JOMOOB+1xmyvqouF51gDg+JP99LlpQyr1z/I/OZcS5dQqS
        IiuT1n6gQaEuXTI2WVuq4LD4w+8pXkliKwXNarXZaAN5gFYdEVqYsttYBzO7tPcqEWP9WDJCrwYRN
        3y9ZUw/Rzyc31NQAWsRinKTygJcWc5RMA72c69FpctNhg3ePg9xPnudj7mqkQ+j91kJYiYfEN7RYq
        PC3qgZ0A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkTe5-0006V0-K0; Wed, 02 Dec 2020 15:02:17 +0000
Date:   Wed, 2 Dec 2020 15:02:17 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Message-ID: <20201202150217.GA23632@infradead.org>
References: <20201201120652.487077-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201120652.487077-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
