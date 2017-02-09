Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Thu, 9 Feb 2017 15:34:36 -0800
From: Matthew Wilcox <willy@infradead.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCHv6 11/37] HACK: readahead: alloc huge pages, if allowed
Message-ID: <20170209233436.GZ2267@bombadil.infradead.org>
References: <20170126115819.58875-1-kirill.shutemov@linux.intel.com>
 <20170126115819.58875-12-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170126115819.58875-12-kirill.shutemov@linux.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Thu, Jan 26, 2017 at 02:57:53PM +0300, Kirill A. Shutemov wrote:
> Most page cache allocation happens via readahead (sync or async), so if
> we want to have significant number of huge pages in page cache we need
> to find a ways to allocate them from readahead.
> 
> Unfortunately, huge pages doesn't fit into current readahead design:
> 128 max readahead window, assumption on page size, PageReadahead() to
> track hit/miss.
> 
> I haven't found a ways to get it right yet.
> 
> This patch just allocates huge page if allowed, but doesn't really
> provide any readahead if huge page is allocated. We read out 2M a time
> and I would expect spikes in latancy without readahead.
> 
> Therefore HACK.
> 
> Having that said, I don't think it should prevent huge page support to
> be applied. Future will show if lacking readahead is a big deal with
> huge pages in page cache.
> 
> Any suggestions are welcome.

Well ... what if we made readahead 2 hugepages in size for inodes which
are using huge pages?  That's only 8x our current readahead window, and
if you're asking for hugepages, you're accepting that IOs are going to
be larger, and you probably have the kind of storage system which can
handle doing larger IOs.
