Subject: Re: [PATCH 7/8] mq-deadline: add blk-mq adaptation of the deadline IO
 scheduler
To: Paolo Valente <paolo.valente@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <1481933536-12844-8-git-send-email-axboe@fb.com>
 <84DA10A3-5055-4D48-A990-6CB5A5D34F0C@linaro.org>
 <21ff7888-ec08-0dab-a997-872ad0027fe2@fb.com>
 <4C7AD847-C02D-47FF-83B7-F0BB8FBED5F5@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>, osandov@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <f26b60aa-b047-d7a3-550d-5270c696e2a1@fb.com>
Date: Thu, 2 Feb 2017 08:30:35 -0700
MIME-Version: 1.0
In-Reply-To: <4C7AD847-C02D-47FF-83B7-F0BB8FBED5F5@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/02/2017 02:19 AM, Paolo Valente wrote:
> The scheme is clear.  One comment, in case it could make sense and
> avoid more complexity: since put_rq_priv is invoked in two different
> contexts, process or interrupt, I didn't feel so confusing that, when
> put_rq_priv is invoked in the context where the lock cannot be held
> (unless one is willing to pay with irq disabling all the times), the
> lock is not held, while, when invoked in the context where the lock
> can be held, the lock is actually held, or must be taken.

If you grab the same lock from put_rq_priv, yes, you must make it IRQ
disabling in all contexts, and use _irqsave() from put_rq_priv. If it's
just freeing resources, you could potentially wait and do that when
someone else needs them, since that part will come from proces context.
That would need two locks, though.

As I said above, I would not worry about the IRQ disabling lock.

-- 
Jens Axboe
