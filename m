Return-Path: <n.borisov@siteground.com>
Return-Path: <n.borisov@siteground.com>
Subject: Re: [PATCH BUGFIX V3] block: add missing group association in
 bio-cloning functions
To: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>
References: <x49eg9961hh.fsf@segfault.boston.devel.redhat.com>
 <1462917696-5237-1-git-send-email-paolo.valente@linaro.org>
 <5732D364.2020905@kyup.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, linus.walleij@linaro.org, broonie@kernel.org,
 stable@vger.kernel.org
From: Nikolay Borisov <kernel@kyup.com>
Message-ID: <5732D47A.4090706@kyup.com>
Date: Wed, 11 May 2016 09:43:06 +0300
MIME-Version: 1.0
In-Reply-To: <5732D364.2020905@kyup.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>



On 05/11/2016 09:38 AM, Nikolay Borisov wrote:
> 
> 
> On 05/11/2016 01:01 AM, Paolo Valente wrote:
>> When a bio is cloned, the newly created bio must be associated with
>> the same blkcg as the original bio (if BLK_CGROUP is enabled). If
>> this operation is not performed, then the new bio is not associated
>> with any group, and the group of the current task is returned when
>> the group of the bio is requested.
>>
>> Depending on the cloning frequency, this may cause a large
>> percentage of the bios belonging to a given group to be treated
>> as if belonging to other groups (in most cases as if belonging to
>> the root group). The expected group isolation may thereby be broken.
>>
>> This commit adds the missing association in bio-cloning functions.
>>
>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>> ---
>>  block/bio.c          | 15 +++++++++++++++
>>  fs/btrfs/extent_io.c |  6 ------
>>  include/linux/bio.h  |  3 +++
>>  3 files changed, 18 insertions(+), 6 deletions(-)
>>
> 
> Just for reference something like that was already proposed (and tested)
> before, though it never got merged :
> 
> https://www.redhat.com/archives/dm-devel/2016-March/msg00007.html
> 
> So you might also want to patch __bio_clone_fast to also apply this for
> dm backed devices.

Right, to correct myself: You might want to move the association to
__blk_clone_fast that way you are also covering dm devices as well as
users of bio_clone_fast.


> 
> Otherwise:
> 
> Reviewed-by: Nikolay Borisov <kernel@kyup.com>
> 
