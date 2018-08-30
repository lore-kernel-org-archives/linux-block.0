Return-Path: <axboe@kernel.dk>
Subject: Re: writeback throttling deadlock
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ming Lei <ming.lei@redhat.com>, Josef Bacik <jbacik@fb.com>
References: <alpine.LRH.2.02.1808301053240.10353@file01.intranet.prod.int.rdu2.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4dbd3e39-f9c1-467a-8937-f55b01a639a2@kernel.dk>
Date: Thu, 30 Aug 2018 09:06:07 -0600
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1808301053240.10353@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/30/18 8:58 AM, Mikulas Patocka wrote:
> I report this deadlock in writeback throttling.
> 
> The deadlock happened in guest virtual machine with Debian kernel 4.17.17 
> (4.17.0-3-amd64). The virtual machine had most of its memory swapped out, 
> when I tried to shut it down, I got this deadlock. There was no io in 
> flight.

Not very helpful for your case, but this should be fixed in Linus's
current tree. I've got a few pending fixes still, but they will be
going upstream for 4.19-rc2.

-- 
Jens Axboe
