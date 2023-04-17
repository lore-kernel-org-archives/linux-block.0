Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5755BC77B70
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 04:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjDQEwL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 00:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDQEwK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 00:52:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C35198
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 21:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VIVeq2nfpcBEkP7mrcWNvsyhCO5QQ4SYJqiYrt0VLnw=; b=HxKvOdyDRLbD42rxWcmkLas9Jw
        06rd8zlbhyU3jHNrhWzL0i2hBYI1Z0Yak+IAFcRvhOYr14J27Fh0YMMPVzxbeThJ/KBMgYAjnDhqm
        ugaREmTrRCQRKqLk0II8GSZDyI6y92Un9150qDf/HdTNwzJdE8La6IokorqtzvAt3zxHzr/8xpC0O
        l7KtrmrAyQu+gM9hRWLcJil5dyGZTjlF1myFMD4aHHuFiIlaoINUWYChWbbwbQmlBxteIqOrlxH3+
        2jpSqbKRFb8sFXO+RR1MdMvasilR8qB0R/Y5CpxLtShDwOtZo43Hu819rdRx6iUUw79f+sC6dC0If
        b5csXZeg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1poGqW-00ErcQ-1g;
        Mon, 17 Apr 2023 04:52:08 +0000
Date:   Sun, 16 Apr 2023 21:52:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: ublk: switch to ioctl command encoding
Message-ID: <ZDzQeE3dHIC8FmE8@infradead.org>
References: <20230407083722.2090706-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407083722.2090706-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 07, 2023 at 04:37:22PM +0800, Ming Lei wrote:
> All ublk commands(control, IO) should have taken ioctl command encoding
> from the beginning,

Why?
