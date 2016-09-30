Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35227 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbcI3IfZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2016 04:35:25 -0400
Received: by mail-yw0-f193.google.com with SMTP id t204so3709404ywt.2
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2016 01:35:24 -0700 (PDT)
Date: Fri, 30 Sep 2016 10:35:21 +0200
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] blkcg: Unlock blkcg_pol_mutex once if cpd == NULL
Message-ID: <20160930083521.GB29207@mtj.duckdns.org>
References: <e9746d79-c14d-bf76-5218-3e7cdfbf4b34@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e9746d79-c14d-bf76-5218-3e7cdfbf4b34@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 29, 2016 at 08:33:30AM -0700, Bart Van Assche wrote:
> Unlocking a mutex twice is wrong. Hence modify blkcg_policy_register()
> such that blkcg_pol_mutex is unlocked once if cpd == NULL. This patch
> avoids that smatch reports the following error:
> 
> block/blk-cgroup.c:1378: blkcg_policy_register() error: double unlock 'mutex:&blkcg_pol_mutex'
> 
> Fixes: 06b285bd1125 ("blkcg: fix blkcg_policy_data allocation bug")
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: <stable@vger.kernel.org>

Applied to cgroup/for-4.9.  We're right before v4.8 release and it's
extremely unlikely to trigger (it has never been actually reported).

Thanks.

-- 
tejun
