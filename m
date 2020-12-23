Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A50C433E6
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 07:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24BC1224B0
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 07:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgLWHqE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Dec 2020 02:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbgLWHqE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Dec 2020 02:46:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B473BC0613D6;
        Tue, 22 Dec 2020 23:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t5D7i1pq4WxJtDi5FOVW40JzpWIutUjfMACyuB3kKdM=; b=qfnLHHI89SWzxhiGAAUkaw/UO7
        tK2yT9NhwtogeNmARwvkthBKV7QMIN8FtNtHJXcORhd3mDPyc+UBdW2QjWt2QzJUvlIFef50MhpP7
        pvPZs9D2UGhomItz1mfy6ditZJp2va6hLVgYFrkRolJ8cmmDxbFwc9GBTQTgJoctPxtfpSyPQqdcI
        vWBG6l6l0rDs0T/850+T++yUNYu0NX01wzqa/xU1lvRSpgl0UVHCzGIZK0SVEPjP6ivq9kSuZY6PM
        JbaBu7dGWJJa94oQe/neiK6W/7EU+WQa9klkm8BsZwXdbIQvUIEc3cbxhDdkVMbE2KB7CrLd9HuXX
        yMEZGIKQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krypg-0003ym-1q; Wed, 23 Dec 2020 07:45:16 +0000
Date:   Wed, 23 Dec 2020 07:45:15 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, hch@infradead.org
Subject: Re: [PATCH v2] block: move definition of blk_qc_t to types.h
Message-ID: <20201223074515.GB14729@infradead.org>
References: <20201223054412.60372-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223054412.60372-1-jefflexu@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 23, 2020 at 01:44:12PM +0800, Jeffle Xu wrote:
> So that kiocb.ki_cookie can be defined as blk_qc_t, which will enforce
> the encapsulation.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
