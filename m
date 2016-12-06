Return-Path: <nicstange@gmail.com>
Return-Path: <nicstange@gmail.com>
From: Nicolai Stange <nicstange@gmail.com>
To: Nicolai Stange <nicstange@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,  Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>,  Shaun Tancheff <shaun.tancheff@seagate.com>,  Damien Le Moal <damien.lemoal@hgst.com>,  linux-block@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix unintended fallthrough in generic_make_request_checks()
References: <20161204135639.7016-1-nicstange@gmail.com>
Date: Tue, 06 Dec 2016 01:04:54 +0100
In-Reply-To: <20161204135639.7016-1-nicstange@gmail.com> (Nicolai Stange's
	message of "Sun, 4 Dec 2016 14:56:39 +0100")
Message-ID: <87eg1l53dl.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Nicolai Stange <nicstange@gmail.com> writes:

> ---
> Applicable to next-20161202.
>
> Note that after this patch, I'm seeing a single
>  EXT4-fs (dm-1): Delayed block allocation failed for inode 2625094 at
>                  logical offset 2032 with max blocks 2 with error 121
> with 121 == EREMOTEIO
>
> This is because my SATA sda reports 0x20 (invalid command) back
> in response to 0x41 (WRITE_SAME).
>
> After this has happened, sd_done() disables "write same" once and for
> all, hence only this single message.
>
> I expect this to get fixed by
>   https://patchwork.kernel.org/patch/9321963/

Just FYI: Not really, the (supposedly) corresponding commit has already
been in linux-next when I was testing: commit 0ce1b18c42a5 ("libata:
Some drives failing on SCT Write Same").

I sent separate patch for this issue:
http://lkml.kernel.org/r/20161205235638.11539-1-nicstange@gmail.com

Regards,

Nicolai
