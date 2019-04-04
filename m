Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E525C4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 17:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D839206BA
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 17:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfDDROd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:14:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36636 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfDDROd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 13:14:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so1685786pfn.3;
        Thu, 04 Apr 2019 10:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7iLtxq0I28C/dXANpCXTuGHcN/w+wC11WHPTTykpH6w=;
        b=WlzsY6tRAsUVF94Rrlj3Jue44OmSn20e/YzWYJrbU/LqNoJ+5j94VwWt2yHYau6FY4
         JRGI+YK7hljB6/Wo+POlDmpaE0jkMpT+tbdEgEvx1J4Ga6kV+I1Vgqu647W+SpNdeXz9
         Z7qEXJ4oCaDj1NELA6Gv6P2d2V8tP+Ln5ISoAZH5RGSK+RoK64av5Iv+dgnMW3Ym1z/k
         DojRy2Zs3CUfG7u/DQL8UBsV2UPsJCwGzR6OYvNnUVniY7QIuH5F4uV9fthmhfhZ0755
         FhUfwBm6YygurkhDMh2+k6gkfhHTklqClPY3KIQwEN6NWZ2YcevzQp9l1zz1m8YN8XWS
         R9Yw==
X-Gm-Message-State: APjAAAX0XMmfLRCKdY7vNAzlHs8KtMnprFl3xVMWjpZDAB8IgsthFaOo
        N21bo8Nt2f/LPB0ik98Onu4=
X-Google-Smtp-Source: APXvYqyOE+U7xdMvLR5AlV1JyQxfpW/sawKc+3kpeVlwk9o3yfqRYDbMzKnE+hiZvG6vmHKVaHsgfA==
X-Received: by 2002:a63:f218:: with SMTP id v24mr7172703pgh.326.1554398072036;
        Thu, 04 Apr 2019 10:14:32 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id j22sm25576963pfn.129.2019.04.04.10.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 10:14:30 -0700 (PDT)
Message-ID: <1554398069.118779.253.camel@acm.org>
Subject: Re: [PATCH V4 7/7] SCSI: don't hold device refcount in IO path
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
Date:   Thu, 04 Apr 2019 10:14:29 -0700
In-Reply-To: <20190404084320.24681-8-ming.lei@redhat.com>
References: <20190404084320.24681-1-ming.lei@redhat.com>
         <20190404084320.24681-8-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-04-04 at 16:43 +-0800, Ming Lei wrote:
