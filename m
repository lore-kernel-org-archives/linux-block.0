Return-Path: <gregkh@linuxfoundation.org>
Date: Tue, 6 Feb 2018 02:24:21 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc: logang@deltatee.com, axboe@kernel.dk, jlayton@poochiereds.net,
	bfields@fieldses.org, viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] block, char_dev: Use correct format specifier for
 unsigned ints
Message-ID: <20180206102421.GC7889@kroah.com>
References: <151788389652.28069.6065922071875812126.stgit@srivatsa-ubuntu>
 <151788391701.28069.13145257664735983272.stgit@srivatsa-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <151788391701.28069.13145257664735983272.stgit@srivatsa-ubuntu>
List-ID: <linux-block@vger.kernel.org>

On Mon, Feb 05, 2018 at 06:25:27PM -0800, Srivatsa S. Bhat wrote:
> From: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
> 
> register_blkdev() and __register_chrdev_region() treat the major
> number as an unsigned int. So print it the same way to avoid
> absurd error statements such as:
> "... major requested (-1) is greater than the maximum (511) ..."
> (and also fix off-by-one bugs in the error prints).
> 
> While at it, also update the comment describing register_blkdev().
> 
> Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
> ---
> 
>  block/genhd.c |   19 +++++++++++--------
>  fs/char_dev.c |    4 ++--
>  2 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 88a53c1..21a18e5 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -308,19 +308,22 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
>  /**
>   * register_blkdev - register a new block device
>   *
> - * @major: the requested major device number [1..255]. If @major = 0, try to
> - *         allocate any unused major number.
> + * @major: the requested major device number [1..BLKDEV_MAJOR_MAX-1]. If
> + *         @major = 0, try to allocate any unused major number.
>   * @name: the name of the new block device as a zero terminated string
>   *
>   * The @name must be unique within the system.
>   *
>   * The return value depends on the @major input parameter:
>   *
> - *  - if a major device number was requested in range [1..255] then the
> - *    function returns zero on success, or a negative error code
> + *  - if a major device number was requested in range [1..BLKDEV_MAJOR_MAX-1]
> + *    then the function returns zero on success, or a negative error code
>   *  - if any unused major number was requested with @major = 0 parameter
>   *    then the return value is the allocated major number in range
> - *    [1..255] or a negative error code otherwise
> + *    [1..BLKDEV_MAJOR_MAX-1] or a negative error code otherwise
> + *
> + * See Documentation/admin-guide/devices.txt for the list of allocated
> + * major numbers.
>   */
>  int register_blkdev(unsigned int major, const char *name)
>  {
> @@ -347,8 +350,8 @@ int register_blkdev(unsigned int major, const char *name)
>  	}
>  
>  	if (major >= BLKDEV_MAJOR_MAX) {
> -		pr_err("register_blkdev: major requested (%d) is greater than the maximum (%d) for %s\n",
> -		       major, BLKDEV_MAJOR_MAX, name);
> +		pr_err("register_blkdev: major requested (%u) is greater than the maximum (%u) for %s\n",
> +		       major, BLKDEV_MAJOR_MAX-1, name);
>  
>  		ret = -EINVAL;
>  		goto out;
> @@ -375,7 +378,7 @@ int register_blkdev(unsigned int major, const char *name)
>  		ret = -EBUSY;
>  
>  	if (ret < 0) {
> -		printk("register_blkdev: cannot get major %d for %s\n",
> +		printk("register_blkdev: cannot get major %u for %s\n",
>  		       major, name);
>  		kfree(p);
>  	}
> diff --git a/fs/char_dev.c b/fs/char_dev.c
> index 33c9385..a279c58 100644
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -121,8 +121,8 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
>  	}
>  
>  	if (major >= CHRDEV_MAJOR_MAX) {
> -		pr_err("CHRDEV \"%s\" major requested (%d) is greater than the maximum (%d)\n",
> -		       name, major, CHRDEV_MAJOR_MAX);
> +		pr_err("CHRDEV \"%s\" major requested (%u) is greater than the maximum (%u)\n",
> +		       name, major, CHRDEV_MAJOR_MAX-1);
>  		ret = -EINVAL;
>  		goto out;
>  	}

Thanks for both of these patches, if Al doesn't grab them, I will after
4.16-rc1 comes out.

greg k-h
