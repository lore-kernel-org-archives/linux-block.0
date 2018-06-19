Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Message-ID: <0ddda59286e0be135cf133dc653da54f66c264a7.camel@kernel.org>
Subject: Re: [PATCH 2/5] buffer: record blockdev write errors in super_block
 that backs them
From: Jeff Layton <jlayton@kernel.org>
To: viro@ZenIV.linux.org.uk, dhowells@redhat.com,
        Jens Axboe <axboe@fb.com>, David Howells <dhowells@redhat.com>
Cc: willy@infradead.org, andres@anarazel.de, cmaiolino@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date: Tue, 19 Jun 2018 06:40:23 -0400
In-Reply-To: <81a365a631279f8b0ad0ed71b222c19817045704.camel@kernel.org>
References: <20180604180304.9662-1-jlayton@kernel.org>
         <20180604180304.9662-3-jlayton@kernel.org>
         <81a365a631279f8b0ad0ed71b222c19817045704.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-06-06 at 11:56 -0400, Jeff Layton wrote:
> On Mon, 2018-06-04 at 14:03 -0400, Jeff Layton wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> > 
> > When syncing out a block device (a'la __sync_blockdev), any error
> > encountered will only be recorded in the bd_inode's mapping. When the
> > blockdev contains a filesystem however, we'd like to also record the
> > error in the super_block that's stored there.
> > 
> > Make mark_buffer_write_io_error also record the error in the
> > corresponding super_block when a writeback error occurs and the block
> > device contains a mounted superblock.
> > 
> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > ---
> >  fs/buffer.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index 249b83fafe48..dae2a857d5bc 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -1117,6 +1117,8 @@ void mark_buffer_write_io_error(struct buffer_head *bh)
> >  		mapping_set_error(bh->b_page->mapping, -EIO);
> >  	if (bh->b_assoc_map)
> >  		mapping_set_error(bh->b_assoc_map, -EIO);
> > +	if (bh->b_bdev->bd_super)
> > +		errseq_set(&bh->b_bdev->bd_super->s_wb_err, -EIO);
> >  }
> >  EXPORT_SYMBOL(mark_buffer_write_io_error);
> >  
> 
> (cc'ing linux-block and Jens)
> 
> I'm wondering whether this patch might turn out to be racy. For
> instance, could a call to __sync_blockdev race with an unmount in such
> a way that bd_super goes NULL after we check it but before errseq_set
> is called?
> 
> If so, what can we do to ensure that that doesn't happen? Any insight
> here would be appreciated.
> 
> Thanks,

Jens, ping? I never got a response on the above.

After looking over it some more, I suspect that this may be racy with
some filesystems. Some of them seem to just flush out data to the
bd_inode on unmount, and trust the system to take care of the rest.

One possible fix there might be to turn bd_super into an RCU managed
pointer. We already free super_blocks under RCU, so we could do
something there like:

rcu_read_lock();
sb = rcu_dereference(bh->b_bdev->bd_super);
if (sb)
	errseq_set(&sb->s_wb_err, -EIO);
rcu_read_unlock();

There aren't that many accessors of bd_super, so that seems like it'd be
fairly simple to do.

Still, I'd like someone to sanity check me here. Is there something that
would prevent the above race that I'm not seeing?

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
