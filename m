Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 02/16] blk-mq: abstract out queue map
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-3-axboe@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <725b4d35-2390-58d9-4041-0bac6de6cd77@grimberg.me>
Date: Tue, 30 Oct 2018 17:31:08 -0700
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-3-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> @@ -41,12 +41,12 @@ int blk_mq_rdma_map_queues(struct blk_mq_tag_set *set,
>   			goto fallback;
>   
>   		for_each_cpu(cpu, mask)
> -			set->mq_map[cpu] = queue;
> +			set->map[0].mq_map[cpu] = queue;

Any reason not to change the signature like the other mappers?
