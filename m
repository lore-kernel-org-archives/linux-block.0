Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Revert "blk-mq: remove code for dealing with remapping
 queue"
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Ewan Milne <emilne@redhat.com>,
 Stefan Haberland <sth@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20180424200144.16179-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7e791ec9-7d45-f9c5-75be-fa356663eba0@kernel.dk>
Date: Wed, 25 Apr 2018 09:49:46 -0600
MIME-Version: 1.0
In-Reply-To: <20180424200144.16179-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/24/18 2:01 PM, Ming Lei wrote:
> This reverts commit 37c7c6c76d431dd7ef9c29d95f6052bd425f004c.
> 
> Turns out some drivers(most are FC drivers) may not use managed
> IRQ affinity, and has their customized .map_queues meantime, so
> still keep this code for avoiding regression.

Applied, thanks.

-- 
Jens Axboe
