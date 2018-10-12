Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Subject: Re: [PATCHv5 0/3] Deprecate DAC960 driver
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>,
 James Bottomley <james.bottomley@hansenpartnership.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20181012071548.129113-1-hare@suse.de>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <374ac361-6100-dc25-6745-7b6ed521fba5@acm.org>
Date: Fri, 12 Oct 2018 06:38:17 -0700
MIME-Version: 1.0
In-Reply-To: <20181012071548.129113-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/12/18 12:15 AM, Hannes Reinecke wrote:
> Hi all,
> 
> as we're trying to get rid of the remaining request_fn drivers here's
> a patchset to move the DAC960 driver to the SCSI stack.
> As per request from hch I've split up the driver into two new SCSI
> drivers called 'myrb' and 'myrs'.

Hi Hannes,

Apparently only patches 1/3 and 2/3 made it to the linux-scsi mailing 
list but patch 3/3 not. See also 
https://marc.info/?l=linux-scsi&r=3&b=201810&w=2.

Bart.
