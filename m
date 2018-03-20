Return-Path: <dongsheng.yang@easystack.cn>
Subject: Re: [PATCH] rbd: fix spelling mistake: "reregisteration" ->
 "re-registration"
To: Colin King <colin.king@canonical.com>, Ilya Dryomov <idryomov@gmail.com>,
 Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20180319133310.4251-1-colin.king@canonical.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Message-ID: <5AB0E3D5.6090301@easystack.cn>
Date: Tue, 20 Mar 2018 18:35:01 +0800
MIME-Version: 1.0
In-Reply-To: <20180319133310.4251-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Colin,

On 03/19/2018 09:33 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in rdb_warn message text
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/block/rbd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 1e03b04819c8..7b97240ff15e 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3887,7 +3887,7 @@ static void rbd_reregister_watch(struct work_struct *work)
>   
>   	ret = rbd_dev_refresh(rbd_dev);
>   	if (ret)
> -		rbd_warn(rbd_dev, "reregisteration refresh failed: %d", ret);
> +		rbd_warn(rbd_dev, "re-registration refresh failed: %d", ret);

Hmmm, I am not sure is that a spelling mistake, because the function 
name is rbd_reregister_watch().

Thanx
Yang
>   }
>   
>   /*
