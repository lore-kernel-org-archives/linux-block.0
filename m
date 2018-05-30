Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RESEND] blk-throttle: fix potential NULL pointer
 dereference in throtl_select_dispatch
To: Liu Bo <bo.liu@linux.alibaba.com>, linux-block@vger.kernel.org
References: <1527582552-4841-1-git-send-email-bo.liu@linux.alibaba.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <02ad0f46-32ed-bb6b-0d35-6408a827ee07@kernel.dk>
Date: Wed, 30 May 2018 10:54:41 -0600
MIME-Version: 1.0
In-Reply-To: <1527582552-4841-1-git-send-email-bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/29/18 2:29 AM, Liu Bo wrote:
> tg in throtl_select_dispatch is used first and then do check. Since tg
> may be NULL, it has potential NULL pointer dereference risk. So fix
> it.

Applied, thanks.

-- 
Jens Axboe
