Return-Path: <axboe@kernel.dk>
Subject: Re: clean up physical merging helpers V2
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20180924074355.2802-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <dae7788b-9b0f-bb51-820e-ab626d157e23@kernel.dk>
Date: Mon, 24 Sep 2018 12:35:08 -0600
MIME-Version: 1.0
In-Reply-To: <20180924074355.2802-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/24/18 1:43 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series moves various helpers related to merging based on physical
> addresses from the public headers into block/, cleans up the code a bit
> and removes not nessecary includes from the block headers.
> 
> Change since V1:
>  - dropped the Xen related changed which are moved into a new series
>    to be sent after this one

Looks good to me - #1 should just go to the arm guys separately, there's
no point in me carrying this arch patch.

-- 
Jens Axboe
