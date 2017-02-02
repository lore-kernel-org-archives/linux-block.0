Return-Path: <prvs=32061165df=axboe@fb.com>
Subject: Re: [PATCH] nbd: use our own workqueue for recv threads
To: Josef Bacik <jbacik@fb.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <kernel-team@fb.com>
References: <1485983471-3717-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <bb9bc1c1-c7be-9339-d3c8-a02e79f33db9@fb.com>
Date: Wed, 1 Feb 2017 17:35:59 -0800
MIME-Version: 1.0
In-Reply-To: <1485983471-3717-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>

On 02/01/2017 01:11 PM, Josef Bacik wrote:
> Since we are in the memory reclaim path we need our recv work to be on a
> workqueue that has WQ_MEM_RECLAIM set so we can avoid deadlocks.  Also
> set WQ_HIGHPRI since we are in the completion path for IO.

Applied for 4.11.

-- 
Jens Axboe
