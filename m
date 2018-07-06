Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: fix infinite loop if the device loses discard
 capability
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-block@vger.kernel.org, Zdenek Kabelac <zkabelac@redhat.com>,
 Mike Snitzer <msnitzer@redhat.com>, dm-devel@redhat.com
References: <alpine.LRH.2.02.1807031332250.22443@file01.intranet.prod.int.rdu2.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <aaa019b2-1994-789c-3faa-c38a5b4c86d4@kernel.dk>
Date: Fri, 6 Jul 2018 07:50:56 -0600
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1807031332250.22443@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/3/18 11:34 AM, Mikulas Patocka wrote:
> If __blkdev_issue_discard is in progress and a device mapper device is
> reloaded with a table that doesn't support discard,
> q->limits.max_discard_sectors is set to zero. This results in infinite
> loop in __blkdev_issue_discard.
> 
> This patch checks if max_discard_sectors is zero and aborts with
> -EOPNOTSUPP.

Applied, thanks.

-- 
Jens Axboe
