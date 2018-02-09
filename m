Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:58289 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752103AbeBICPX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Feb 2018 21:15:23 -0500
Subject: Re: [PATCH v2] blk-throttle: fix race between blkcg_bio_issue_check
 and cgroup_rmdir
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        xuejiufei <jiufei.xue@linux.alibaba.com>,
        Caspar Zhang <caspar@linux.alibaba.com>,
        linux-block <linux-block@vger.kernel.org>,
        cgroups@vger.kernel.org
References: <6f136c90-faa9-4bc0-b02f-3a112b4d8360@linux.alibaba.com>
 <20180207213811.GF695913@devbig577.frc2.facebook.com>
 <b590caed-1423-4776-966d-cd9e346a8ea1@linux.alibaba.com>
 <20180208152307.GL695913@devbig577.frc2.facebook.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <aac95b90-786d-95bf-b93d-87ecca79f846@linux.alibaba.com>
Date: Fri, 9 Feb 2018 10:15:19 +0800
MIME-Version: 1.0
In-Reply-To: <20180208152307.GL695913@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Tejun,

On 18/2/8 23:23, Tejun Heo wrote:
> Hello, Joseph.
> 
> On Thu, Feb 08, 2018 at 10:29:43AM +0800, Joseph Qi wrote:
>> So you mean checking css->refcnt to prevent the further use of
>> blkg_get? I think it makes sense.
> 
> Yes.
> 
>> IMO, we should use css_tryget_online instead, and rightly after taking
> 
> Not really.  An offline css still can have a vast amount of IO to
> drain and write out.
> 
IIUC, we have to identify it is in blkcg_css_offline now which will
blkg_put. Since percpu_ref_kill_and_confirm in kill_css will set flag
__PERCPU_REF_DEAD, so we can use this to avoid the race. IOW, if
__PERCPU_REF_DEAD is set now, we know blkcg css is in offline and
continue access blkg may risk double free. Thus we choose to skip these
ios.
I don't get how css_tryget works since it doesn't care the flag
__PERCPU_REF_DEAD. Also css_tryget can't prevent blkcg_css from
offlining since the race happens blkcg_css_offline is in progress.
Am I missing something here?

Thanks,
Joseph

>> queue_lock. Because there may be more use of blkg_get in blk_throtl_bio
>> in the futher. Actually it already has two now. One is in
>> blk_throtl_assoc_bio, and the other is in throtl_qnode_add_bio.
>> What do you think of this?
> 
> As long as we avoid making the bypass paths expensive, whatever makes
> the code easier to read and maintain would be better.  css ref ops are
> extremely cheap anyway.
> 
> Thanks.
> 
