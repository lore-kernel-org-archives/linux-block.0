Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FDFC433DF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 13:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419B7206E9
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 13:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Osyq2Ysw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbgF3Nju (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgF3Njt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 09:39:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645FAC061755
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2020 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6H2MMgeHb/yqhdfsC65Gr4SLZMyV8l6pjYhABTVGajk=; b=Osyq2YswMjzKiCsg3RSJSOBh3k
        Xz3sjRclf4nnypy9hlZBTETT3z8AGnY8M823fkIpCWX4u3hwCg1VmgXjNYi231343dAVFWEahfoG4
        dxHsqiJat9Gn+7bz7FpbS/6vJJtN5OU7M97jlMbOlzjNeHyPnRoHfWZKDo+CI36AKUxXjFTmMzzoo
        MsBj7KIO4Wjq7XzhRxhv+C74KIADX3Z+8IJZKDRLB3fyfk8grHRazkXY1+4hy3qcHmQUmIOK/BoFN
        6Ez9thqKuzoog/XZoC3aN5loX1kKOTVBjhE48KJYDRZGv1wOj+PNR2ozbs3A5XtWbYwv7ete0+A7C
        /iD6s/xA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqGUF-0007w3-4N; Tue, 30 Jun 2020 13:39:47 +0000
Date:   Tue, 30 Jun 2020 14:39:47 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V2 3/3] blk-mq: centralise related handling into
 blk_mq_get_driver_tag
Message-ID: <20200630133947.GA30397@infradead.org>
References: <20200630071108.2192017-1-ming.lei@redhat.com>
 <20200630071108.2192017-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630071108.2192017-4-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 30, 2020 at 03:11:08PM +0800, Ming Lei wrote:
> Move .nr_active update and request assignment into blk_mq_get_driver_tag(),
> all are good to do during getting driver tag.
> 
> Meantime blk-flush related code is simplified and flush request needn't
> to update the request table manually any more.

As mentioned last time: BLK_MQ_REQ_INTERNAL is gone in the latest block
tree, so this won't apply.
