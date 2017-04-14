Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39630 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751854AbdDNUIM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2017 16:08:12 -0400
Subject: Re: [PATCH v4 0/5] blk-mq: Kyber multiqueue I/O scheduler
To: Omar Sandoval <osandov@osandov.com>, <linux-block@vger.kernel.org>
References: <cover.1492156558.git.osandov@fb.com>
CC: <kernel-team@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <ce14118b-7ad5-2af3-b68d-5e2292720d9f@fb.com>
Date: Fri, 14 Apr 2017 14:08:02 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1492156558.git.osandov@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/14/2017 01:59 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This is v4 of Kyber, an I/O scheduler for multiqueue devices combining
> several techniques: the scalable bitmap library, the new blk-stats API,
> and queue depth throttling similar to blk-wbt. v1 was here [1], v2 was
> here [2], v3 was here [3].
> 
> v4 fixes a hang in v3 caused by a race condition in the wait queue
> handling in kyber_get_domain_token().
> 
> This series is based on block/for-next. Patches 1 and 2 implement a new
> sbitmap operation. Patch 3 exports a couple of helpers. Patch 4 moves a
> scheduler callback to somewhere more useful. Patch 5 implements the new
> scheduler.

Added for 4.12, thanks Omar.

-- 
Jens Axboe
