Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA39C433ED
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 05:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A58DB613C4
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 05:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhEEFpp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 May 2021 01:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhEEFpp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 May 2021 01:45:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE60C061574
        for <linux-block@vger.kernel.org>; Tue,  4 May 2021 22:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tfIbCE5PtUo+T4UstmLUV156SoaNG1hVSxocsxbyORk=; b=eEM2HbGNb9sSh7hsqOhqfyxB0Z
        thYxLo4+xbOC3WxI1gvTX5KkEjiRsFwpOT+BRaYxeiPXge6wW5tJzJd9htNuYEQGWAEWPGvJDoQpg
        LLRtiDwLdJhyXjDBcrS/Dlmjn6yWG1Dt8YeLXLkmBHTp93Kv1BBAzUu/bYLOX4JItQEe9+pgeoSEd
        iOSh9fTyQ2gqqWf4gOy2fEC+yEVCDcgUp9Athd3cyFKewo2wK5dNxZL62/JhikurmFBN8iIUfjZQT
        E2o34wT+tCJuoBmPVtchozh9R/wIks5yVJh4GHLrY+LhzC9Tn8pQW43ZR00QI1KKEQ5qlk+7z6rwT
        PR1zt7nA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leAJW-00HXKA-L4; Wed, 05 May 2021 05:43:17 +0000
Date:   Wed, 5 May 2021 06:43:14 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Enrico Granata <egranata@google.com>
Cc:     virtio-dev@lists.oasis-open.org, hch@infradead.org, mst@redhat.com,
        linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] Provide detailed specification of virtio-blk lifetime
 metrics
Message-ID: <20210505054314.GA4179527@infradead.org>
References: <20210420162556.217350-1-egranata@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420162556.217350-1-egranata@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 20, 2021 at 04:25:56PM +0000, Enrico Granata wrote:
> In the course of review, some concerns were surfaced about the
> original virtio-blk lifetime proposal, as it depends on the eMMC
> spec which is not open
> 
> Add a more detailed description of the meaning of the fields
> added by that proposal to the virtio-blk specification, as to
> make it feasible to understand and implement the new lifetime
> metrics feature without needing to refer to JEDEC's specification
> 
> This patch does not change the meaning of those fields nor add
> any new fields, but it is intended to provide an open and more
> clear description of the meaning associated with those fields.
> 
> Signed-off-by: Enrico Granata <egranata@google.com>

Still not a fan of the encoding, but at least it is properly documented
now:

Acked-by: Christoph Hellwig <hch@lst.de>
