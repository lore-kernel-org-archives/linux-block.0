Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET v9] Add support for write life time hints
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, hch@infradead.org, linux-nvme@lists.infradead.org
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <yq11sqejfe6.fsf@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b9130363-4b7e-33f8-e1da-10e192fb046f@kernel.dk>
Date: Tue, 20 Jun 2017 19:45:08 -0600
MIME-Version: 1.0
In-Reply-To: <yq11sqejfe6.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 07:30 PM, Martin K. Petersen wrote:
> 
> Jens,
> 
>> A new iteration of this patchset, previously known as write streams.
>> As before, this patchset aims at enabling applications split up
>> writes into separate streams, based on the perceived life time
>> of the data written. This is useful for a variety of reasons:
> 
> The grep-wielding streams police noticed several occurrences of the
> string "stream" in patches 1-3 and 5. Please fix.
You really hate those streams :-)

I've pruned all references to it, from comments and arguments.

> Otherwise OK as a baseline.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

Thanks!

-- 
Jens Axboe
