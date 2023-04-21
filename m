Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600B8C77B76
	for <linux-block@archiver.kernel.org>; Fri, 21 Apr 2023 22:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjDUWrL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Apr 2023 18:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjDUWrK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2023 18:47:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6C91FF1;
        Fri, 21 Apr 2023 15:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VcM5hqe8ohQj2y6ERa1ukw3ufFJS21Hh1hq4I+TYzSo=; b=rgNlBrbBZQE/jPeLix+D0ilI0Q
        71kmRlZ2+T7aKhtBX4TmXZ0BiGQZ6bWSHN2OzBeUMgbJLMrI7CQn70w0LvkZZGKGUJujkqTXWkWCn
        Uh6eKQlha9lwPIMZE0f1gWoEFMdo8DN/1Pxf71MEA3Z2VCdB/1uMtYEpQ0H1m50J90mZqXPHNOXGx
        bSzD0JUSBjwZItHuHF9/l21almvKizFj2XpMdsw1wY4wRNpKrGeRSwNNW62/pJmU8cPHf8nq6R41+
        wt8Sfq2bTDEup+WZg0StBdVV64q8kbX2jTs0APsYWtyNZY/6fadEMw2ddReaCFvGP6+6ykleJrobe
        Sok4SDkw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ppzWs-00FiFo-Cm; Fri, 21 Apr 2023 22:46:58 +0000
Date:   Fri, 21 Apr 2023 23:46:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, brauner@kernel.org,
        djwong@kernel.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, hare@suse.de, kbusch@kernel.org,
        patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/8] shmem: account for high order folios
Message-ID: <ZEMSYtF3np7W6bIX@casper.infradead.org>
References: <20230421214400.2836131-1-mcgrof@kernel.org>
 <20230421214400.2836131-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421214400.2836131-4-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 21, 2023 at 02:43:55PM -0700, Luis Chamberlain wrote:
> -		if (xa_is_value(page))
> -			swapped++;
> +		if (xa_is_value(folio))
> +			swapped+=(folio_nr_pages(folio));

			swapped += folio_nr_pages(folio);

>  			if (xa_is_value(folio)) {
> +				long swaps_freed = 0;
>  				if (unfalloc)
>  					continue;
> -				nr_swaps_freed += !shmem_free_swap(mapping,
> -							indices[i], folio);
> +				swaps_freed = folio_nr_pages(folio);

Why initialise it to 0 when you're about to set it to folio_nr_pages()?

> +				if (!shmem_free_swap(mapping, indices[i], folio)) {
> +					if (swaps_freed > 1)
> +						pr_warn("swaps freed > 1 -- %lu\n", swaps_freed);

Debug code that escaped into this patch?

> -		info->swapped++;
> +		info->swapped+=folio_nr_pages(folio);

Same comment as earlier.

> -	info->alloced--;
> -	info->swapped--;
> +	info->alloced-=num_swap_pages;
> +	info->swapped-=num_swap_pages;

Spacing

> -	info->swapped--;
> +	info->swapped-= folio_nr_pages(folio);

Spacing.

