Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] bcache: fix 0day error of setting writeback_rate by sysfs
 interface
To: Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
 Kai Krakow <kai@kaishome.de>, Stefan Priebe <s.priebe@profihost.ag>
References: <20180810154550.5020-1-colyli@suse.de>
 <a418aaaf-f392-79d6-4892-60737d748887@kernel.dk>
 <456e4bc7-ce84-8a1a-ba96-3eb7b24bd8ca@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1aae42a6-f96d-e2e8-7dc9-3a506af5d95e@kernel.dk>
Date: Sun, 12 Aug 2018 09:10:35 -0600
MIME-Version: 1.0
In-Reply-To: <456e4bc7-ce84-8a1a-ba96-3eb7b24bd8ca@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/10/18 10:49 PM, Coly Li wrote:
> On 2018/8/11 2:19 AM, Jens Axboe wrote:
>> On 8/10/18 9:45 AM, Coly Li wrote:
>>> Commit ea8c5356d390 ("bcache: set max writeback rate when I/O request
>>> is idle") changes struct bch_ratelimit member rate from uint32_t to
>>> atomic_long_t and uses atomic_long_set() in drivers/md/bcache/sysfs.c
>>> to set new writeback rate, after the input is converted from memory
>>> buf to long int by sysfs_strtoul_clamp().
>>>
>>> The above change has a problem because there is an implicit return
>>> inside sysfs_strtoul_clamp() so the following atomic_long_set()
>>> won't be called. This error is detected by 0day system with following
>>> snipped smatch warnings:
>>>
>>> drivers/md/bcache/sysfs.c:271 __cached_dev_store() error: uninitialized
>>> symbol 'v'.
>>> 270  sysfs_strtoul_clamp(writeback_rate, v, 1, INT_MAX);
>>>      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> @271 atomic_long_set(&dc->writeback_rate.rate, v);
>>>
>>> This patch fixes the above error by using strtoul_safe_clamp() to
>>> convert the input buffer into a long int type result.
>>>
>>> Fixes: Commit ea8c5356d390 ("bcache: set max writeback rate when I/O request is idle")
>>> Signed-off-by: Coly Li <colyli@suse.de>
>>> Cc: stable@vger.kernel.org #4.16+
>>> Cc: Kai Krakow <kai@kaishome.de>
>>> Cc: Stefan Priebe <s.priebe@profihost.ag>
>>
> 
> Hi Jens,
> 
>> You don't need to CC stable for this, the commit isn't in a released kernel
>> yet. In fact, it's not even in Linus's tree, it's just queued up for 4.19.
>>
> 
> What I thought was, Commit ea8c5356d390 ("bcache: set max writeback rate
> when I/O request is idle") is a stable fix, so this patch should go into
> stable as well. Otherwise the stable kernel cannot manually set
> writeback_rate via sysfs interface.

It's not necessary when new patch is correctly marked as fixing one that
is going to stable.

-- 
Jens Axboe
