Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:35735 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbcIQB1F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Sep 2016 21:27:05 -0400
Subject: Re: [PATCH] blk-throttle: fix infinite throttling caused by
 non-cascading timer wheel
To: Vivek Goyal <vgoyal@redhat.com>
References: <1473662730-184701-1-git-send-email-houtao1@huawei.com>
 <20160913134646.GA19320@redhat.com>
CC: <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
From: Hou Tao <houtao1@huawei.com>
Message-ID: <57DC9BDB.3000208@huawei.com>
Date: Sat, 17 Sep 2016 09:26:51 +0800
MIME-Version: 1.0
In-Reply-To: <20160913134646.GA19320@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Thanks for the patch. I can reproduce it. I am wondering that why are you
> doing so many checks. Can't we just check if throttle group is empty or
> not. If it is empty and slice has expired, then start a new slice. If
> throttle group is not empty, then we know slice has to be an active slice
> and should be extended (despite the fact that it might have expired
> because timer function got called later than we expected it to be).
Yes, only checking the empty status of bio queue is enough.

The check of dispatched ios and bytes was used to ensure the time slice
had not been used, but the logic is incorrect: even if the time slice
had been used, the extend of time slice is needed if the timer slacked.

> Can you please try following patch. It seems to resolve the issue for me.
It works for me.

