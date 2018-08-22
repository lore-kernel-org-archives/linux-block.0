Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: don't warn when calling fsync on read-only block
 devices
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
 Mike Snitzer <snitzer@redhat.com>, Zdenek Kabelac <zkabelac@redhat.com>,
 WGH <wgh@torlan.ru>, linux-block@vger.kernel.org
References: <alpine.LRH.2.02.1808221217030.30929@file01.intranet.prod.int.rdu2.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <222ce989-dbb9-b994-a97f-4dce04f5bc69@kernel.dk>
Date: Wed, 22 Aug 2018 10:26:06 -0600
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1808221217030.30929@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/22/18 10:23 AM, Mikulas Patocka wrote:
> It is possible to call fsync on a read-only handle (for example, fsck.ext2 
> does it when doing read-only check), and this call results in kernel 
> warning. This bug was introduced by the commit 721c7fc701c7 "block: fail 
> op_is_write() requests to read-only partitions".

Similar patch is already queued up, it'll go into Linus's tree before
-rc1.

-- 
Jens Axboe
