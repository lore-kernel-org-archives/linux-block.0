Return-Path: <hch@lst.de>
Date: Thu, 28 Jun 2018 16:31:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
	Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH] block: Fix cloning of requests with a special payload
Message-ID: <20180628143139.GA16624@lst.de>
References: <20180627195518.13958-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180627195518.13958-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Thanks,

this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
