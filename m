Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 07/24] ibtrs: client: sysfs interface functions
To: Roman Pen <roman.penyaev@profitbricks.com>, linux-block@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Or Gerlitz <ogerlitz@mellanox.com>,
 Danil Kipnis <danil.kipnis@profitbricks.com>,
 Jack Wang <jinpu.wang@profitbricks.com>
References: <20180202140904.2017-1-roman.penyaev@profitbricks.com>
 <20180202140904.2017-8-roman.penyaev@profitbricks.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1e874694-b30e-d957-6b48-edefe8e41c9a@grimberg.me>
Date: Mon, 5 Feb 2018 13:20:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180202140904.2017-8-roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Roman,

> This is the sysfs interface to IBTRS sessions on client side:
> 
>    /sys/kernel/ibtrs_client/<SESS-NAME>/
>      *** IBTRS session created by ibtrs_clt_open() API call
>      |
>      |- max_reconnect_attempts
>      |  *** number of reconnect attempts for session
>      |
>      |- add_path
>      |  *** adds another connection path into IBTRS session
>      |
>      |- paths/<DEST-IP>/
>         *** established paths to server in a session
>         |
>         |- disconnect
>         |  *** disconnect path
>         |
>         |- reconnect
>         |  *** reconnect path
>         |
>         |- remove_path
>         |  *** remove current path
>         |
>         |- state
>         |  *** retrieve current path state
>         |
>         |- stats/
>            *** current path statistics
>            |
> 	  |- cpu_migration
> 	  |- rdma
> 	  |- rdma_lat
> 	  |- reconnects
> 	  |- reset_all
> 	  |- sg_entries
> 	  |- wc_completions
> 
> Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
> Signed-off-by: Danil Kipnis <danil.kipnis@profitbricks.com>
> Cc: Jack Wang <jinpu.wang@profitbricks.com>

I think stats usually belong in debugfs.
