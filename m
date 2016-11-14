Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0084.outbound.protection.outlook.com ([104.47.42.84]:29756
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S938725AbcKNWqb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2016 17:46:31 -0500
Subject: Re: [PATCH V4 00/15] blk-throttle: add .high limit
To: Shaohua Li <shli@fb.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1479161136.git.shli@fb.com>
CC: <Kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <986ada43-3217-3277-724a-5c76f8dad74e@sandisk.com>
Date: Mon, 14 Nov 2016 14:46:22 -0800
MIME-Version: 1.0
In-Reply-To: <cover.1479161136.git.shli@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 11/14/2016 02:22 PM, Shaohua Li wrote:
> The background is we don't have an ioscheduler for blk-mq yet, so we can't
> prioritize processes/cgroups. This patch set tries to add basic arbitration
> between cgroups with blk-throttle. It adds a new limit io.high for
> blk-throttle. It's only for cgroup2.

Hello Shaohua,

My understanding of this work is that a significant part of it will have 
to be reverted once blk-mq supports I/O scheduling, e.g. the code for 
detecting whether the I/O submitter is idle. Shouldn't this kind of 
infrastructure be added after support has been added in blk-mq for I/O 
scheduling?

Thanks,

Bart.
