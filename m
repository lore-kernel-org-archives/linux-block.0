Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3 1/2] block: Add iocontext priority to request
To: Adam Manzanares <adam.manzanares@hgst.com>, tj@kernel.org
References: <1476218427-4021-1-git-send-email-adam.manzanares@hgst.com>
 <1476218427-4021-2-git-send-email-adam.manzanares@hgst.com>
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4b60fe5d-113f-9361-bbae-7473002500ba@kernel.dk>
Date: Wed, 12 Oct 2016 08:49:54 -0600
MIME-Version: 1.0
In-Reply-To: <1476218427-4021-2-git-send-email-adam.manzanares@hgst.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/11/2016 02:40 PM, Adam Manzanares wrote:
> Patch adds an association between iocontext ioprio and the ioprio of
> a request. This feature is only enabled if a queue flag is set to
> indicate that requests should have ioprio associated with them. The
> queue flag is exposed as the req_prio queue sysfs entry.

Honestly, I don't get this patchset. For the normal file system path, we
inherit the iocontext priority into the bio. That in turns gets
inherited by the request. Why is this any different?

It'd be much cleaner to just have 'rq' inherit the IO priority from the
io context when the 'rq' is allocated, and ensuring that we inherit and
override this if the bio has one set instead. It should already work
like that.

And in no way should we add some sysfs file to control this, that is
nuts.

-- 
Jens Axboe
