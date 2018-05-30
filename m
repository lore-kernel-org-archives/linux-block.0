Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: clear DISCONNECT_REQUESTED flag once disconnection
 occurs.
To: kvigor@gmail.com, linux-block@vger.kernel.org
Cc: josef@toxicpanda.com, Kevin Vigor <kvigor@fb.com>
References: <1527635391-9156-1-git-send-email-kvigor@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <23eafc98-86d5-aa74-40fb-fd35a0112f0f@kernel.dk>
Date: Wed, 30 May 2018 09:41:50 -0600
MIME-Version: 1.0
In-Reply-To: <1527635391-9156-1-git-send-email-kvigor@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/29/18 5:09 PM, kvigor@gmail.com wrote:
> @@ -937,7 +946,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
>  		queue_work(recv_workqueue, &args->work);
>  
>  		atomic_inc(&config->live_connections);
> -		wake_up(&config->conn_wait);
> +		wake_up_all(&config->conn_wait);
>  		return 0;
>  	}
>  	sockfd_put(sock);

Unless you're using exclusive waits, and you are not, then wake_up() is
equivalent to wake_up_all().

-- 
Jens Axboe
