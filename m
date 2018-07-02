Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] drbd: fix access after free
To: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>
References: <20180625093952.20220-1-lars.ellenberg@linbit.com>
 <20180702112703.GA10994@soda.linbit>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4a49baa0-f1fb-a593-ae11-443c8385494b@kernel.dk>
Date: Mon, 2 Jul 2018 08:22:10 -0600
MIME-Version: 1.0
In-Reply-To: <20180702112703.GA10994@soda.linbit>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/2/18 5:27 AM, Lars Ellenberg wrote:
> Jens, I had hoped you'd apply this "oneliner" into 4.18 already?
> Did you miss it?

I did miss it, applied it now, thanks.

-- 
Jens Axboe
