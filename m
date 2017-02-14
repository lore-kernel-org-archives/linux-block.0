Return-Path: <hare@suse.de>
Subject: Re: [PATCH BUGFIX] block: make elevator_get robust against cross
 blk/blk-mq choice
To: Omar Sandoval <osandov@osandov.com>
References: <20170213210107.4848-1-paolo.valente@linaro.org>
 <20170213210107.4848-2-paolo.valente@linaro.org>
 <20170213220900.GA11052@vader.DHCP.thefacebook.com>
 <89b98d59-fcae-6b13-a6a1-6fe62967929d@kernel.dk>
 <d6e69d7b-dc69-90ec-0130-dc774fd4da2a@suse.de> <20170214070727.GA19880@vader>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>,
 Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
 linus.walleij@linaro.org, broonie@kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <847276bd-5242-1434-5f41-75fedb900a32@suse.de>
Date: Tue, 14 Feb 2017 08:11:46 +0100
MIME-Version: 1.0
In-Reply-To: <20170214070727.GA19880@vader>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/14/2017 08:07 AM, Omar Sandoval wrote:
> On Tue, Feb 14, 2017 at 07:58:22AM +0100, Hannes Reinecke wrote:
>> While we're at the topic:
>>
>> Can't we use the same names for legacy and mq scheduler?
>> It's quite an unnecessary complication to have
>> 'noop', 'deadline', and 'cfq' for legacy, but 'none' and 'mq-deadline'
>> for mq. If we could use 'noop' and 'deadline' for mq, too, the existing
>> settings or udev rules will continue to work and we wouldn't get any
>> annoying and pointless warnings here...
> 
> I mentioned this to Jens a little while ago but I didn't feel strongly
> enough to push the issue. I also like this idea -- it makes the
> transition to blk-mq a little more transparent.
> 
And saves us _a lot_ of support cases :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
