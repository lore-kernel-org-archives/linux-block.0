Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DF0C00145
	for <linux-block@archiver.kernel.org>; Thu, 15 Dec 2022 09:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiLOJaW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiLOJaT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2022 04:30:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAB1379E5;
        Thu, 15 Dec 2022 01:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IlJozU8OcvQayugAj056DEYAilBtzE6ivKVmxPXiPjk=; b=KwL0SIsMaRie20LTB50JeyVkKV
        POMk7lwcQE7zJUjIsRTtQq8GEMo7/nLrkOmO6nZIpJnGAv/SzZQAQ1a4aQyzrgwzCw435vslZO6H2
        cA93wdjgSACqBxvjHiLQYJhuGX65OwIAYQgmwBWgKEUIOv3SPuIL6ccFpRdbMFAJTBda0JmSptqaq
        ea4y2Nu96SWWKLgPdgO8tds7ISBV1IlSdQ1jOcjIW3gRq229Qqi5Qlhn8USxSwfC8pJn+AyI4jMkc
        UneNesuw7+JfPgOQY8LKbFNx2r7/+AB/pH3mOVOGX1zuYukb1nEpgQGkdzemkKJXmV+xAhUmI6+xv
        NRn5VSQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5kZF-008HLa-4H; Thu, 15 Dec 2022 09:30:17 +0000
Date:   Thu, 15 Dec 2022 01:30:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/21] block, blksnap: init() and exit() functions
Message-ID: <Y5rpKXuJxqeUYfJP@infradead.org>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <20221209142331.26395-8-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209142331.26395-8-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 09, 2022 at 03:23:17PM +0100, Sergei Shtepa wrote:
> +	result = diff_io_init();
> +	if (result)
> +		return result;
> +
> +	result = snapimage_init();
> +	if (result)
> +		return result;
> +
> +	result = tracker_init();
> +	if (result)
> +		return result;

You need to clean up all these initialization if a later one fails.

Also, does this really need a separate file?  Any good reason to
not just keep the tiny amount of init code in ctrl.c?

> +static void __exit blk_snap_exit(void)
> +{
> +	pr_info("Unloading module\n");

Also we try to avoid these verbose messages for new code normally.
