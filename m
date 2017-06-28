Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55544 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751528AbdF1Qlu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 12:41:50 -0400
Subject: Re: [PATCH V4 11/12] blktrace: add an option to allow displying
 cgroup path
To: Shaohua Li <shli@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC: <tj@kernel.org>, <gregkh@linuxfoundation.org>, <hch@lst.de>,
        <rostedt@goodmis.org>, <lizefan@huawei.com>, <Kernel-team@fb.com>,
        Shaohua Li <shli@fb.com>
References: <cover.1498666964.git.shli@fb.com>
 <4fd5daa04db8e79e5f9e85e348112af1dc714cc4.1498666964.git.shli@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <209b9d5e-291c-882f-5116-53ad9c6eee2b@fb.com>
Date: Wed, 28 Jun 2017 10:41:14 -0600
MIME-Version: 1.0
In-Reply-To: <4fd5daa04db8e79e5f9e85e348112af1dc714cc4.1498666964.git.shli@fb.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/28/2017 10:30 AM, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> By default we output cgroup id in blktrace. This adds an option to
> display cgroup path. Since get cgroup path is a relativly heavy
> operation, we don't enable it by default.
> 
> with the option enabled, blktrace will output something like this:
> dd-1353  [007] d..2   293.015252:   8,0   /test/level  D   R 24 + 8 [dd]

Typo in your subject, "displaying".

-- 
Jens Axboe
