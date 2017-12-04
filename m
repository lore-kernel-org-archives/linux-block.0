Return-Path: <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 0/5] blkcg: Limit maximum number of aio requests available
 for cgroup
To: Benjamin LaHaise <ben@communityfibre.ca>
Cc: axboe@kernel.dk, viro@zeniv.linux.org.uk, tj@kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aio@kvack.org, oleg@redhat.com
References: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
 <20171204165213.GF11494@kvack.org>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <08b9cab6-5237-c027-3bf3-08a69de7fe41@virtuozzo.com>
Date: Tue, 5 Dec 2017 00:27:37 +0300
MIME-Version: 1.0
In-Reply-To: <20171204165213.GF11494@kvack.org>
Content-Type: text/plain; charset=utf-8
Return-Path: ktkhai@virtuozzo.com
List-ID: <linux-block@vger.kernel.org>

Hi, Benjamin,

On 04.12.2017 19:52, Benjamin LaHaise wrote:
> Hi Kirill,
> 
> On Mon, Dec 04, 2017 at 07:12:51PM +0300, Kirill Tkhai wrote:
>> Hi,
>>
>> this patch set introduces accounting aio_nr and aio_max_nr per blkio cgroup.
>> It may be used to limit number of aio requests, which are available for
>> a cgroup, and could be useful for containers.
>>
>> The accounting is hierarchical, and aio contexts, allocated in child cgroup,
>> are accounted in parent cgroups too.
>>
>> Also, new cgroup file "io.aio_nr" is introduced. It's used to set cgroup
>> aio requests limit, to show current limit and number of currenly occupied
>> requests.
> 
> Where are your test cases to check this functionality in the libaio test
> suite?

I tried to find actual libaio test suite repository url in google,
but there is no certain answer. Also, there is no information in kernel
anywhere (I hope I grepped right).

Could you please provide url where actual upstream libaio could be obtained?

Kirill

> 
> 		-ben
> 
>> Patches 1-3 are refactoring.
>> Patch 4 is the place where the accounting actually introduced.
>> Patch 5 adds "io.aio_nr" file.
>>
>> ---
>>
>> Kirill Tkhai (5):
>>       aio: Move aio_nr increment to separate function
>>       aio: Export aio_nr_lock and aio_max_nr initial value to include/linux/aio.h
>>       blkcg: Add blkcg::blkg_aio_nr and blkcg::blkg_aio_max_nr
>>       blkcg: Charge aio requests in blkio cgroup hierarchy
>>       blkcg: Add cgroup file to configure blkcg::blkg_aio_max_nr
>>
>>
>>  block/blk-cgroup.c         |   88 +++++++++++++++++++++++++-
>>  fs/aio.c                   |  151 ++++++++++++++++++++++++++++++++++++++++----
>>  include/linux/aio.h        |   21 ++++++
>>  include/linux/blk-cgroup.h |    4 +
>>  4 files changed, 247 insertions(+), 17 deletions(-)
>>
>> --
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>>
> 
