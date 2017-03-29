Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38232 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752751AbdC2UbO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2017 16:31:14 -0400
Subject: Re: [PATCH] blk-mq: Export queue state through
 /sys/kernel/debug/block/*/state
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
References: <1D08B61A9CF0974AA09887BE32D889DA12B851@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
CC: Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <42634489-db2d-e04d-28ba-3943a185a678@fb.com>
Date: Wed, 29 Mar 2017 14:31:01 -0600
MIME-Version: 1.0
In-Reply-To: <1D08B61A9CF0974AA09887BE32D889DA12B851@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/29/2017 02:20 PM, Bart Van Assche wrote:
> Make it possible to check whether or not a block layer queue has
> been stopped. Make it possible to run a blk-mq queue from user
> space.

I like this, I've had run-this-queue wired up as well from sysfs
in the past. Maybe we should push it one further, and also allow
things like running a stopped queue?

Would probably be nicer if the file accepted input like "run" (which
would be your current run-this-queue) and "start" (start stopped
queues).

Then we could also EINVAL writes that we don't grok, instead of
just blindly always running the queue.

-- 
Jens Axboe
