Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Mon, 9 May 2016 08:55:27 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"xfs@oss.sgi.com" <xfs@oss.sgi.com>,
	"linux-nvdimm@ml01.01.org" <linux-nvdimm@ml01.01.org>,
	"jmoyer@redhat.com" <jmoyer@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"axboe@fb.com" <axboe@fb.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"boaz@plexistor.com" <boaz@plexistor.com>,
	"Wilcox, Matthew R" <matthew.r.wilcox@intel.com>,
	"david@fromorbit.com" <david@fromorbit.com>,
	"jack@suse.cz" <jack@suse.cz>
Subject: Re: [PATCH v5 3/5] dax: use sb_issue_zerout instead of calling
 dax_clear_sectors
Message-ID: <20160509145527.GA31079@linux.intel.com>
References: <1462571591-3361-1-git-send-email-vishal.l.verma@intel.com>
 <1462571591-3361-4-git-send-email-vishal.l.verma@intel.com>
 <20160508085203.GA10160@infradead.org>
 <1462733173.3006.7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1462733173.3006.7.camel@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Sun, May 08, 2016 at 06:46:13PM +0000, Verma, Vishal L wrote:
> On Sun, 2016-05-08 at 01:52 -0700, Christoph Hellwig wrote:
> > On Fri, May 06, 2016 at 03:53:09PM -0600, Vishal Verma wrote:
> > > 
> > > From: Matthew Wilcox <matthew.r.wilcox@intel.com>
> > > 
> > > dax_clear_sectors() cannot handle poisoned blocks.��These must be
> > > zeroed using the BIO interface instead.��Convert ext2 and XFS to
> > > use
> > > only sb_issue_zerout().
> > > 
> > > Signed-off-by: Matthew Wilcox <matthew.r.wilcox@intel.com>
> > > [vishal: Also remove the dax_clear_sectors function entirely]
> > > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > Just to make sure:��the existing sb_issue_zerout as in 4.6-rc
> > is already doing the right thing for DAX?��I've got a pending
> > patchset
> > for XFS that introduces another dax_clear_sectors users, but if it's
> > already safe to use blkdev_issue_zeroout I can switch to that and
> > avoid
> > the merge conflict.
> 
> I believe so - Jan has moved all unwritten extent conversions out of
> DAX with his patch set, and I believe zeroing through the driver is
> always fine. Ross or Jan could confirm though.�

Yep, I believe that the existing sb_issue_zeroout() as of v4.6-rc* does the
right thing.  We'll end up calling sb_issue_zeroout() => blkdev_issue_zeroout()
=> __blkdev_issue_zeroout() because we don't have support for discard or
write_same in PMEM.  This will send zero page BIOs to the PMEM driver, which
will do the zeroing as normal writes.
