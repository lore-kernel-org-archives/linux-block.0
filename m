Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH blktests 2/2] block/011: Perform PCI reset while doing IO
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Omar Sandoval <osandov@osandov.com>,
 Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@fb.com>
References: <20170623142951.17189-1-jthumshirn@suse.de>
 <20170623142951.17189-2-jthumshirn@suse.de>
 <813a788b-58f6-f3d5-57f0-60d1d439a923@kernel.dk>
 <20170626140610.GA25745@linux-x5ow.site>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8581cda3-02c3-a8cc-073f-38d9e65ad096@kernel.dk>
Date: Mon, 26 Jun 2017 08:25:36 -0600
MIME-Version: 1.0
In-Reply-To: <20170626140610.GA25745@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/26/2017 08:06 AM, Johannes Thumshirn wrote:
> On Fri, Jun 23, 2017 at 09:36:14AM -0600, Jens Axboe wrote:
>> On 06/23/2017 08:29 AM, Johannes Thumshirn wrote:
>>> From: Omar Sandoval <osandov@fb.com>
>>>
>>> This test-case performs I/O with fio while doing PCI disable/enable
>>> cycles.
>>>
>>> In the results we don't care for I/O errors but for hiccups in dmesg only.
>>
>> Let's get this in, that would be a very useful test. A few comments -
>> not necessarily on this patch in particular, but for future cleanups
>> and improvements.
>>
>>> +	if _test_dev_is_rotational; then
>>> +		size="32m"
>>> +	else
>>> +		size="1g"
>>> +	fi
>>
>> I introduced this idea in one of my previous patches. I wonder if we
>> should turn that into a helper. Pass in the dev, get returned a
>> suitable fio size, instead of hard coding this in each job that
>> needs it.
> 
> Sure.
> 
>>
>>> +	# start fio job
>>> +	_run_fio --bs=4k --rw=randread --norandommap \
>>> +		--name=reads --filename="$TEST_DEV" --size="$size" \
>>> +		--numjobs=8 --direct=1 2>/dev/null &
>>
>> I don't believe we check for fio errors right now, but we probably
>> should in the future. So I think you'd want to add something ala:
>>
>> --ignore_error=EIO,ENXIO,ENODEV
>>
>> to your options to make it explicit that you don't care about IO
>> errors for this test.
> 
> Oh nice, didn't know about the option. Btw as we're currently all have
> arbitrary values for the numjobs parameter, how about a wrapper over getconf
> _NPROCESSORS_ONLN?

Yes that's a good idea, then we can at least size the jobs based on
how many cores we have.

-- 
Jens Axboe
