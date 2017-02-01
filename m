Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37750 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751736AbdBATJr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Feb 2017 14:09:47 -0500
Subject: Re: [PATCH V2 1/3] blk-mq: allocate blk_mq_tags and requests in
 correct node
To: Shaohua Li <shli@fb.com>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>
References: <a52afb3e09691267f2240331ef0b9962f793703d.1485971427.git.shli@fb.com>
CC: <bhelgaas@google.com>, <hch@lst.de>
From: Jens Axboe <axboe@fb.com>
Message-ID: <b41e8f74-007d-c818-4915-3ea3b7c229b5@fb.com>
Date: Wed, 1 Feb 2017 11:09:36 -0800
MIME-Version: 1.0
In-Reply-To: <a52afb3e09691267f2240331ef0b9962f793703d.1485971427.git.shli@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/01/2017 09:53 AM, Shaohua Li wrote:
> blk_mq_tags/requests of specific hardware queue are mostly used in
> specific cpus, which might not be in the same numa node as disk. For
> example, a nvme card is in node 0. half hardware queue will be used by
> node 0, the other node 1.

All three patches look good to me. Bjorn, to avoid complications, if
you can review/ack patch #2, then I will queue it up through the block
tree for 4.11.

-- 
Jens Axboe

