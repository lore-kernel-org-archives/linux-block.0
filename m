Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A2DC433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Dec 2021 08:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbhLOIts (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Dec 2021 03:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhLOItr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Dec 2021 03:49:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FB1C061574
        for <linux-block@vger.kernel.org>; Wed, 15 Dec 2021 00:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MgAay+5nUnQTk9uo5V1ZbdC5cd6OtZ9IbkjljmGaBpc=; b=3glpHNXSPf5r3bPKY1r5FtgO/1
        bvc1lHsyHDcBa5QeLLhiYx8TR500UPd0kTJugHiY193rnEf1yVQvEJJcGKBUdLWcegJoheW8gWMRA
        I1Op7xM3Azywf+SEcEtfFz/ejCMDkodVeZrfoR9DAv7dBfXoI+/AZUkjvx48p8vmekqCU8aZqg2fs
        8iRCzIjtLjx5iY5TCKtOZbX9u6vra/k3CnDVgxj4sayQb898cYgaPs1hQqiA6jy7Mxa8SrivcEms5
        DpAsBNm8Qs9qB6FvIGsinX26MjsNk/A+CImkO2tHjfvQscIAIA34jIMUyaKaQmxd6ehQswzB+oifJ
        YH0CXu+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxPyt-00HOK5-6M; Wed, 15 Dec 2021 08:49:47 +0000
Date:   Wed, 15 Dec 2021 00:49:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH] block: make queue stat accounting a reference
Message-ID: <YbmsK3iu0KPXTnkh@infradead.org>
References: <d6819554-8632-e707-3037-773a6ee904cb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6819554-8632-e707-3037-773a6ee904cb@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 14, 2021 at 05:02:57PM -0700, Jens Axboe wrote:
> -	bool enable_accounting;
> +	int accounting;

unsigned?
