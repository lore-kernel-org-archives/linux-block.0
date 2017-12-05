Return-Path: <mhocko@kernel.org>
Date: Tue, 5 Dec 2017 16:15:32 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: axboe@kernel.dk, bcrl@kvack.org, tj@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aio@kvack.org, jmoyer@redhat.com
Subject: Re: [PATCH] aio: Add memcg accounting of user used data
Message-ID: <20171205151532.5evofjjma2zg3kte@dhcp22.suse.cz>
References: <151246799787.29619.13497559380263553588.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <151246799787.29619.13497559380263553588.stgit@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Tue 05-12-17 13:00:54, Kirill Tkhai wrote:
> Currently, number of available aio requests may be
> limited only globally. There are two sysctl variables
> aio_max_nr and aio_nr, which implement the limitation
> and request accounting. They help to avoid
> the situation, when all the memory is eaten in-flight
> requests, which are written by slow block device,
> and which can't be reclaimed by shrinker.
> 
> This meets the problem in case of many containers
> are used on the hardware node. Since aio_max_nr is
> a global limit, any container may occupy the whole
> available aio requests, and to deprive others the
> possibility to use aio at all. The situation may
> happen because of evil intentions of the container's
> user or because of the program error, when the user
> makes this occasionally
> 
> The patch allows to fix the problem. It adds memcg
> accounting of user used aio data (the biggest is
> the bunch of aio_kiocb; ring buffer is the second
> biggest), so a user of a certain memcg won't be able
> to allocate more aio requests memory, then the cgroup
> allows, and he will bumped into the limit.

So what happens when we hit the hard limit and oom kill somebody?
Are those charged objects somehow bound to a process context?
-- 
Michal Hocko
SUSE Labs
