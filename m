Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 9/9] nvme: add support for streams and directives
To: Andreas Dilger <adilger@dilger.ca>
Cc: Christoph Hellwig <hch@infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-block@vger.kernel.org,
 Martin Petersen <martin.petersen@oracle.com>, linux-nvme@lists.infradead.org
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-10-git-send-email-axboe@kernel.dk>
 <20170626095907.GG14057@infradead.org>
 <d2dcae41-d0b2-71a7-a63d-b7ef25ae47d2@kernel.dk>
 <7A48D12A-E656-4FC8-9D03-1BC482B8AE34@dilger.ca>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2b006cc3-a113-7322-0af4-99b0de2d8031@kernel.dk>
Date: Mon, 26 Jun 2017 13:39:25 -0600
MIME-Version: 1.0
In-Reply-To: <7A48D12A-E656-4FC8-9D03-1BC482B8AE34@dilger.ca>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 06/26/2017 01:36 PM, Andreas Dilger wrote:
> On Jun 26, 2017, at 7:56 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 06/26/2017 03:59 AM, Christoph Hellwig wrote:
>>> Looks mostly good,
>>>
>>> but two nit-picks:
>>>
>>> - can we keep a module option to disable streams, or in fact for
>>>   now maybe to explicitly enable it?  I expect this to be interesting
>>>   at least for the first devices that implement it.  Also given that
>>>   it needs to be explicitly enabled I would expect some overhead of
>>>   just enabling it when never used
>>
>> Fine with me, I can add the 'streams' parameter back, but just default
>> it to false.
> 
> Better would be a parameter to set the default streams count, 0 by default.

The user should not need to know. If streams is enabled (bool), then it'll
ask for as many as we need on the block side right now, and scale down if
we have to. So I'd rather keep it as a "use streams or not" bool on the
nvme side.


-- 
Jens Axboe
