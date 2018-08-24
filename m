Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To: Anchal Agarwal <anchalag@amzn.com>
Cc: fllinden@amazon.com, Jianchao Wang <jianchao.w.wang@oracle.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 anchalag@amazon.com
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
 <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
 <20180824181223.GA9049@kaos-source-ops-60001.pdx1.amazon.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <677c8648-63fd-601c-b906-40a8502f9782@kernel.dk>
Date: Fri, 24 Aug 2018 12:50:44 -0600
MIME-Version: 1.0
In-Reply-To: <20180824181223.GA9049@kaos-source-ops-60001.pdx1.amazon.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/24/18 12:12 PM, Anchal Agarwal wrote:
> That's totally fair. As compared to before the patch it was way too high
> and my test case wasn't even running due to the thunderign herd issues and
> queue re-ordering. Anyways as I also mentioned before 10 times 
> contention is not too bad since its not really affecting much the number of
> files read in my applciation. Also, you are right waking up N tasks seems 
> plausible. 

OK, I'm going to take that as a positive response. I'm going to propose
the last patch as the final addition in this round, since it does fix a
gap in the previous. And I do think that we need to wake as many tasks
as can make progress, otherwise we're deliberately running the device at
a lower load than we should.

> My application is somewhat similar to database workload. It does uses fsync 
> internally also. So what it does is it creates files of random sizes with 
> random contents. It stores the hash of those files in memory. During the 
> test it reads those files back from storage and checks their hashes. 

How many tasks are running for your test?

-- 
Jens Axboe
