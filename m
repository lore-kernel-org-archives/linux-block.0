Return-Path: <ben@communityfibre.ca>
Date: Mon, 4 Dec 2017 11:52:13 -0500
From: Benjamin LaHaise <ben@communityfibre.ca>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: axboe@kernel.dk, viro@zeniv.linux.org.uk, tj@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aio@kvack.org, oleg@redhat.com
Subject: Re: [PATCH 0/5] blkcg: Limit maximum number of aio requests available for cgroup
Message-ID: <20171204165213.GF11494@kvack.org>
References: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

Hi Kirill,

On Mon, Dec 04, 2017 at 07:12:51PM +0300, Kirill Tkhai wrote:
> Hi,
> 
> this patch set introduces accounting aio_nr and aio_max_nr per blkio cgroup.
> It may be used to limit number of aio requests, which are available for
> a cgroup, and could be useful for containers.
> 
> The accounting is hierarchical, and aio contexts, allocated in child cgroup,
> are accounted in parent cgroups too.
> 
> Also, new cgroup file "io.aio_nr" is introduced. It's used to set cgroup
> aio requests limit, to show current limit and number of currenly occupied
> requests.

Where are your test cases to check this functionality in the libaio test
suite?

		-ben

> Patches 1-3 are refactoring.
> Patch 4 is the place where the accounting actually introduced.
> Patch 5 adds "io.aio_nr" file.
> 
> ---
> 
> Kirill Tkhai (5):
>       aio: Move aio_nr increment to separate function
>       aio: Export aio_nr_lock and aio_max_nr initial value to include/linux/aio.h
>       blkcg: Add blkcg::blkg_aio_nr and blkcg::blkg_aio_max_nr
>       blkcg: Charge aio requests in blkio cgroup hierarchy
>       blkcg: Add cgroup file to configure blkcg::blkg_aio_max_nr
> 
> 
>  block/blk-cgroup.c         |   88 +++++++++++++++++++++++++-
>  fs/aio.c                   |  151 ++++++++++++++++++++++++++++++++++++++++----
>  include/linux/aio.h        |   21 ++++++
>  include/linux/blk-cgroup.h |    4 +
>  4 files changed, 247 insertions(+), 17 deletions(-)
> 
> --
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 

-- 
"Thought is the essence of where you are now."
