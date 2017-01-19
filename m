Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35163 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752673AbdASOMm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jan 2017 09:12:42 -0500
Subject: Re: [bug report] blk-mq-sched: add framework for MQ capable IO
 schedulers
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20170119073238.GA9834@mwanda>
CC: <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <2b6d2aa1-a7eb-04d1-ac4a-643f35615160@fb.com>
Date: Thu, 19 Jan 2017 06:11:45 -0800
MIME-Version: 1.0
In-Reply-To: <20170119073238.GA9834@mwanda>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/18/2017 11:32 PM, Dan Carpenter wrote:
> Hello Jens Axboe,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch bd166ef183c2: "blk-mq-sched: add framework for MQ capable
> IO schedulers" from Jan 17, 2017, leads to the following Smatch
> complaint:
> 
> block/elevator.c:234 elevator_init()
> 	 error: we previously assumed 'e' could be null (see line 229)
> 
> block/elevator.c
>    228	
>    229			if (!e) {
>                             ^^
> Null.
> 
>    230				printk(KERN_ERR
>    231					"Default I/O scheduler not found. " \
>    232					"Using noop/none.\n");
>    233				if (q->mq_ops) {
>    234					elevator_put(e);
>                                         ^^^^^^^^^^^^^^^
> This will Oops.
> 
>    235					return 0;
>    236				}

Good find, thanks Dan. I've killed the elevator_put().

-- 
Jens Axboe

