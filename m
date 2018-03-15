Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752503AbeCOPwI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:52:08 -0400
Subject: Re: [PATCH 05/16] bcache: Remove an unused variable
To: Bart Van Assche <bart.vanassche@wdc.com>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
 <20180315150814.9412-6-bart.vanassche@wdc.com>
From: Coly Li <colyli@suse.de>
Message-ID: <a6a8975e-9a74-3f5c-c51f-57dcef7ce0e8@suse.de>
Date: Thu, 15 Mar 2018 23:51:14 +0800
MIME-Version: 1.0
In-Reply-To: <20180315150814.9412-6-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 15/03/2018 11:08 PM, Bart Van Assche wrote:
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

Hi Bart,

I suggest to add at least one line commit log, thanks in advance for it :-)

Coly Li

> ---
>  drivers/md/bcache/extents.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/md/bcache/extents.c b/drivers/md/bcache/extents.c
> index f9d391711595..c334e6666461 100644
> --- a/drivers/md/bcache/extents.c
> +++ b/drivers/md/bcache/extents.c
> @@ -534,7 +534,6 @@ static bool bch_extent_bad_expensive(struct btree *b, const struct bkey *k,
>  static bool bch_extent_bad(struct btree_keys *bk, const struct bkey *k)
>  {
>  	struct btree *b = container_of(bk, struct btree, keys);
> -	struct bucket *g;
>  	unsigned i, stale;
>  
>  	if (!KEY_PTRS(k) ||
> @@ -549,7 +548,6 @@ static bool bch_extent_bad(struct btree_keys *bk, const struct bkey *k)
>  		return false;
>  
>  	for (i = 0; i < KEY_PTRS(k); i++) {
> -		g = PTR_BUCKET(b->c, k, i);
>  		stale = ptr_stale(b->c, k, i);
>  
>  		btree_bug_on(stale > 96, b,
> 
