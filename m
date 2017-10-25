Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v5 9/9] block: Assign a lock_class per gendisk used for
 wait_for_completion()
To: Ingo Molnar <mingo@kernel.org>, Byungchul Park <byungchul.park@lge.com>
Cc: peterz@infradead.org, johan@kernel.org, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, tj@kernel.org,
 johannes.berg@intel.com, oleg@redhat.com, amir73il@gmail.com,
 david@fromorbit.com, darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 hch@infradead.org, idryomov@gmail.com, kernel-team@lge.com
References: <1508921765-15396-1-git-send-email-byungchul.park@lge.com>
 <1508921765-15396-10-git-send-email-byungchul.park@lge.com>
 <20171025101328.b6fg32m2oazh3zro@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <89864125-688d-d3df-a24c-7f335b9a144e@kernel.dk>
Date: Wed, 25 Oct 2017 11:20:42 -0700
MIME-Version: 1.0
In-Reply-To: <20171025101328.b6fg32m2oazh3zro@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/25/2017 03:13 AM, Ingo Molnar wrote:
> 
> * Byungchul Park <byungchul.park@lge.com> wrote:
> 
>> Darrick posted the following warning and Dave Chinner analyzed it:
>>
>>> ======================================================
>>> WARNING: possible circular locking dependency detected
>>> 4.14.0-rc1-fixes #1 Tainted: G        W
> 
>> Reported-by: Darrick J. Wong <darrick.wong@oracle.com>
>> Analyzed-by: Dave Chinner <david@fromorbit.com>
>> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
>> ---
>>  block/bio.c           |  2 +-
>>  block/genhd.c         | 10 ++--------
>>  include/linux/genhd.h | 22 ++++++++++++++++++++--
>>  3 files changed, 23 insertions(+), 11 deletions(-)
> 
> Ok, this patch looks good to me now, I'll wait to get an Ack or Nak from Jens for 
> these changes.
> 
> Jens: this patch has some dependencies in prior lockdep changes, so I'd like to 
> carry it in the locking tree for a v4.15 merge.

Looks fine to me, you can add my reviewed-by and carry it in your tree.

-- 
Jens Axboe
