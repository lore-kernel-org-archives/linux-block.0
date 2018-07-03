Return-Path: <rdunlap@infradead.org>
Subject: Re: [PATCH 05/14] swap,blkcg: issue swap io with the appropriate
 context
To: Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
 tj@kernel.org, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 kernel-team@fb.com
References: <20180703151503.2549-1-josef@toxicpanda.com>
 <20180703151503.2549-6-josef@toxicpanda.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <da01afa9-ee89-3c54-9e41-b10875ff0787@infradead.org>
Date: Tue, 3 Jul 2018 12:27:21 -0700
MIME-Version: 1.0
In-Reply-To: <20180703151503.2549-6-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/03/2018 08:14 AM, Josef Bacik wrote:
> From: Tejun Heo <tj@kernel.org>
> 
> For backcharging we need to know who the page belongs to when swapping
> it out.  We don't worry about things that do ->rw_page (zram etc) at the
> moment, we're only worried about pages that actually go to a block
> device.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Josef Bacik <jbacik@fb.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> cked-by: Andrew Morton <akpm@linux-foundation.org>

Checked-by:  ?  :)
copy-pasto

> ---
>  block/bio.c         | 24 ++++++++++++++++++++++++
>  include/linux/bio.h |  7 +++++++
>  mm/page_io.c        |  1 +
>  3 files changed, 32 insertions(+)


-- 
~Randy
