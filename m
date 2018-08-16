Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block, bfq: return nbytes and not zero from struct cftype
 .write() method
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Arianna Avanzini <avanzini.arianna@gmail.com>
References: <f574e019-00f2-96c3-fc32-541c6584ca96@maciej.szmigiero.name>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <19c68f93-017d-cda1-632f-039ca3ca0158@kernel.dk>
Date: Thu, 16 Aug 2018 13:11:49 -0600
MIME-Version: 1.0
In-Reply-To: <f574e019-00f2-96c3-fc32-541c6584ca96@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/15/18 3:56 PM, Maciej S. Szmigiero wrote:
> The value that struct cftype .write() method returns is then directly
> returned to userspace as the value returned by write() syscall, so it
> should be the number of bytes actually written (or consumed) and not zero.
> 
> Returning zero from write() syscall makes programs like /bin/echo or bash
> spin.

Applied, thanks.

Just a heads-up that gmail thinks your email is spam.

-- 
Jens Axboe
