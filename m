Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Finish renaming REQ_DISCARD into REQ_OP_DISCARD
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@wdc.com>, Mike Christie
 <mchristi@redhat.com>, "Martin K . Petersen" <martin.petersen@oracle.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>
References: <20181003205625.27554-1-bvanassche@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <89e42732-4ec3-148e-0b8f-9c0f53c8ab17@kernel.dk>
Date: Wed, 3 Oct 2018 16:12:40 -0600
MIME-Version: 1.0
In-Reply-To: <20181003205625.27554-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/3/18 2:56 PM, Bart Van Assche wrote:
> From: Bart Van Assche <bart.vanassche@wdc.com>
> 
> Some time ago REQ_DISCARD was renamed into REQ_OP_DISCARD. Some comments
> and documentation files were not updated however. Update these comments
> and documentation files. See also commit 4e1b2d52a80d ("block, fs,
> drivers: remove REQ_OP compat defs and related code").

Applied, thanks.

-- 
Jens Axboe
