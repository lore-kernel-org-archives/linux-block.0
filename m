Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362E579CD
	for <linux-block@vger.kernel.org>; Mon,  8 Jan 2024 05:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="wHRaIK8I"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cda3e35b26so136491a12.1
        for <linux-block@vger.kernel.org>; Sun, 07 Jan 2024 21:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1704693125; x=1705297925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W1r4ujRia0zfQXcteYOfRIs14gJdmnJ+2ERHUVFa4gA=;
        b=wHRaIK8IjRxK3InqMwGt9AS884Z6KEu1C9Nlnf93PPed7vWErJWBW2pDbJR31SHew1
         ZG6Ij7Y4gwVnWt/2Q2hkoyjjeqQmiN3zrYPp0r4GKzX01DtE+EHMveWZXICPFQc9LLvp
         54m9tvo8ZHTJZwMRgJG40uF8zq44rb2XXKlZO/jDHYCwnK4B4WzQV6RAlrUUoPNGg5GI
         crXHnuWKLhweOsKMPJFOLleytg9mK+MDl8nJO5rgQTUmhR9eTgRagsQv0Zs+YCVxnWCN
         7/6ZJyuwOcytnMguJyntVPaDr1sSrgX2nbDUOpPf8eYhUcQUwJHLtqSR+wHfVntg5OuF
         nw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704693125; x=1705297925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1r4ujRia0zfQXcteYOfRIs14gJdmnJ+2ERHUVFa4gA=;
        b=r5WNio4wEKnZ6R1l7CAg54voZlJBOMZmMTfbMdhToa0PPOuiqyBLBH6bxt6eoTEVH8
         MwUPZAif9GJY9g/uX4hEVemowCV99hkDh4wKf5hTkN2dqr7TUQFPNxADXcug2ZhE2TTg
         C3BA59xnd0ZgrCbdFBoJm0c1b7PmB8cBqzSgod/FEgYjyYkgkepYlh9v1iNmTzqwO2TD
         pxtXLvX3V4NfuO2NulU98SiXObqnqGIgLxabfCFutZa6qIHYxaiPfqmS4lW+0BgyHsD1
         /0qh0/a4MrZRyRG+8QqIwyVwaBiTQcKQD+1i6c18SYItSWIcUbwc9IhCCK065u817qTB
         M3/A==
X-Gm-Message-State: AOJu0YxWSoWcxHded3dX7/Kx2KXwXRJIJvc5CYrMBxZUJdPvBKqgHECA
	mM4SO80dr6dEZ7I5ExQaq0ZfurzCWEXeAQ==
X-Google-Smtp-Source: AGHT+IGoT+aCE0kCzFmeL7TUu1ViE+TWvKWkeBs6ua6H3kxq98LMKvxACWNKHnJ5DkiZPd/Q7BelBw==
X-Received: by 2002:a17:903:1c2:b0:1d4:e36f:7480 with SMTP id e2-20020a17090301c200b001d4e36f7480mr1192896plh.5.1704693125520;
        Sun, 07 Jan 2024 21:52:05 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902e54e00b001cf51972586sm5324750plf.292.2024.01.07.21.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 21:52:05 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rMiYM-007VkB-1I;
	Mon, 08 Jan 2024 16:52:02 +1100
Date: Mon, 8 Jan 2024 16:52:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH DRAFT RFC 34/34] buffer: port block device access to
 files and get rid of bd_inode access
Message-ID: <ZZuNgqLNimnMBTIC@dread.disaster.area>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
 <20240103-vfs-bdev-file-v1-34-6c8ee55fb6ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103-vfs-bdev-file-v1-34-6c8ee55fb6ef@kernel.org>

