Return-Path: <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 0/5] blkcg: Limit maximum number of aio requests available
 for cgroup
To: Tejun Heo <tj@kernel.org>
Cc: axboe@kernel.dk, bcrl@kvack.org, viro@zeniv.linux.org.uk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aio@kvack.org, oleg@redhat.com
References: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
 <20171204200756.GC2421075@devbig577.frc2.facebook.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <17b22d53-ad3d-1ba8-854f-fc2a43d86c44@virtuozzo.com>
Date: Tue, 5 Dec 2017 00:44:00 +0300
MIME-Version: 1.0
In-Reply-To: <20171204200756.GC2421075@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Return-Path: ktkhai@virtuozzo.com
List-ID: <linux-block@vger.kernel.org>

Hello, Tejun,

On 04.12.2017 23:07, Tejun Heo wrote:
> On Mon, Dec 04, 2017 at 07:12:51PM +0300, Kirill Tkhai wrote:
>> this patch set introduces accounting aio_nr and aio_max_nr per blkio cgroup.
>> It may be used to limit number of aio requests, which are available for
>> a cgroup, and could be useful for containers.
> 
> Can you please explain how this is a fundamental resource which can't
> be controlled otherwise?

Currently, aio_nr and aio_max_nr are global. In case of containers this
means that a single container may occupy all aio requests, which are
available in the system, and to deprive others possibility to use aio
at all. This may happen because of evil intentions of the container's
user or because of the program error, when the user makes this occasionally.

My patch set allows to guarantee that every container or cgroup has
its own number of allowed aios, and nobody can steal it, and therefore
can't slow down another containers, and to force programs to use direct io.

AIO gives certain advantages to its user, so this patchset just doesn't
allow to rob the advantages without any possibility to protect against that.

This could be used by LXC or for starting some critical micro-services,
for example. 

Kirill
