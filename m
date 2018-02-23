Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:34661 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750916AbeBWB47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 20:56:59 -0500
Subject: Re: [PATCH v2] blk-throttle: fix race between blkcg_bio_issue_check
 and cgroup_rmdir
To: Tejun Heo <tj@kernel.org>, Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        Caspar Zhang <caspar@linux.alibaba.com>,
        linux-block <linux-block@vger.kernel.org>,
        cgroups@vger.kernel.org
References: <6f136c90-faa9-4bc0-b02f-3a112b4d8360@linux.alibaba.com>
 <20180207213811.GF695913@devbig577.frc2.facebook.com>
 <b590caed-1423-4776-966d-cd9e346a8ea1@linux.alibaba.com>
 <20180208152307.GL695913@devbig577.frc2.facebook.com>
 <aac95b90-786d-95bf-b93d-87ecca79f846@linux.alibaba.com>
 <20180212171143.GY695913@devbig577.frc2.facebook.com>
 <19009bad-8429-c210-dd91-2b20771a66bd@linux.alibaba.com>
 <20180222151721.GA1641506@devbig577.frc2.facebook.com>
From: xuejiufei <jiufei.xue@linux.alibaba.com>
Message-ID: <bc6304d1-5b76-c867-e76a-ab1c87b604ee@linux.alibaba.com>
Date: Fri, 23 Feb 2018 09:56:54 +0800
MIME-Version: 1.0
In-Reply-To: <20180222151721.GA1641506@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Tejun,

On 2018/2/22 下午11:18, Tejun Heo wrote:
> Hello,
> 
> On Thu, Feb 22, 2018 at 02:14:34PM +0800, Joseph Qi wrote:
>> I still don't get how css_tryget can work here.
>>
>> The race happens when:
>> 1) writeback kworker has found the blkg with rcu;
>> 2) blkcg is during offlining and blkg_destroy() has already been called.
>> Then, writeback kworker will take queue lock and access the blkg with
>> refcount 0.
> 
> Yeah, then tryget would fail and it should go through the root.
> 
In this race, the refcount of blkg becomes zero and is destroyed.
However css may still have refcount, and css_tryget can return success
before other callers put the refcount.
So I don't get how css_tryget can fix this race? Or I wonder if we can
add another function blkg_tryget?

Thanks,
Jiufei

> Thanks.
> 
