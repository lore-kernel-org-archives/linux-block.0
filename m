Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Subject: Re: [PATCH 05/24] fs: Get proper reference for s_bdi
To: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
References: <20170202173422.3240-1-jack@suse.cz>
 <20170202173422.3240-6-jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
From: Boaz Harrosh <boaz@plexistor.com>
Message-ID: <d671b948-9449-b0df-27ac-79a768077a64@plexistor.com>
Date: Thu, 9 Feb 2017 16:36:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170202173422.3240-6-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 02/02/2017 07:34 PM, Jan Kara wrote:
> So far we just relied on block device to hold a bdi reference for us
> while the filesystem is mounted. While that works perfectly fine, it is
> a bit awkward that we have a pointer to a refcounted structure in the
> superblock without proper reference. So make s_bdi hold a proper
> reference to block device's BDI. No filesystem using mount_bdev()
> actually changes s_bdi so this is safe and will make bdev filesystems
> work the same way as filesystems needing to set up their private bdi.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/super.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 31dc4c6450ef..dfb95ccd4351 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1047,12 +1047,9 @@ static int set_bdev_super(struct super_block *s, void *data)
>  {
>  	s->s_bdev = data;
>  	s->s_dev = s->s_bdev->bd_dev;
> +	s->s_bdi = bdi_get(s->s_bdev->bd_bdi);
> +	s->s_iflags |= SB_I_DYNBDI;
>  
> -	/*
> -	 * We set the bdi here to the queue backing, file systems can
> -	 * overwrite this in ->fill_super()
> -	 */

Question: So I have an FS that uses mount_bdev but than goes and overrides sb->s_bdev
in ->fill_super() anyway. This is because of two reasons. One because I have many
more devices. (like btrfs I'm moulti-dev) but I like to use mount_bdev because of the
somewhat delicate handling of automatic bind-mounts.

For me it is a bigger hack to get the ref-counting and bind-mounts locking correctly
then to bdi_put and say the new super_setup_bdi(sb) in fill_super. Would you expect
problems?

Thanks for any help
Boaz

> -	s->s_bdi = bdev_get_queue(s->s_bdev)->backing_dev_info;
>  	return 0;
>  }
>  
> 
