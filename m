Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751302AbeCOQ13 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 12:27:29 -0400
Subject: Re: [PATCH 11/16] bcache: Check the d->disk pointer before using it
To: Bart Van Assche <bart.vanassche@wdc.com>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
 <20180315150814.9412-12-bart.vanassche@wdc.com>
From: Coly Li <colyli@suse.de>
Message-ID: <a167d50c-fe24-56e6-a4c2-d02425ccad82@suse.de>
Date: Fri, 16 Mar 2018 00:25:49 +0800
MIME-Version: 1.0
In-Reply-To: <20180315150814.9412-12-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 15/03/2018 11:08 PM, Bart Van Assche wrote:
> Since bcache_device_free() checks the d->disk pointer I think that
> means that that pointer can be NULL. Hence test that pointer before
> using it. This was detected by smatch.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

Reviewed-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
>  drivers/md/bcache/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index d19a44cd1fd7..39bec137f636 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -742,7 +742,7 @@ static void bcache_device_free(struct bcache_device *d)
>  {
>  	lockdep_assert_held(&bch_register_lock);
>  
> -	pr_info("%s stopped", d->disk->disk_name);
> +	pr_info("%s stopped", d->disk ? d->disk->disk_name : "(?)");
>  
>  	if (d->c)
>  		bcache_device_detach(d);
> 
