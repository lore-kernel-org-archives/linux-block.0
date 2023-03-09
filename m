Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A173C64EC4
	for <linux-block@archiver.kernel.org>; Thu,  9 Mar 2023 02:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCIC3p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Mar 2023 21:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCIC3o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2023 21:29:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDCD9E679
        for <linux-block@vger.kernel.org>; Wed,  8 Mar 2023 18:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=salT6MNlKGmE/7wMi5HFyNriJe6kIvhEm5yPrtpnuPE=; b=ORSFGdkWKi3J5rRx+ZSjvaI6tL
        e2xS2KmV8gNbgKMCkDDk2LicGfhHiyLu6Mb8PSmq6TFu4RCONv/liR+5ckX0nLIGEzq4dZXmitjVr
        ae+cIGtWfaCmn/bWdot8SBRX7UomTb12OlpxoNUKY5NZIKeNfXJfNWlhlgnYUYAYL06IehTm9jfIX
        q0JQTwwokDwh1gS1/gJ69qFHxDSzJ1Mqvt0A873z8mxbKnqJOIUkT//z23JWlIPa52QGt6AluQZvh
        2zXodryKK5Oil5dKEWydFFDUL80NKldRdr7ZHjZbgpBz5XWP/WWJcChfjJZ2uDNXw+p2aM1g6bAyF
        F7tJNjmA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pa62G-007WmG-Om; Thu, 09 Mar 2023 02:29:40 +0000
Date:   Wed, 8 Mar 2023 18:29:40 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH 1/5] brd: convert to folios
Message-ID: <ZAlElDl6Jphcb2F3@bombadil.infradead.org>
References: <20230306120127.21375-1-hare@suse.de>
 <20230306120127.21375-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306120127.21375-2-hare@suse.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 06, 2023 at 01:01:23PM +0100, Hannes Reinecke wrote:
> Convert the driver to work on folios instead of pages.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/block/brd.c | 171 ++++++++++++++++++++++----------------------
>  1 file changed, 85 insertions(+), 86 deletions(-)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 34177f1bd97d..7efc276c4963 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -28,8 +28,8 @@
>  #include <linux/uaccess.h>
>  
>  /*
> - * Each block ramdisk device has a radix_tree brd_pages of pages that stores
> - * the pages containing the block device's contents. A brd page's ->index is
> + * Each block ramdisk device has a radix_tree brd_folios of folios that stores
                                                            ^^^^^^^^^
> + * the folios containing the block device's contents. A brd folio's ->index is
      ^^^^^^^^^^

So we end up with:

"a radix_tree brd_folios of folios that stores the folios containing ..."

What about:

"a radix_tree brd_folios that stores folios containing"

Other than that, looks good:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

So another thing, I think I counted about 5-8 grammatical rules which
could be bundled up into *one* SmPL grammar patch which could then be
used to automatically do similar tasks elsewhere.

  Luis
