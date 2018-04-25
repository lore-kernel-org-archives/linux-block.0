Return-Path: <sth@linux.vnet.ibm.com>
Subject: Re: [PATCH] Revert "blk-mq: remove code for dealing with remapping
 queue"
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Ewan Milne <emilne@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20180424200144.16179-1-ming.lei@redhat.com>
From: Stefan Haberland <sth@linux.vnet.ibm.com>
Date: Wed, 25 Apr 2018 17:45:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180424200144.16179-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <02eea71b-2fcf-6700-315d-db984f802049@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On 24.04.2018 22:01, Ming Lei wrote:
> This reverts commit 37c7c6c76d431dd7ef9c29d95f6052bd425f004c.
>
> Turns out some drivers(most are FC drivers) may not use managed
> IRQ affinity, and has their customized .map_queues meantime, so
> still keep this code for avoiding regression.
>
> Reported-by: Laurence Oberman <loberman@redhat.com>
> Cc: Ewan Milne <emilne@redhat.com>
> Cc: Stefan Haberland <sth@linux.vnet.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>

Tested-by: Stefan Haberland <sth@linux.vnet.ibm.com>
