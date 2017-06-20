Return-Path: <viro@ftp.linux.org.uk>
Date: Tue, 20 Jun 2017 01:24:28 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, hch@lst.de, jack@suse.cz,
	akpm@linux-foundation.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/10 v13] merge request: No wait AIO
Message-ID: <20170620002428.GM10672@ZenIV.linux.org.uk>
References: <20170619163348.15542-1-rgoldwyn@suse.de>
 <a3c9ac14-d04d-2dc5-c656-879c6262aa96@kernel.dk>
 <20170619233439.GL10672@ZenIV.linux.org.uk>
 <1de9d545-8811-4dfa-22db-f5172f122a95@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1de9d545-8811-4dfa-22db-f5172f122a95@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 19, 2017 at 05:36:05PM -0600, Jens Axboe wrote:
> On 06/19/2017 05:34 PM, Al Viro wrote:
> > On Mon, Jun 19, 2017 at 05:15:16PM -0600, Jens Axboe wrote:
> >> On 06/19/2017 10:33 AM, Goldwyn Rodrigues wrote:
> >>> Jens,
> >>>
> >>> As Christoph suggested, I am sending the patches against the block
> >>> tree for merge since the block layer changes had the most conflicts.
> >>> My tree is at https://github.com/goldwynr/linux/tree/nowait-block
> >>
> >> I can merge it for 4.13, but I need Al to be happy with it first.
> > 
> > FWIW, it's really a matter of who gets more conflicts - I'm OK with the
> > general shape of that code and it could go through either tree (or both,
> > for that matter, if an immutable branch is promised).
> 
> I'm still hopeful that the write hint patchset will make it as well,
> which will definitely conflict with this. So if you don't mind, I'd
> like to queue it through the block tree. The block for-4.x/ branches
> are not rebased.

Fine by me; the only problem I see there at the moment is with ext4 and
xfs ->read_iter() not buggering off on nowait (xfs one has
        xfs_ilock(ip, XFS_IOLOCK_SHARED);
done before it gets to generic_file_read_iter()).
