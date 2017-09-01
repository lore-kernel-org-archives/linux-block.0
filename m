Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2 1/2] block/loop: fix use after free
To: Shaohua Li <shli@kernel.org>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Shaohua Li <shli@fb.com>
References: <1a1c70b8fd5044e11bd152686a742a017ebea99e.1504289520.git.shli@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f591cd96-b6de-9865-119f-598176387f66@kernel.dk>
Date: Fri, 1 Sep 2017 13:58:02 -0600
MIME-Version: 1.0
In-Reply-To: <1a1c70b8fd5044e11bd152686a742a017ebea99e.1504289520.git.shli@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/01/2017 12:15 PM, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> lo_rw_aio->call_read_iter->
> 1       aops->direct_IO
> 2       iov_iter_revert
> lo_rw_aio_complete could happen between 1 and 2, the bio and bvec could
> be freed before 2, which accesses bvec.

Applied 1-2, thanks.

-- 
Jens Axboe
