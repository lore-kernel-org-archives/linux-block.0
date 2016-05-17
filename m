Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:17941 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752466AbcEQW6q (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 17 May 2016 18:58:46 -0400
Date: Wed, 18 May 2016 08:58:42 +1000
From: Dave Chinner <david@fromorbit.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Jeff Moyer <jmoyer@redhat.com>,
	Stephen Bates <stephen.bates@microsemi.com>,
	Keith Busch <keith.busch@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH] block: Fix S_DAX inode flag locking
Message-ID: <20160517225842.GA21200@dastard>
References: <1463509797-10324-1-git-send-email-jonathan.derrick@intel.com>
 <1463509797-10324-2-git-send-email-jonathan.derrick@intel.com>
 <CAPcyv4hX2prAxpk9npM2mUGsSQ7Myjig-JfUfeXUANAzrcgTEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPcyv4hX2prAxpk9npM2mUGsSQ7Myjig-JfUfeXUANAzrcgTEQ@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 17, 2016 at 12:34:57PM -0700, Dan Williams wrote:
> On Tue, May 17, 2016 at 11:29 AM, Jon Derrick
> <jonathan.derrick@intel.com> wrote:
> > This patch fixes S_DAX bd_inode i_flag locking to conform to suggested
> 
> A "fix" implies that its currently broken.  I don't see how it is, not
> until we add an ioctl method or other path that also tries to update
> the flags outside of blkdev_get() context.  So, I don't think this
> patch stands on its own if you were intending it to be merged
> separately.
> 
> > locking rules. It is presumed that S_DAX is the only valid inode flag
> > for a block device which subscribes to direct-access, and will restore
> > any previously set flags if direct-access initialization fails.
> >
> > This reverts to i_flags behavior prior to
> > bbab37ddc20bae4709bca8745c128c4f46fe63c5
> > by allowing other bd_inode flags when DAX is disabled
> >
> > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > ---
> >  fs/block_dev.c | 31 ++++++++++++++++++++++++++-----
> >  1 file changed, 26 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > index 20a2c02..d41e37f 100644
> > --- a/fs/block_dev.c
> > +++ b/fs/block_dev.c
> > @@ -1159,6 +1159,20 @@ void bd_set_size(struct block_device *bdev, loff_t size)
> >  }
> >  EXPORT_SYMBOL(bd_set_size);
> >
> > +static void bd_add_dax(struct inode *inode)
> > +{
> > +       inode_lock(inode);
> > +       inode->i_flags |= S_DAX;
> > +       inode_unlock(inode);
> > +}
> > +
> > +static void bd_clear_dax(struct inode *inode)
> > +{
> > +       inode_lock(inode);
> > +       inode->i_flags &= ~S_DAX;
> > +       inode_unlock(inode);
> > +}
> 
> Since this is inode generic should these helpers be prefixed "i_"
> rather than "bd_"?

Probably not, because in general filesystems are responsible for
updating i_flags to reflect on-disk inode configuration and that's
typically done under transaction contexts. e.g.  through ioctl
interfaces to set/clear flags that are stored on disk.  As such,
inode->i_flags is effectively protected by the filesystem specific
locking heirarchy, not the generic inode_lock().

e.g. have a look at XFS storing a persistent "DAX-enabled" flag in
the inode, which can be set/cleared on individual inodes dynamically
by FS_IOC_FSSETXATTR. The XFS i_flags update function assumes
exclusive access to the field as it is called under locked
transaction context. Similar code exists in ext4, btrfs, gfs2,
etc....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
