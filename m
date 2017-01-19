Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:30003 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbdASHc6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jan 2017 02:32:58 -0500
Date: Thu, 19 Jan 2017 10:32:38 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org
Subject: [bug report] blk-mq-sched: add framework for MQ capable IO schedulers
Message-ID: <20170119073238.GA9834@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Jens Axboe,

This is a semi-automatic email about new static checker warnings.

The patch bd166ef183c2: "blk-mq-sched: add framework for MQ capable
IO schedulers" from Jan 17, 2017, leads to the following Smatch
complaint:

block/elevator.c:234 elevator_init()
	 error: we previously assumed 'e' could be null (see line 229)

block/elevator.c
   228	
   229			if (!e) {
                            ^^
Null.

   230				printk(KERN_ERR
   231					"Default I/O scheduler not found. " \
   232					"Using noop/none.\n");
   233				if (q->mq_ops) {
   234					elevator_put(e);
                                        ^^^^^^^^^^^^^^^
This will Oops.

   235					return 0;
   236				}

regards,
dan carpenter
