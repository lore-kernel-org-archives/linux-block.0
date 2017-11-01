Return-Path: <ming.lei@redhat.com>
Date: Wed, 1 Nov 2017 09:46:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Omar Sandoval <osandov@fb.com>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Roman Pen <roman.penyaev@profitbricks.com>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Message-ID: <20171101014611.GA8200@ming.t460p>
References: <20171027044330.11921-1-ming.lei@redhat.com>
 <7921fc66-16de-200b-cc0f-02cf52ef9002@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7921fc66-16de-200b-cc0f-02cf52ef9002@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 31, 2017 at 02:29:32PM -0600, Jens Axboe wrote:
> On 10/26/2017 10:43 PM, Ming Lei wrote:
> > Hi Jens,
> > 
> > The 1st patch removes the RESTART for TAG-SHARED because SCSI handles it
> > by itself, and not necessary to waste CPU to do the expensive RESTART.
> > And Roman Pen reported that this RESTART cuts half of IOPS in his case.
> > 
> > The 2nd patch removes the RESTART when .get_budget returns BLK_STS_RESOURCE,
> > and this RESTART is handled by SCSI's RESTART(scsi_end_request()) too.
> 
> What base is this against?

The for-next branch of your block tree:

--
Ming
