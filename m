Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A45C433F5
	for <linux-block@archiver.kernel.org>; Thu, 31 Mar 2022 05:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiCaFR0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 01:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiCaFRW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 01:17:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3575583B6;
        Wed, 30 Mar 2022 22:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ANbvzWQvNfeYGzbiD6/wAHprXWq1t02+UVc9tNIiwuE=; b=GBcRpXtrNAx16DMpK/U8n2u2M6
        AQdUlOHOggVT3wpCHBTXFRuoAGvKRODSIznxL+Rk7nghPzyDcx0YT9jb+iYraZ4/lwq3OkRPI74V2
        uHfsJdtR1vCqHcxQvHh3puTDNtUNgmUfWEpdsRQsDS1s8L1Us7H5PHtPVsqBaa7167TDKGmEhRY2R
        ICJ2D4GnQaBnF//FX8TXXQCQkM2dGsTILllaumqImHph7s7e4hIlQcY7KZN05zgh9iNt2swXKcq/O
        +U9oFtK8QQAzP2ECMvuUYFYCtHmZcXjVvOgf2/51Z1RABS5ylPmjt2eL3h0godRT3V4+XBQhJ2c8N
        kV4GZV0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZn9g-000gCh-LL; Thu, 31 Mar 2022 05:15:32 +0000
Date:   Wed, 30 Mar 2022 22:15:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Christoph Hellwig <hch@infradead.org>, CGEL <cgel.zte@gmail.com>,
        axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] block/psi: make PSI annotations of submit_bio only work
 for file pages
Message-ID: <YkU49BQ4rPheOG0f@infradead.org>
References: <YjiMsGoXoDU+FwsS@cmpxchg.org>
 <623938d1.1c69fb81.52716.030f@mx.google.com>
 <YjnO3p6vvAjeMCFC@cmpxchg.org>
 <20220323061058.GA2343452@cgel.zte@gmail.com>
 <62441603.1c69fb81.4b06b.5a29@mx.google.com>
 <YkRUfuT3jGcqSw1Q@cmpxchg.org>
 <YkRVSIG6QKfDK/ES@infradead.org>
 <YkR7NPFIQ9h2AK9h@cmpxchg.org>
 <YkR9IW1scr2EDBpa@infradead.org>
 <YkSChWxuBzEB3Fqn@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkSChWxuBzEB3Fqn@cmpxchg.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 30, 2022 at 12:17:09PM -0400, Johannes Weiner wrote:
> It's add_to_page_cache_lru() that sets the flag.
> 
> Basically, when a PageWorkingset (hot) page gets reclaimed, the bit is
> stored in the vacated tree slot. When the entry is brought back in,
> add_to_page_cache_lru() transfers it to the newly allocated page.

Ok.  In this case my patch didn't quite do the right thing for readahead
either.  But that does leave a question for the btrfs compressed
case, which only adds extra pages to a read to readahad a bigger
cluster size - that is these pages are not read at the request of the
VM.  Does it really make sense to do PSI accounting for them in that
case?
