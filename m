Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FF8C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E156113D
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhJTGW6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 02:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhJTGW6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 02:22:58 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7B4C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 23:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6hhgvVS2TA57K9peGoW9Bg5Gb/bAT4l/Zw92LWlyGfo=; b=d2cIORc55pY8KgvXRfnmFHqe7D
        FaPTQKbDy78AM6iwtKYKynMs+efczuOGwN8hXklY7xXzgTMh0FhGT0+Yaycoe2YEVU8pOyQlNpwUs
        HG1zKe9e+Uq+6AAbyqlIV1CKGpmHeChNbkGkpzwK1I0cFW+4Ra4cJo15v3YG0dpLiYo2NdkrgLFp8
        aFoQ4VxVSAXN7j2Vf958pxZ99XXfhKdvf/AaY8YkSLzPbSr/6j4RjSK96WvT82HpwhaenNJO+wbAB
        xXb/HZq3OHvBenW3o04q1lFhG6h/SiMlU47T16qnMq7sLaiC0LXIBJddgZ8yiyQmBsiJt61cfwYHM
        1zbQHrlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md4xv-003TJr-Sy; Wed, 20 Oct 2021 06:20:43 +0000
Date:   Tue, 19 Oct 2021 23:20:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 11/16] block: add optimised version bio_set_dev()
Message-ID: <YW+1OxkLRboWQNm4@infradead.org>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <3c908cb74959c631995341111a7ce116487da5c5.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c908cb74959c631995341111a7ce116487da5c5.1634676157.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 10:24:20PM +0100, Pavel Begunkov wrote:
> If a bio was just allocated its flags should be zero and there is no
> need to clear them. Add __bio_set_dev(), which is faster and doesn't
> care about clering flags.

This is entirely the wrong way around.  Please add a new bio_reset_dev
for the no more than about two hand full callers that actually had
a device set and just optimize bio_set_dev.
