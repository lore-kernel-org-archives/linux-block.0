Return-Path: <colyli@suse.de>
Subject: Re: [PATCH 00/10] bcache patches for 4.19, 2nd wave
To: Jens Axboe <axboe@kernel.dk>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
References: <20180809074851.11027-1-colyli@suse.de>
 <ffb6468d-2f00-f9e7-665a-b82d0dcf1e1f@kernel.dk>
From: Coly Li <colyli@suse.de>
Message-ID: <1d3f51bb-3584-09c4-d045-df6d14de4312@suse.de>
Date: Thu, 9 Aug 2018 22:24:37 +0800
MIME-Version: 1.0
In-Reply-To: <ffb6468d-2f00-f9e7-665a-b82d0dcf1e1f@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2018/8/9 10:21 PM, Jens Axboe wrote:
> On 8/9/18 1:48 AM, Coly Li wrote:
>> Hi Jens, 
>>
>> Here are 2nd wave bcache patches for 4.19.
>>
>> The patches from me were either verified by other people or posted
>> for quite long time. Except for the debugfs_create_dir() fix and
>> "set max writeback rate" fix, rested patches are simple or trivial
>> IMHO.
>>
>> Our new bcache developer Shenghui Wang contributes two patches in
>> this run. The first one fixes a misleading error message, and the
>> second one is a code style clean up.
>>
>> Thanks in advance for picking them.
> 
> Applied, fixed up a typo in your patch #4.
> 
Oh, thanks!

Coly Li
