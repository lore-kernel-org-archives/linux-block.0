Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0F5C001DB
	for <linux-block@archiver.kernel.org>; Mon, 14 Aug 2023 13:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjHNNXv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjHNNXk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Aug 2023 09:23:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA6212D;
        Mon, 14 Aug 2023 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T8Pbi+AtdsCBMxSWZKRpPW1Wq89VMiXjiZzvJl2OWrg=; b=ZAzrCQUwDaAiLY4rZgSiHtfOqx
        IW4PK1p+wQl0ChvH7y0wpWHWR1LYToASBwSu0e0rdS9Xca7PHdv361bc0zWtqxALBw2YbZE8gTIzw
        13sjIAlCgdMAwDNFKrSkxr9EgUQKWPHkeNvYBf8QbDUyMjHiTJLz1zL0NHqF32I0riLKJ51lf4FaP
        WXfc4pqsB+rzHH9681o5Kp/D8rqmKoSAfEFvs97UULXP66FtphZ0I3Hq6RhsECX25jD1y3TKWr1aY
        lyGixDvt6jM913leiyLRLYy667PvsQDGi2bPZnuVG0g3Qk20/qMhJAdDhUc5bligeE0bPItFzdYq3
        NbVRDT0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVXXc-002BRU-Pq; Mon, 14 Aug 2023 13:23:28 +0000
Date:   Mon, 14 Aug 2023 14:23:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        jlayton@kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iov_iter: Convert iterate*() to inline funcs
Message-ID: <ZNoq0PNpFM8l8vAe@casper.infradead.org>
References: <3710261.1691764329@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3710261.1691764329@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 11, 2023 at 03:32:09PM +0100, David Howells wrote:
> @@ -578,10 +683,11 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t byt
>  		kunmap_atomic(kaddr);
>  		return 0;
>  	}
> -	iterate_and_advance(i, bytes, base, len, off,
> -		copyin(p + off, base, len),
> -		memcpy_from_iter(i, p + off, base, len)
> -	)
> +
> +	bytes = iterate_and_advance(i, bytes, p,
> +				    copy_from_user_iter,
> +				    iov_iter_is_copy_mc(i) ?
> +				    memcpy_from_iter_mc : memcpy_from_iter);
>  	kunmap_atomic(kaddr);
>  	return bytes;
>  }

Please work against linux-next; this function is completely rewritten
there.
