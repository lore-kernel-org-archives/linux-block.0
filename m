Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46065 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751393AbdA0WMs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 17:12:48 -0500
Subject: Re: [PATCH v2] blk-mq: fix debugfs compilation issues
To: Omar Sandoval <osandov@osandov.com>, <linux-block@vger.kernel.org>
References: <9980eb1d180dc482953b8e473f607bec7411e2b1.1485548245.git.osandov@fb.com>
 <8ff253c312f1af002b99065b0a1e355af2d3ee9a.1485550075.git.osandov@fb.com>
CC: <kernel-team@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <27a2195f-349c-bfa4-bb59-a47c776d8905@fb.com>
Date: Fri, 27 Jan 2017 15:11:38 -0700
MIME-Version: 1.0
In-Reply-To: <8ff253c312f1af002b99065b0a1e355af2d3ee9a.1485550075.git.osandov@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/27/2017 01:49 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This fixes a couple of problems:
> 
> 1. In the !CONFIG_DEBUG_FS case, the stub definitions were bogus.
> 2. In the !CONFIG_BLOCK case, blk-mq-debugfs.c shouldn't be compiled at
>    all.
> 
> Fix the stub definitions and add a CONFIG_BLK_DEBUG_FS Kconfig option.

Thanks, added.

-- 
Jens Axboe

