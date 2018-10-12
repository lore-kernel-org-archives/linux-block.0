Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHv5 0/3] Deprecate DAC960 driver
To: Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>,
 James Bottomley <james.bottomley@hansenpartnership.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20181012071548.129113-1-hare@suse.de>
 <374ac361-6100-dc25-6745-7b6ed521fba5@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <398faf1f-cab9-9b51-f653-bc7e065c66eb@kernel.dk>
Date: Fri, 12 Oct 2018 10:39:37 -0600
MIME-Version: 1.0
In-Reply-To: <374ac361-6100-dc25-6745-7b6ed521fba5@acm.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/12/18 7:38 AM, Bart Van Assche wrote:
> On 10/12/18 12:15 AM, Hannes Reinecke wrote:
>> Hi all,
>>
>> as we're trying to get rid of the remaining request_fn drivers here's
>> a patchset to move the DAC960 driver to the SCSI stack.
>> As per request from hch I've split up the driver into two new SCSI
>> drivers called 'myrb' and 'myrs'.
> 
> Hi Hannes,
> 
> Apparently only patches 1/3 and 2/3 made it to the linux-scsi mailing 
> list but patch 3/3 not. See also 
> https://marc.info/?l=linux-scsi&r=3&b=201810&w=2.

I'm guessing it's just too big. I got it, but probably due to the CC.

-- 
Jens Axboe
