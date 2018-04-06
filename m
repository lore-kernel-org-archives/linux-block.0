Return-Path: <mlyle@lyle.org>
MIME-Version: 1.0
In-Reply-To: <87muyhmnyv.fsf@vostro.rath.org>
References: <1522782091.951690.1325310168.33572B11@webmail.messagingengine.com>
 <e9abd200-1718-7975-b3e5-d05473e7d2d4@kernel.dk> <1522918273.1829962.1327322736.4F60CFBA@webmail.messagingengine.com>
 <70ea227e-ecb2-9047-0f8d-0864340dc870@lyle.org> <87muyhmnyv.fsf@vostro.rath.org>
From: Michael Lyle <mlyle@lyle.org>
Date: Thu, 5 Apr 2018 17:21:21 -0700
Message-ID: <CAJ+L6qfQhodW_wY1cMGVixtrp46SQDF6K2K_zceU-A77DH917g@mail.gmail.com>
Subject: Re: bcache and hibernation
To: Michael Lyle <mlyle@lyle.org>, Jens Axboe <axboe@kernel.dk>,
	linux-bcache <linux-bcache@vger.kernel.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 5, 2018 at 12:51 PM, Nikolaus Rath <Nikolaus@rath.org> wrote:
> Hi Michael,
>
> Could you explain why this isn't a problem with writethrough? It seems
> to me that the trouble happens when the hibernation image is *read*, so
> why does it matter what kind of write caching is used?

With writethrough you can set up your loader to read it directly from
the backing device-- e.g. you don't need the cache, and there's at
least some valid configurations; with writeback some of the extents
may be on the cache dev so...

That said, it's not really great to put swap/hibernate on a cache
device... the workloads don't usually benefit much from tiering (since
they tend to be write-once-read-never or write-once-read-once).

>> I am unaware of a mechanism to prohibit this in the kernel-- to say that
>> a given type of block provider can't be involved in a resume operation.
>> Most documentation for hibernation explicitly cautions about the btrfs
>> situation, but use of bcache is less common and as a result generally
>> isn't covered.
>
> Could you maybe add a warning to Documentation/bcache.txt? I think this
> would have saved me.

Yah, I can look at that.

>
> Best,
> -Nikolaus

Mike
