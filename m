Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To: Anchal Agarwal <anchalag@amzn.com>
Cc: fllinden@amazon.com, Jianchao Wang <jianchao.w.wang@oracle.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
 <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
 <20180824181223.GA9049@kaos-source-ops-60001.pdx1.amazon.com>
 <677c8648-63fd-601c-b906-40a8502f9782@kernel.dk>
 <20180824203305.GA4690@kaos-source-ops-60001.pdx1.amazon.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <dc734449-7cd8-3a8e-9fdc-d7d854393900@kernel.dk>
Date: Fri, 24 Aug 2018 14:41:07 -0600
MIME-Version: 1.0
In-Reply-To: <20180824203305.GA4690@kaos-source-ops-60001.pdx1.amazon.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/24/18 2:33 PM, Anchal Agarwal wrote:
> On Fri, Aug 24, 2018 at 12:50:44PM -0600, Jens Axboe wrote:
>> On 8/24/18 12:12 PM, Anchal Agarwal wrote:
>>> That's totally fair. As compared to before the patch it was way too high
>>> and my test case wasn't even running due to the thunderign herd issues and
>>> queue re-ordering. Anyways as I also mentioned before 10 times 
>>> contention is not too bad since its not really affecting much the number of
>>> files read in my applciation. Also, you are right waking up N tasks seems 
>>> plausible. 
>>
>> OK, I'm going to take that as a positive response. I'm going to propose
>> the last patch as the final addition in this round, since it does fix a
>> gap in the previous. And I do think that we need to wake as many tasks
>> as can make progress, otherwise we're deliberately running the device at
>> a lower load than we should.
>>
>>> My application is somewhat similar to database workload. It does uses fsync 
>>> internally also. So what it does is it creates files of random sizes with 
>>> random contents. It stores the hash of those files in memory. During the 
>>> test it reads those files back from storage and checks their hashes. 
>>
>> How many tasks are running for your test?
>>
>> -- 
>> Jens Axboe
>>
>>
> 
> So there are 128 Concurrent reads/writes happening. Max files written before
> reads start is 16384 and each file is of size 512KB. Does that answer your
> question?

Yes it does, thanks. That's not a crazy amount of tasks or threads.

> BTW, I still have to test the last patch you send but by looking at the patch 
> I assumed it will work anyways!

Thanks for the vote of confidence, I'd appreciate if you would give it a
whirl. Your workload seems nastier than what I test with, so would be
great to have someone else test it too.

-- 
Jens Axboe
