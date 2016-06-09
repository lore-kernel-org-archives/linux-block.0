Return-Path: <axboe@kernel.dk>
Subject: Re: two small updates for the request op split
To: Christoph Hellwig <hch@lst.de>, axboe@fb.com, mchristi@redhat.com
References: <1465480836-32093-1-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <575990C5.6090603@kernel.dk>
Date: Thu, 9 Jun 2016 09:52:37 -0600
MIME-Version: 1.0
In-Reply-To: <1465480836-32093-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/09/2016 08:00 AM, Christoph Hellwig wrote:
> First one packs struct request better, and the second one gives the
> secure erase operation it's own opcode as it's very different from
> the normal discard.

Thanks, applied for 4.8.

-- 
Jens Axboe
