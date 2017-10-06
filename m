Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block/aoe: Convert timers to use timer_setup()
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, "Ed L. Cashin" <ed.cashin@acm.org>,
 linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20171005231354.GA109107@beast>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8a7183b5-d9d8-af74-6ce8-aa005468a83b@kernel.dk>
Date: Fri, 6 Oct 2017 08:19:58 -0600
MIME-Version: 1.0
In-Reply-To: <20171005231354.GA109107@beast>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/05/2017 05:13 PM, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.

Applied to for-4.15/timer

-- 
Jens Axboe
