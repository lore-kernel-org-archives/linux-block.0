Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC13C10F13
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 16:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37FF217D7
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 16:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfDPQrB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:47:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:37732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726647AbfDPQrB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 12:47:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3126AAAC3;
        Tue, 16 Apr 2019 16:46:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A0DBB1E15B4; Tue, 16 Apr 2019 18:46:58 +0200 (CEST)
Date:   Tue, 16 Apr 2019 18:46:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v1 10/15] block: add gup flag to
 bio_add_page()/bio_add_pc_page()/__bio_add_page()
Message-ID: <20190416164658.GB17148@quack2.suse.cz>
References: <20190411210834.4105-1-jglisse@redhat.com>
 <20190411210834.4105-11-jglisse@redhat.com>
 <20190415145952.GE13684@quack2.suse.cz>
 <20190415152433.GB3436@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190415152433.GB3436@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 15-04-19 11:24:33, Jerome Glisse wrote:
> On Mon, Apr 15, 2019 at 04:59:52PM +0200, Jan Kara wrote:
> > Hi Jerome!
> > 
> > On Thu 11-04-19 17:08:29, jglisse@redhat.com wrote:
> > > From: Jérôme Glisse <jglisse@redhat.com>
> > > 
> > > We want to keep track of how we got a reference on page added to bio_vec
> > > ie wether the page was reference through GUP (get_user_page*) or not. So
> > > add a flag to bio_add_page()/bio_add_pc_page()/__bio_add_page() to that
> > > effect.
> > 
> > Thanks for writing this patch set! Looking through patches like this one,
> > I'm a bit concerned. With so many bio_add_page() callers it's difficult to
> > get things right and not regress in the future. I'm wondering whether the
> > things won't be less error-prone if we required that all page reference
> > from bio are gup-like (not necessarily taken by GUP, if creator of the bio
> > gets to struct page he needs via some other means (e.g. page cache lookup),
> > he could just use get_gup_pin() helper we'd provide).  After all, a page
> > reference in bio means that the page is pinned for the duration of IO and
> > can be DMAed to/from so it even makes some sense to track the reference
> > like that. Then bio_put() would just unconditionally do put_user_page() and
> > we won't have to propagate the information in the bio.
> > 
> > Do you think this would be workable and easier?
> 
> It might be workable but i am not sure it is any simpler. bio_add_page*()
> does not take page reference it is up to the caller to take the proper
> page reference so the complexity would be push there (just in a different
> place) so i don't think it would be any simpler. This means that we would
> have to update more code than this patchset does.

I agree that the amount of work in this patch set is about the same
(although you don't have to pass the information about reference type in
the biovec so you save the complexities there). But for the future the
rule that "bio references must be gup-pins" is IMO easier to grasp for
developers and you can reasonably assert it in bio_add_page().

> This present patch is just a coccinelle semantic patch and even if it
> is scary to see that many call site, they are not that many that need
> to worry about the GUP parameter and they all are in patch 11, 12, 13
> and 14.
> 
> So i believe this patchset is simpler than converting everyone to take
> a GUP like page reference. Also doing so means we loose the information
> about GUP kind of defeat the purpose. So i believe it would be better
> to limit special reference to GUP only pages.

So what's the difference whether the page reference has been acquired via
GUP or via some other means? I don't think that really matters. If say
infiniband introduced new ioctl() that takes file descriptor, offset, and
length and just takes pages from page cache and attaches them to their RDMA
scatter-gather lists, then they'd need to use 'pin' references anyway...

Then why do we work on differentiating between GUP pins and other page
references?  Because it matters what the reference is going to be used for
and what is it's lifetime. And generally GUP references are used to do IO
to/from page and may even be controlled by userspace so that's why we need
to make them different. But in principle the 'gup-pin' reference is not about
the fact that the reference has been obtained from GUP but about the fact
that it is used to do IO. Hence I think that the rule "bio references must
be gup-pins" makes some sense.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
