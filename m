Return-Path: <axboe@kernel.dk>
Subject: Re: Hard LOCKUP on 4.15-rc9 + 'blkmq/for-next' branch
To: David Zarzycki <dave@znu.io>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <95E75EBE-D01A-4236-8762-FF3522D6DBAD@znu.io>
 <78e10971-611e-8dd7-104e-8266c3ba3b5c@kernel.dk>
 <7E93BF17-8476-4A93-BD27-D2E22E5DAB00@znu.io>
 <6025644f-e147-903a-e836-a2f53d3a61e9@kernel.dk>
 <79205A92-2997-45D6-9277-6F56EC7CA989@znu.io>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e492ffee-6a04-4f84-a22e-6d71486dbe07@kernel.dk>
Date: Tue, 23 Jan 2018 08:34:26 -0700
MIME-Version: 1.0
In-Reply-To: <79205A92-2997-45D6-9277-6F56EC7CA989@znu.io>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/23/18 6:48 AM, David Zarzycki wrote:
> 
> 
>> On Jan 22, 2018, at 20:20, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> All of these are off the blk-wbt completion path. I suggested earlier to
>> try and disable CONFIG_BLK_WBT to see if it goes away, or at least to
>> see if the pattern changes.
> 
> Hi Jens,
> 
> Bingo! Disabling CONFIG_BLK_WBT makes the problem go away.

Interesting. The only thing I can think of is
block/blk-wbt.c:get_rq_wait() returning a bogus pointer, but your
compiler would need to be broken for that. And I think your lockdep
would have exploded if that was the case. See below for a quick'n dirty
you can try and run to disprove that theory.

>>> I’m open to trying anything at this point. Thanks for helping,
>>
>> I'd try other types of stress testing. Has the machine otherwise been
>> stable, or is it a new box?
> 
> It is a new box. Other than the CONFIG_BLK_WBT problem, it handles
> stress just fine. If you want to debug this further, I’m willing to
> run instrumented code.

The below is a long shot, but I'll try and think about it some more. I
haven't had any reports like this, ever, so it's very puzzling.


diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index ae8de9780085..5a45e9245d89 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -103,7 +103,7 @@ static bool wb_recent_wait(struct rq_wb *rwb)
 
 static inline struct rq_wait *get_rq_wait(struct rq_wb *rwb, bool is_kswapd)
 {
-	return &rwb->rq_wait[is_kswapd];
+	return &rwb->rq_wait[!!is_kswapd];
 }
 
 static void rwb_wake_all(struct rq_wb *rwb)

-- 
Jens Axboe
