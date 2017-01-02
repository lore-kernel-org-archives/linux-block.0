Return-Path: <guaneryu@gmail.com>
Return-Path: <guaneryu@gmail.com>
Date: Tue, 3 Jan 2017 00:21:45 +0800
From: Eryu Guan <guaneryu@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clean_bdev_aliases: Prevent cleaning blocks that are not
 in block range
Message-ID: <20170102162145.GA1946@eguan.usersys.redhat.com>
References: <1482672663-17122-1-git-send-email-chandan@linux.vnet.ibm.com>
 <20170102155803.GH18058@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170102155803.GH18058@quack2.suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 02, 2017 at 04:58:03PM +0100, Jan Kara wrote:
> On Sun 25-12-16 19:01:03, Chandan Rajendra wrote:
> > The first block to be cleaned may start at a non-zero page offset. In
> > such a scenario clean_bdev_aliases() will end up cleaning blocks that
> > do not fall in the range of blocks to be cleaned. This commit fixes the
> > issue by skipping blocks that do not fall in valid block range.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> 
> Ah, very good catch! How did you spot this?

I failed to notice this patch, and I came up with a same patch today
myself, and I'm still testing it.

I found this by xfstests, many tests (tens of tests) failed fsck after
test when testing extN if blocksize < pagesize. E.g. generic/013 could
reproduce the fs corruption quite reliablely for me.

Reviewed-by: Eryu Guan <eguan@redhat.com>

> 
> The patch looks good. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Jens, please merge this fix quickly as we may end up discarding changes to
> innocent metadata blocks due to this... Thanks!
> 
> 								Honza
> > ---
> >  fs/buffer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index 1df2bd5..28484b3 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -1660,7 +1660,7 @@ void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
> >  			head = page_buffers(page);
> >  			bh = head;
> >  			do {
> > -				if (!buffer_mapped(bh))
> > +				if (!buffer_mapped(bh) || (bh->b_blocknr < block))
> >  					goto next;
> >  				if (bh->b_blocknr >= block + len)
> >  					break;
> > -- 
> > 2.5.5
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
