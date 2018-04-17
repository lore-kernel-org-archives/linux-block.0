Return-Path: <hch@lst.de>
Date: Tue, 17 Apr 2018 17:15:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Wakko Warner <wakko@animx.eu.org>,
	Bart Van Assche <Bart.VanAssche@wdc.com>,
	target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
	"Nicholas A. Bellinger" <nab@linux-iscsi.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] target: fix crash with iscsi target and dvd
Message-ID: <20180417151502.GB24654@lst.de>
References: <20180416094841.30212-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180416094841.30212-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Btw, seems like someone needs to volunteer for putting together a pull
request with target fixes for Linus - I haven't heard from Nic for
a while, and we've got quite a few fixes out on the list.
