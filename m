Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:44580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935659AbeFMOnL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jun 2018 10:43:11 -0400
Date: Wed, 13 Jun 2018 07:42:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 00/30] block: support multipage bvec
Message-ID: <20180613144253.GA4693@infradead.org>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180611164806.GA7452@infradead.org>
 <20180612034242.GC26412@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180612034242.GC26412@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 12, 2018 at 11:42:49AM +0800, Ming Lei wrote:
> On Mon, Jun 11, 2018 at 09:48:06AM -0700, Christoph Hellwig wrote:
> > І think the new naming scheme in this series is a nightmare.  It
> > confuses the heck out of me, and that is despite knowing many bits of
> > the block layer inside out, and reviewing previous series.
> 
> In V5, there isn't such issue, since bio_for_each_segment* is renamed
> into bio_for_each_page* first before doing the change.

But now we are at V6 where that isn't the case..

> Seems Jens isn't fine with the big renaming, then I follow the suggestion
> of taking 'chunk' for representing multipage bvec in V6.

Please don't use chunk.  We are iterating over bio_vec structures, while
we have the concept of a chunk size for something else in the block layer,
so this just creates confusion.  Nevermind names like
bio_for_each_chunk_segment_all which just double the confusion.

So assuming that bio_for_each_segment is set to stay as-is for now,
here is a proposal for sanity by using the vec name.

OLD:	    bio_for_each_segment
NEW(page):  bio_for_each_segment, to be renamed bio_for_each_page later
NEW(bvec):  bio_for_each_bvec

OLD:	    __bio_for_each_segment
NEW(page):  __bio_for_each_segment, to be renamed __bio_for_each_page later
NEW(bvec):  (no bvec version needed)

OLD:	    bio_for_each_segment_all
NEW(page):  bio_for_each_page_all (needs updated prototype anyway)
NEW(bvec):  (no bvec version needed once bcache is fixed up)	
