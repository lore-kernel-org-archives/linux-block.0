Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 01/10] mempool: Add mempool_init()/mempool_exit()
To: Kent Overstreet <kent.overstreet@gmail.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, Ingo Molnar <mingo@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
 <20180509013358.16399-2-kent.overstreet@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f6b03dbb-a9d0-2b5b-c21a-e92572bc343a@kernel.dk>
Date: Fri, 11 May 2018 15:11:45 -0600
MIME-Version: 1.0
In-Reply-To: <20180509013358.16399-2-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/8/18 7:33 PM, Kent Overstreet wrote:
> Allows mempools to be embedded in other structs, getting rid of a
> pointer indirection from allocation fastpaths.
> 
> mempool_exit() is safe to call on an uninitialized but zeroed mempool.

Looks fine to me. I'd like to carry it through the block branch, as some
of the following cleanups depend on it. Kent, can you post a v2 with
the destroy -> exit typo fixed up?

But would be nice to have someone sign off on it...

-- 
Jens Axboe
