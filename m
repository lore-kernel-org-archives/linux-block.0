Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:37465 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755110AbdJLVvV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Oct 2017 17:51:21 -0400
Date: Fri, 13 Oct 2017 00:51:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org
Subject: [bug report] block, bfq: decrease burst size when queues in burst
 exit
Message-ID: <20171012215113.tc6h67dzqfwy3xdm@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Paolo Valente,

This is a semi-automatic email about new static checker warnings.

The patch 7cb04004fa37: "block, bfq: decrease burst size when queues 
in burst exit" from Sep 21, 2017, leads to the following Smatch 
complaint:

block/bfq-iosched.c:3730 bfq_put_queue()
	 error: we previously assumed 'bfqq->bfqd' could be null (see line 3720)

block/bfq-iosched.c
  3719	
  3720		if (bfqq->bfqd)
                    ^^^^^^^^^^
Check for NULL.

  3721			bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p %d",
  3722				     bfqq, bfqq->ref);
  3723	
  3724		bfqq->ref--;
  3725		if (bfqq->ref)
  3726			return;
  3727	
  3728		if (bfq_bfqq_sync(bfqq) && !hlist_unhashed(&bfqq->burst_list_node)) {
  3729			hlist_del_init(&bfqq->burst_list_node);
  3730			bfqq->bfqd->burst_size--;
                        ^^^^^^^^^^^^^^^^^^^^^^
Patch adds an unchecked dereference.

  3731		}
  3732	

regards,
dan carpenter
