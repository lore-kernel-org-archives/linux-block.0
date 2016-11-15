Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55546 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965810AbcKODzw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2016 22:55:52 -0500
Subject: Re: [PATCH] blk-mq drivers: untangle 0 and BLK_MQ_RQ_QUEUE_OK
To: Omar Sandoval <osandov@osandov.com>, <linux-block@vger.kernel.org>
References: <6ac81fdd561e008fec1f31e9a4530358737389a6.1479167141.git.osandov@fb.com>
CC: <linux-nvme@lists.infradead.org>, <linux-scsi@vger.kernel.org>,
        <kernel-team@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <f9b19a2b-6424-d8c7-d243-113af2b5fde5@fb.com>
Date: Mon, 14 Nov 2016 20:54:56 -0700
MIME-Version: 1.0
In-Reply-To: <6ac81fdd561e008fec1f31e9a4530358737389a6.1479167141.git.osandov@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 11/14/2016 04:49 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> Let's not depend on any of the BLK_MQ_RQ_QUEUE_* constants having
> specific values. No functional change.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> Hi, Jens,
>
> Some more trivial cleanup, feel free to apply or not if it's too intrusive.

I think we should clean it up. But you should split this patch in two -
one for NVMe, and one for SCSI.

And it should be against for-4.10/block, the nvme parts don't apply
without fuzz.

-- 
Jens Axboe

