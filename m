Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] loop: remove union of use_aio and ref in struct loop_cmd
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Shaohua Li <shli@fb.com>
References: <f1805518db399aa091aaada51de4d9153963d77f.1505942666.git.osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8d8d9fac-363d-0e06-250e-db915293978b@kernel.dk>
Date: Wed, 20 Sep 2017 15:27:51 -0600
MIME-Version: 1.0
In-Reply-To: <f1805518db399aa091aaada51de4d9153963d77f.1505942666.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/20/2017 03:24 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> When the request is completed, lo_complete_rq() checks cmd->use_aio.
> However, if this is in fact an aio request, cmd->use_aio will have
> already been reused as cmd->ref by lo_rw_aio*. Fix it by not using a
> union. On x86_64, there's a hole after the union anyways, so this
> doesn't make struct loop_cmd any bigger.

Thanks Omar, applied.

-- 
Jens Axboe
