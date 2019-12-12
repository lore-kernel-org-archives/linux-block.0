Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8C8C43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 02:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C8B21655
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 02:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RYU3VrjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfLLCV4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:21:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44754 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfLLCV4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 21:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=57zdz9mrxIVUHQOhknZrQgy/UswdkJ3VTH/h3Vnf6SM=; b=RYU3VrjXW23DkSlr3BV5xCMqx
        0vg+jGF2kmZXc1b1pLgXeNc1QmxxzDCj96BAPefUN9G/8umS/psViUr0MEpsL0GhOjuS9PS6TQ/FM
        ifi3z7+Otr7DN9wwvZOsgwBtmJoFMjSQnKHChpWJzSdd19gi8k7hstqF/LlkpVX79gJ+Emr01SAXX
        8ThYyCPRiAqO8stqZyeVsxeXDKDVKForQpdoLzCooi+29uXYJqer7/BKQKF7CDhiUKRCg1VRiSxRu
        JWSktsAvb0Kit9Zd60BPbShI9OeTPecvBBd6mgoVD7HwTimV46K3PzNDJt0SdM/NNNFOxOjU3vzPS
        zZS9sbsWA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifE71-0004PK-6N; Thu, 12 Dec 2019 02:21:55 +0000
Date:   Wed, 11 Dec 2019 18:21:55 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
Message-ID: <20191212022155.GQ32169@bombadil.infradead.org>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
 <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
 <e7fc6b37-8106-4fe2-479c-05c3f2b1c1f1@kernel.dk>
 <00a5c8b7-215a-7615-156d-d8f3dbb1cd3a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a5c8b7-215a-7615-156d-d8f3dbb1cd3a@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 11, 2019 at 07:03:40PM -0700, Jens Axboe wrote:
> Tested and cleaned a bit, and added truncate protection through
> inode_dio_begin()/inode_dio_end().
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=buffered-uncached&id=6dac80bc340dabdcbfb4230b9331e52510acca87
> 
> This is much faster than the previous page cache dance, and I _think_
> we're ok as long as we block truncate and hole punching.

What about races between UNCACHED and regular buffered IO?  Seems like
we might end up sending overlapping writes to the device?
