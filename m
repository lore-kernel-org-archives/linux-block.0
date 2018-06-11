Return-Path: <dvyukov@google.com>
MIME-Version: 1.0
In-Reply-To: <1d8de494-0a52-33f5-4c8d-0ec08cfb101c@kernel.dk>
References: <CACT4Y+ZmRj61ia-WQBC=M72o=OZWk5LSnzf2qOEuOLHAa4do_A@mail.gmail.com>
 <1d8de494-0a52-33f5-4c8d-0ec08cfb101c@kernel.dk>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 11 Jun 2018 10:23:43 +0200
Message-ID: <CACT4Y+b3ZWfOEHdYPCtP3mULz+6PheWv1CRvEME4jcpbjiJirA@mail.gmail.com>
Subject: Re: mainline boot is broken: KASAN: use-after-free in blk_flush_complete_seq
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sat, Jun 9, 2018 at 2:33 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 6/9/18 3:34 AM, Dmitry Vyukov wrote:
>> Hi,
>>
>> Boot of mainline kernel is currently broken.
>> On commit 7d3bf613e99abbd96ac7b90ee3694a246c975021.
>> Config:
>> https://gist.githubusercontent.com/dvyukov/9f7f1fd9e477efd85b221b3a21036c20/raw/7c56ede0840494b26045976960866f2b265c6f64/gistfile1.txt
>> Should have been introduced very recently.
>
> Can you try the below?

Yes, this fixes the use-after-free:

Tested-by: Dmitry Vyukov <dvyukov@google.com>

>> You may need to also patch "umh: fix race condition", because that's
>> another boot crasher currently present in tree.
>
> Not sure that that refers to.


Currently there are 2 boot bugs present in upstream tree: this block
bug and an umh bug. I assumed that anybody who will be fixing the
block bug will want to first reproduce it and then test the fix
locally. But if one would try to do it, they will actually hit the umh
bug first. So I provided the fixing commit for the umh bug to simplify
things for whoever would be fixing this block bug.


> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 058abdb50f31..ce41f666de3e 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -169,9 +169,11 @@ static bool blk_flush_complete_seq(struct request *rq,
>         struct request_queue *q = rq->q;
>         struct list_head *pending = &fq->flush_queue[fq->flush_pending_idx];
>         bool queued = false, kicked;
> +       unsigned int cmd_flags;
>
>         BUG_ON(rq->flush.seq & seq);
>         rq->flush.seq |= seq;
> +       cmd_flags = rq->cmd_flags;
>
>         if (likely(!error))
>                 seq = blk_flush_cur_seq(rq);
> @@ -212,7 +214,7 @@ static bool blk_flush_complete_seq(struct request *rq,
>                 BUG();
>         }
>
> -       kicked = blk_kick_flush(q, fq, rq->cmd_flags);
> +       kicked = blk_kick_flush(q, fq, cmd_flags);
>         return kicked | queued;
>  }
>
>
> --
> Jens Axboe
>
