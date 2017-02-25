Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50241 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751332AbdBYCyh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Feb 2017 21:54:37 -0500
Subject: Re: [PATCH V2 1/3] blk-mq: allocate blk_mq_tags and requests in
 correct node
To: Shaohua Li <shli@fb.com>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>
References: <a52afb3e09691267f2240331ef0b9962f793703d.1485971427.git.shli@fb.com>
CC: <bhelgaas@google.com>, <hch@lst.de>
From: Jens Axboe <axboe@fb.com>
Message-ID: <a1007be5-f026-b4fe-b3c7-d333c5c16f87@fb.com>
Date: Fri, 24 Feb 2017 19:54:24 -0700
MIME-Version: 1.0
In-Reply-To: <a52afb3e09691267f2240331ef0b9962f793703d.1485971427.git.shli@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/01/2017 10:53 AM, Shaohua Li wrote:
> blk_mq_tags/requests of specific hardware queue are mostly used in
> specific cpus, which might not be in the same numa node as disk. For
> example, a nvme card is in node 0. half hardware queue will be used by
> node 0, the other node 1.

Applied 1-3 for this series, thanks Shaohua!

-- 
Jens Axboe
