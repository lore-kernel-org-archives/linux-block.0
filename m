Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B98ACA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1885A23126
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mv+LTLDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbgEMM1y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 08:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgEMM1y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 08:27:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA51C061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 05:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KshPX4OSLDyhYg2bK/7AYzTciP1pjieRzRjIQ+fRtWI=; b=Mv+LTLDuwXYRDvIhSmF9/bJM8m
        x3mp8q0mI0FEkm2a7n0f8yQzBNTWZScFo8WKyGMmI1BlsfBT36cbjQ2sZ+2BB7LNcK8kkdhcdW+xQ
        nDGTsQURNN+b7faqbaOywEfJJcTAUDG1NBmyusdjR5gKmrjarzf9FCbnVWjvT2K2HKkj4DpUBjJOq
        11K0KxEZGvBFYyRg+YhyTa80pH+EQaJrUmgcJ9yZlIHUrEg+APH33ui2bZ7QEFlsSgXHSzwmEJuIa
        N0cV4Q4ZWEFaZB3Vm0TWCzVulPicy2J00GyDxCSwRyRMoVOW/RrsVhM7nWTi3gaUvFMPZMMUt6x7h
        1G4JulzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYqUL-000666-68; Wed, 13 May 2020 12:27:53 +0000
Date:   Wed, 13 May 2020 05:27:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/9] blk-mq: don't predicate last flag in
 blk_mq_dispatch_rq_list
Message-ID: <20200513122753.GC23958@infradead.org>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095443.2038859-4-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 05:54:37PM +0800, Ming Lei wrote:
> .commit_rqs() is supposed to handle partial dispatch when driver may not
> see .last of flag passed to .queue_rq().
> 
> We have added .commit_rqs() in case of partial dispatch and all consumers
> of bd->last have implemented .commit_rqs() callback, so it is perfect to
> pass real .last flag of the request list to .queue_rq() instead of faking
> it by trying to allocate driver tag for next request in the batching list.

The current case still seems like a nice optimization to avoid an extra
indirect function call.  So if you want to get rid of it I think it at
least needs a better rationale.
