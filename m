Subject: Re: [PATCHSET v6] blk-mq scheduling framework
To: Paolo Valente <paolo.valente@linaro.org>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <C14FF2E2-886B-4EFD-8FBB-7DC528B02373@linaro.org>
Cc: Linux-Kernal <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>, bart.vanassche@sandisk.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <0cf80fa9-f8e9-5cdb-80b0-f277452e5ab1@fb.com>
Date: Sun, 15 Jan 2017 08:55:18 -0700
MIME-Version: 1.0
In-Reply-To: <C14FF2E2-886B-4EFD-8FBB-7DC528B02373@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/15/2017 03:12 AM, Paolo Valente wrote:
> 
>> Il giorno 11 gen 2017, alle ore 22:39, Jens Axboe <axboe@fb.com> ha scritto:
>>
>> Another year, another posting of this patchset. The previous posting
>> was here:
>>
>> https://www.spinics.net/lists/kernel/msg2406106.html
>>
>> (yes, I've skipped v5, it was fixes on top of v4, not the rework).
>>
>> I've reworked bits of this to get rid of the shadow requests, thanks
>> to Bart for the inspiration. The missing piece, for me, was the fact
>> that we have the tags->rqs[] indirection array already. I've done this
>> somewhat differently, though, by having the internal scheduler tag
>> map be allocated/torn down when an IO scheduler is attached or
>> detached. This also means that when we run without a scheduler, we
>> don't have to do double tag allocations, it'll work like before.
>>
>> The patchset applies on top of 4.10-rc3, or can be pulled here:
>>
>> git://git.kernel.dk/linux-block blk-mq-sched.6
>>
>>
> 
> Hi Jens,
> I have checked this new version to find solutions to the apparent
> errors, mistakes or just unclear parts (to me) that I have pointed out
> before Christmas last year.  But I have found no changes related to
> these problems.
> 
> As I have already written, I'm willing to try to fix those errors
> myself, if they really are errors, but I would first need at least
> some minimal initial feedback and guidance.  If needed, tell me how I
> can help you get in sync again with these issues (sending my reports
> again, sending a digest of them, ...).

Sorry Paolo, but focus has been on getting the framework in both
a mergeable and stable state, which it is now. I'll tend to BFQ
specific issues next week, so we can get those resolved as well.

Do you have a place where you have posted your in-progress
conversion?

-- 
Jens Axboe
