Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79F8C433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A193361215
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhKDSjK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhKDSjJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 14:39:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68AEC061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 11:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jxYvYJME0mf/G1CxGitQEN9xpV2HRv5HE7YRx3yg2NI=; b=IT75mmBVrNwZIuvSscXQoshXbs
        LptSGp6Dw4vYt3UVmqzK/URm8O7ENWtHCjSkUyI8aOZ3hqj6EESj6SBCxxQ3EXXudq/64GRzQipjS
        HHBi0EWcaOkV/L/1Dkz9NFldhP0u8JFHAv/gkISTz3DQPHk9ERgRcRk9Lug9yGSgm5adOs3yC+K0M
        wgsDDwRlezT7O9XipZWV4IGbiPh00WIctIOfTDPIUM/J8RQ8BVknZ9rI8C6cMsPRnWyemSOgOwNh4
        L3tQVrLCOwB/1tUQkdnYkQLXDB3NrrZeM/DRBEf39UXE0OdF2LVQ0m0/EttMTK0qvl6UU2+6bh64x
        xqspMaMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mihbD-009nlL-7s; Thu, 04 Nov 2021 18:36:31 +0000
Date:   Thu, 4 Nov 2021 11:36:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 4/5] block: move queue enter logic into
 blk_mq_submit_bio()
Message-ID: <YYQoLzMn7+s9hxpX@infradead.org>
References: <20211104182201.83906-1-axboe@kernel.dk>
 <20211104182201.83906-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104182201.83906-5-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static inline bool blk_mq_queue_enter(struct request_queue *q, struct bio *bio)
> +{
> +	if (!blk_try_enter_queue(q, false) && bio_queue_enter(bio))
> +		return false;
> +	return true;
> +}

Didn't we just agree on splitting bio_queue_enter into an inline helper
and an out of line slowpath instead?
