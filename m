Return-Path: <mlyle@lyle.org>
Return-Path: <mlyle@lyle.org>
Subject: Re: bcache and hibernation
To: Nikolaus Rath <nikolaus@rath.org>, Jens Axboe <axboe@kernel.dk>,
 linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1522782091.951690.1325310168.33572B11@webmail.messagingengine.com>
 <e9abd200-1718-7975-b3e5-d05473e7d2d4@kernel.dk>
 <1522918273.1829962.1327322736.4F60CFBA@webmail.messagingengine.com>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <70ea227e-ecb2-9047-0f8d-0864340dc870@lyle.org>
Date: Thu, 5 Apr 2018 11:13:08 -0700
MIME-Version: 1.0
In-Reply-To: <1522918273.1829962.1327322736.4F60CFBA@webmail.messagingengine.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Nikolaus (and everyone else),

Sorry I've been slow in responding.  I probably need to step down as
bcache maintainer because so many other things have competed for my time
lately and I've fallen behind on both patches and mailing list.

On 04/05/2018 01:51 AM, Nikolaus Rath wrote:
> Is there a way to prevent this from happening? Could eg the kernel detect that the swap devices is (indirectly) on bcache and refuse to hibernate? Or is there a way to do a "true" read-only mount of a bcache volume so that one can safely resume from it?

I think you're correct.  If you're using bcache in writeback mode, it is
not safe to hibernate there, because some of the blocks involved in the
resume can end up in cache (and dependency issues, like you mention).
There's similar cautions/problems with btrfs.

I am unaware of a mechanism to prohibit this in the kernel-- to say that
a given type of block provider can't be involved in a resume operation.
Most documentation for hibernation explicitly cautions about the btrfs
situation, but use of bcache is less common and as a result generally
isn't covered.

> Best,
> -Nikolaus
Mike
