Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH v3] block/loop: Serialize ioctl operations.
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot
 <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
        syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1527297408-4428-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <ce5ce21a-5865-36c5-a110-eed11f785ab2@I-love.SAKURA.ne.jp>
 <748bce03-afda-4ed2-13b3-1fcd01d57770@kernel.dk>
 <9a9209af-c841-6034-4b4f-46d93aa0c037@i-love.sakura.ne.jp>
 <92bffcc8-c25d-2297-80b3-24ba99075cd6@i-love.sakura.ne.jp>
Message-ID: <7986e524-1dc8-8d8e-51bc-a5671d7555cc@i-love.sakura.ne.jp>
Date: Tue, 28 Aug 2018 19:31:16 +0900
MIME-Version: 1.0
In-Reply-To: <92bffcc8-c25d-2297-80b3-24ba99075cd6@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Jens, did you come up with a better alternative?
We have another bug which is causing many hung task reports.
I do want to make progress rather than stall for another three month.

On 2018/07/11 23:29, Tetsuo Handa wrote:
> Since syzbot restarted testing linux-next.git , it is a good chance
> to test this patch for unexpected regressions (until you come up with
> a good alternative).
> 
> On 2018/06/26 23:34, Tetsuo Handa wrote:
>> Did you get any idea?
>>
>> On 2018/06/05 3:13, Jens Axboe wrote:
>>> On 6/4/18 5:19 AM, Tetsuo Handa wrote:
>>>> This problem was already ignored for 8 months. Unless we boost priority,
>>>> this problem will be ignored for years. Jens, can we test this patch?
>>>
>>> Sorry, it's just that I _really_ hate this patch. We're making up
>>> a weird locking primitive that tracks the process, with a weird
>>> unlock helper that only unlocks if it's the process that is
>>> holding the mutex.
>>>
>>> I'll try and think about this a bit, it would be nice if we had
>>> a better alternative than the above.
>>>
