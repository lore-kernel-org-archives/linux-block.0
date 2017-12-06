Return-Path: <mhocko@kernel.org>
Date: Wed, 6 Dec 2017 13:23:03 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: axboe@kernel.dk, bcrl@kvack.org, tj@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aio@kvack.org, jmoyer@redhat.com
Subject: Re: [PATCH] aio: Add memcg accounting of user used data
Message-ID: <20171206122303.GA7515@dhcp22.suse.cz>
References: <151246799787.29619.13497559380263553588.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <151246799787.29619.13497559380263553588.stgit@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Tue 05-12-17 13:00:54, Kirill Tkhai wrote:
[...]
> This meets the problem in case of many containers
> are used on the hardware node. Since aio_max_nr is
> a global limit, any container may occupy the whole
> available aio requests, and to deprive others the
> possibility to use aio at all. The situation may
> happen because of evil intentions of the container's
> user or because of the program error, when the user
> makes this occasionally

I am sorry to beat more on this but finally got around to
http://lkml.kernel.org/r/17b22d53-ad3d-1ba8-854f-fc2a43d86c44@virtuozzo.com
and read the above paragraph once again. I can see how accounting to
a memcg helps to reduce the memory footprint but I fail to see how it
helps the above scenario. Could you clarify wow you set up a limit to
prevent anybody from DoSing other containers by depleting aio_max_nr?
-- 
Michal Hocko
SUSE Labs
