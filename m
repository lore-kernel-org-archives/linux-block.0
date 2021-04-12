Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA9FC433B4
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 10:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 582BA6128B
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 10:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbhDLKSd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 06:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbhDLKS1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 06:18:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9C6C061574
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 03:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jV5fyW/LBzaam9w8luLE2iB1qL52MuWwRwdPbMP8VQ0=; b=pR8liyV/aUFsDqMWiUMaBu2v52
        gWL4Ih/4g+udSbBzTmRH1z/v/FFHB/LRZRhWZHhNa/pdr/ploLZElxZLTqBIWOVUZjNsirmnG5PFO
        risGoMnorWIM5a6QHIr8+1TwhFS24ol7d6FG+2NL2yJ0gQxHX0+X/PyeNjrinjy7B7Ix6Mf3n+fx6
        imN6eLodaCdjYAi/0LmiYVWgq6chw5QyoK1Gl+OjclPaukHmW2J2j+4zYJBrX7aH2SkNTFm1whQRu
        GVSS/N4ql29jXFBol5xS1iW8kR+Vst4e0zH58eKJuHgzMMonsUJVyRb7LZbhM3elCWMEUNEFf/2Ei
        d1E8okjw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lVtdt-004Axt-G3; Mon, 12 Apr 2021 10:18:05 +0000
Date:   Mon, 12 Apr 2021 11:18:05 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 07/12] block: prepare for supporting bio_list via
 other link
Message-ID: <20210412101805.GB993044@infradead.org>
References: <20210401021927.343727-1-ming.lei@redhat.com>
 <20210401021927.343727-8-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401021927.343727-8-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'd so something s/prepare for supporting/support using/ for the title.
Can't say I like spreading the bio_list even more.

Btw, what uses bi_next for the bios that are being polled?
