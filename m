Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 8 Sep 2017 07:48:09 -0700
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	lizefan@huawei.com, tglx@linutronix.de, kernel-team@fb.com,
	axboe@kernel.dk, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 3/3] block/loop: make loop cgroup aware
Message-ID: <20170908144808.GA1774378@devbig577.frc2.facebook.com>
References: <cover.1504748195.git.shli@fb.com>
 <83915a4be672d99729029800196008c3b39c7a3a.1504748195.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <83915a4be672d99729029800196008c3b39c7a3a.1504748195.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Wed, Sep 06, 2017 at 07:00:53PM -0700, Shaohua Li wrote:
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 9d4545f..9850b27 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -482,6 +482,8 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
>  {
>  	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
>  
> +	if (cmd->css)
> +		css_put(cmd->css);
>  	cmd->ret = ret > 0 ? 0 : ret;
>  	lo_rw_aio_do_completion(cmd);

The fact that we're forwarding explicitly in loop still bothers me a
bit.  Can you please elaborate why we don't want to do this
generically through aio?

Thanks.

-- 
tejun
