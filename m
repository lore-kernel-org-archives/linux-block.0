Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH blktests 1/9] blktests: add hepler functions for new md
 tests
To: Johannes Thumshirn <jthumshirn@suse.de>,
 bingjingc <bingjingc@synology.com>
Cc: linux-block@vger.kernel.org, cccheng@synology.com,
 linux-raid@vger.kernel.org
References: <1528272400-7128-1-git-send-email-bingjingc@synology.com>
 <20180606084402.vmx4qi42bmj5tmb4@linux-x5ow.site>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8bda8c14-0d38-ca5a-3614-6cfdef099c21@kernel.dk>
Date: Wed, 6 Jun 2018 08:29:25 -0600
MIME-Version: 1.0
In-Reply-To: <20180606084402.vmx4qi42bmj5tmb4@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/6/18 2:44 AM, Johannes Thumshirn wrote:
> On Wed, Jun 06, 2018 at 04:06:40PM +0800, bingjingc wrote:
>> We'd like to leverage this test framework for testing linux raid
>> software. There are several resync tasks in md/raid. For this commit,
>> we are trying to add creation resync and basic recovery tests for
>> every raid type.
>>
>> RAID is different from other block devices. It requires several
>> raid devices and hotspare devices for being assembled, disambled,
>> expended or recovered in the runtime. So we don't test devices
>> iteratively in TEST_DEVS list. We define RAID_DEVS and
>> RAID_SPARE_DEVS lists for providing block devices instead.
>>
>> We want to test the software not devices. We also provide a
>> LIMIT_DEV_SIZE option for limiting the tested array size by limiting
>> used space for each block device.
>>
>> [Getting Started]
>>
>> Additional dependencies are also minimal:
>> - mdadm
>> - cmp
>>
>> And please provide a file named config:
>> RAID_DEVS=(/dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3 /dev/loop4)
>> RAID_SPARE_DEVS=(/dev/loop100 /dev/loop101)
>> LIMIT_DEV_SIZE=20480 # optional
>>
>> And as root, you can run the md set of tests by typing
>> ./check md
>>
>> For someone who don't want to run md tests, they just keep RAID_DEVS
>> and RAID_SPARE_DEVS not assigned, all md tests will be skipped.
> 
> While I'm very much in support for the idea, please be aware that md
> has an own test suite by itself and please Cc the md mailing list as
> well.

Hopefully this can be the start of migrating over those tests!

-- 
Jens Axboe
