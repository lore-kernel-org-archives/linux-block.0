Return-Path: <SRS0=3Les=W5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594EBC3A59B
	for <linux-block@archiver.kernel.org>; Mon,  2 Sep 2019 08:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359A32168B
	for <linux-block@archiver.kernel.org>; Mon,  2 Sep 2019 08:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfIBIiR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:38:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:34852 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729408AbfIBIiR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Sep 2019 04:38:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD795B7A8;
        Mon,  2 Sep 2019 08:38:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 011111E406C; Mon,  2 Sep 2019 10:38:12 +0200 (CEST)
Date:   Mon, 2 Sep 2019 10:38:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH block/for-next] writeback: add tracepoints for cgroup
 foreign writebacks
Message-ID: <20190902083812.GA14207@quack2.suse.cz>
References: <20190829224701.GX2263813@devbig004.ftw2.facebook.com>
 <20190830154023.GC25069@quack2.suse.cz>
 <20190830154921.GZ2263813@devbig004.ftw2.facebook.com>
 <20190830164211.GD25069@quack2.suse.cz>
 <20190830170903.GB2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830170903.GB2263813@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Tejun,

On Fri 30-08-19 10:09:03, Tejun Heo wrote:
> On Fri, Aug 30, 2019 at 06:42:11PM +0200, Jan Kara wrote:
> > Well, but if you look at __set_page_dirty_nobuffers() it is careful. It
> > does:
> > 
> > struct address_space *mapping = page_mapping(page);
> > 
> > if (!mapping) {
> > 	bail
> > }
> > ... use mapping
> > 
> > Exactly because page->mapping can become NULL under your hands if you don't
> > hold page lock. So I think you either need something similar in your
> > tracepoint or handle this in the caller.
> 
> So, account_page_dirtied() is called from two places.
> 
> __set_page_dirty() and __set_page_dirty_nobuffers().  The following is
> from the latter.
> 
> 	lock_page_memcg(page);
> 	if (!TestSetPageDirty(page)) {
> 		struct address_space *mapping = page_mapping(page);
> 		...
> 
> 		if (!mapping) {
> 			unlock_page_memcg(page);
> 			return 1;
> 		}
> 
> 		xa_lock_irqsave(&mapping->i_pages, flags);
> 		BUG_ON(page_mapping(page) != mapping);
> 		WARN_ON_ONCE(!PagePrivate(page) && !PageUptodate(page));
> 		account_page_dirtied(page, mapping);
> 		...
> 
> If I'm reading it right, it's saying that at this point if mapping
> exists after setting page dirty, it must not change while locking
> i_pages.

Correct __set_page_dirty_nobuffers() is supposed to be called serialized
with truncation either through page lock or other means. At least the
comment says so and the code looks like that.

> 
> __set_page_dirty_nobuffers() is more brief but seems to be making the
> same assumption.

I suppose you mean __set_page_dirty() here.

> 	xa_lock_irqsave(&mapping->i_pages, flags);
> 	if (page->mapping) {	/* Race with truncate? */
> 		WARN_ON_ONCE(warn && !PageUptodate(page));
> 		account_page_dirtied(page, mapping);
> 		__xa_set_mark(&mapping->i_pages, page_index(page),
> 				PAGECACHE_TAG_DIRTY);
> 	}
> 	xa_unlock_irqrestore(&mapping->i_pages, flags);
> 
> Both are clearly assuming that once i_pages is locked, mapping can't
> change.  So, inside account_page_dirtied(), mapping clearly can't
> change.  The TP in question - track_foreign_dirty - is invoked from
> mem_cgroup_track_foreign_dirty() which is only called from
> account_page_dirty(), so I'm failing to see how mapping would change
> there.

I'm not sure where we depend here on page->mapping not getting cleared. The
point is even if page->mapping is getting cleared while we work on the
page, we have 'mapping' stored locally so we just account everything
against the original mapping. 

I've researched this a bit more and commit 2d6d7f982846 "mm: protect
set_page_dirty() from ongoing truncation" introduced the idea that
__set_page_dirty_nobuffers() should be only called synchronized with
truncation. Now I know for a fact that this is not always the case (e.g.
various RDMA drivers calling set_page_dirty() without a lock or any other
protection against truncate) but let's consider this a bug in the caller of
set_page_dirty(). So in the end I agree that you're fine with relying on
page_mapping() not changing under you.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
