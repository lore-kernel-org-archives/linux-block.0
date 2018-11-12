Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] kyber: fix wrong strlcpy() size in
 trace_kyber_latency()
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Jordan Glover <Golden_Miller83@protonmail.ch>,
 Bart Van Assche <bvanassche@acm.org>
References: <7cd2a3c7ceed5dea16bc4ccf8edad77e90a49e7a.1542010053.git.osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <81f37068-4e6b-0d76-d547-932e4ea4a916@kernel.dk>
Date: Mon, 12 Nov 2018 08:29:17 -0700
MIME-Version: 1.0
In-Reply-To: <7cd2a3c7ceed5dea16bc4ccf8edad77e90a49e7a.1542010053.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/12/18 1:08 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> When copying to the latency type, we should be passing LATENCY_TYPE_LEN,
> not DOMAIN_LEN (this isn't a problem in practice because we only pass
> "total" or "I/O"). Fix it by changing all of the strlcpy() calls to use
> sizeof().

Applied, thanks.

-- 
Jens Axboe
