Return-Path: <liangchen.linux@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170705182729.GE10673@infradead.org>
References: <20170629134510.GA32385@infradead.org> <1498855388-16990-1-git-send-email-bcache@lists.ewheeler.net>
 <1498855388-16990-6-git-send-email-bcache@lists.ewheeler.net> <20170705182729.GE10673@infradead.org>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Thu, 6 Jul 2017 09:56:01 +0800
Message-ID: <CAKhg4tLWnfaEXJ_Mx3_D8ca2iZrifpXbMv45SFEdWL=-QOP+KA@mail.gmail.com>
Subject: Re: [PATCH 06/19] bcache: explicitly destory mutex while exiting
To: Christoph Hellwig <hch@infradead.org>
Cc: bcache@lists.ewheeler.net, linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org, axboe@kernel.dk, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

mutex_destroy does nothing normally (may not be true in the future), but
when debug mutex is turned on it helps with debugging - mutex_destroy
in mutex-debug.c.
It's not about freeing of the memory. It's more about consistency of the
use of mutex and making the code future proof.

Thanks,
Linag

On Thu, Jul 6, 2017 at 2:27 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Jun 30, 2017 at 01:42:55PM -0700, bcache@lists.ewheeler.net wrote:
>> From: Liang Chen <liangchen.linux@gmail.com>
>>
>> mutex_destroy does nothing most of time, but it's better to call
>> it to make the code future proof and it also has some meaning
>> for like mutex debug.
>
> It shouldn't really - we should get the destroy behavior for free
> when doing a slab free of the area.
>
> What issue are you trying to solve?
