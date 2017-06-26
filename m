Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] New test and a fixup for blktests
To: Omar Sandoval <osandov@osandov.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <9fd24bc2-cddc-6f46-230a-dc1673242a54@kernel.dk>
 <20170626204539.GD6710@vader.dhcp.thefacebook.com>
 <99056c08-07c3-5753-cea0-3e44affa435d@kernel.dk>
 <20170626210455.GE6710@vader.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <52579416-9fde-8a6b-de60-b0378ab3333f@kernel.dk>
Date: Mon, 26 Jun 2017 15:05:17 -0600
MIME-Version: 1.0
In-Reply-To: <20170626210455.GE6710@vader.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/26/2017 03:04 PM, Omar Sandoval wrote:
> On Mon, Jun 26, 2017 at 03:02:55PM -0600, Jens Axboe wrote:
>> On 06/26/2017 02:45 PM, Omar Sandoval wrote:
>>> On Wed, Jun 21, 2017 at 09:22:47AM -0600, Jens Axboe wrote:
>>>> Hi Omar,
>>>>
>>>> Two changes here:
>>>>
>>>> - block/006 wants to use the iops results, but it isn't using _fio_perf.
>>>> - Add block/010 to test for shared vs non-shared tags performance.
>>>>
>>>>
>>>>   https://github.com/axboe/blktests.git axboe
>>>>
>>>>
>>>> ----------------------------------------------------------------
>>>> Jens Axboe (2):
>>>>       block/006: use _fio_perf to get perf results
>>>>       block/010: add test case for shared/unshared tags
>>>>
>>>>  tests/block/006     |  4 +--
>>>>  tests/block/010     | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  tests/block/010.out |  2 ++
>>>>  3 files changed, 86 insertions(+), 2 deletions(-)
>>>>  create mode 100755 tests/block/010
>>>>  create mode 100644 tests/block/010.out
>>>>
>>>> -- 
>>>> Jens Axboe
>>>>
>>>
>>> Thanks, Jens, applied the first one, but
>>>
>>> [ 1876.142470] null_blk: unknown parameter 'shared_tags' ignored
>>>
>>> Am I missing a patch?
>>
>> Yes, the shared tags is a new feature, it's coming in 4.13. But I checked
>> and it doesn't abort the module load. So the test ends up just being the
>> same thing run twice, if shared_tags isn't available. I figured that
>> was good enough.
> 
> Sounds good, I'll apply it as-is and add an extra patch on top that
> checks if the module parameter exists.

Awesome, extra cookie for you :-)

-- 
Jens Axboe
