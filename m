Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34081 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752533AbdBJTGP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Feb 2017 14:06:15 -0500
Subject: Re: [PATCH] blk-mq-sched: don't hold queue_lock when calling exit_icq
To: Omar Sandoval <osandov@osandov.com>, <linux-block@vger.kernel.org>
References: <73cd0cf484e8b75a771d908c172cd3a931dc00a3.1486751329.git.osandov@fb.com>
CC: Paolo Valente <paolo.valente@linaro.org>, <kernel-team@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <f766bb31-78d3-32ca-9628-8f505748e3bc@fb.com>
Date: Fri, 10 Feb 2017 11:35:10 -0700
MIME-Version: 1.0
In-Reply-To: <73cd0cf484e8b75a771d908c172cd3a931dc00a3.1486751329.git.osandov@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/10/2017 11:32 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> None of the other blk-mq elevator hooks are called with this lock held.
> Additionally, it can lead to circular locking dependencies between
> queue_lock and the private scheduler lock.

Applied, thanks Omar.

-- 
Jens Axboe
