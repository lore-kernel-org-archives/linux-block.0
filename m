Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:46620 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932320AbeAJBou (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jan 2018 20:44:50 -0500
Subject: Re: [RFC PATCH] blk-throttle: dispatch more sync writes in block
 throttle layer
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Shaohua Li <shli@kernel.org>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        jinli.zjl@alibaba-inc.com, qijiang.qj@alibaba-inc.com
References: <f6f59e3c-456a-8275-8af0-32e4f2e5cdd6@gmail.com>
 <20180108120742.GJ3668920@devbig577.frc2.facebook.com>
 <5ff01c31-5277-909f-4c35-9b9be513d8e1@gmail.com>
 <20180109145659.GG3668920@devbig577.frc2.facebook.com>
From: xuejiufei <xuejiufei@gmail.com>
Message-ID: <37158a6a-ff0d-10e7-c39b-9d588b5f50d2@gmail.com>
Date: Wed, 10 Jan 2018 09:44:43 +0800
MIME-Version: 1.0
In-Reply-To: <20180109145659.GG3668920@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Tejun,

On 2018/1/9 下午10:56, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jan 09, 2018 at 12:45:13PM +0800, xuejiufei wrote:
>> 1. A bio is charged according to the direction, if we put the reads
>> and sync writes together, we need to search the queue to pick a
>> certain number of read and write IOs when the limit is not reached.
> 
> Ah, you're right.
> 
>> 2. I found that the multi-queue scheduler kyber also has three queues:
>> one for read, one for sync write and one for others. This patch
>> introduces another queue for async writes and others just like kyber.
> 
> Yeah, it'd make sense to make that a separate queue then.
> 
Could you please review this patch and give some advice?

Thanks.
Jiufei Xue

> Thanks.
> 
