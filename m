Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHv6 0/3] Deprecate DAC960 driver
To: Hannes Reinecke <hare@suse.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>,
 James Bottomley <james.bottomley@hansenpartnership.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20181017152513.136526-1-hare@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <965bd811-98fb-394c-2a31-a71241b1ef1b@kernel.dk>
Date: Wed, 17 Oct 2018 09:43:44 -0600
MIME-Version: 1.0
In-Reply-To: <20181017152513.136526-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/17/18 9:25 AM, Hannes Reinecke wrote:
> Hi all,
> 
> as we're trying to get rid of the remaining request_fn drivers here's
> a patchset to move the DAC960 driver to the SCSI stack.
> As per request from hch I've split up the driver into two new SCSI
> drivers called 'myrb' and 'myrs'.
> 
> The 'myrb' driver only supports the earlier (V1) firmware interface, which
> doesn't have a SCSI interface for the logical drives; for those I've added
> a (pretty rudimentary, admittedly) SCSI translation for them.
> 
> The 'myrs' driver supports the newer (V2) firmware interface, which is
> SCSI based and doesn't need the translation layer.
> 
> And the weird proc interface from DAC960 has been converted to sysfs attributes.
> 
> Tested with eXtremeRAID 1100 (for V1 Firmware) and Mylex AcceleRAID 170
> (for V2 Firmware).

Applied 3/3 in for-4.20/block

-- 
Jens Axboe
