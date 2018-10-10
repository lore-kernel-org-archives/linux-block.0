Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Subject: Re: [PATCHv4 0/3] Deprecate DAC960 driver
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 James Bottomley <james.bottomley@hansenpartnership.com>,
 Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org
References: <20181009152701.5542-1-hare@suse.de>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <5fc78ab4-37c5-b80a-9f23-b9c4c00ba2d9@acm.org>
Date: Tue, 9 Oct 2018 19:03:41 -0700
MIME-Version: 1.0
In-Reply-To: <20181009152701.5542-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/9/18 8:26 AM, Hannes Reinecke wrote:
> as we're trying to get rid of the remaining request_fn drivers here's
> a patchset to move the DAC960 driver to the SCSI stack.
> As per request from hch I've split up the driver into two new SCSI
> drivers called 'myrb' and 'myrs'.

Hi Hannes,

It seems like only patches 1/3 and 2/3 but not 3/3 made it to the list?
See e.g. https://marc.info/?a=105878808800002&r=1.

Thanks,

Bart.
