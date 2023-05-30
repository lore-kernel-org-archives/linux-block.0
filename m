Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B4AC7EE23
	for <linux-block@archiver.kernel.org>; Tue, 30 May 2023 03:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjE3Djz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 May 2023 23:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjE3Djy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 May 2023 23:39:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563C4B7;
        Mon, 29 May 2023 20:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2D/dQDDcxVNNdhfU159MLR/FS+XWwtto6W8hG7rRSiY=; b=UFz1I7BrDrz/KrjWMd1GpiN8CY
        izU4R/occ2YkdHaiSMFt3hzhzlpvrZVQ4RYKxk7+4zQH+/xX6cSNuj1op/XqUGo3GPp1nZ46SiFmC
        lcO09fgDSbEtrQGiG0wwv52dX7kD7n/uvFW97/OSzAsBPbSjAMPgxWo1I/tFfcZrBSygoVbu/ZNZc
        bhjO3w3LIBc7h96viLyck3A7QdN/XEDNFVxbI1C+apn1ifn6p/RxuYSafRPigvjwzwwL/n0dyl0+S
        0uAU+JQU39lmzQAcfNeWoBvbn0s/O/btYNuM0S1GyXaA3xbpj6dkLBkMGPB9U9w+h3Cma91hWJmZ8
        O2mM5mNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q3qCw-005vQx-6s; Tue, 30 May 2023 03:39:38 +0000
Date:   Tue, 30 May 2023 04:39:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     gouhao@uniontech.com
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/buffer: using __bio_add_page in submit_bh_wbc()
Message-ID: <ZHVv+rPl7iL3dMqi@casper.infradead.org>
References: <20230530033239.17534-1-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530033239.17534-1-gouhao@uniontech.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 30, 2023 at 11:32:39AM +0800, gouhao@uniontech.com wrote:
> From: Gou Hao <gouhao@uniontech.com>
> 
> In submit_bh_wbc(), bio is newly allocated, so it
> does not need any merging logic.
> 
> And using bio_add_page here will execute 'bio_flagged(
> bio, BIO_CLONED)' and 'bio_full' twice, which is unnecessary.

https://lore.kernel.org/linux-fsdevel/20230502101934.24901-5-johannes.thumshirn@wdc.com/

You could send some Reviewed-by: tags to that patch series.
