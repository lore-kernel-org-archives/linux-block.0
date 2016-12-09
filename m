Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-wbt: don't throttle discard or write zeroes
To: Christoph Hellwig <hch@lst.de>
References: <1481289546-2397-1-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <33b32c94-2389-5f6f-8dff-704e498026e2@kernel.dk>
Date: Fri, 9 Dec 2016 09:31:18 -0700
MIME-Version: 1.0
In-Reply-To: <1481289546-2397-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/09/2016 06:19 AM, Christoph Hellwig wrote:
> Both of these are metadata only commands that are not issued by the
> writeback code and not directly relevant to the writeback bandwith.

Added, thanks.

-- 
Jens Axboe
