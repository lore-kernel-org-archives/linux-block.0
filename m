Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60049 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751475AbeCOQa6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 12:30:58 -0400
Subject: Re: [PATCH 12/16] bcache: Make it easier for static analyzers to
 analyze bch_allocator_thread()
To: Bart Van Assche <bart.vanassche@wdc.com>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
 <20180315150814.9412-13-bart.vanassche@wdc.com>
From: Coly Li <colyli@suse.de>
Message-ID: <bed0d218-75f8-2f6a-04f6-3e0c19563ef8@suse.de>
Date: Fri, 16 Mar 2018 00:29:49 +0800
MIME-Version: 1.0
In-Reply-To: <20180315150814.9412-13-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 15/03/2018 11:08 PM, Bart Van Assche wrote:
> This patch does not change any functionality but avoids that smatch
> reports the following:
> 
> drivers/md/bcache/alloc.c:334: bch_allocator_thread() error: uninitialized symbol 'bucket'.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

Hi Bart,

Your change is OK to me, but the original code seems OK too. Can I say
this is a bug should be fixed from smatch ?

Thanks.

Coly Li

> ---
>  drivers/md/bcache/alloc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
> index 458e1d38577d..6a98d48c5f5f 100644
> --- a/drivers/md/bcache/alloc.c
> +++ b/drivers/md/bcache/alloc.c
> @@ -316,6 +316,7 @@ static int bch_allocator_push(struct cache *ca, long bucket)
>  static int bch_allocator_thread(void *arg)
>  {
>  	struct cache *ca = arg;
> +	long bucket;
>  
>  	mutex_lock(&ca->set->bucket_lock);
>  
> @@ -325,11 +326,7 @@ static int bch_allocator_thread(void *arg)
>  		 * possibly issue discards to them, then we add the bucket to
>  		 * the free list:
>  		 */
> -		while (!fifo_empty(&ca->free_inc)) {
> -			long bucket;
> -
> -			fifo_pop(&ca->free_inc, bucket);
> -
> +		while (fifo_pop(&ca->free_inc, bucket)) {
>  			if (ca->discard) {
>  				mutex_unlock(&ca->set->bucket_lock);
>  				blkdev_issue_discard(ca->bdev,
> 
