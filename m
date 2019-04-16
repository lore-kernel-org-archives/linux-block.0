Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22B8C10F13
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 16:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB682087C
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 16:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbfDPQwI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:52:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:38848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729237AbfDPQwI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 12:52:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D821B077;
        Tue, 16 Apr 2019 16:52:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D663A1E15B4; Tue, 16 Apr 2019 18:52:06 +0200 (CEST)
Date:   Tue, 16 Apr 2019 18:52:06 +0200
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
Message-ID: <20190416165206.GC17148@quack2.suse.cz>
References: <20190411210834.4105-1-jglisse@redhat.com>
 <20190411210834.4105-11-jglisse@redhat.com>
 <20190415145952.GE13684@quack2.suse.cz>
 <20190416002203.GA3158@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416002203.GA3158@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 15-04-19 20:22:04, Jerome Glisse wrote:
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
> Thinking again on this, i can drop that patch and just add a new
> bio_add_page_from_gup() and then it would be much more obvious that
> only very few places need to use that new version and they are mostly
> obvious places. It is usualy GUP then right away add the pages to bio
> or bvec.

Yes, that's another option. Probably second preferred by me after my own
proposal ;)

> We can probably add documentation around GUP explaining that if you
> want to build a bio or bvec from GUP you must pay attention to which
> function you use.

Yes, although we both know how careful people are in reading
documentation...

> Also pages going in a bio are not necessarily written too, they can
> be use as source (writting to block) or as destination (reading from
> block). So having all of them with refcount bias as GUP would muddy
> the water somemore between pages we can no longer clean (ie GUPed)
> and those that are just being use in regular read or write operation.

Why would the difference matter here?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
