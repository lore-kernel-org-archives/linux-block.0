Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751095AbeECPCU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 May 2018 11:02:20 -0400
Date: Thu, 3 May 2018 17:02:17 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, bart.vanassche@wdc.com, ming.lei@redhat.com,
        rjw@rjwysocki.net, mguzik@redhat.com, linux-pm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] fs: fix corner case race on freeze_bdev() when sb
 disappears
Message-ID: <20180503150217.ywu2cuxjbsgr47a6@quack2.suse.cz>
References: <20180420235904.27496-1-mcgrof@kernel.org>
 <20180420235904.27496-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180420235904.27496-4-mcgrof@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri 20-04-18 16:59:04, Luis R. Rodriguez wrote:
> freeze_bdev() will bail but leave the bd_fsfreeze_count incremented
> if the get_active_super() does not find the superblock on our
> super_blocks list to match.
> 
> This issue has been present since v2.6.29 during the introduction of the
> ioctl_fsfreeze() and ioctl_fsthaw() via commit fcccf502540e3 ("filesystem
> freeze: implement generic freeze feature").
> 
> I am not aware of any existing races which have triggered this
> situation, however, if it does trigger it could mean leaving a
> superblock with bd_fsfreeze_count always positive.
> 
> Fixes: fcccf502540e3 ("filesystem freeze: implement generic freeze feature")
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/block_dev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index b54966679833..7a532aa58c07 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -507,8 +507,10 @@ struct super_block *freeze_bdev(struct block_device *bdev)
>  	}
>  
>  	sb = get_active_super(bdev);
> -	if (!sb)
> +	if (!sb) {
> +		bdev->bd_fsfreeze_count--;
>  		goto out;
> +	}
>  	if (sb->s_op->freeze_super)
>  		error = sb->s_op->freeze_super(sb);
>  	else
> -- 
> 2.16.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
