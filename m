Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7DFC433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 06:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3619C2186A
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 06:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WKWlytiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgFRGyA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgFRGyA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 02:54:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF93C06174E
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 23:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nltc649ESpUSb9RgWmw1IsUpGT6nkS+CmBjRABwNwJg=; b=WKWlytiParcxhkTsz/FpSzUWAj
        AAaZLtbp2Q7WZoPJ606dXSgNeM9i22b9N3JtlUB+t3pKhUN4bzg55Xi1Exg7ZGwCmcne9Lve/dhtS
        QjeOGgWEtGM2/+ihdKmJ14UPr0WrP/EqllPWCgc8FMzdB0szrDNzvg3FwmWaf8zJmMx4ohavyGikh
        BDW7qvo7GnFp1Yf6t1/f6Em6/qw6Vu0KEUkdmpFsiaaxfL/dZ1rSlCWSfSxtz4KOwr8XFfNyReIan
        u9wU5lvLlyLKuunF5SYynFGQz1aZ9GqI370wfEY9cxP5E9tRR4HqNdGBX6CmVBH8QkPKQ6P1mudf9
        FzAywfOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jloQx-0006bu-QH; Thu, 18 Jun 2020 06:53:59 +0000
Date:   Wed, 17 Jun 2020 23:53:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] blktrace: Provide event for request merging
Message-ID: <20200618065359.GA24943@infradead.org>
References: <20200617135823.980-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617135823.980-1-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 17, 2020 at 03:58:23PM +0200, Jan Kara wrote:
>  	blk_account_io_merge_request(next);
>  
> +	trace_block_rq_merge(q, next);

q can be derived from next, no need to explicitly pass it.  And yes,
I know a lot of existing tracepoints do so, but I plan to fix that up
as well.
