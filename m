Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Roman Pen <roman.penyaev@profitbricks.com>, Hannes Reinecke <hare@suse.com>
References: <20171027044330.11921-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7921fc66-16de-200b-cc0f-02cf52ef9002@kernel.dk>
Date: Tue, 31 Oct 2017 14:29:32 -0600
MIME-Version: 1.0
In-Reply-To: <20171027044330.11921-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/26/2017 10:43 PM, Ming Lei wrote:
> Hi Jens,
> 
> The 1st patch removes the RESTART for TAG-SHARED because SCSI handles it
> by itself, and not necessary to waste CPU to do the expensive RESTART.
> And Roman Pen reported that this RESTART cuts half of IOPS in his case.
> 
> The 2nd patch removes the RESTART when .get_budget returns BLK_STS_RESOURCE,
> and this RESTART is handled by SCSI's RESTART(scsi_end_request()) too.

What base is this against?

-- 
Jens Axboe
