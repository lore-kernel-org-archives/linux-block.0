Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D270FC433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A7561212
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhKDSjZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhKDSjY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 14:39:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990DAC061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g0malwws8zYtKkiKDl+h6kawsGVUoLFJvh3V8ZyaYGA=; b=C6224VKi00vi/O8SvypqyT0DmH
        Re5jkrQmomVIbAMtt0x8r7rvLoAqdyUy/hhIGHQpI5i4+RUax5RlWN9kx3Lw6qnHSB2p63cxwE6DL
        Lc0M/wZBReyUNuRoorNP72XcS1em4gS5RHNKDyYVfgan0Z1zr22/PH1TMfN+SHMSfgz67z0asVzjE
        flrqbFC/+DmWv4V7dLkOjfXKeJ9DgrfiPknET2bfkAv08WBrMfnemYnNIeMiGg1/PryJ8NnVdXSKc
        IA+lI9IdRl7jsmZfjhLalSy22iIUXwGDonBcPpC9uXeQ3pDDKZCSRfB2C3wo1dcQNOIjxH61m5Jyf
        GXEZRtKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mihbS-009nmQ-8B; Thu, 04 Nov 2021 18:36:46 +0000
Date:   Thu, 4 Nov 2021 11:36:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 5/5] block: ensure cached plug request matches the
 current queue
Message-ID: <YYQoPgyTVIKy0Y9p@infradead.org>
References: <20211104182201.83906-1-axboe@kernel.dk>
 <20211104182201.83906-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104182201.83906-6-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 04, 2021 at 12:22:01PM -0600, Jens Axboe wrote:
> If we're driving multiple devices, we could have pre-populated the cache
> for a different device. Ensure that the empty request matches the current
> queue.
> 
> Fixes: 47c122e35d7e ("block: pre-allocate requests if plug is started and is a batch")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
