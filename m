Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE22CEB64DD
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 13:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjGUNrc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 09:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGUNrc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 09:47:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03FC19B0
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 06:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689947207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fg+kb92yYWPyx50R1MjtqV3MSUwxSnk+PurOqG2WFyU=;
        b=A9v7F51KKKWgQqVk42e6hFOLOEr2xxcqUGm4uISlSkqCybRshB5MSYGYKMMopvYTORKQy0
        2i7soSNhlZMyxAGNcAvkbYHZzh5Mn9b6zTemaz8aze2iexmi/l3z62fybKg8f89XTf4gKh
        mkiSfQDuDCq3HRFYUZnhlDS3Akq/Fhg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-xrt63HV0Nq6RUfTGzW2C9g-1; Fri, 21 Jul 2023 09:46:43 -0400
X-MC-Unique: xrt63HV0Nq6RUfTGzW2C9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73C26858EED;
        Fri, 21 Jul 2023 13:46:43 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 60B141121314;
        Fri, 21 Jul 2023 13:46:43 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 6773930C0457; Fri, 21 Jul 2023 13:46:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 659EC3FB76;
        Fri, 21 Jul 2023 15:46:36 +0200 (CEST)
Date:   Fri, 21 Jul 2023 15:46:36 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Jens Axboe <axboe@kernel.dk>, Li Nan <linan666@huaweicloud.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 2/3] brd: enable discard
In-Reply-To: <ZLjJ6nU1YjlLD+Ay@infradead.org>
Message-ID: <e2277e5d-c9fe-b4a6-14fa-25926846aa4e@redhat.com>
References: <3fcf222-4894-992-ae81-c72ca983d82@redhat.com> <ZLjJ6nU1YjlLD+Ay@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Wed, 19 Jul 2023, Christoph Hellwig wrote:

> > +static void brd_free_page_rcu(struct rcu_head *head)
> > +{
> > +	struct page *page = container_of(head, struct page, rcu_head);
> > +	__free_page(page);
> 
> Nit: missing empty line here.  Although I see no point in the local
> variable anyay.
> 
> > +}
> > +
> > +static void brd_free_page(struct brd_device *brd, sector_t sector)
> > +{
> > +	struct page *page;
> > +	pgoff_t idx;
> > +
> > +	idx = sector >> PAGE_SECTORS_SHIFT;
> > +	page = xa_erase(&brd->brd_pages, idx);
> > +
> > +	if (page) {
> > +		BUG_ON(page->index != idx);
> > +		call_rcu(&page->rcu_head, brd_free_page_rcu);
> > +	}
> 
> Doing one call_rcu per page is horribly inefficient.  Please look into
> batching this up.
> 
> > +static bool discard = false;
> > +module_param(discard, bool, 0444);
> > +MODULE_PARM_DESC(discard, "Support discard");
> 
> Doing this as a global paramter that can't even be changed at run time
> does not feel very user friendly.

Hi

I addressed these issues and I'll send a new version.

Mikulas

