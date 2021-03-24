Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D079FC433C1
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 18:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CACA61A1E
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 18:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbhCXSRM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 14:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237364AbhCXSRH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 14:17:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CA0C061763
        for <linux-block@vger.kernel.org>; Wed, 24 Mar 2021 11:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eyWlq2aUMFVFlF2E21fr1Z0V82kVrvCRVem/G6BMweM=; b=qFnyd4V8WTbz8VVdV+PT23tCo5
        UA0d518Ws0ErgbCQOYD+zxK2nQqBpbxd1pwcCsD6WHmiaB0TR91A8LlmUAnfCh0RVuLDGr9onl/Sf
        SfAHmQvd2pFOJ5xsxCsucZefUIMl0igrEjd1C4gs3w2muzfEuF9Ns6hH9DrF6VCetGPiW4iQ1tLU0
        Or8IJEJRNahMM0TuUTubPbxjfQTDSVMlix6iAB4H6nubvfKQkMvmYThD/0hcYk2IQz3jH6Orgykzo
        gkc/JosOQw3pD0SYFmCW/JOkz0cJlX9GuTqe8RhMSU1Zd9DXAQ7ErzjLpiLqZo99iO9nQXAHEgImR
        xYTCf2dQ==;
Received: from [2001:4bb8:191:f692:b499:58dc:411a:54d1] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP840-004EHV-Cd; Wed, 24 Mar 2021 18:17:04 +0000
Date:   Wed, 24 Mar 2021 19:17:02 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: Re: [PATCH V3 03/13] block: add helper of blk_create_io_context
Message-ID: <YFuCHvUFwhYRNa6Z@infradead.org>
References: <20210324121927.362525-1-ming.lei@redhat.com>
 <20210324121927.362525-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324121927.362525-4-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 24, 2021 at 08:19:17PM +0800, Ming Lei wrote:
> Add one helper for creating io context and prepare for supporting
> efficient bio based io poll.

Looking at what gets added later here I do not think this helper is
a good idea.  Having a separate one for creating any needed poll-only
context is a lot more clear.
