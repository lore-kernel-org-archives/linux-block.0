Return-Path: <darrick.wong@oracle.com>
Date: Wed, 14 Jun 2017 21:15:03 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
Message-ID: <20170615041503.GB4521@birch.djwong.org>
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
 <1497498312-17704-5-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497498312-17704-5-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 14, 2017 at 09:45:05PM -0600, Jens Axboe wrote:
> Add four flags for the pwritev2(2) system call, allowing an application
> to give the kernel a hint about what on-media life times can be
> expected from a given write.
> 
> The intent is for these values to be relative to each other, no
> absolute meaning should be attached to these flag names.
> 
> Define IOCB flags to carry this over this information from the pwritev2
> RWF_WRITE_LIFE_* flags.
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/read_write.c         |  9 ++++++++-
>  include/linux/fs.h      | 12 ++++++++++++
>  include/uapi/linux/fs.h | 10 ++++++++++
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 47c1d4484df9..9cb2314efca3 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -678,7 +678,7 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
>  	struct kiocb kiocb;
>  	ssize_t ret;
>  
> -	if (flags & ~(RWF_HIPRI | RWF_DSYNC | RWF_SYNC))
> +	if (flags & ~(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_WRITE_LIFE_MASK))
>  		return -EOPNOTSUPP;
>  
>  	init_sync_kiocb(&kiocb, filp);
> @@ -688,6 +688,13 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
>  		kiocb.ki_flags |= IOCB_DSYNC;
>  	if (flags & RWF_SYNC)
>  		kiocb.ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
> +	if (flags & RWF_WRITE_LIFE_MASK) {
> +		struct inode *inode = file_inode(filp);
> +
> +		inode->i_write_hint = (flags & RWF_WRITE_LIFE_MASK) >>
> +					RWF_WRITE_LIFE_SHIFT;

Hmm, so once set, hints stick around until someone else sets a different
one.  I suppose it's unlikely that you'd have two programs writing to
the same inode with different write hints, right?

Just wondering if anyone will be surprised that they thought they were
writing to an _EXTREME hint file but someone else switched it to _SHORT
on them.

Also, how does userspace query the write hint value once set?

> +		kiocb.ki_flags |= inode->i_write_hint << IOCB_WRITE_LIFE_SHIFT;
> +	}
>  	kiocb.ki_pos = *ppos;
>  
>  	if (type == READ)
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f4f9df8ed059..63798b67fcfe 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -269,6 +269,12 @@ struct writeback_control;
>  #define IOCB_SYNC		(1 << 5)
>  #define IOCB_WRITE		(1 << 6)
>  
> +/*
> + * Steal 4-bits for stream information, this allows 16 valid streams
> + */
> +#define IOCB_WRITE_LIFE_SHIFT	7
> +#define IOCB_WRITE_LIFE_MASK	(BIT(7) | BIT(8) | BIT(9) | BIT(10))
> +
>  struct kiocb {
>  	struct file		*ki_filp;
>  	loff_t			ki_pos;
> @@ -292,6 +298,12 @@ static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
>  	};
>  }
>  
> +static inline int iocb_write_hint(const struct kiocb *iocb)
> +{
> +	return (iocb->ki_flags & IOCB_WRITE_LIFE_MASK) >>
> +			IOCB_WRITE_LIFE_SHIFT;
> +}
> +
>  /*
>   * "descriptor" for what we're up to with a read.
>   * This allows us to use the same read code yet
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 24e61a54feaa..58b7ee06b380 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -361,4 +361,14 @@ struct fscrypt_key {
>  #define RWF_DSYNC			0x00000002 /* per-IO O_DSYNC */
>  #define RWF_SYNC			0x00000004 /* per-IO O_SYNC */
>  
> +/*
> + * Data life time write flags, steal 4 bits for that
> + */
> +#define RWF_WRITE_LIFE_SHIFT		4
> +#define RWF_WRITE_LIFE_MASK		0x000000f0 /* 4 bits of stream ID */
> +#define RWF_WRITE_LIFE_SHORT		(1 << RWF_WRITE_LIFE_SHIFT)
> +#define RWF_WRITE_LIFE_MEDIUM		(2 << RWF_WRITE_LIFE_SHIFT)
> +#define RWF_WRITE_LIFE_LONG		(3 << RWF_WRITE_LIFE_SHIFT)
> +#define RWF_WRITE_LIFE_EXTREME		(4 << RWF_WRITE_LIFE_SHIFT)

Should O_TMPFILE files ought to be created with i_write_hint =
RWF_WRITE_LIFE_SHORT by default?

--D

> +
>  #endif /* _UAPI_LINUX_FS_H */
> -- 
> 2.7.4
> 
