Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: handle partial completions for special payload
 requests
To: Christoph Hellwig <hch@lst.de>
References: <20170511103438.26717-1-hch@lst.de>
Cc: abdhalee@linux.vnet.ibm.com, martin.petersen@oracle.com,
 linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <32352d74-5ff6-f7e2-7949-5721b910415f@kernel.dk>
Date: Thu, 11 May 2017 08:09:12 -0600
MIME-Version: 1.0
In-Reply-To: <20170511103438.26717-1-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/11/2017 04:34 AM, Christoph Hellwig wrote:
> SCSI devices can return short writes on Write Same just like for normal
> writes, so we need to handle this case for our special payload requests
> as well.

Added for 4.12-rc1, thanks Christoph.

-- 
Jens Axboe
