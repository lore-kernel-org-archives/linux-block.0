Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] elevator: allow specifying elevator by config boot param
 for blk-mq devices
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alex Ivanov <yourbestfriend@openmailbox.org>, linux-block@vger.kernel.org
References: <20170712185708.5987-1-yourbestfriend@openmailbox.org>
 <0661f4cc-a5dc-5747-dd38-de78586843a2@kernel.dk>
 <20170713101154.GH5212@linux-x5ow.site>
 <49033d7d-8941-3c17-962f-dab170401bcf@kernel.dk>
 <20170714064026.GB3484@linux-x5ow.site>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8080a6a6-ccc5-95d8-031b-01a156b2cd65@kernel.dk>
Date: Fri, 14 Jul 2017 08:26:52 -0600
MIME-Version: 1.0
In-Reply-To: <20170714064026.GB3484@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/14/2017 12:40 AM, Johannes Thumshirn wrote:
> On Thu, Jul 13, 2017 at 08:02:41AM -0600, Jens Axboe wrote:
>> Because it sucks as an interface - there's no way to apply different
>> settings to different devices, and using the kernel command line to
>> control something like this is ugly. It never should have been done.
>>
>> The sysfs interface, either manually, scripted, or through udev,
>> makes a lot more sense.
> 
> Not that I disagree with your reasons, but not being able to select a
> mq scheduler confuses quite some users out there.

Maybe we can add something about the API being deprecated, if someone
tries to select an mq scheduler. The old scheduler will die in due
course once that path goes away, and once that happens, we can kill
the parameter.

-- 
Jens Axboe
