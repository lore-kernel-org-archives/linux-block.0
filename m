Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8238CC10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 22:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6DF2082A
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 22:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDIWOh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 18:14:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46044 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfDIWOh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 18:14:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id bf11so36728plb.12;
        Tue, 09 Apr 2019 15:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/IIhUG2WbrCKFyQjKD4SZ0Kmhgmea3u16wmMFj6AbU4=;
        b=ZFyB2SX5Siq6Pp8Y5lk3AlTUcdPVknmMaM7y9LTwFmSOx5/B92IFTAtfZSI6Zy5Ng2
         QGOXD7uhe2+O58BCyPDgZDDxjXap2+pf0+aa6dpc2MV3iPHZqqHol9qInUeY+AU+JvWQ
         yWSOJ32LLD5mD/k59h28nMTCh0CdVvMYSwMguf+fEuyEa0uodB0L9t7CXi8Z45rZVU5L
         jQAtS8D7gr7cocE1Q/I5LVh6co/WNGaq3AKkPIC6y5Q3zoER1JvG4dquYggPeecoFQWY
         dpTVx5sOkSJHTOPWI1mcsrjuwjGtFbMf0Q87T998Y3kEr0R1qKrZFTia5lr6nxsfm4Z0
         HeTQ==
X-Gm-Message-State: APjAAAVKuCp/xs0T1FWOJgxC0HO6AkYIhtT3ord2FClIl4NOilPUtUGZ
        MrfPrqJ5YJFm8UlFwpG7wx+BeZqRcCU=
X-Google-Smtp-Source: APXvYqxL5FsjLcO9ruYuSxj937lcCtz6BWIlAvKlhTf/iE2+N2ybNv2juBdDS1V/FUBcdSLbw39d5A==
X-Received: by 2002:a17:902:ab91:: with SMTP id f17mr35641560plr.151.1554848076166;
        Tue, 09 Apr 2019 15:14:36 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id e1sm40660547pfn.187.2019.04.09.15.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 15:14:35 -0700 (PDT)
Message-ID: <1554848074.161891.18.camel@acm.org>
Subject: Re: [PATCH] scsi: core: set result when the command cannot be
 dispatched
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jaesoo Lee <jalee@purestorage.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Roland Dreier <roland@purestorage.com>
Date:   Tue, 09 Apr 2019 15:14:34 -0700
In-Reply-To: <CAJX3CthodX6+G1agGR==ZTbc6J0gg55ca+ABQ7hmy3TPT+dsDw@mail.gmail.com>
References: <1554846371-33660-1-git-send-email-jalee@purestorage.com>
         <CAJX3CthodX6+G1agGR==ZTbc6J0gg55ca+ABQ7hmy3TPT+dsDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-09 at 14:53 -0700, Jaesoo Lee wrote:
+AD4 When SCSI blk-mq is enabled, there is a bug in handling errors in scsi+AF8-queue+AF8-rq.
+AD4 Specifically, the bug is not setting result field of scsi+AF8-request correctly when
+AD4 the dispatch of the command has been failed. Since the upper layer code
+AD4 including the sg+AF8-io ioctl expects to receive any error status from result field
+AD4 of scsi+AF8-request, the error is silently ignored and this could cause data
+AD4 corruptions for some applications. This commit also fixes another bug that the
+AD4 result field is not initialized when scsi+AF8-request is allocated.
+AD4 
+AD4 Signed-off-by: Jaesoo Lee +ADw-jalee+AEA-purestorage.com+AD4
+AD4 ---
+AD4  block/scsi+AF8-ioctl.c      +AHw 1 +-
+AD4  drivers/scsi/scsi+AF8-lib.c +AHw 1 +-
+AD4  2 files changed, 2 insertions(+-)
+AD4 
+AD4 diff --git a/block/scsi+AF8-ioctl.c b/block/scsi+AF8-ioctl.c
+AD4 index 533f4ae..f2d7979 100644
+AD4 --- a/block/scsi+AF8-ioctl.c
+AD4 +-+-+- b/block/scsi+AF8-ioctl.c
+AD4 +AEAAQA -723,6 +-723,7 +AEAAQA void scsi+AF8-req+AF8-init(struct scsi+AF8-request +ACo-req)
+AD4         req-+AD4-cmd +AD0 req-+AD4AXwBf-cmd+ADs
+AD4         req-+AD4-cmd+AF8-len +AD0 BLK+AF8-MAX+AF8-CDB+ADs
+AD4         req-+AD4-sense+AF8-len +AD0 0+ADs
+AD4 +-       req-+AD4-result +AD0 0+ADs
+AD4  +AH0
+AD4  EXPORT+AF8-SYMBOL(scsi+AF8-req+AF8-init)+ADs

What makes you think that this assignment is necessary?

+AD4 diff --git a/drivers/scsi/scsi+AF8-lib.c b/drivers/scsi/scsi+AF8-lib.c
+AD4 index 2018967..af1488d 100644
+AD4 --- a/drivers/scsi/scsi+AF8-lib.c
+AD4 +-+-+- b/drivers/scsi/scsi+AF8-lib.c
+AD4 +AEAAQA -1699,6 +-1699,7 +AEAAQA static blk+AF8-status+AF8-t scsi+AF8-queue+AF8-rq(struct
+AD4 blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
+AD4                         ret +AD0 BLK+AF8-STS+AF8-DEV+AF8-RESOURCE+ADs
+AD4                 break+ADs
+AD4         default:
+AD4 +-               scsi+AF8-req(req)-+AD4-result +AD0 DID+AF8-NO+AF8-CONNECT +ADwAPA 16+ADs
+AD4                 /+ACo
+AD4                  +ACo Make sure to release all allocated ressources when
+AD4                  +ACo we hit an error, as we will never see this command

What leads you to the conclusion that (ret +ACEAPQ BLK+AF8-STS+AF8-OK +ACYAJg
ret +ACEAPQ BLK+AF8-STS+AF8-RESOUCE) means that there is a connectivity issue?

Thanks,

Bart.
