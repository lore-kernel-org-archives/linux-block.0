Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34465 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751679AbeCORBN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 13:01:13 -0400
Subject: Re: [PATCH 13/16] bcache: Make bch_dump_read() fail if copying to
 user space fails
To: Bart Van Assche <bart.vanassche@wdc.com>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-bcache <linux-bcache@vger.kernel.org>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
 <20180315150814.9412-14-bart.vanassche@wdc.com>
From: Coly Li <colyli@suse.de>
Message-ID: <f72260be-9288-37c3-c7c8-a6f9a7d3955d@suse.de>
Date: Fri, 16 Mar 2018 01:00:08 +0800
MIME-Version: 1.0
In-Reply-To: <20180315150814.9412-14-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 15/03/2018 11:08 PM, Bart Van Assche wrote:
> copy_to_user() returns the number of remaining bytes. Avoid that
> a larger value is returned than the number of bytes that have
> been copied by returning -EFAULT if not all bytes have been copied.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> ---
>  drivers/md/bcache/debug.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
> index af89408befe8..376899cfcbf1 100644
> --- a/drivers/md/bcache/debug.c
> +++ b/drivers/md/bcache/debug.c
> @@ -175,9 +175,8 @@ static ssize_t bch_dump_read(struct file *file, char __user *buf,
>  		struct keybuf_key *w;
>  		unsigned bytes = min(i->bytes, size);
>  
> -		int err = copy_to_user(buf, i->buf, bytes);
> -		if (err)
> -			return err;
> +		if (copy_to_user(buf, i->buf, bytes))
> +			return -EFAULT;
>  

Hi Bart,

I am not sure whether this change is correct. -EFAULT seems not an
expected return value of read(2), while -1 is the expected return value
when error occurs.

Maybe if copy_to_user() returns value in (0, size], "ret + (size - err)"
should be returned. An exception is when copy_to_user() returns 0 and
ret is 0 too, in this situation -1 should be returned.

Correct me if I am wrong.

Coly Li

>  		ret	 += bytes;
>  		buf	 += bytes;
> 
