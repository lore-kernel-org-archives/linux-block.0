Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Thu, 3 May 2018 16:53:54 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, bart.vanassche@wdc.com, ming.lei@redhat.com,
        rjw@rjwysocki.net, mguzik@redhat.com, linux-pm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: move documentation for thaw_super() where
 appropriate
Message-ID: <20180503145354.unbzycfj6axeumfl@quack2.suse.cz>
References: <20180420235904.27496-1-mcgrof@kernel.org>
 <20180420235904.27496-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180420235904.27496-2-mcgrof@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri 20-04-18 16:59:02, Luis R. Rodriguez wrote:
> On commit 08fdc8a0138a ("buffer.c: call thaw_super during emergency thaw")
> Mateusz added thaw_super_locked() and made thaw_super() use it, but
> forgot to move the documentation.
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

Looks good (modulo the -- which is probably worth fixing when touching the
comment anyway). You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 5fa9a8d8d865..9d0eb5e20a1f 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1532,12 +1532,6 @@ int freeze_super(struct super_block *sb)
>  }
>  EXPORT_SYMBOL(freeze_super);
>  
> -/**
> - * thaw_super -- unlock filesystem
> - * @sb: the super to thaw
> - *
> - * Unlocks the filesystem and marks it writeable again after freeze_super().
> - */
>  static int thaw_super_locked(struct super_block *sb)
>  {
>  	int error;
> @@ -1573,6 +1567,12 @@ static int thaw_super_locked(struct super_block *sb)
>  	return 0;
>  }
>  
> +/**
> + * thaw_super -- unlock filesystem
> + * @sb: the super to thaw
> + *
> + * Unlocks the filesystem and marks it writeable again after freeze_super().
> + */
>  int thaw_super(struct super_block *sb)
>  {
>  	down_write(&sb->s_umount);
> -- 
> 2.16.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
