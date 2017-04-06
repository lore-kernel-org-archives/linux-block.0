Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33411 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756031AbdDFJYE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2017 05:24:04 -0400
Subject: Re: [PATCH rfc 5/6] block: Add rdma affinity based queue mapping
 helper
To: Max Gurtovoy <maxg@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <1491140492-25703-1-git-send-email-sagi@grimberg.me>
 <1491140492-25703-6-git-send-email-sagi@grimberg.me>
 <becb84ac-7819-a207-56b1-70f16cb80e42@mellanox.com>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e1ea43dd-c44b-4b2f-f381-1195fd082609@grimberg.me>
Date: Thu, 6 Apr 2017 12:23:59 +0300
MIME-Version: 1.0
In-Reply-To: <becb84ac-7819-a207-56b1-70f16cb80e42@mellanox.com>
Content-Type: text/plain; charset=windows-1255; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> shouldn't you include  <linux/kobject.h> and <linux/blkdev.h> like in
> commit 8ec2ef2b66ea2f that fixes blk-mq-pci.c ?

Not really. We can lose these from blk-mq-pci.c as well.

>> +#include <linux/blk-mq.h>
>> +#include <linux/blk-mq-rdma.h>
>> +#include <rdma/ib_verbs.h>
>> +#include <linux/module.h>
>> +#include "blk-mq.h"
>
> Is this include needed ?

You're right, I can just keep:

+#include <linux/blk-mq.h>
+#include <linux/blk-mq-rdma.h>
+#include <rdma/ib_verbs.h>