On Wed, Jan 03, 2024 at 01:55:32PM +0100, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  block/fops.c                  |  1 +
>  drivers/md/md-bitmap.c        |  1 +
>  fs/affs/file.c                |  1 +
>  fs/btrfs/inode.c              |  1 +
>  fs/buffer.c                   | 69 ++++++++++++++++++++++---------------------
>  fs/direct-io.c                |  2 +-
>  fs/erofs/data.c               |  7 +++--
>  fs/erofs/internal.h           |  1 +
>  fs/erofs/zmap.c               |  1 +
>  fs/ext2/inode.c               |  8 +++--
>  fs/ext4/inode.c               |  6 ++--
>  fs/ext4/super.c               |  6 ++--
>  fs/f2fs/data.c                |  6 +++-
>  fs/f2fs/f2fs.h                |  1 +
>  fs/fuse/dax.c                 |  1 +
>  fs/gfs2/aops.c                |  1 +
>  fs/gfs2/bmap.c                |  1 +
>  fs/hpfs/file.c                |  1 +
>  fs/jbd2/commit.c              |  1 +
>  fs/jbd2/journal.c             | 26 +++++++++-------
>  fs/jbd2/recovery.c            |  6 ++--
>  fs/jbd2/revoke.c              | 10 +++----
>  fs/jbd2/transaction.c         |  1 +
>  fs/mpage.c                    |  5 +++-
>  fs/nilfs2/btnode.c            |  2 ++
>  fs/nilfs2/gcinode.c           |  1 +
>  fs/nilfs2/mdt.c               |  1 +
>  fs/nilfs2/page.c              |  2 ++
>  fs/nilfs2/recovery.c          | 20 ++++++-------
>  fs/nilfs2/the_nilfs.c         |  1 +
>  fs/ntfs/aops.c                |  3 ++
>  fs/ntfs/file.c                |  1 +
>  fs/ntfs/mft.c                 |  2 ++
>  fs/ntfs3/fsntfs.c             |  8 ++---
>  fs/ntfs3/inode.c              |  1 +
>  fs/ntfs3/super.c              |  2 +-
>  fs/ocfs2/journal.c            |  2 +-
>  fs/reiserfs/journal.c         |  8 ++---
>  fs/reiserfs/reiserfs.h        |  6 ++--
>  fs/reiserfs/tail_conversion.c |  1 +
>  fs/xfs/xfs_iomap.c            |  7 +++--
>  fs/zonefs/file.c              |  2 ++
>  include/linux/buffer_head.h   | 45 +++++++++++++++-------------
>  include/linux/iomap.h         |  1 +
>  include/linux/jbd2.h          |  6 ++--
>  45 files changed, 172 insertions(+), 114 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index e831196dafac..6557b71c7657 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -381,6 +381,7 @@ static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	loff_t isize = i_size_read(inode);
>  
>  	iomap->bdev = bdev;
> +	BUG_ON(true /* TODO(brauner): This is the only place where we don't go from inode->i_sb->s_f_bdev for obvious reasons. Thoughts? */);

Maybe block devices should have their own struct file created when the
block device is instantiated and torn down when the block device is
trashed?

> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 18c8f168b153..e0f38fafc5df 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -122,10 +122,12 @@ xfs_bmbt_to_iomap(
>  	}
>  	iomap->offset = XFS_FSB_TO_B(mp, imap->br_startoff);
>  	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
> -	if (mapping_flags & IOMAP_DAX)
> +	if (mapping_flags & IOMAP_DAX) {
>  		iomap->dax_dev = target->bt_daxdev;
> -	else
> +	} else {
>  		iomap->bdev = target->bt_bdev;
> +		iomap->f_bdev = target->bt_f_bdev;
> +	}
>  	iomap->flags = iomap_flags;
>  
>  	if (xfs_ipincount(ip) &&
> @@ -151,6 +153,7 @@ xfs_hole_to_iomap(
>  	iomap->offset = XFS_FSB_TO_B(ip->i_mount, offset_fsb);
>  	iomap->length = XFS_FSB_TO_B(ip->i_mount, end_fsb - offset_fsb);
>  	iomap->bdev = target->bt_bdev;
> +	iomap->f_bdev = target->bt_f_bdev;
>  	iomap->dax_dev = target->bt_daxdev;

Why are we passing both iomap->bdev and the bdev file pointer? I
didn't see anything that uses the bdev file pointer, so I'm not sure
why this is being added if iomap->bdev is not getting removed....

> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 96dd0acbba44..91f1e434cab3 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -97,6 +97,7 @@ struct iomap {
>  	u64			length;	/* length of mapping, bytes */
>  	u16			type;	/* type of mapping */
>  	u16			flags;	/* flags for mapping */
> +	struct file		*f_bdev;

	struct file		*bdev_file; /* block device for I/O */

>  	struct block_device	*bdev;	/* block device for I/O */
>  	struct dax_device	*dax_dev; /* dax_dev for dax operations */
>  	void			*inline_data;

-Dave.
-- 
Dave Chinner
david@fromorbit.com
