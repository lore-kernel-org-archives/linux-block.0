Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Tue, 26 Jul 2016 13:29:38 -0400
From: Theodore Ts'o <tytso@mit.edu>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Hugh Dickins <hughd@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCHv1, RFC 00/33] ext4: support of huge pages
Message-ID: <20160726172938.GA9284@thunk.org>
References: <1469493335-3622-1-git-send-email-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469493335-3622-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 26, 2016 at 03:35:02AM +0300, Kirill A. Shutemov wrote:
> Here's the first version of my patchset which intended to bring huge pages
> to ext4. It's not yet ready for applying or serious use, but good enough
> to show the approach.

Thanks.  The major issues I noticed when doing a quick scan of the
patches you've already mentioned here.  I'll try to take a closer look
in the next week or so when I have time.

One random question --- in the huge=always approach, how much
additional work would be needed to support file systems with a 64k
block size on a system with 4k pages?

					- Ted
