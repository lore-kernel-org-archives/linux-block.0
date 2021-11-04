Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F54C433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 09:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76FD6112E
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 09:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhKDJEN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 05:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhKDJEM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 05:04:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8B6C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 02:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VkkSDHiTeEHaRclvzZd8LZqdnE7k2sooCxKY+u9YQYo=; b=iwspwjoZl7+QMqS5zjbHlObNlh
        7FgwZB6Ab9YQRRQr3R5UJMPbclvP/nPDsfw1vWEQaMe0hY48jZdmNVFbjryduhVtrnhh1gvaNaH+t
        QmXuaZ/O1zriMuvt+L6B5aGxZ3M9e2ih7aKYAEdfAF7uDY2vOU0CGQInFJ/W3D07vWmwIiTCnYeDn
        LHBRkMIhT5/dknd1QgEiTgTuaMHMZpN7IOJZHQ3VTRxdcq/3AkMug9HbSkxvC5tj1ByyIWYg/Tfrh
        ON87Sh2W+RRrDmbWMjiPZoQx50YckF4gagHnU6ca+9Yygb2RI+0XH6vHfuDGnn65H8lwny60xzoaS
        g9U7vziw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miYcp-008PGE-0V; Thu, 04 Nov 2021 09:01:35 +0000
Date:   Thu, 4 Nov 2021 02:01:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] block: have plug stored requests hold references to
 the queue
Message-ID: <YYOhbiRY0xFAyVEE@infradead.org>
References: <20211103183222.180268-1-axboe@kernel.dk>
 <20211103183222.180268-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103183222.180268-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> @@ -1643,7 +1643,7 @@ void blk_flush_plug(struct blk_plug *plug, bool from_schedule)
>  		flush_plug_callbacks(plug, from_schedule);
>  	if (!rq_list_empty(plug->mq_list))
>  		blk_mq_flush_plug_list(plug, from_schedule);
> -	if (unlikely(!from_schedule && plug->cached_rq))
> +	if (unlikely(!rq_list_empty(plug->cached_rq)))

How is this related to the rest of the patch?
