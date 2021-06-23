Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550CDC48BE5
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 07:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B286611C1
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 07:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhFWHsB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 03:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFWHsB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 03:48:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7FEC061574;
        Wed, 23 Jun 2021 00:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tbxLmABV1Eam+4di+sqNdDzjHR+frCejHCLVHaU+ge0=; b=Xm9DuzrYRhjIDtYKcqBefON5+N
        ig6Yjf7t4I5CZBuDPR2xmxvcTd8ovtIhQgvzkQr6yBdBoysvgBGC5q1etcLwDfgoPrunwnWJJdgUF
        TbtW9DJfMLzZPFH+OuBuAbgIlOTEV5TT7UviZXO3tFBvJCcT53ZTSZ7XISMXdqbk84uukXh45UOH0
        g/bAyUSkqMAhg4Luqso8Tkmjd3mATu2RsQom6CQxUU+8L5YXlK9QMZBUmdVJsIHznQgRYy3A0/8cS
        Ze7eb8YwZGaPAGDUqgTiqw3OAcqmVM0abwrF4U64/pIZhYTgQQmn+NzmLvlFivaILyEvXIxI2XE01
        2HAAJDmw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvxZG-00FAm8-Sf; Wed, 23 Jun 2021 07:45:09 +0000
Date:   Wed, 23 Jun 2021 08:45:02 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Anton Suvorov <warwish@yandex-team.ru>
Cc:     willy@infradead.org, dmtrmonakhov@yandex-team.ru,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 05/10] block: reduce stack footprint dealing with
 block device names
Message-ID: <YNLmfsrS6RIFBX/n@infradead.org>
References: <YLe9eDbG2c/rVjyu@casper.infradead.org>
 <20210622174424.136960-1-warwish@yandex-team.ru>
 <20210622174424.136960-6-warwish@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622174424.136960-6-warwish@yandex-team.ru>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 08:44:19PM +0300, Anton Suvorov wrote:
> Stack usage reduced (measured with allyesconfig):

Not just stack footprint, but also a whole lot cleaner code in general.

> -			       bdevname(state->bdev, b), blk);
> +			pr_err("Dev %pg: unable to read RDB block %d\n", state->bdev, blk);

> -		       bdevname(state->bdev, b), blk);
> +		pr_err("Dev %pg: RDB in block %d has bad checksum\n", state->bdev, blk);

> -			pr_err("Dev %s: unable to read partition block %d\n",
> -			       bdevname(state->bdev, b), blk);
> +			pr_err("Dev %pg: unable to read partition block %d\n", state->bdev, blk);

[...]

Please keep the non-format string arguments on separate lines instead
of creating unreadable lines.
