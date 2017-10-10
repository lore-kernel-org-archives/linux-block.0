Return-Path: <rakesh@tuxera.com>
Date: Tue, 10 Oct 2017 12:43:06 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Jens Axboe <axboe@kernel.dk>
CC: Christoph Hellwig <hch@infradead.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH V2] writeback: merge try_to_writeback_inodes_sb_nr() into
 caller
Message-ID: <20171010094306.GA32628@dhcp-216.srv.tuxera.com>
References: <20171009103440.GA29114@dhcp-216.srv.tuxera.com>
 <20171009120029.GL17917@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20171009120029.GL17917@quack2.suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

On Mon, Oct 09, 2017 at 02:00:29PM +0200, Jan Kara wrote:
> On Mon 09-10-17 13:34:41, Rakesh Pandit wrote:
> > Since commit 925a6efb8ff0c ("Btrfs: stop using
> > try_to_writeback_inodes_sb_nr to flush delalloc") this function hasn't
> > been used outside so stop exporting it.
> > 
> > In addition we merge it into try_to_writeback_inodes_sb() which is the
> > only caller.  Also change return type of try_to_writeback_inodes_sb to
> > void as the only user ext4 doesn't care.
> > 
> > Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> 
> Looks good. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza

As there are many writeback related changes on your tree would you be
okay queuing this up as well for-4.15 with above reviewed-by tag ?

This should apply fine on your tree for-4.15.

Let me know if that isn't okay.

Best regards,
	Rakesh Pandit

> 
> > ---
> >  fs/fs-writeback.c         | 30 ++++++------------------------
> >  include/linux/writeback.h |  4 +---
> >  2 files changed, 7 insertions(+), 27 deletions(-)
> > 
> > V2: Merge into only caller, change return type and adjust docs a bit
> > 
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 9e24d60..08f5deb 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -2376,37 +2376,19 @@ void writeback_inodes_sb(struct super_block *sb, enum wb_reason reason)
> >  EXPORT_SYMBOL(writeback_inodes_sb);
> >  
> >  /**
> > - * try_to_writeback_inodes_sb_nr - try to start writeback if none underway
> > + * try_to_writeback_inodes_sb - try to start writeback if none underway
> >   * @sb: the superblock
> > - * @nr: the number of pages to write
> > - * @reason: the reason of writeback
> > + * @reason: reason why some writeback work was initiated
> >   *
> > - * Invoke writeback_inodes_sb_nr if no writeback is currently underway.
> > - * Returns 1 if writeback was started, 0 if not.
> > + * Invoke __writeback_inodes_sb_nr if no writeback is currently underway.
> >   */
> > -bool try_to_writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
> > -				   enum wb_reason reason)
> > +void try_to_writeback_inodes_sb(struct super_block *sb, enum wb_reason reason)
> >  {
> >  	if (!down_read_trylock(&sb->s_umount))
> > -		return false;
> > +		return;
> >  
> > -	__writeback_inodes_sb_nr(sb, nr, reason, true);
> > +	__writeback_inodes_sb_nr(sb, get_nr_dirty_pages(), reason, true);
> >  	up_read(&sb->s_umount);
> > -	return true;
> > -}
> > -EXPORT_SYMBOL(try_to_writeback_inodes_sb_nr);
> > -
> > -/**
> > - * try_to_writeback_inodes_sb - try to start writeback if none underway
> > - * @sb: the superblock
> > - * @reason: reason why some writeback work was initiated
> > - *
> > - * Implement by try_to_writeback_inodes_sb_nr()
> > - * Returns 1 if writeback was started, 0 if not.
> > - */
> > -bool try_to_writeback_inodes_sb(struct super_block *sb, enum wb_reason reason)
> > -{
> > -	return try_to_writeback_inodes_sb_nr(sb, get_nr_dirty_pages(), reason);
> >  }
> >  EXPORT_SYMBOL(try_to_writeback_inodes_sb);
> >  
> > diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> > index dd1d2c2..e15ec14 100644
> > --- a/include/linux/writeback.h
> > +++ b/include/linux/writeback.h
> > @@ -163,9 +163,7 @@ struct bdi_writeback;
> >  void writeback_inodes_sb(struct super_block *, enum wb_reason reason);
> >  void writeback_inodes_sb_nr(struct super_block *, unsigned long nr,
> >  							enum wb_reason reason);
> > -bool try_to_writeback_inodes_sb(struct super_block *, enum wb_reason reason);
> > -bool try_to_writeback_inodes_sb_nr(struct super_block *, unsigned long nr,
> > -				   enum wb_reason reason);
> > +void try_to_writeback_inodes_sb(struct super_block *sb, enum wb_reason reason);
> >  void sync_inodes_sb(struct super_block *);
> >  void wakeup_flusher_threads(enum wb_reason reason);
> >  void wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
> > -- 
> > 2.5.5
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
