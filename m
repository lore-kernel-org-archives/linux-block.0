Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35050 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752845AbdCBDRq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Mar 2017 22:17:46 -0500
Subject: Re: [PATCH 1/2] loop: fix LO_FLAGS_PARTSCAN hang
To: Omar Sandoval <osandov@osandov.com>, <linux-block@vger.kernel.org>
References: <7e888cad9e6c35835559281d3ab9e05ea48836d0.1488393750.git.osandov@fb.com>
CC: <kernel-team@fb.com>, Ming Lei <tom.leiming@gmail.com>,
        <stable@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <c868e1be-e224-c1fa-1c32-7c73c1f7359b@fb.com>
Date: Wed, 1 Mar 2017 19:26:48 -0700
MIME-Version: 1.0
In-Reply-To: <7e888cad9e6c35835559281d3ab9e05ea48836d0.1488393750.git.osandov@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/01/2017 11:42 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> loop_reread_partitions() needs to do I/O, but we just froze the queue,
> so we end up waiting forever. This can easily be reproduced with losetup
> -P. Fix it by moving the reread to after we unfreeze the queue.

Thanks Omar, applied. That's a brown paper bag bug.

-- 
Jens Axboe
