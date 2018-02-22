Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180210004617.3071-1-ming.lei@redhat.com>
References: <20180210004617.3071-1-ming.lei@redhat.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 22 Feb 2018 11:23:20 +0800
Message-ID: <CACVXFVPkhmq4qiTDAJyC+T+KtU+tHPUVjWmRvqkZ3Q6sVjYUgw@mail.gmail.com>
Subject: Re: [PATCH V2] block: pass inclusive 'lend' parameter to truncate_inode_pages_range
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	linux-block <linux-block@vger.kernel.org>, stable <stable@vger.kernel.org>,
	Dmitry Monakhov <dmonakhov@openvz.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sat, Feb 10, 2018 at 8:46 AM, Ming Lei <ming.lei@redhat.com> wrote:
> The 'lend' parameter of truncate_inode_pages_range is required to be
> inclusive, so follow the rule.
>
> This patch fixes one memory corruption triggered by discard.
>
> Cc: <stable@vger.kernel.org>
> Cc: Dmitry Monakhov <dmonakhov@openvz.org>
> Fixes: 351499a172c0 ("block: Invalidate cache on discard v2")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
>         - Cc stable list and Dmitry as suggested by Bart
>
>  block/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 1668506d8ed8..3884d810efd2 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -225,7 +225,7 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
>
>         if (start + len > i_size_read(bdev->bd_inode))
>                 return -EINVAL;
> -       truncate_inode_pages_range(mapping, start, start + len);
> +       truncate_inode_pages_range(mapping, start, start + len - 1);
>         return blkdev_issue_discard(bdev, start >> 9, len >> 9,
>                                     GFP_KERNEL, flags);
>  }
> --
> 2.9.5
>

Hi Jens,

Could you consider it in v4.16 since it does fix a regression in lkp test?

Thanks,
Ming Lei
