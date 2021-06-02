Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C455AC47083
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 17:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACABF61CBF
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 17:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhFBRU6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jun 2021 13:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFBRU6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jun 2021 13:20:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02908C061574;
        Wed,  2 Jun 2021 10:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MK1pETBXrySMeSg1fQow8LKBoON8twsNxQ/RvKjSq1Q=; b=n5inLmh8f/qlRGVh5Fjou8GHhU
        un0sKY5ifWaMx8BKQhogTSkx+pA6Yhv62FhlKXADiZOf8lX/olDll1/5Zx2k1up1c07H4KN6GZGrB
        RhbGhhL+Yd+HHW/6Emd+tZYhG0yid4Sj0CRhW3434h5d4RyZOqoxqtXVyV98NPaxRRmJscaIaBhB3
        O9nw0LYC5DS3Q8ov2no78YY1pTDdXgx/75mKXd5ZLz7QZXsK4RjWC2+T3YdRFvFIlXvmnNn7kaqbN
        BVBx7wENO9a/JiST/qITczKs/HtAEFTyo5zHnUO7a0UBHmhyx0+oDjQlIuRX26b8W6lnwfcxqI4Y2
        iJcRYweQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1loUW0-00BM3z-RJ; Wed, 02 Jun 2021 17:19:00 +0000
Date:   Wed, 2 Jun 2021 18:18:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anton Suvorov <warwish@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH 02/10] dax: reduce stack footprint dealing with block
 device names
Message-ID: <YLe9eDbG2c/rVjyu@casper.infradead.org>
References: <20210602152903.910190-1-warwish@yandex-team.ru>
 <20210602152903.910190-3-warwish@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602152903.910190-3-warwish@yandex-team.ru>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 02, 2021 at 06:28:55PM +0300, Anton Suvorov wrote:
> @@ -81,29 +80,29 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
>  	int err, id;
>  
>  	if (blocksize != PAGE_SIZE) {
> -		pr_info("%s: error: unsupported blocksize for dax\n",
> -				bdevname(bdev, buf));
> +		pr_info("%pg: error: unsupported blocksize for dax\n",
> +			bdev);

You can combine these onto one line without passing 80 columns:

		pr_info("%pg: error: unsupported blocksize for dax\n", bdev);

(many other examples of this)
