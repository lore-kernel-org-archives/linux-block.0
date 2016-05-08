Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Sun, 8 May 2016 01:52:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-nvdimm@ml01.01.org,
	Matthew Wilcox <matthew.r.wilcox@intel.com>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	xfs@oss.sgi.com, linux-ext4@vger.kernel.org, linux-mm@kvack.org,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Moyer <jmoyer@redhat.com>,
	Boaz Harrosh <boaz@plexistor.com>
Subject: Re: [PATCH v5 3/5] dax: use sb_issue_zerout instead of calling
 dax_clear_sectors
Message-ID: <20160508085203.GA10160@infradead.org>
References: <1462571591-3361-1-git-send-email-vishal.l.verma@intel.com>
 <1462571591-3361-4-git-send-email-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462571591-3361-4-git-send-email-vishal.l.verma@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri, May 06, 2016 at 03:53:09PM -0600, Vishal Verma wrote:
> From: Matthew Wilcox <matthew.r.wilcox@intel.com>
> 
> dax_clear_sectors() cannot handle poisoned blocks.  These must be
> zeroed using the BIO interface instead.  Convert ext2 and XFS to use
> only sb_issue_zerout().
> 
> Signed-off-by: Matthew Wilcox <matthew.r.wilcox@intel.com>
> [vishal: Also remove the dax_clear_sectors function entirely]
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Just to make sure:  the existing sb_issue_zerout as in 4.6-rc
is already doing the right thing for DAX?  I've got a pending patchset
for XFS that introduces another dax_clear_sectors users, but if it's
already safe to use blkdev_issue_zeroout I can switch to that and avoid
the merge conflict.
