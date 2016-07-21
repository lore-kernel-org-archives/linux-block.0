Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: do not merge requests without consulting with
 io scheduler
To: Tahsin Erdogan <tahsin@google.com>
References: <1467917302-1232-1-git-send-email-tahsin@google.com>
Cc: kbuild test robot <lkp@intel.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1a1a7773-4a9f-f989-ea00-2ec3ff5fe937@kernel.dk>
Date: Wed, 20 Jul 2016 21:36:33 -0600
MIME-Version: 1.0
In-Reply-To: <1467917302-1232-1-git-send-email-tahsin@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 07/07/2016 12:48 PM, Tahsin Erdogan wrote:
> Before merging a bio into an existing request, io scheduler is called to
> get its approval first. However, the requests that come from a plug
> flush may get merged by block layer without consulting with io
> scheduler.
>
> In case of CFQ, this can cause fairness problems. For instance, if a
> request gets merged into a low weight cgroup's request, high weight cgroup
> now will depend on low weight cgroup to get scheduled. If high weigt cgroup
> needs that io request to complete before submitting more requests, then it
> will also lose its timeslice.
>
> Following script demonstrates the problem. Group g1 has a low weight, g2
> and g3 have equal high weights but g2's requests are adjacent to g1's
> requests so they are subject to merging. Due to these merges, g2 gets
> poor disk time allocation.

Looks (and seems) sane to me, no reason why the plug path should be 
different. Applied for 4.8, thanks.

-- 
Jens Axboe
