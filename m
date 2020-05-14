Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEDCC433E0
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 06:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FC3206D8
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 06:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aJ39dImC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgENGlf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 02:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726122AbgENGle (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 02:41:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C918DC061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 23:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tdKQLFRAjhwTleO3Wg5bWVOm3KaOEoA4zqJwwED9BEg=; b=aJ39dImC9m2L3HhCmFEWWBMG7r
        e54zdTwD57lZbTZ39171YviPj3OXSisEDThQXELf8rCF0+cqKTbdW0aODrUU5CZI5O408EV0IN6R+
        i5kNtqCcJEazi79KLggIoqTmi4CFMFpttSh2rOJZOhPlxZ4o1WifpdbgBQjxFcJupVGuNAUdNe6r2
        nYnFoNWXUbbaQNsTGr4ZeKG2z6DlogmhZv8rE0L8a/kqSG+NdvHdKoVfC+lh9NCojxuKvTfq+gpy1
        zf+Gtz+HEQgkLKdxgLSptm2xS8WHhOfATkHZdaRg+zjzFiXFOyyQ+J0EyuzGXQRyKMdbIfud6dxZt
        AbgeKiFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZ7Yj-0006p2-JY; Thu, 14 May 2020 06:41:33 +0000
Date:   Wed, 13 May 2020 23:41:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH] block: fix build failure in case of !CONFIG_BLOCK
Message-ID: <20200514064133.GA5058@infradead.org>
References: <20200514014302.2078182-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514014302.2078182-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Can you please just move the function out of line?  If we context
switch it is by definition to performance critical enough to be an
inline function bloating the callers..
