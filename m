Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Mon, 14 May 2018 15:11:10 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 01/10] mempool: Add mempool_init()/mempool_exit()
Message-ID: <20180514191110.GB8869@kmo-pixel>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
 <20180509013358.16399-2-kent.overstreet@gmail.com>
 <f6b03dbb-a9d0-2b5b-c21a-e92572bc343a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f6b03dbb-a9d0-2b5b-c21a-e92572bc343a@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 11, 2018 at 03:11:45PM -0600, Jens Axboe wrote:
> On 5/8/18 7:33 PM, Kent Overstreet wrote:
> > Allows mempools to be embedded in other structs, getting rid of a
> > pointer indirection from allocation fastpaths.
> > 
> > mempool_exit() is safe to call on an uninitialized but zeroed mempool.
> 
> Looks fine to me. I'd like to carry it through the block branch, as some
> of the following cleanups depend on it. Kent, can you post a v2 with
> the destroy -> exit typo fixed up?
> 
> But would be nice to have someone sign off on it...

Done - it's now up in my git repo:
http://evilpiepirate.org/git/bcachefs.git bcachefs-block
