Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Fix queue usage on failed request allocation
To: Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Cc: Max Gurtovoy <maxg@mellanox.com>, Ming Lei <minlei@redhat.com>
References: <1502743211-14992-1-git-send-email-keith.busch@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5fe259b8-540e-573f-ba23-50a66712c20d@kernel.dk>
Date: Tue, 15 Aug 2017 07:22:50 -0600
MIME-Version: 1.0
In-Reply-To: <1502743211-14992-1-git-send-email-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/14/2017 02:40 PM, Keith Busch wrote:
> blk_mq_get_request() does not release the callers queue usage counter
> when allocation fails. The caller still needs to account for its own
> queue usage when it is unable to allocate a request.

Thanks Keith, applied.

-- 
Jens Axboe
