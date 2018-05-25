Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Block: null_blk: add blocking description and remove
 lightnvm
To: Liu Bo <bo.liu@linux.alibaba.com>, linux-block@vger.kernel.org
References: <1527259204-79604-1-git-send-email-bo.liu@linux.alibaba.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bf9ff654-3f3e-406d-9fd0-8d42966beb27@kernel.dk>
Date: Fri, 25 May 2018 08:52:23 -0600
MIME-Version: 1.0
In-Reply-To: <1527259204-79604-1-git-send-email-bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/25/18 8:40 AM, Liu Bo wrote:
> - The description of 'blocking' is missing in null_blk.txt
> 
> - The 'lightnvm' parameter has been removed in null_blk.c
> 
> This updates both in null_blk.txt.

Thanks, applied.

-- 
Jens Axboe
