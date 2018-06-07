Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block changes for 4.18-rc
To: Kent Overstreet <kent.overstreet@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, linux-block <linux-block@vger.kernel.org>,
 NeilBrown <neilb@suse.com>, Arnd Bergmann <arnd@arndb.de>
References: <11b01169-8e11-34ed-8137-aa5cd50a39c2@kernel.dk>
 <CA+55aFy6_+90WKyDAbhh0NcN22N11AyaCaJu0nrafmf49+h6tQ@mail.gmail.com>
 <52aaf207-ef5d-a886-66fe-566de9d9bbee@kernel.dk>
 <CA+55aFz_iLabbCcCEWY8j5KcKCDsC7074f4EDi8mxB7-FrBHwA@mail.gmail.com>
 <20180604182017.GA1351649@devbig577.frc2.facebook.com>
 <CA+55aFwOjtyPODy2U9vBQjxjXYq=veRzvMS2Uwdt8f1erRXe1A@mail.gmail.com>
 <f35436ab-bdac-5277-d0d2-b8432c620aff@kernel.dk>
 <20180604190428.GA30325@kmo-pixel>
 <CA+55aFyv5v7S_Qj0WwxE0foK69p+WVeDrq1ZKD9EJfP20sJboQ@mail.gmail.com>
 <20180605005614.GE30325@kmo-pixel>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d4f35b68-6e05-098c-8c14-e8bd19dd00ce@kernel.dk>
Date: Wed, 6 Jun 2018 19:45:14 -0600
MIME-Version: 1.0
In-Reply-To: <20180605005614.GE30325@kmo-pixel>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/4/18 6:56 PM, Kent Overstreet wrote:
> On Mon, Jun 04, 2018 at 05:42:04PM -0700, Linus Torvalds wrote:
>> On Mon, Jun 4, 2018 at 12:04 PM Kent Overstreet
>> <kent.overstreet@gmail.com> wrote:
>>>
>>> However, that's not correct as is because mddev_delayed_put() calls
>>> kobject_put(), and the kobject isn't initialized when the mddev is first
>>> allocated, it's initialized when the gendisk is allocated... that isn't hard to
>>> fix but that's getting into real refactoring that I'll need to put actual work
>>> into testing.
>>
>> Well, it also removes the bioset_exit() calls entirely.
> 
> Yeah, I realized that when I went back to finish that patch
>>
>> How about just the attached?
>>
>> It simply does it as two different cases, and adds the bioset_exit()
>> calls to mddev_delayed_delete().
> 
> Oh right, just taking advantage of the fact that just the queue_work() needs to
> be under the spinlock, not the actual free in the other case.
> 
> I like your patch for a less invasive version, but I did finish and test my
> version, which deletes more code :)
> 
> I've already gone to the trouble of coming up with a VM smoketest, so I can test
> yours too... I don't really have a strong opinion on which patch should go in.

Kent, care to submit a proper version? We should get this in.

-- 
Jens Axboe
