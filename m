Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8C5C4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 15:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CB42082E
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 15:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfDDP5P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:57:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38280 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfDDP5P (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 11:57:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so1583124pfo.5;
        Thu, 04 Apr 2019 08:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NwB2rl05HbXVS4y6vXAxUKEoYOtRSGeEET8HwSQ56bw=;
        b=uNUJq7U739wlRtNa7mFkQPvORUnZ/BJCdO1D1xFCNB/01ujs0B5QihuetafCKflxoG
         nIfgHV0+9YTe0Vq3pNe6+TZEAC8h8mn+rlvoq32M3PFmJahdbpo86Nay7+Y7bZfjblQj
         Z0z45w3bA4nFYl2Ahs3ni4WaKpL0vXG5xWTW3iQIf+jsSRKiAUk0rAfGIcWDdUeQ+oEX
         VyUdolZo4Z490IK4pc2HZ7fEzhn/PpmLggn8U9xxHw9HJ2iOFZvXBeu2WrAJ8HDoEzqi
         J7cBA8rhV8foeSE1t59WT530oJcmqjyCyLvQ7yCkoyze+PKMEpJ+n+rNMkApwf1j5AfL
         25EQ==
X-Gm-Message-State: APjAAAUTmpUz4J+BEuLLeveG379sZnPM9SadMrwTTQ/f0+aAlzI+V8Zk
        kQc2L0BNRSYvFxz6Ay8o4ps=
X-Google-Smtp-Source: APXvYqxwDdNrLv/DsXeZpsBn39j0b6raqgjQO1Vhy96ZMMdGMz8n3MqyyBY8XXmSCeqTtFmcy+Xv2w==
X-Received: by 2002:a65:6107:: with SMTP id z7mr6585832pgu.313.1554393434035;
        Thu, 04 Apr 2019 08:57:14 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id y15sm8315087pfo.22.2019.04.04.08.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 08:57:13 -0700 (PDT)
Message-ID: <1554393431.118779.249.camel@acm.org>
Subject: Re: [PATCH V4 3/7] blk-mq: quiesce queue before updating
 nr_hw_queues
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
Date:   Thu, 04 Apr 2019 08:57:11 -0700
In-Reply-To: <20190404084320.24681-4-ming.lei@redhat.com>
References: <20190404084320.24681-1-ming.lei@redhat.com>
         <20190404084320.24681-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-04-04 at 16:43 +-0800, Ming Lei wrote:
+AD4 diff --git a/block/blk-mq.c b/block/blk-mq.c
+AD4 index b512ba0cb359..41c12d9008b7 100644
+AD4 --- a/block/blk-mq.c
+AD4 +-+-+- b/block/blk-mq.c
+AD4 +AEAAQA -3224,8 +-3224,11 +AEAAQA static void +AF8AXw-blk+AF8-mq+AF8-update+AF8-nr+AF8-hw+AF8-queues(struct blk+AF8-mq+AF8-tag+AF8-set +ACo-set,
+AD4         if (nr+AF8-hw+AF8-queues +ADw 1 +AHwAfA nr+AF8-hw+AF8-queues +AD0APQ set-+AD4-nr+AF8-hw+AF8-queues)
+AD4                 return+ADs
+AD4  
+AD4 -       list+AF8-for+AF8-each+AF8-entry(q, +ACY-set-+AD4-tag+AF8-list, tag+AF8-set+AF8-list)
+AD4 +-       list+AF8-for+AF8-each+AF8-entry(q, +ACY-set-+AD4-tag+AF8-list, tag+AF8-set+AF8-list) +AHs
+AD4                 blk+AF8-mq+AF8-freeze+AF8-queue(q)+ADs
+AD4 +-               blk+AF8-mq+AF8-quiesce+AF8-queue(q)+ADs
+AD4 +-               blk+AF8-sync+AF8-queue(q)+ADs
+AD4 +-       +AH0
+AD4         /+ACo
+AD4          +ACo Sync with blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter.
+AD4          +ACo-/
+AD4 +AEAAQA -3269,8 +-3272,10 +AEAAQA static void +AF8AXw-blk+AF8-mq+AF8-update+AF8-nr+AF8-hw+AF8-queues(struct blk+AF8-mq+AF8-tag+AF8-set +ACo-set,
+AD4         list+AF8-for+AF8-each+AF8-entry(q, +ACY-set-+AD4-tag+AF8-list, tag+AF8-set+AF8-list)
+AD4                 blk+AF8-mq+AF8-elv+AF8-switch+AF8-back(+ACY-head, q)+ADs
+AD4  
+AD4 -       list+AF8-for+AF8-each+AF8-entry(q, +ACY-set-+AD4-tag+AF8-list, tag+AF8-set+AF8-list)
+AD4 +-       list+AF8-for+AF8-each+AF8-entry(q, +ACY-set-+AD4-tag+AF8-list, tag+AF8-set+AF8-list) +AHs
+AD4 +-               blk+AF8-mq+AF8-unquiesce+AF8-queue(q)+ADs
+AD4                 blk+AF8-mq+AF8-unfreeze+AF8-queue(q)+ADs
+AD4 +-       +AH0
+AD4  +AH0
+AD4  
+AD4  void blk+AF8-mq+AF8-update+AF8-nr+AF8-hw+AF8-queues(struct blk+AF8-mq+AF8-tag+AF8-set +ACo-set, int nr+AF8-hw+AF8-queues)

Are you sure this patch is sufficient? What prevents that blk+AF8-mq+AF8-run+AF8-hw+AF8-queues()
gets called after the blk+AF8-mq+AF8-quiesce() and blk+AF8-sync+AF8-queue() calls have finished
and before the queue is unfrozen?

Bart.
