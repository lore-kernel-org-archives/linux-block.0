Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] kyber: fix another domain token wait queue hang
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
References: <e5dfd4063f73561dde6508d70e51159595d42185.1512513903.git.osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <43bae283-12a0-2b0e-8e25-29784d3264d0@kernel.dk>
Date: Wed, 6 Dec 2017 13:13:45 -0800
MIME-Version: 1.0
In-Reply-To: <e5dfd4063f73561dde6508d70e51159595d42185.1512513903.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/05/2017 10:57 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Commit 8cf466602028 ("kyber: fix hang on domain token wait queue") fixed
> a hang caused by leaving wait entries on the domain token wait queue
> after the __sbitmap_queue_get() retry succeeded, making that wait entry
> a "dud" which won't in turn wake more entries up. However, we can also
> get a dud entry if kyber_get_domain_token() fails once but is then
> called again and succeeds. This can happen if the hardware queue is
> rerun for some other reason, or, more likely, kyber_dispatch_request()
> tries the same domain twice.
> 
> The fix is to remove our entry from the wait queue whenever we
> successfully get a token. The only complication is that we might be on
> one of many wait queues in the struct sbitmap_queue, but that's easily
> fixed by remembering which wait queue we were put on.
> 
> While we're here, only initialize the wait queue entry once instead of
> on every wait, and use spin_lock_irq() instead of spin_lock_irqsave(),
> since this is always called from process context with irqs enabled.

That latter part probably should have been a separate patch... But
applied for this series, thanks Omar.

-- 
Jens Axboe
