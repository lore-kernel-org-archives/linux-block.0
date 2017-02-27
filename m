Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45194 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751372AbdB0SI1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2017 13:08:27 -0500
Subject: Re: [PATCH 1/3] blk-mq: make blk_mq_alloc_request_hctx() allocate a
 scheduler request
To: Omar Sandoval <osandov@osandov.com>,
        Sagi Grimberg <sagi@grimberg.me>, <linux-block@vger.kernel.org>
References: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
CC: <kernel-team@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <6137d2c6-816e-83b2-103c-cdf0840f49fd@fb.com>
Date: Mon, 27 Feb 2017 11:07:27 -0700
MIME-Version: 1.0
In-Reply-To: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/27/2017 10:47 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> blk_mq_alloc_request_hctx() allocates a driver request directly, unlike
> its blk_mq_alloc_request() counterpart. It also crashes because it
> doesn't update the tags->rqs map.
> 
> Fix it by making it allocate a scheduler request.

All three look good to me. Would you mind respinning #1, it doesn't
apply on top of the reserved tag patch.

-- 
Jens Axboe
