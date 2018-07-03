Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/14][V6] Introduce io.latency io controller for cgroups
To: Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 kernel-team@fb.com
References: <20180703151503.2549-1-josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f2d28a6b-a4bf-f340-cf78-024fb5f3314b@kernel.dk>
Date: Tue, 3 Jul 2018 09:37:27 -0600
MIME-Version: 1.0
In-Reply-To: <20180703151503.2549-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/3/18 9:14 AM, Josef Bacik wrote:
> Jens, I'm sending this through your tree since it's mostly block related,
> however there are the two mm related patches, so if somebody from mm could weigh
> in on how we want to handle those that would be great.  Thanks,

Since we got Hannes's and Andrew's ack, I think we're fine. I've applied this
for 4.19, thanks.

-- 
Jens Axboe
