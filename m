Return-Path: <mlyle@lyle.org>
Return-Path: <mlyle@lyle.org>
Subject: Re: [GIT PULL] Block fixes for 4.15-rc
To: Jens Axboe <axboe@kernel.dk>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <ed934de4-4245-a2f9-f04a-7e27ec05a1cb@kernel.dk>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <670b5c50-0971-fb65-4400-6509257e2496@lyle.org>
Date: Thu, 30 Nov 2017 13:58:04 -0800
MIME-Version: 1.0
In-Reply-To: <ed934de4-4245-a2f9-f04a-7e27ec05a1cb@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus & Jens--

Just one small clarification:

On 11/30/2017 01:14 PM, Jens Axboe wrote:
> - Pull bcache fixes from Michael Lyle. Most important is a regression
>   fix for a case where bcache could return the wrong data in some
>   circumstances.

The fix for the block-layer data corruption issue from NVMe multipath
work was already accepted in the previous pull.  The main fix in this
series is Rui Hua's fix for  a race condition regression where -EINTR
was returned to upper layers that didn't expect it.

Thanks,

Mike
