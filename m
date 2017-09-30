Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: remove unused function hctx_allow_merges
From: Jens Axboe <axboe@kernel.dk>
To: weiping zhang <zhangweiping@didichuxing.com>
Cc: linux-block@vger.kernel.org
References: <20170930070143.GA14515@localhost.didichuxing.com>
 <fb885765-3243-15ee-da3c-272e0a2d3cc5@kernel.dk>
Message-ID: <63663207-1f6a-31c8-210d-3df99c46a4f5@kernel.dk>
Date: Sat, 30 Sep 2017 10:16:38 +0200
MIME-Version: 1.0
In-Reply-To: <fb885765-3243-15ee-da3c-272e0a2d3cc5@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/30/2017 10:15 AM, Jens Axboe wrote:
> On 09/30/2017 09:01 AM, weiping zhang wrote:
>> since 9bddeb2a5b981 "blk-mq: make per-sw-queue bio merge as default .bio_merge"
>> there is no caller for this function.
> 
> Looks like this should change the new check to actually use this function
> instead, or we will be doing merges if someone has turned off merging
> through the sysfs 'nomerges' function.

Actually, looks like the caller does that now, so the patch was actually
fine.

-- 
Jens Axboe
