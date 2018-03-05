Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36589 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbeCEVzq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Mar 2018 16:55:46 -0500
Received: by mail-pl0-f65.google.com with SMTP id 61-v6so10551994plf.3
        for <linux-block@vger.kernel.org>; Mon, 05 Mar 2018 13:55:46 -0800 (PST)
Subject: Re: [PATCH] bcache: fix error return value in memory shrink
To: tang.junhui@zte.com.cn, colyli@suse.de
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1517369453-28193-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <af38bfef-eafb-c124-92cf-eede945815cd@lyle.org>
Date: Mon, 5 Mar 2018 13:55:44 -0800
MIME-Version: 1.0
In-Reply-To: <1517369453-28193-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

LGTM, applied

On 01/30/2018 07:30 PM, tang.junhui@zte.com.cn wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> In bch_mca_scan(), the return value should not be the number of freed btree
> nodes, but the number of pages of freed btree nodes.
> 
> Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
> ---
>  drivers/md/bcache/btree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index 81e8dc3..a5fbccc 100644
> --- a/drivers/md/bcache/btree.c
> +++ b/drivers/md/bcache/btree.c
> @@ -718,7 +718,7 @@ static unsigned long bch_mca_scan(struct shrinker *shrink,
>  	}
>  out:
>  	mutex_unlock(&c->bucket_lock);
> -	return freed;
> +	return freed * c->btree_pages;
>  }
>  
>  static unsigned long bch_mca_count(struct shrinker *shrink,
> 
