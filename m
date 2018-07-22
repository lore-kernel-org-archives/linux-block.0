Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: fail the request in case issue failure
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Kashyap Desai <kashyap.desai@broadcom.com>,
 Laurence Oberman <loberman@redhat.com>, Omar Sandoval <osandov@fb.com>,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>,
 Hannes Reinecke <hare@suse.de>, kernel test robot <rong.a.chen@intel.com>,
 LKP <lkp@01.org>
References: <20180722061015.761-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <481357c8-a51d-2d45-e165-b0230f4296c4@kernel.dk>
Date: Sun, 22 Jul 2018 17:32:00 -0600
MIME-Version: 1.0
In-Reply-To: <20180722061015.761-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/22/18 12:10 AM, Ming Lei wrote:
> Inside blk_mq_try_issue_list_directly(), if the request is issued as
> failed, we shouldn't try to do it again, otherwise the warning in
> blk_mq_start_request() will be triggered. This change is aligned to
> behaviour of other ways of request issue & dispatch.

Applied, thanks.

-- 
Jens Axboe
