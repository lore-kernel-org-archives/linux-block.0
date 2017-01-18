Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55635 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750826AbdARWXE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2017 17:23:04 -0500
Subject: Re: [PATCH for-4.10] blk-mq: Remove unused variable
To: Keith Busch <keith.busch@intel.com>, <linux-block@vger.kernel.org>,
        "Sagi Grimberg" <sagi@grimberg.me>
References: <1484778075-25065-1-git-send-email-keith.busch@intel.com>
 <625adb77-d3cf-0377-99f2-06a8be8c2467@fb.com>
CC: Christoph Hellwig <hch@lst.de>
From: Jens Axboe <axboe@fb.com>
Message-ID: <4f59ef02-f114-4423-1b28-6f4ff582add4@fb.com>
Date: Wed, 18 Jan 2017 14:21:48 -0800
MIME-Version: 1.0
In-Reply-To: <625adb77-d3cf-0377-99f2-06a8be8c2467@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/18/2017 02:16 PM, Jens Axboe wrote:
> On 01/18/2017 02:21 PM, Keith Busch wrote:
>> Signed-off-by: Keith Busch <keith.busch@intel.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Does it cause a warning anywhere? If not, I'd rather not apply
> it, since it'll cause a merge conflict for 4.11 (and the problem
> doesn't exist there).

Ah screw it, the fact that we have that in 4.10 is an eye sore.
I'd rather deal with the conflict, I'll apply it for 4.10. Thanks
Keith.

-- 
Jens Axboe

