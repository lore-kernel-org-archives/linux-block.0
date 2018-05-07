Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/3] block: break discard submissions into the user
 defined size
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 dchinner@redhat.com
References: <1525360843-6504-1-git-send-email-axboe@kernel.dk>
 <1525360843-6504-2-git-send-email-axboe@kernel.dk>
 <20180507095128.GA25210@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d5505f94-4bcb-5acc-7b5c-158d9d9e9215@kernel.dk>
Date: Mon, 7 May 2018 09:47:52 -0600
MIME-Version: 1.0
In-Reply-To: <20180507095128.GA25210@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/7/18 3:51 AM, Christoph Hellwig wrote:
> On Thu, May 03, 2018 at 09:20:41AM -0600, Jens Axboe wrote:
>> Don't build discards bigger than what the user asked for, if the
>> user decided to limit the size by writing to 'discard_max_bytes'.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Why do this here when blk_bio_discard_split already takes care of it?

Functionally it should be the same, just seems pointless to defer
the chopping if we can build them the right size to begin with.

-- 
Jens Axboe
