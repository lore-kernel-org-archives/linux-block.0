Return-Path: <hare@suse.de>
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
To: Jens Axboe <axboe@kernel.dk>, Johannes Thumshirn <jthumshirn@suse.de>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <20170111134312.GH6286@linux-x5ow.site>
 <cc00cc1f-17d7-105e-ef2c-61791b7cc676@kernel.dk>
Cc: linux-block@vger.kernel.org, Linux-scsi@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@infradead.org>, Keith Busch <keith.busch@intel.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <9d23f03f-5094-98bc-3c6d-e263801bed61@suse.de>
Date: Wed, 11 Jan 2017 16:16:56 +0100
MIME-Version: 1.0
In-Reply-To: <cc00cc1f-17d7-105e-ef2c-61791b7cc676@kernel.dk>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/11/2017 04:07 PM, Jens Axboe wrote:
> On 01/11/2017 06:43 AM, Johannes Thumshirn wrote:
>> Hi all,
>>
>> I'd like to attend LSF/MM and would like to discuss polling for block drivers.
>>
>> Currently there is blk-iopoll but it is neither as widely used as NAPI in the
>> networking field and accoring to Sagi's findings in [1] performance with
>> polling is not on par with IRQ usage.
>>
>> On LSF/MM I'd like to whether it is desirable to have NAPI like polling in
>> more block drivers and how to overcome the currently seen performance issues.
> 
> It would be an interesting topic to discuss, as it is a shame that blk-iopoll
> isn't used more widely.
> 
Indeed; some drivers like lpfc already _have_ a polling mode, but not
hooked up to blk-iopoll. Would be really cool to get that going.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
