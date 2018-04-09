Return-Path: <sth@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/8] blk-mq: fix and improve queue mapping
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20180408094814.28953-1-ming.lei@redhat.com>
From: Stefan Haberland <sth@linux.vnet.ibm.com>
Date: Mon, 9 Apr 2018 17:48:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180408094814.28953-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c74b18f0-6e0d-b0ec-7cbb-9233aebde43f@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On 08.04.2018 11:48, Ming Lei wrote:
> Hi Jens,
>
> The first two patches fix issues about queue mapping.
>
> The other 6 patches improve queue mapping for blk-mq.
>
> Christian, this patches should fix your issue, so please give
> a test, and the patches can be found in the following tree:
>
> 	https://github.com/ming1/linux/commits/v4.17-rc-blk-fix_mapping_v1
>
> Thanks,
> Ming

Hi Ming,

thanks for the patches.
Unfortunately I was not able to try them with your git tree since I ran 
into the same problem, that Li Wang reported today.
But your patches applied to our local git tree seem to work fine. A 
small DASD regression test showed no issues or warnings.

Regards,
Stefan
