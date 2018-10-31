Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: brd: associate with queue until adding disk
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org
References: <20181031084050.2238-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5839d935-3326-2772-4b8d-f8ef8e1b3433@kernel.dk>
Date: Wed, 31 Oct 2018 08:43:27 -0600
MIME-Version: 1.0
In-Reply-To: <20181031084050.2238-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/31/18 2:40 AM, Ming Lei wrote:
> brd_free() may be called in failure path on one brd instance which
> disk isn't added yet, so release handler of gendisk may free the
> associated request_queue early and causes the following use-after-free[1].
> 
> This patch fixes this issue by associating gendisk with request_queue
> just before adding disk.

Looks good to me, thanks, applied.

-- 
Jens Axboe
