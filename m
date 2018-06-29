Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Blktrace: bail out early if block debugfs is not
 configured
To: Liu Bo <bo.liu@linux.alibaba.com>, linux-block@vger.kernel.org
References: <1530237368-105049-1-git-send-email-bo.liu@linux.alibaba.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9d232e49-c739-ffe9-395f-b6623f25f5f6@kernel.dk>
Date: Fri, 29 Jun 2018 09:02:35 -0600
MIME-Version: 1.0
In-Reply-To: <1530237368-105049-1-git-send-email-bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/28/18 7:56 PM, Liu Bo wrote:
> Since @blk_debugfs_root couldn't be configured dynamically, we can
> save a few memory allocation if it's not there.

Applied for 4.19, thanks.

-- 
Jens Axboe
