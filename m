Return-Path: <colyli@suse.de>
Subject: Re: [PATCH v3 00/17] bcache for 4.19, 3rd wave
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20180811052000.103680-1-colyli@suse.de>
 <9fc1c391-bfde-ed26-925a-56e30d2fc07e@kernel.dk>
From: Coly Li <colyli@suse.de>
Message-ID: <97c00b52-c5e1-227d-0ed5-e6e3e70742ff@suse.de>
Date: Sun, 12 Aug 2018 12:09:36 +0800
MIME-Version: 1.0
In-Reply-To: <9fc1c391-bfde-ed26-925a-56e30d2fc07e@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2018/8/12 5:42 AM, Jens Axboe wrote:
> On 8/10/18 11:19 PM, Coly Li wrote:
>> Hi Jens,
>>
>> This series contains several minor fixes and code cleanup reported by
>> scripts/checkpatch.pl. After this series, there are still a few warning
>> from checkpatch.pl, but I think they are necessary to be the way they
>> are and don't change them. For example, error message exceeds 80 chars
>> line limit.
> 
> It's a little late to apply these at this point, since 4.18 will be
> released tomorrow. I can queue them up for later in the merge
> window, for a post pull.
> 

Hi Jens

Sure, thank you.

Coly Li
