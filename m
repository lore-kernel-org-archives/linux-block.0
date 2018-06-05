Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: Consistently use request pointer in debug messages.
To: Josef Bacik <josef@toxicpanda.com>
Cc: kvigor@gmail.com, linux-block@vger.kernel.org, Kevin Vigor <kvigor@fb.com>
References: <1528130412-4541-1-git-send-email-kvigor@gmail.com>
 <10d1cb78-5d68-0301-ae5c-3d35ce68383a@kernel.dk>
 <20180605143005.m3bkudt4zydhllu7@destiny>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bc33c7b8-b70c-f2a9-56ac-7e87ed9da29f@kernel.dk>
Date: Tue, 5 Jun 2018 08:32:46 -0600
MIME-Version: 1.0
In-Reply-To: <20180605143005.m3bkudt4zydhllu7@destiny>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/5/18 8:30 AM, Josef Bacik wrote:
> On Tue, Jun 05, 2018 at 08:23:06AM -0600, Jens Axboe wrote:
>> On 6/4/18 10:40 AM, kvigor@gmail.com wrote:
>>> From: Kevin Vigor <kvigor@fb.com>
>>>
>>> Existing dev_dbg messages sometimes identify request using request
>>> pointer, sometimes using nbd_cmd pointer. This makes it hard to
>>> follow request flow. Consistently use request pointer instead.
>>
>> You're missing the Signed-off-by.
>>
> 
> Blah sorry, still a little foggy,
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Not you, Kevin :-)

-- 
Jens Axboe
