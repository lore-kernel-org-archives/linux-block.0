Return-Path: <maxg@mellanox.com>
Subject: Re: [PATCH 0/3] Move tagset reinit to its only current consumer,
 nvme-core
To: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, Christoph Hellwig <hch@lst.de>
References: <1504711832-28425-1-git-send-email-sagi@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <a9b25790-1998-102c-cabc-d7647a4c070a@mellanox.com>
Date: Thu, 7 Sep 2017 13:07:18 +0300
MIME-Version: 1.0
In-Reply-To: <1504711832-28425-1-git-send-email-sagi@grimberg.me>
Content-Type: text/plain; charset="windows-1255"; format=flowed
Return-Path: maxg@mellanox.com
List-ID: <linux-block@vger.kernel.org>



On 9/6/2017 6:30 PM, Sagi Grimberg wrote:
> As suggested by Bart Van Assche, get rid of
> blk_mq_reinit_tagset and move it to nvme-core (its
> only current consumer).
> 
> Instead, introduce a more generic tagset iterator helper.
> 
> Sagi Grimberg (3):
>    block: introduce blk_mq_tagset_iter
>    nvme: introduce nvme_reinit_tagset
>    block: remove blk_mq_reinit_tagset
> 
>   block/blk-mq-tag.c       | 11 +++++------
>   drivers/nvme/host/core.c | 13 +++++++++++++
>   drivers/nvme/host/fc.c   |  3 ++-
>   drivers/nvme/host/nvme.h |  2 ++
>   drivers/nvme/host/rdma.c |  7 +++----
>   include/linux/blk-mq.h   |  4 ++--
>   6 files changed, 27 insertions(+), 13 deletions(-)
> 

The series looks good to me,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>

BTW, if we talking about the reinit_tagset, can you explain the 
motivation for dereg_mr and alloc new mr for the RDMA transport layer ?
we don't do it in iSER/SRP so I wonder what is special here ?
I got some local protection errors in MP tests and under high load FIO 
(that cause cmd TMO to expire and abort the cmds and then reconnect).
I wonder if there is a connection between the two. I'm also debugging a 
situation that we might have free/dereg/local_invalidate the MR before 
the QP moved to ERR state.
