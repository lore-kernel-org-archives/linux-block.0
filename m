Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Fri, 10 Feb 2017 09:46:10 -0800
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
Subject: Re: [PATCHv6 13/37] mm: make write_cache_pages() work on huge pages
Message-ID: <20170210174610.GC2267@bombadil.infradead.org>
References: <20170126115819.58875-1-kirill.shutemov@linux.intel.com>
 <20170126115819.58875-14-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170126115819.58875-14-kirill.shutemov@linux.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Thu, Jan 26, 2017 at 02:57:55PM +0300, Kirill A. Shutemov wrote:
> We writeback whole huge page a time. Let's adjust iteration this way.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

I think a lot of the complexity in this patch is from pagevec_lookup_tag
giving you subpages rather than head pages...

> @@ -2268,7 +2273,8 @@ int write_cache_pages(struct address_space *mapping,
>  					 * not be suitable for data integrity
>  					 * writeout).
>  					 */
> -					done_index = page->index + 1;
> +					done_index = compound_head(page)->index
> +						+ hpage_nr_pages(page);
>  					done = 1;
>  					break;
>  				}

you'd still need this line, but it'd only be:

					done_index = page->index +
						(1 << compound_order(page));

I think we want:

#define	nr_pages(page)	(1 << compound_order(page))

because we seem to be repeating that idiom quite a lot in these patches.

					done_index = page->index +
								nr_pages(page);

Still doesn't quite fit on one line, but it's closer, and it's the
ridiculous indentation in that function that's the real problem.
