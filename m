Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] kyber: fix integer overflow of latency targets on 32-bit
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Stephen Rothwell <sfr@canb.auug.org.au>
References: <56a03261ec32ef67a8ce36106bf2f2f7638600ca.1538151757.git.osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e0002e2d-800d-be6c-cb1a-75eaf9b8aeac@kernel.dk>
Date: Fri, 28 Sep 2018 10:50:03 -0600
MIME-Version: 1.0
In-Reply-To: <56a03261ec32ef67a8ce36106bf2f2f7638600ca.1538151757.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/28/18 10:22 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> NSEC_PER_SEC has type long, so 5 * NSEC_PER_SEC is calculated as a long.
> However, 5 seconds is 5,000,000,000 nanoseconds, which overflows a
> 32-bit long. Make sure all of the targets are calculated as 64-bit
> values.

Applied, thanks Omar.

-- 
Jens Axboe
