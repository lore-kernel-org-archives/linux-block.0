Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EFBC6FD1D
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 15:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjCQPcO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjCQPcJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 11:32:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F6461A84;
        Fri, 17 Mar 2023 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=inUvHEu4HUOp2iy8ZcRjHwFFv7P6+MbAHF55eOD5Mdw=; b=eIu8cVVErxdUVQNrKy4EFwDue/
        RJ0stM0TyUWl3VnVLFZYeOvuOTwJ2udGzfFYdyBTVKHhNKVK3VUUJ9izcE+n1jzCKOI/OyC/hbtl4
        pEzeWP1fDuv16Nh3tjqz7wfZDBzAamimQM6/6ar6GVSIC0hPeKTQjlIEnwPS7f4OSrgTpHE++8FlP
        sLbqg6taQ64TtHMZPTdjIDzRCuLAZnbC3jfhWveMaoQD1r3kPvtYOrRS7XJg3PGvrSVexghCtAKXO
        U/HqBzlSgYAz68iJFK6bhwPOrd85yzZxGvJxAq/+c5NlE7oLGtqw8yNKS+M4tzox1RZJZsPiarZoa
        qKVFIlnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pdC3d-00Fzmq-V3; Fri, 17 Mar 2023 15:31:54 +0000
Date:   Fri, 17 Mar 2023 15:31:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Christoph Hellwig <hch@infradead.org>, hubcap@omnibond.com,
        senozhatsky@chromium.org, martin@omnibond.com, minchan@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, axboe@kernel.dk,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, gost.dev@samsung.com, mcgrof@kernel.org,
        devel@lists.orangefs.org
Subject: Re: [RFC PATCH 1/3] filemap: convert page_endio to folio_endio
Message-ID: <ZBSH6Uq6IIXON/rh@casper.infradead.org>
References: <20230315123233.121593-1-p.raghav@samsung.com>
 <CGME20230315123234eucas1p2503d83ad0180cecde02e924d7b143535@eucas1p2.samsung.com>
 <20230315123233.121593-2-p.raghav@samsung.com>
 <ZBHcl8Pz2ULb4RGD@infradead.org>
 <d6cde35e-359a-e837-d2e0-f2bd362f2c3e@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6cde35e-359a-e837-d2e0-f2bd362f2c3e@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 16, 2023 at 11:04:54AM +0100, Pankaj Raghav wrote:
> -       /* clean up. */
> -       while ((page = readahead_page(rac))) {
> -               page_endio(page, false, ret);
> -               put_page(page);
> +               while ((folio = readahead_folio(rac))) {
> +                       folio_clear_uptodate(folio);
> +                       folio_set_error(folio);
> +                       folio_unlock(folio);
> +               }
> +               return;
> +       }
> +
> +       while ((folio = readahead_folio(rac))) {
> +               folio_mark_uptodate(folio);
> +               folio_unlock(folio);
>         }

readahead_folio() is a bit too heavy-weight for that, IMO.  I'd do this
as;

	while ((folio = readahead_folio(rac))) {
		if (!ret)
			folio_mark_uptodate(folio);
		folio_unlock(folio);
	}

(there's no need to call folio_set_error(), nor folio_clear_uptodate())
