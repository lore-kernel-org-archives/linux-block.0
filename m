Return-Path: <axboe@kernel.dk>
Subject: Re: remove most req->special users
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20181109183208.19879-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <06b09b48-76d9-eae5-5cfa-e4df5ca285e6@kernel.dk>
Date: Fri, 9 Nov 2018 15:47:05 -0700
MIME-Version: 1.0
In-Reply-To: <20181109183208.19879-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/9/18 11:32 AM, Christoph Hellwig wrote:
> Try to get rid of the req->special users so that we can remove this
> field.  With this series we basically only have the osd / scsi BIDI
> code left, which should go away in another series.

Outside of the typo in skd_main that Bart pointed out, the rest
of it looks fine to me. Can you send a v2 with that fixed?

-- 
Jens Axboe
