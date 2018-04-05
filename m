Return-Path: <Nikolaus@rath.org>
From: Nikolaus Rath <Nikolaus@rath.org>
To: Michael Lyle <mlyle@lyle.org>
Cc: Jens Axboe <axboe@kernel.dk>,  linux-bcache@vger.kernel.org,  linux-block@vger.kernel.org
Subject: Re: bcache and hibernation
References: <1522782091.951690.1325310168.33572B11@webmail.messagingengine.com>
	<e9abd200-1718-7975-b3e5-d05473e7d2d4@kernel.dk>
	<1522918273.1829962.1327322736.4F60CFBA@webmail.messagingengine.com>
	<70ea227e-ecb2-9047-0f8d-0864340dc870@lyle.org>
Date: Thu, 05 Apr 2018 20:51:04 +0100
In-Reply-To: <70ea227e-ecb2-9047-0f8d-0864340dc870@lyle.org> (Michael Lyle's
	message of "Thu, 5 Apr 2018 11:13:08 -0700")
Message-ID: <87muyhmnyv.fsf@vostro.rath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Michael,

On Apr 05 2018, Michael Lyle <mlyle@lyle.org> wrote:
> On 04/05/2018 01:51 AM, Nikolaus Rath wrote:
>> Is there a way to prevent this from happening? Could eg the kernel
>> detect that the swap devices is (indirectly) on bcache and refuse to
>> hibernate? Or is there a way to do a "true" read-only mount of a
>> bcache volume so that one can safely resume from it?
>
> I think you're correct.  If you're using bcache in writeback mode, it is
> not safe to hibernate there, because some of the blocks involved in the
> resume can end up in cache (and dependency issues, like you mention).

Could you explain why this isn't a problem with writethrough? It seems
to me that the trouble happens when the hibernation image is *read*, so
why does it matter what kind of write caching is used?

> I am unaware of a mechanism to prohibit this in the kernel-- to say that
> a given type of block provider can't be involved in a resume operation.
> Most documentation for hibernation explicitly cautions about the btrfs
> situation, but use of bcache is less common and as a result generally
> isn't covered.

Could you maybe add a warning to Documentation/bcache.txt? I think this
would have saved me.

Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