+AD4 scsi+AF8-device's refcount is always grabbed in IO path.
+AD4 
+AD4 Turns out it isn't necessary, because blk+AF8-queue+AF8-cleanup() will
+AD4 drain any in-flight IOs, then cancel timeout/requeue work, and
+AD4 SCSI's requeue+AF8-work is canceled too in +AF8AXw-scsi+AF8-remove+AF8-device().
+AD4 
+AD4 Also scsi+AF8-device won't go away until blk+AF8-cleanup+AF8-queue() is done.
+AD4 
+AD4 So don't hold the refcount in IO path, especially the refcount isn't
+AD4 required in IO path since blk+AF8-queue+AF8-enter() / blk+AF8-queue+AF8-exit()
+AD4 is introduced in the legacy block layer.
+AD4 
+AD4 Cc: Dongli Zhang +ADw-dongli.zhang+AEA-oracle.com+AD4
+AD4 Cc: James Smart +ADw-james.smart+AEA-broadcom.com+AD4
+AD4 Cc: Bart Van Assche +ADw-bart.vanassche+AEA-wdc.com+AD4
+AD4 Cc: linux-scsi+AEA-vger.kernel.org,
+AD4 Cc: Martin K . Petersen +ADw-martin.petersen+AEA-oracle.com+AD4,
+AD4 Cc: Christoph Hellwig +ADw-hch+AEA-lst.de+AD4,
+AD4 Cc: James E . J . Bottomley +ADw-jejb+AEA-linux.vnet.ibm.com+AD4,
+AD4 Cc: jianchao wang +ADw-jianchao.w.wang+AEA-oracle.com+AD4
+AD4 Signed-off-by: Ming Lei +ADw-ming.lei+AEA-redhat.com+AD4
+AD4 ---
+AD4  drivers/scsi/scsi+AF8-lib.c +AHw 28 +-+---------------------------
+AD4  1 file changed, 2 insertions(+-), 26 deletions(-)
+AD4 
+AD4 diff --git a/drivers/scsi/scsi+AF8-lib.c b/drivers/scsi/scsi+AF8-lib.c
+AD4 index 601b9f1de267..3369d66911eb 100644
+AD4 --- a/drivers/scsi/scsi+AF8-lib.c
+AD4 +-+-+- b/drivers/scsi/scsi+AF8-lib.c
+AD4 +AEAAQA -141,8 +-141,6 +AEAAQA scsi+AF8-set+AF8-blocked(struct scsi+AF8-cmnd +ACo-cmd, int reason)
+AD4  
+AD4  static void scsi+AF8-mq+AF8-requeue+AF8-cmd(struct scsi+AF8-cmnd +ACo-cmd)
+AD4  +AHs
+AD4 -       struct scsi+AF8-device +ACo-sdev +AD0 cmd-+AD4-device+ADs
+AD4 -
+AD4         if (cmd-+AD4-request-+AD4-rq+AF8-flags +ACY RQF+AF8-DONTPREP) +AHs
+AD4                 cmd-+AD4-request-+AD4-rq+AF8-flags +ACYAPQ +AH4-RQF+AF8-DONTPREP+ADs
+AD4                 scsi+AF8-mq+AF8-uninit+AF8-cmd(cmd)+ADs
+AD4 +AEAAQA -150,7 +-148,6 +AEAAQA static void scsi+AF8-mq+AF8-requeue+AF8-cmd(struct scsi+AF8-cmnd +ACo-cmd)
+AD4                 WARN+AF8-ON+AF8-ONCE(true)+ADs
+AD4         +AH0
+AD4         blk+AF8-mq+AF8-requeue+AF8-request(cmd-+AD4-request, true)+ADs
+AD4 -       put+AF8-device(+ACY-sdev-+AD4-sdev+AF8-gendev)+ADs
+AD4  +AH0
+AD4  
+AD4  /+ACoAKg
+AD4 +AEAAQA -189,19 +-186,7 +AEAAQA static void +AF8AXw-scsi+AF8-queue+AF8-insert(struct scsi+AF8-cmnd +ACo-cmd, int reason, bool unbusy)
+AD4          +ACo-/
+AD4         cmd-+AD4-result +AD0 0+ADs
+AD4  
+AD4 -       /+ACo
+AD4 -        +ACo Before a SCSI command is dispatched,
+AD4 -        +ACo get+AF8-device(+ACY-sdev-+AD4-sdev+AF8-gendev) is called and the host,
+AD4 -        +ACo target and device busy counters are increased. Since
+AD4 -        +ACo requeuing a request causes these actions to be repeated and
+AD4 -        +ACo since scsi+AF8-device+AF8-unbusy() has already been called,
+AD4 -        +ACo put+AF8-device(+ACY-device-+AD4-sdev+AF8-gendev) must still be called. Call
+AD4 -        +ACo put+AF8-device() after blk+AF8-mq+AF8-requeue+AF8-request() to avoid that
+AD4 -        +ACo removal of the SCSI device can start before requeueing has
+AD4 -        +ACo happened.
+AD4 -        +ACo-/
+AD4         blk+AF8-mq+AF8-requeue+AF8-request(cmd-+AD4-request, true)+ADs
+AD4 -       put+AF8-device(+ACY-device-+AD4-sdev+AF8-gendev)+ADs
+AD4  +AH0
+AD4  
+AD4  /+ACo
+AD4 +AEAAQA -619,7 +-604,6 +AEAAQA static bool scsi+AF8-end+AF8-request(struct request +ACo-req, blk+AF8-status+AF8-t error,
+AD4                 blk+AF8-mq+AF8-run+AF8-hw+AF8-queues(q, true)+ADs
+AD4  
+AD4         percpu+AF8-ref+AF8-put(+ACY-q-+AD4-q+AF8-usage+AF8-counter)+ADs
+AD4 -       put+AF8-device(+ACY-sdev-+AD4-sdev+AF8-gendev)+ADs
+AD4         return false+ADs
+AD4  +AH0
+AD4  
+AD4 +AEAAQA -1613,7 +-1597,6 +AEAAQA static void scsi+AF8-mq+AF8-put+AF8-budget(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx)
+AD4         struct scsi+AF8-device +ACo-sdev +AD0 q-+AD4-queuedata+ADs
+AD4  
+AD4         atomic+AF8-dec(+ACY-sdev-+AD4-device+AF8-busy)+ADs
+AD4 -       put+AF8-device(+ACY-sdev-+AD4-sdev+AF8-gendev)+ADs
+AD4  +AH0
+AD4  
+AD4  static bool scsi+AF8-mq+AF8-get+AF8-budget(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx)
+AD4 +AEAAQA -1621,16 +-1604,9 +AEAAQA static bool scsi+AF8-mq+AF8-get+AF8-budget(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx)
+AD4         struct request+AF8-queue +ACo-q +AD0 hctx-+AD4-queue+ADs
+AD4         struct scsi+AF8-device +ACo-sdev +AD0 q-+AD4-queuedata+ADs
+AD4  
+AD4 -       if (+ACE-get+AF8-device(+ACY-sdev-+AD4-sdev+AF8-gendev))
+AD4 -               goto out+ADs
+AD4 -       if (+ACE-scsi+AF8-dev+AF8-queue+AF8-ready(q, sdev))
+AD4 -               goto out+AF8-put+AF8-device+ADs
+AD4 -
+AD4 -       return true+ADs
+AD4 +-       if (scsi+AF8-dev+AF8-queue+AF8-ready(q, sdev))
+AD4 +-               return true+ADs
+AD4  
+AD4 -out+AF8-put+AF8-device:
+AD4 -       put+AF8-device(+ACY-sdev-+AD4-sdev+AF8-gendev)+ADs
+AD4 -out:
+AD4         if (atomic+AF8-read(+ACY-sdev-+AD4-device+AF8-busy) +AD0APQ 0 +ACYAJg +ACE-scsi+AF8-device+AF8-blocked(sdev))
+AD4                 blk+AF8-mq+AF8-delay+AF8-run+AF8-hw+AF8-queue(hctx, SCSI+AF8-QUEUE+AF8-DELAY)+ADs
+AD4         return false+ADs

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4



