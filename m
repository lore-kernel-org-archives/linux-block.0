Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] bsg-lib: don't free job in bsg_prepare_job
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 stable@vger.kernel.org
References: <20170907115436.5069-1-hch@lst.de>
 <20170907115436.5069-2-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ceb7daa1-7863-8fd3-4f9d-575dd2fe2d49@kernel.dk>
Date: Thu, 14 Sep 2017 22:31:34 -0600
MIME-Version: 1.0
In-Reply-To: <20170907115436.5069-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/07/2017 05:54 AM, Christoph Hellwig wrote:
> The job structure is allocated as part of the request, so we should not
> free it in the error path of bsg_prepare_job.

Added for this series, thanks.

-- 
Jens Axboe
