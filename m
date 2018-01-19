Return-Path: <msnitzer@redhat.com>
Date: Fri, 19 Jan 2018 12:22:51 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 3/3] block: Remove kblockd_schedule_delayed_work{,_on}()
Message-ID: <20180119172250.GC29664@redhat.com>
References: <20180119165856.17677-1-bart.vanassche@wdc.com>
 <20180119165856.17677-4-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119165856.17677-4-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jan 19 2018 at 11:58am -0500,
Bart Van Assche <bart.vanassche@wdc.com> wrote:

> The previous patch removed all users of these two functions. Hence
> also remove the functions themselves.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>
