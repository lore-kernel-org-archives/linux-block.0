Subject: Re: [PATCH 1/2] sbitmap: use smp_mb__after_atomic() in sbq_wake_up()
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
References: <b8c8740615f38f36e3a5f726f97903ca2af9f549.1484769083.git.osandov@fb.com>
Cc: Martin Raiber <martin@urbackup.org>, kernel-team@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <2521c6b9-7b4e-0fd7-5ce0-f27e1494b7da@fb.com>
Date: Wed, 18 Jan 2017 12:42:24 -0800
MIME-Version: 1.0
In-Reply-To: <b8c8740615f38f36e3a5f726f97903ca2af9f549.1484769083.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/18/2017 11:55 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> We always do an atomic clear_bit() right before we call sbq_wake_up(),
> so we can use smp_mb__after_atomic(). While we're here, comment the
> memory barriers in here a little more.

Thanks Omar, applied 1-2.

-- 
Jens Axboe
