Return-Path: <hare@suse.de>
Subject: Re: [PATCH] Revert "loop: support 4k physical blocksize"
To: Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@osandov.com>,
 linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Ming Lei <ming.lei@redhat.com>,
 Karel Zak <kzak@redhat.com>, Milan Broz <gmazyland@gmail.com>
References: <7e96dfd9a867e2dc16e472f8623c67fad399f6af.1503525187.git.osandov@fb.com>
 <ab75358c-dec4-7559-8449-e772b9ac9bab@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b9805a67-7a3c-a8bf-467f-d208ea34690a@suse.de>
Date: Thu, 24 Aug 2017 08:12:38 +0200
MIME-Version: 1.0
In-Reply-To: <ab75358c-dec4-7559-8449-e772b9ac9bab@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/23/2017 11:59 PM, Jens Axboe wrote:
> On 08/23/2017 03:54 PM, Omar Sandoval wrote:
>> From: Omar Sandoval <osandov@fb.com>
>>
>> There's some stuff still up in the air, let's not get stuck with a
>> subpar ABI. I'll follow up with something better for 4.14.
> 
> I think that's a good idea, there was already too much late churn
> fixing up the 4k support. Dropped the fixups, added this.
> 
<sigh>

I'll never get it upstream ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
