Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60964 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753194AbdCBCuK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Mar 2017 21:50:10 -0500
Subject: Re: [PATCH 2/2] blk-mq-debugfs: add q->mq_freeze_depth output
To: Omar Sandoval <osandov@osandov.com>, <linux-block@vger.kernel.org>
References: <7e888cad9e6c35835559281d3ab9e05ea48836d0.1488393750.git.osandov@fb.com>
 <d4ab26006c6b454db94d548df10da3ce8908c8a1.1488393750.git.osandov@fb.com>
CC: <kernel-team@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <6fb18656-799e-6221-6b82-44f14cd59418@fb.com>
Date: Wed, 1 Mar 2017 19:25:59 -0700
MIME-Version: 1.0
In-Reply-To: <d4ab26006c6b454db94d548df10da3ce8908c8a1.1488393750.git.osandov@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/01/2017 11:42 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This can be used to diagnose freeze-related hangs.

Do we really need this? For the loop case, it was painfully
obvious that it was a count issue. And I can't think of any
cases where it would have helped us, outside of rewriting
core parts (like the first edition of the shadow requests
for the scheduler).

Not strongly opposed to it, feel free to convince me.

-- 
Jens Axboe
