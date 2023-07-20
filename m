Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B52EB64DA
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 05:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGTFrT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 01:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjGTFrF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 01:47:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC2730D7
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 22:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YVOpWW5ereww6heLbtQTazT6W0zL2YV+OIVG2yGU5AA=; b=zZ3rbakHaN/cMXdYWFVN9lxveb
        UmRAm1mHG/7WHbZ+TrN3I0PxIvbu9yYD63dDKKa6TA7mc0iEcuan7aXGHrG5EFJoVAsn43w0+UTLL
        S2FCd20PyZTeYqsyP75DmCwOKsTSvWL6BIfQfTtQChWKtMqLKCzyzFF/FLHWUgBB8gc97jt1jY6tC
        r7fgHVxobX11dOGc4tMZaBk6+0LNLlI5fyoQ1HJgsXjFR2gXG09q5ds5LHgcTPhKgUi+PFWh6JWoN
        QM8HWK3LMWPAKkL2fZuiaTMRPapWDUkYM1MmXz5bO8i3y1hIc7hDOuNwqWXLgVeYB9Ag0nQdJTkjd
        A2gvY+Hw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qMMTS-009qv7-1o;
        Thu, 20 Jul 2023 05:45:14 +0000
Date:   Wed, 19 Jul 2023 22:45:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Li Nan <linan666@huaweicloud.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 2/3] brd: enable discard
Message-ID: <ZLjJ6nU1YjlLD+Ay@infradead.org>
References: <3fcf222-4894-992-ae81-c72ca983d82@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fcf222-4894-992-ae81-c72ca983d82@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static void brd_free_page_rcu(struct rcu_head *head)
> +{
> +	struct page *page = container_of(head, struct page, rcu_head);
> +	__free_page(page);

Nit: missing empty line here.  Although I see no point in the local
variable anyay.

> +}
> +
> +static void brd_free_page(struct brd_device *brd, sector_t sector)
> +{
> +	struct page *page;
> +	pgoff_t idx;
> +
> +	idx = sector >> PAGE_SECTORS_SHIFT;
> +	page = xa_erase(&brd->brd_pages, idx);
> +
> +	if (page) {
> +		BUG_ON(page->index != idx);
> +		call_rcu(&page->rcu_head, brd_free_page_rcu);
> +	}

Doing one call_rcu per page is horribly inefficient.  Please look into
batching this up.

> +static bool discard = false;
> +module_param(discard, bool, 0444);
> +MODULE_PARM_DESC(discard, "Support discard");

Doing this as a global paramter that can't even be changed at run time
does not feel very user friendly.
