Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD4FC433EF
	for <linux-block@archiver.kernel.org>; Mon, 11 Oct 2021 08:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3560360ED4
	for <linux-block@archiver.kernel.org>; Mon, 11 Oct 2021 08:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbhJKIbB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Oct 2021 04:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbhJKIbA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Oct 2021 04:31:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F41C061570;
        Mon, 11 Oct 2021 01:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sztkCoURuqdRvrtmoX0y2x+BvWMtJwZhjdAMJIDHL2k=; b=jmEczP9+nk/1ca9r43kTEnWYCk
        fD/zQbZ0H026IxClf06SUzYw5xpJd2MofpMTqs+2sJ4KeJZDnu3xjZGRegkJ3s6yL2/gDFiadMWtX
        zTNpIFeAq1j0CxIIrXO5hhqQgm8fomZGBtRgJ2ctrskryxonJ0JAiE2eZwWMIBZ2HLUeTwEHz39uu
        hFcJwAedQJwhYJvqE/O7sCuski38SP2ftpMxroSf0CtaGkuvAZfYjCx6mYLaUSKgRvJzQvVDFJttk
        hszh6qzyJ736U3HO+7EmjxudbV5O7SG+CGf65Zd1Yfw9MddId+k8p5lfs5rozrJzssVh7hquue4F6
        YPEY85VA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZqdn-005N7Q-BW; Mon, 11 Oct 2021 08:26:59 +0000
Date:   Mon, 11 Oct 2021 09:26:35 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] block: cache bdev in struct file for raw bdev IO
Message-ID: <YWP1O+oZmsovShoR@infradead.org>
References: <cover.1633781740.git.asml.silence@gmail.com>
 <cfc66d9946422fa1778504f976621c91be2befb5.1633781740.git.asml.silence@gmail.com>
 <0785c707-ba82-1e46-5d4d-63ccacdb471f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0785c707-ba82-1e46-5d4d-63ccacdb471f@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 09, 2021 at 10:33:17AM -0600, Jens Axboe wrote:
> > +static inline struct block_device *blkdev_get_bdev(struct file *file)
> > +{
> > +	return file->private_data;
> > +}
> 
> Get rid of this and just use bdev = file->private_data where
> appropriate. Easier to read, we don't need to hide this in a function.

100% agreed.
