Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751095AbcJMNeE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Oct 2016 09:34:04 -0400
Date: Thu, 13 Oct 2016 15:18:02 +0200
From: Jan Kara <jack@suse.cz>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCHv3 17/41] filemap: handle huge pages in
 filemap_fdatawait_range()
Message-ID: <20161013131802.GC27186@quack2.suse.cz>
References: <20160915115523.29737-1-kirill.shutemov@linux.intel.com>
 <20160915115523.29737-18-kirill.shutemov@linux.intel.com>
 <20161013094441.GC26241@quack2.suse.cz>
 <20161013120844.GA2906@node>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161013120844.GA2906@node>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu 13-10-16 15:08:44, Kirill A. Shutemov wrote:
> On Thu, Oct 13, 2016 at 11:44:41AM +0200, Jan Kara wrote:
> > On Thu 15-09-16 14:54:59, Kirill A. Shutemov wrote:
> > > We writeback whole huge page a time.
> > 
> > This is one of the things I don't understand. Firstly I didn't see where
> > changes of writeback like this would happen (maybe they come later).
> > Secondly I'm not sure why e.g. writeback should behave atomically wrt huge
> > pages. Is this because radix-tree multiorder entry tracks dirtiness for us
> > at that granularity?
> 
> We track dirty/writeback on per-compound pages: meaning we have one
> dirty/writeback flag for whole compound page, not on every individual
> 4k subpage. The same story for radix-tree tags.
> 
> > BTW, can you also explain why do we need multiorder entries? What do
> > they solve for us?
> 
> It helps us having coherent view on tags in radix-tree: no matter which
> index we refer from the range huge page covers we will get the same
> answer on which tags set.

OK, understand that. But why do we need a coherent view? For which purposes
exactly do we care that it is not just a bunch of 4k pages that happen to
be physically contiguous and thus can be mapped in one PMD?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
