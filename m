Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] elevator: allow specifying elevator by config boot param
 for blk-mq devices
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alex Ivanov <yourbestfriend@openmailbox.org>, linux-block@vger.kernel.org
References: <20170712185708.5987-1-yourbestfriend@openmailbox.org>
 <0661f4cc-a5dc-5747-dd38-de78586843a2@kernel.dk>
 <20170713101154.GH5212@linux-x5ow.site>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <49033d7d-8941-3c17-962f-dab170401bcf@kernel.dk>
Date: Thu, 13 Jul 2017 08:02:41 -0600
MIME-Version: 1.0
In-Reply-To: <20170713101154.GH5212@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/13/2017 04:11 AM, Johannes Thumshirn wrote:
> On Wed, Jul 12, 2017 at 04:51:33PM -0600, Jens Axboe wrote:
>> No, that boot option was a mistake, let's not propagate that to mq
>> scheduling as well.
> 
> Can you please explain why? I as well have requests from our users to
> select the mq schedulers on the command line.

Because it sucks as an interface - there's no way to apply different
settings to different devices, and using the kernel command line to
control something like this is ugly. It never should have been done.

The sysfs interface, either manually, scripted, or through udev,
makes a lot more sense.

-- 
Jens Axboe
