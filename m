Return-Path: <viro@ftp.linux.org.uk>
Date: Mon, 19 Jun 2017 17:44:27 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: axboe@kernel.dk, hch@lst.de, jack@suse.cz, akpm@linux-foundation.org,
	linux-block@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 05/10] fs: return if direct I/O will trigger writeback
Message-ID: <20170619164427.GF10672@ZenIV.linux.org.uk>
References: <20170619163348.15542-1-rgoldwyn@suse.de>
 <20170619163348.15542-6-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170619163348.15542-6-rgoldwyn@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 19, 2017 at 11:33:43AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Find out if the I/O will trigger a wait due to writeback. If yes,
> return -EAGAIN.
> 
> Return -EINVAL for buffered AIO: there are multiple causes of
> delay such as page locks, dirty throttling logic, page loading
> from disk etc. which cannot be taken care of.
> 

I don't believe that generic_file_read_iter() is sufficient.  Consider
ext4_file_read_iter() -> ext4_dax_read_iter():
static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
{
        struct inode *inode = file_inode(iocb->ki_filp);
        ssize_t ret;

        inode_lock_shared(inode);

IOW, your ext4 patch is missing a chunk.  I hadn't checked xfs one...
