Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH blktests 2/2] block/011: Perform PCI reset while doing IO
To: Omar Sandoval <osandov@osandov.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
 Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@fb.com>
References: <20170623142951.17189-1-jthumshirn@suse.de>
 <20170623142951.17189-2-jthumshirn@suse.de>
 <813a788b-58f6-f3d5-57f0-60d1d439a923@kernel.dk>
 <20170626140610.GA25745@linux-x5ow.site>
 <8581cda3-02c3-a8cc-073f-38d9e65ad096@kernel.dk>
 <20170626212934.GG6710@vader.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e23fd8bf-ecaf-2e86-49d5-ce500d47c817@kernel.dk>
Date: Mon, 26 Jun 2017 15:45:11 -0600
MIME-Version: 1.0
In-Reply-To: <20170626212934.GG6710@vader.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/26/2017 03:29 PM, Omar Sandoval wrote:
> On Mon, Jun 26, 2017 at 08:25:36AM -0600, Jens Axboe wrote:
>> On 06/26/2017 08:06 AM, Johannes Thumshirn wrote:
>>> On Fri, Jun 23, 2017 at 09:36:14AM -0600, Jens Axboe wrote:
>>>> On 06/23/2017 08:29 AM, Johannes Thumshirn wrote:
>>>>> From: Omar Sandoval <osandov@fb.com>
>>>>>
>>>>> This test-case performs I/O with fio while doing PCI disable/enable
>>>>> cycles.
>>>>>
>>>>> In the results we don't care for I/O errors but for hiccups in dmesg only.
>>>>
>>>> Let's get this in, that would be a very useful test. A few comments -
>>>> not necessarily on this patch in particular, but for future cleanups
>>>> and improvements.
>>>>
>>>>> +	if _test_dev_is_rotational; then
>>>>> +		size="32m"
>>>>> +	else
>>>>> +		size="1g"
>>>>> +	fi
>>>>
>>>> I introduced this idea in one of my previous patches. I wonder if we
>>>> should turn that into a helper. Pass in the dev, get returned a
>>>> suitable fio size, instead of hard coding this in each job that
>>>> needs it.
> 
> What I wanted to have here eventually is a helper that you can run when
> you just want arbitrary I/O. Haven't gotten around to it.

That would be handy. Until that happens, I would not worry about it,
it's not like it's a lot of work to just copy/paste the "do random
reads QD=x with Y jobs" between jobs. It'd be fine as a separate
cleanup at some point.


-- 
Jens Axboe
