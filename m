Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB80C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35194222C4
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NcEGA0Ek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLKUnw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:43:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLKUnw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 15:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6vrmgfi+4nbdOkVEhxkfkbfonRvSVMuVgBeRSgTCURI=; b=NcEGA0EkSkv9urc5oY45erA5Z
        kXMIkX3ZMDeFK8SWl9RakM896GU6zgqje8VCLvgL5UJGrzzEr41Qo1pjfNiqQsyziQ2Dk9hJ+5lE+
        QIgQkDtzXTe7pXcKDDRyhb07+79di9ZGqv/adl8bpbOrU+YrVDloSW8xdbTdhm9i4dG2m6IW83Ba6
        ybYDR4rrxzAkdx6chLYkVLYLqCqdwW309zN3WiWY+N09/Nfa6s7vSYsVbU6bZc9YhRoUtYp/CC3AX
        eSgWkApm5FVsSIPQrdYEd61PvbDxXpHygQNjynxLQpBIBGpG4m/uvjY0LDDx5eAH9h1WgzKXKfQ3N
        xfRTG8YiA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if8pp-0005Dn-Py; Wed, 11 Dec 2019 20:43:49 +0000
Date:   Wed, 11 Dec 2019 12:43:49 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
Message-ID: <20191211204349.GO32169@bombadil.infradead.org>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
 <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 11, 2019 at 01:08:32PM -0700, Jens Axboe wrote:
> > The fact that you see that xas_create() so prominently would imply
> > perhaps add_to_swap_cache(), which certainly implies that the page
> > shrinking isn't hitting the file pages...
> 
> That's presumably misleading, as it's just lookups. But yes,
> confusing...

While xas_create() could be called directly, it's more often called
through xas_store() ... which would be called if we're storing a shadow
entry to replace a page, which this workload would presumably be doing.
