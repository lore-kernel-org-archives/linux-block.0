Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To: Eduardo Valentin <eduval@amazon.com>
Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anchal Agarwal <anchalag@amazon.com>,
 Frank van der Linden <fllinden@amazon.com>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <809b2243-7a76-3d8a-5d1b-b6b9d9712f41@kernel.dk>
 <d28bca3a-196d-1520-35cf-bec1e1872d34@oracle.com>
 <1f2d5ab0-2322-56b7-3544-3cf733a22dd8@kernel.dk>
 <2f83f994-2734-17b2-3c74-b6869ba18184@kernel.dk>
 <20180824171439.GA12587@u40b0340c692b58f6553c.ant.amazon.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <40137009-76ed-d48b-758e-d09283305fb7@kernel.dk>
Date: Fri, 24 Aug 2018 11:17:13 -0600
MIME-Version: 1.0
In-Reply-To: <20180824171439.GA12587@u40b0340c692b58f6553c.ant.amazon.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/24/18 11:14 AM, Eduardo Valentin wrote:
>> +	if (lock) {
>> +		spin_unlock_irq(lock);
>> +		io_schedule();
>> +		spin_lock_irq(lock);
>> +	} else
>> +		io_schedule();
> 
> Nitpick but, shouldn't this look like:
> 
> +	if (lock) {
> +		spin_unlock_irq(lock);
> +		io_schedule();
> +		spin_lock_irq(lock);
> +	} else {
> +		io_schedule();
> +	}

Depends on who you ask... I prefer the former.

> And another random though, it would be good to have some sort of
> tracing of this.

wbt does have tracing, but we've never had tracing on the sleep/wakeup
parts. But that's pretty much completely orthogonal to the issue, that
should be done as a separate patch, if useful.

BTW, I've now tested this and it seems to work fine for me.

-- 
Jens Axboe
