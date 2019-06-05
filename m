Return-Path: <SRS0=Ij7C=UE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283C4C282DE
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 05:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36592083E
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 05:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S5O9J46y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbfFEFng (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jun 2019 01:43:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49508 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfFEFng (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jun 2019 01:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0nvl81NRj7KH7v4x3HY8gsEUauXzmM0pV++zveLOJ/U=; b=S5O9J46yyvY2NUviueLv2f6RU
        JescWXYUzulwZOWnJmDNZhz0+/PPeUpxkuZHR96V/WBa/8629mdferh3JWBaq9XDw6QJNX6LzN/jd
        J1NKZwqlfb3uFizq6Jew1aA5NREmM/k37ZH45HaXLJFHW9fSXZrclCGDHSiomc1Qj8UVR6jq6+nYn
        gTq5Z38L9ZWHyuqMd7nJMh+KakHhhQuy4L9Glfp+d8q6bIVAxO9S/dwdLI2F035ALKL6e/qukdGsI
        RSKlJ2YMvRhqsYi+XrgHCmQ7tkcrc5nHO0i8TVtXK3QeVBNzpy//8bVe+PMiT6mQo8NqUZbGZyvyZ
        doYzNj64g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYOi0-0002F4-96; Wed, 05 Jun 2019 05:43:36 +0000
Date:   Tue, 4 Jun 2019 22:43:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 17/18] bcache: make bset_search_tree() be more
 understandable
Message-ID: <20190605054335.GA7849@infradead.org>
References: <20190604151624.105150-1-colyli@suse.de>
 <20190604155330.107927-1-colyli@suse.de>
 <20190604155330.107927-2-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604155330.107927-2-colyli@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -			n = j * 2 + (((unsigned int)
> -				      (f->mantissa -
> -				       bfloat_mantissa(search, f))) >> 31);
> +			n = (f->mantissa >= bfloat_mantissa(search, f))
> +				? j * 2
> +				: j * 2 + 1;

If you really want to make it more readable a good old if else would
help a lot.

>  		else
>  			n = (bkey_cmp(tree_to_bkey(t, j), search) > 0)
>  				? j * 2

Same here.
