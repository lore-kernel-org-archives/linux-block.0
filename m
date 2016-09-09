Return-Path: <axboe@kernel.dk>
Subject: Re: wb-buf-throttle feedback
To: rrs@researchut.com, linux-block@vger.kernel.org
References: <1473447658.8897.13.camel@researchut.com>
 <7cb20dd5-a5a3-25d3-987b-d36e54cae2f7@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <09938f88-2a74-cb95-4498-5fc883eba115@kernel.dk>
Date: Fri, 9 Sep 2016 14:19:50 -0600
MIME-Version: 1.0
In-Reply-To: <7cb20dd5-a5a3-25d3-987b-d36e54cae2f7@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/09/2016 02:02 PM, Jens Axboe wrote:
> On 09/09/2016 01:00 PM, Ritesh Raj Sarraf wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA512
>>
>> Hi Jens,
>>
>> [Please CC me in replies. I'm not subscribed to the list]
>>
>> Based on your announcement about the writeback patches, I have picked
>> up your
>> changes for testing.
>>
>> I tested it on a 4.7.3 stable kernel with patches applied from your
>> axboe/wb-
>> buf-throttle-v4.7 branch.
>>
>>
>> Instead of the infamous dd use case, I picked up the other generic one
>> i.e. to
>> build the linux kernel.
>>
>>
>> Machine config:
>>
>> Intel(R) Core(TM) i5-4210U CPU @ 1.70GHzRAM: 8 GiB
>> Disk: Rotational SATA HDD Hitachi - 7200 RPM
>>
>>
>> The machine has 4 logical CPUs.
>>
>>
>> Unfortunately, the issue is still easily reproducible. Building a
>> kernel with
>> defaults, which results in make -j4, ended up stalling the entire OS.
>
> What drive is hosting the system and kernel build? I think the current
> branch isn't aggressive enough on SATA style QD=32 devices with write
> back caching, so if that's what you are running, it'd be great if you
> could try a patch or two so we can improve this situation for you.
>
> The v4.7 branch is outdated. Let me spin a new one, that's probably the
> best way to start.

The 4.7 branch has now been updated, it's fully uptodate with the
current 4.8 based branch. Would be great if you could try that. If you
still see slowdowns, try and change RWB_DEF_DEPTH. It's currently at 16,
scale it down to 4 or something like that.

-- 
Jens Axboe
