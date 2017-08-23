Return-Path: <hch@lst.de>
Date: Wed, 23 Aug 2017 20:08:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 4/5] skd: Avoid double completions in case of a timeout
Message-ID: <20170823180837.GF5802@lst.de>
References: <20170823175633.12680-1-bart.vanassche@wdc.com> <20170823175633.12680-5-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170823175633.12680-5-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although as a follow on I would also move the debug printks
from skd_end_request to skd_softirq_done, then remove skd_end_request
and rename skd_softirq_done to skd_complete_rq to fit what other
drivers are doing a little more closely.
