Return-Path: <msnitzer@redhat.com>
Date: Fri, 19 Jan 2018 12:20:26 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/3] blk-mq: Rename blk_mq_request_direct_issue() into
 blk_mq_request_issue_directly()
Message-ID: <20180119172026.GA29664@redhat.com>
References: <20180119165856.17677-1-bart.vanassche@wdc.com>
 <20180119165856.17677-2-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119165856.17677-2-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jan 19 2018 at 11:58am -0500,
Bart Van Assche <bart.vanassche@wdc.com> wrote:

> Most blk-mq functions have a name that follows the pattern blk_mq_${action}.
> However, the function name blk_mq_request_direct_issue is an exception.
> Hence rename this function. This patch does not change any functionality.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>
