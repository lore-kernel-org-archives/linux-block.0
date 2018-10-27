Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 01/14] blk-mq: kill q->mq_map
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-2-axboe@kernel.dk>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <f0b01bcc-fa62-880d-80ef-c44095d82077@oracle.com>
Date: Sat, 27 Oct 2018 22:19:29 +0800
MIME-Version: 1.0
In-Reply-To: <20181025211626.12692-2-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens

On 10/26/18 5:16 AM, Jens Axboe wrote:
> It's just a pointer to set->mq_map, use that instead.
Instead of using the set->mq_map and then a two-dimensional set->mq_map,
how about migrate the mq_map from per-set to per-cpuctx ?
something like:
q->queue_hw_ctx[ctx->map[type]]


Thanks
Jianchao
