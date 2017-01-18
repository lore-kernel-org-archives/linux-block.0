Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43880 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750892AbdARWRV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2017 17:17:21 -0500
Subject: Re: [PATCH for-4.10] blk-mq: Remove unused variable
To: Keith Busch <keith.busch@intel.com>, <linux-block@vger.kernel.org>,
        "Sagi Grimberg" <sagi@grimberg.me>
References: <1484778075-25065-1-git-send-email-keith.busch@intel.com>
CC: Christoph Hellwig <hch@lst.de>
From: Jens Axboe <axboe@fb.com>
Message-ID: <625adb77-d3cf-0377-99f2-06a8be8c2467@fb.com>
Date: Wed, 18 Jan 2017 14:16:51 -0800
MIME-Version: 1.0
In-Reply-To: <1484778075-25065-1-git-send-email-keith.busch@intel.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/18/2017 02:21 PM, Keith Busch wrote:
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Does it cause a warning anywhere? If not, I'd rather not apply
it, since it'll cause a merge conflict for 4.11 (and the problem
doesn't exist there).

-- 
Jens Axboe

