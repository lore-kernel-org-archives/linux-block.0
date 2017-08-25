Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:39095 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756469AbdHYUY0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2017 16:24:26 -0400
Date: Fri, 25 Aug 2017 23:24:00 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: shli@fb.com
Cc: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org
Subject: [bug report] nullb: factor disk parameters
Message-ID: <20170825202400.7zj3ouyryojj2wxl@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Shaohua Li,

This is a semi-automatic email about new static checker warnings.

The patch 2984c8684f96: "nullb: factor disk parameters" from Aug 14, 
2017, leads to the following Smatch complaint:

drivers/block/null_blk.c:1759 null_init_tag_set()
	 error: we previously assumed 'nullb' could be null (see line 1750)

drivers/block/null_blk.c
  1749		set->ops = &null_mq_ops;
  1750		set->nr_hw_queues = nullb ? nullb->dev->submit_queues :
  1751							g_submit_queues;
  1752		set->queue_depth = nullb ? nullb->dev->hw_queue_depth :
  1753							g_hw_queue_depth;
  1754		set->numa_node = nullb ? nullb->dev->home_node : g_home_node;
                                 ^^^^^
The patch introduces a series of new NULL checks

  1755		set->cmd_size	= sizeof(struct nullb_cmd);
  1756		set->flags = BLK_MQ_F_SHOULD_MERGE;
  1757		set->driver_data = NULL;
  1758	
  1759		if (nullb->dev->blocking)
                    ^^^^^^^^^^^^^^^^^^^^
And an unchecked dereference.

  1760			set->flags |= BLK_MQ_F_BLOCKING;
  1761	

regards,
dan carpenter
