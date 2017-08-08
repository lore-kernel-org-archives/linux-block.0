Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Tue, 8 Aug 2017 15:30:36 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, brking@linux.vnet.ibm.com,
	bart.vanassche@wdc.com
Subject: Re: [PATCH 2/6] block: pass in queue to inflight accounting
Message-ID: <20170808223036.GD4072@vader.DHCP.thefacebook.com>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
 <1501859062-11120-3-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501859062-11120-3-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Aug 04, 2017 at 09:04:18AM -0600, Jens Axboe wrote:
> No functional change in this patch, just in preparation for
> basing the inflight mechanism on the queue in question.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Omar Sandoval <osandov@fb.com>
