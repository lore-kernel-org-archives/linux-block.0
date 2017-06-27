Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/9] fs: add fcntl() interface for setting/getting write
 life time hints
To: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, martin.petersen@oracle.com
References: <1498491480-16306-1-git-send-email-axboe@kernel.dk>
 <1498491480-16306-2-git-send-email-axboe@kernel.dk>
 <20170627144255.GB2541@infradead.org>
 <f543046a-c186-da7a-73e1-6510e93118bf@kernel.dk>
 <20170627145711.GA27044@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7e125204-4641-6ca8-4656-d83f6bf7d33d@kernel.dk>
Date: Tue, 27 Jun 2017 08:58:27 -0600
MIME-Version: 1.0
In-Reply-To: <20170627145711.GA27044@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/27/2017 08:57 AM, Christoph Hellwig wrote:
> On Tue, Jun 27, 2017 at 08:55:02AM -0600, Jens Axboe wrote:
>> BTW, that patch does not look like an incremental patch, what's
>> this against?
> 
> The patch I'm replying to, without the other ones.

Looks like a replacement patch, not incremental to that. I'll
update. And I'm fine with not using flags, in fact that's what
I preferred to do initially.

-- 
Jens Axboe
