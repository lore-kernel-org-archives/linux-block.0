Return-Path: <zhangweiping@didichuxing.com>
Date: Mon, 28 Aug 2017 20:22:05 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block, scheduler: convert xxx_var_store to void
Message-ID: <20170828122156.GA29322@localhost.didichuxing.com>
References: <20170824171127.GA25877@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170824171127.GA25877@localhost.didichuxing.com>
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

On Fri, Aug 25, 2017 at 01:11:33AM +0800, weiping zhang wrote:
> The last parameter "count" never be used in xxx_var_store,
> convert these functions to void.
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
>  block/bfq-iosched.c      | 33 +++++++++++++++++----------------
>  block/cfq-iosched.c      | 13 ++++++-------
>  block/deadline-iosched.c |  9 ++++-----
>  block/mq-deadline.c      |  9 ++++-----
>  4 files changed, 31 insertions(+), 33 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 436b6ca..7a4085d 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4787,16 +4787,13 @@ static ssize_t bfq_var_show(unsigned int var, char *page)
>  	return sprintf(page, "%u\n", var);
>  }
>  
> -static ssize_t bfq_var_store(unsigned long *var, const char *page,
> -			     size_t count)
> +static void bfq_var_store(unsigned long *var, const char *page)
>  {
>  	unsigned long new_val;
>  	int ret = kstrtoul(page, 10, &new_val);
>  
>  	if (ret == 0)
>  		*var = new_val;
> -
> -	return count;
>  }
>  
>  #define SHOW_FUNCTION(__FUNC, __VAR, __CONV)				\
> @@ -4838,7 +4835,7 @@ __FUNC(struct elevator_queue *e, const char *page, size_t count)	\
>  {									\
>  	struct bfq_data *bfqd = e->elevator_data;			\
>  	unsigned long uninitialized_var(__data);			\
> -	int ret = bfq_var_store(&__data, (page), count);		\
> +	bfq_var_store(&__data, (page));					\
>  	if (__data < (MIN))						\
>  		__data = (MIN);						\
>  	else if (__data > (MAX))					\
> @@ -4849,7 +4846,7 @@ __FUNC(struct elevator_queue *e, const char *page, size_t count)	\
>  		*(__PTR) = (u64)__data * NSEC_PER_MSEC;			\
>  	else								\
>  		*(__PTR) = __data;					\
> -	return ret;							\
> +	return count;							\
>  }


Hi Jens,

Would you please look this misc patch at your convenience ?

Thanks
