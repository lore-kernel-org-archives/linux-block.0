Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7466 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751799AbcFIPzG (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 9 Jun 2016 11:55:06 -0400
Subject: Re: [PATCH] blk-mq: actually hook up defer list when running requests
To: Omar Sandoval <osandov@osandov.com>
References: <9680c9b9108376337b3c4ee1f5c282eaac8440fd.1465435173.git.osandov@fb.com>
CC: <linux-block@vger.kernel.org>, <kernel-team@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <5759914B.2080806@fb.com>
Date: Thu, 9 Jun 2016 09:54:51 -0600
MIME-Version: 1.0
In-Reply-To: <9680c9b9108376337b3c4ee1f5c282eaac8440fd.1465435173.git.osandov@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/08/2016 07:22 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> If ->queue_rq() returns BLK_MQ_RQ_QUEUE_OK, we use continue and skip
> over the rest of the loop body. However, dptr is assigned later in the
> loop body, and the BLK_MQ_RQ_QUEUE_OK case is exactly the case that we'd
> want it for.
>
> NVMe isn't actually using BLK_MQ_F_DEFER_ISSUE yet, nor is any other
> in-tree driver, but if the code's going to be there, it might as well
> work.
>
> Fixes: 74c450521dd8 ("blk-mq: add a 'list' parameter to ->queue_rq()")
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Thanks Omar, good catch!

-- 
Jens Axboe

