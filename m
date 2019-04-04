Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3128EC4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 21:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EFD2171F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 21:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfDDVaY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:30:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38751 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbfDDVaX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 17:30:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so2016318pfo.5;
        Thu, 04 Apr 2019 14:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YL7c7IPYFwI3LDsFYU0x4w4N8nYF2KkSIbJSux/1CMg=;
        b=RHJYjoJIeGINQsAHTzx72194MFRA+tUpEFBzxmBURTqTB9GUEsCiLarcvOQ45ip95l
         KSNbrqicJUR18isZOmqwunl/ABrEw7wNEb0F6RsL+XZioF03e2s5gvrvySOfHy9FqTqZ
         FByKKlCsGjUOgPqLruDxJIrfk2SO38uF8kJuvv7DXomLchiP2Xlssi/+wIrGiumT42NX
         EgxyFt4XXXe8IsVa+nszbnEayf+qbYgDCrOh0z+cMhVbQ8vo+RNXlsdtyqnyGxsYWHmh
         XZo5fUwZg+V0I6bruQDd9eXagx94eTKYyE8W5PjKVZ418IOiWrV72dwNTrcNCFLckv2f
         9NNA==
X-Gm-Message-State: APjAAAUhdzjZS2rxFQ4BzHnViMFqD6mYYNPlREafJAlU0knfCJ1YhyjX
        1+tcEr3l2GcRSk/N9pI6HnM=
X-Google-Smtp-Source: APXvYqym55lLD+cmt9TDzsa1jt9SdNSu/fzV3Fx3Jmm00QYNM4Tpes0m9y7auQr+6yfiEL1LIDbraA==
X-Received: by 2002:a62:b612:: with SMTP id j18mr8499195pff.124.1554413422907;
        Thu, 04 Apr 2019 14:30:22 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id v20sm30044801pfn.116.2019.04.04.14.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 14:30:22 -0700 (PDT)
Message-ID: <1554413420.118779.260.camel@acm.org>
Subject: Re: [PATCH V4 1/7] blk-mq: grab .q_usage_counter when queuing
 request from plug code path
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Date:   Thu, 04 Apr 2019 14:30:20 -0700
In-Reply-To: <20190404084320.24681-2-ming.lei@redhat.com>
References: <20190404084320.24681-1-ming.lei@redhat.com>
         <20190404084320.24681-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-04-04 at 16:43 +-0800, Ming Lei wrote:
+AD4 Just like aio/io+AF8-uring, we need to grab 2 refcount for queuing one
+AD4 request, one is for submission, another is for completion.
+AD4 
+AD4 If the request isn't queued from plug code path, the refcount grabbed
+AD4 in generic+AF8-make+AF8-request() serves for submission. In theroy, this
+AD4 refcount should have been released after the sumission(async run queue)
+AD4 is done. blk+AF8-freeze+AF8-queue() works with blk+AF8-sync+AF8-queue() together
+AD4 for avoiding race between cleanup queue and IO submission, given async
+AD4 run queue activities are canceled because hctx-+AD4-run+AF8-work is scheduled with
+AD4 the refcount held, so it is fine to not hold the refcount when
+AD4 running the run queue work function for dispatch IO.
+AD4 
+AD4 However, if request is staggered into plug list, and finally queued
+AD4 from plug code path, the refcount in submission side is actually missed.
+AD4 And we may start to run queue after queue is removed because the queue's
+AD4 kobject refcount isn't guaranteed to be grabbed in flushing plug list
+AD4 context, then kernel oops is triggered, see the following race:
+AD4 
+AD4 blk+AF8-mq+AF8-flush+AF8-plug+AF8-list():
+AD4         blk+AF8-mq+AF8-sched+AF8-insert+AF8-requests()
+AD4                 insert requests to sw queue or scheduler queue
+AD4                 blk+AF8-mq+AF8-run+AF8-hw+AF8-queue
+AD4 
+AD4 Because of concurrent run queue, all requests inserted above may be
+AD4 completed before calling the above blk+AF8-mq+AF8-run+AF8-hw+AF8-queue. Then queue can
+AD4 be freed during the above blk+AF8-mq+AF8-run+AF8-hw+AF8-queue().
+AD4 
+AD4 Fixes the issue by grab .q+AF8-usage+AF8-counter before calling
+AD4 blk+AF8-mq+AF8-sched+AF8-insert+AF8-requests() in blk+AF8-mq+AF8-flush+AF8-plug+AF8-list(). This way is
+AD4 safe because the queue is absolutely alive before inserting request.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4-
