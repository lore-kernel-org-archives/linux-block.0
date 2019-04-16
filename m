Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01521C10F14
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 17:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE39520872
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 17:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfDPRHa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:07:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfDPRH3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 13:07:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F60F88317;
        Tue, 16 Apr 2019 17:07:29 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0B2419C71;
        Tue, 16 Apr 2019 17:07:25 +0000 (UTC)
Date:   Tue, 16 Apr 2019 13:07:24 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <20190416170723.GC3254@redhat.com>
References: <20190411210834.4105-1-jglisse@redhat.com>
 <20190411210834.4105-11-jglisse@redhat.com>
 <20190415145952.GE13684@quack2.suse.cz>
 <20190415152433.GB3436@redhat.com>
 <20190416164658.GB17148@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416164658.GB17148@quack2.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 16 Apr 2019 17:07:29 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 16, 2019 at 06:46:58PM +0200, Jan Kara wrote:
> On Mon 15-04-19 11:24:33, Jerome Glisse wrote:
> > On Mon, Apr 15, 2019 at 04:59:52PM +0200, Jan Kara wrote:
> > > Hi Jerome!
> > > 
> > > On Thu 11-04-19 17:08:29, jglisse@redhat.com wrote:
> > > > From: Jérôme Glisse <jglisse@redhat.com>
> > > > 
> > > > We want to keep track of how we got a reference on page added to bio_vec
> > > > ie wether the page was reference through GUP (get_user_page*) or not. So
> > > > add a flag to bio_add_page()/bio_add_pc_page()/__bio_add_page() to that
> > > > effect.
> > > 
> > > Thanks for writing this patch set! Looking through patches like this one,
> > > I'm a bit concerned. With so many bio_add_page() callers it's difficult to
> > > get things right and not regress in the future. I'm wondering whether the
> > > things won't be less error-prone if we required that all page reference
> > > from bio are gup-like (not necessarily taken by GUP, if creator of the bio
> > > gets to struct page he needs via some other means (e.g. page cache lookup),
> > > he could just use get_gup_pin() helper we'd provide).  After all, a page
> > > reference in bio means that the page is pinned for the duration of IO and
> > > can be DMAed to/from so it even makes some sense to track the reference
> > > like that. Then bio_put() would just unconditionally do put_user_page() and
> > > we won't have to propagate the information in the bio.
> > > 
> > > Do you think this would be workable and easier?
> > 
> > It might be workable but i am not sure it is any simpler. bio_add_page*()
> > does not take page reference it is up to the caller to take the proper
> > page reference so the complexity would be push there (just in a different
> > place) so i don't think it would be any simpler. This means that we would
> > have to update more code than this patchset does.
> 
> I agree that the amount of work in this patch set is about the same
> (although you don't have to pass the information about reference type in
> the biovec so you save the complexities there). But for the future the
> rule that "bio references must be gup-pins" is IMO easier to grasp for
> developers and you can reasonably assert it in bio_add_page().
> 
> > This present patch is just a coccinelle semantic patch and even if it
> > is scary to see that many call site, they are not that many that need
> > to worry about the GUP parameter and they all are in patch 11, 12, 13
> > and 14.
> > 
> > So i believe this patchset is simpler than converting everyone to take
> > a GUP like page reference. Also doing so means we loose the information
> > about GUP kind of defeat the purpose. So i believe it would be better
> > to limit special reference to GUP only pages.
> 
> So what's the difference whether the page reference has been acquired via
> GUP or via some other means? I don't think that really matters. If say
> infiniband introduced new ioctl() that takes file descriptor, offset, and
> length and just takes pages from page cache and attaches them to their RDMA
> scatter-gather lists, then they'd need to use 'pin' references anyway...
> 
> Then why do we work on differentiating between GUP pins and other page
> references?  Because it matters what the reference is going to be used for
> and what is it's lifetime. And generally GUP references are used to do IO
> to/from page and may even be controlled by userspace so that's why we need
> to make them different. But in principle the 'gup-pin' reference is not about
> the fact that the reference has been obtained from GUP but about the fact
> that it is used to do IO. Hence I think that the rule "bio references must
> be gup-pins" makes some sense.

It will break things like page protection i am working on (KSM for file
back page). Pages can go through bio for mundane reasons (crypto, network,
gpu, ...) that have nothing to do with I/O for fs and do not have to block
any of the fs operation. If we GUP bias all those pages then we will
effectively make the situation worse in that pages will have a high likely-
hood to always look GUPed while it is just going through some bio for one
of those mundane reasons (and page is not being written to just use as
a source).

I understand why conceptualy it looks appealing but we would be loosing
information here. I really want to be able to determine if a page is GUPed
or not. If we GUP bias everyone in bio then we loose that.

Also i want to point out that the complexity of biasing all page in bio
are much bigger than this patchset it will require changes to all call
site of bio_add_page*() at very least.

Cheers,
Jérôme
