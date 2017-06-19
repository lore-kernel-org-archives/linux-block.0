Return-Path: <axboe@kernel.dk>
Subject: Re: [RESEND PATCH] nvme: host: unquiesce queue in nvme_kill_queues()
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
 linux-nvme@lists.infradead.org
References: <20170619022108.21902-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <65e6c1c0-ebe1-a9c1-7dfd-a85fa619d274@kernel.dk>
Date: Sun, 18 Jun 2017 20:53:46 -0600
MIME-Version: 1.0
In-Reply-To: <20170619022108.21902-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/18/2017 08:21 PM, Ming Lei wrote:
> When nvme_kill_queues() is run, queues may be in
> quiesced state, so we forcibly unquiesce queues to avoid
> blocking dispatch, and I/O hang can be avoided in
> remove path.
> 
> Peviously we use blk_mq_start_stopped_hw_queues() as
> counterpart of blk_mq_quiesce_queue(), now we have
> introduced blk_mq_unquiesce_queue(), so use it explicitly.

Thanks for updating it, added.

-- 
Jens Axboe
