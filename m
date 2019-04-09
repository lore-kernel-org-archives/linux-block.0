Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDCCC10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 23:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BFA2084B
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 23:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfDIXpD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:45:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46455 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfDIXpD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 19:45:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so156506pll.13;
        Tue, 09 Apr 2019 16:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YubDoO15ONGtcPw+tXq3xMJ0OWN2Jvscj4hOEX5UzDo=;
        b=Dfu8iVR5MXIO5U7ijBfIF+gh7c9p+zfZ119dwIklc8+wMTEgrK1MC4YHgsqxF0GwZT
         fc76CnOnWZXr3PM2bzrMnfWLtRw/jXE5k7U6htd31ja6QY5PuRXTFdvLGJlSfNAfLzeD
         VSaPtDo6LdecIbLWysLT8w2uxnWKVvH7t5VHXIpQrB70wRsQ5pfmhRRjwFaji+0o9B34
         5tDjV7H+Gz5gbBvV9a+O+7PaaYFSvOkFxXOt3HlAdGF5h+qMd4Yyfk1Ah1zUPPzxYox1
         6IM01jIDvXq5xN1CapC7EyF7XQg+CAeUnmh42sIC6PNTVvBjJt0Y9/cWvko9zgPxIScl
         ZTgw==
X-Gm-Message-State: APjAAAWxQM9dSHGydMAb8I/tYDQ2yofmpubGmbx797e0T4MEJ5UbYfjZ
        DLLnxOpBIr8zDnSlf0LxIBpxlm5fES4=
X-Google-Smtp-Source: APXvYqwQoIWo2EeBZN6kiAFKJq0r2mMvV+DOsD8lj8VlAZA/UOQ1+9CTROgEFPIzGgaRvcqI/PhK7w==
X-Received: by 2002:a17:902:d701:: with SMTP id w1mr41068754ply.124.1554853501588;
        Tue, 09 Apr 2019 16:45:01 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s79sm83675605pfa.31.2019.04.09.16.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 16:45:00 -0700 (PDT)
Message-ID: <1554853499.161891.22.camel@acm.org>
Subject: Re: [PATCH] scsi: core: set result when the command cannot be
 dispatched
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jaesoo Lee <jalee@purestorage.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Roland Dreier <roland@purestorage.com>
Date:   Tue, 09 Apr 2019 16:44:59 -0700
In-Reply-To: <CAJX3Cti2+3Wnn=pbkc9s-xgxCVw9q3EHPG04Yfasv50r=7ppQQ@mail.gmail.com>
References: <1554846371-33660-1-git-send-email-jalee@purestorage.com>
         <CAJX3CthodX6+G1agGR==ZTbc6J0gg55ca+ABQ7hmy3TPT+dsDw@mail.gmail.com>
         <1554848074.161891.18.camel@acm.org>
         <CAJX3Cti2+3Wnn=pbkc9s-xgxCVw9q3EHPG04Yfasv50r=7ppQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-09 at 16:29 -0700, Jaesoo Lee wrote:
+AD4 Let me comment in line.
+AD4 
+AD4 On Tue, Apr 9, 2019 at 3:14 PM Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4 wrote:
+AD4 +AD4 
+AD4 +AD4 On Tue, 2019-04-09 at 14:53 -0700, Jaesoo Lee wrote:
+AD4 +AD4 +AD4 When SCSI blk-mq is enabled, there is a bug in handling errors in scsi+AF8-queue+AF8-rq.
+AD4 +AD4 +AD4 Specifically, the bug is not setting result field of scsi+AF8-request correctly when
+AD4 +AD4 +AD4 the dispatch of the command has been failed. Since the upper layer code
+AD4 +AD4 +AD4 including the sg+AF8-io ioctl expects to receive any error status from result field
+AD4 +AD4 +AD4 of scsi+AF8-request, the error is silently ignored and this could cause data
+AD4 +AD4 +AD4 corruptions for some applications. This commit also fixes another bug that the
+AD4 +AD4 +AD4 result field is not initialized when scsi+AF8-request is allocated.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Signed-off-by: Jaesoo Lee +ADw-jalee+AEA-purestorage.com+AD4
+AD4 +AD4 +AD4 ---
+AD4 +AD4 +AD4  block/scsi+AF8-ioctl.c      +AHw 1 +-
+AD4 +AD4 +AD4  drivers/scsi/scsi+AF8-lib.c +AHw 1 +-
+AD4 +AD4 +AD4  2 files changed, 2 insertions(+-)
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 diff --git a/block/scsi+AF8-ioctl.c b/block/scsi+AF8-ioctl.c
+AD4 +AD4 +AD4 index 533f4ae..f2d7979 100644
+AD4 +AD4 +AD4 --- a/block/scsi+AF8-ioctl.c
+AD4 +AD4 +AD4 +-+-+- b/block/scsi+AF8-ioctl.c
+AD4 +AD4 +AD4 +AEAAQA -723,6 +-723,7 +AEAAQA void scsi+AF8-req+AF8-init(struct scsi+AF8-request +ACo-req)
+AD4 +AD4 +AD4         req-+AD4-cmd +AD0 req-+AD4AXwBf-cmd+ADs
+AD4 +AD4 +AD4         req-+AD4-cmd+AF8-len +AD0 BLK+AF8-MAX+AF8-CDB+ADs
+AD4 +AD4 +AD4         req-+AD4-sense+AF8-len +AD0 0+ADs
+AD4 +AD4 +AD4 +-       req-+AD4-result +AD0 0+ADs
+AD4 +AD4 +AD4  +AH0
+AD4 +AD4 +AD4  EXPORT+AF8-SYMBOL(scsi+AF8-req+AF8-init)+ADs
+AD4 +AD4 
+AD4 +AD4 What makes you think that this assignment is necessary?
+AD4 +AD4 
+AD4 
+AD4 Actually, I discovered this before fixing this bug and we might not
+AD4 see this problem anymore once this bug is fixed.
+AD4 
+AD4 Previously, since we are not setting scsi+AF8-req(req)-+AD4-result in
+AD4 scsi+AF8-queue+AF8-rq, I found that the application could receive another
+AD4 DID+AF8-TRANSPORT+AF8-DISRUPTED host+AF8-status again if the same 'struct request'
+AD4 is allocated for the IO.
+AD4 
+AD4 Please let me know if I need to remove this change.

Since SCSI LLDs have to set that result variable anyway if a request
completes successfully I'd prefer not to add that assignment.

+AD4 +AD4 +AD4 diff --git a/drivers/scsi/scsi+AF8-lib.c b/drivers/scsi/scsi+AF8-lib.c
+AD4 +AD4 +AD4 index 2018967..af1488d 100644
+AD4 +AD4 +AD4 --- a/drivers/scsi/scsi+AF8-lib.c
+AD4 +AD4 +AD4 +-+-+- b/drivers/scsi/scsi+AF8-lib.c
+AD4 +AD4 +AD4 +AEAAQA -1699,6 +-1699,7 +AEAAQA static blk+AF8-status+AF8-t scsi+AF8-queue+AF8-rq(struct
+AD4 +AD4 +AD4 blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
+AD4 +AD4 +AD4                         ret +AD0 BLK+AF8-STS+AF8-DEV+AF8-RESOURCE+ADs
+AD4 +AD4 +AD4                 break+ADs
+AD4 +AD4 +AD4         default:
+AD4 +AD4 +AD4 +-               scsi+AF8-req(req)-+AD4-result +AD0 DID+AF8-NO+AF8-CONNECT +ADwAPA 16+ADs
+AD4 +AD4 +AD4                 /+ACo
+AD4 +AD4 +AD4                  +ACo Make sure to release all allocated ressources when
+AD4 +AD4 +AD4                  +ACo we hit an error, as we will never see this command
+AD4 +AD4 
+AD4 +AD4 What leads you to the conclusion that (ret +ACEAPQ BLK+AF8-STS+AF8-OK +ACYAJg
+AD4 +AD4 ret +ACEAPQ BLK+AF8-STS+AF8-RESOUCE) means that there is a connectivity issue?
+AD4 
+AD4 I found this is what we are doing for legacy queue case+ADs I referred to
+AD4 scsi+AF8-prep+AF8-return() and scsi+AF8-kill+AF8-request() code where we always
+AD4 returning DID+AF8-NO+AF8-CONNECT.
+AD4 
+AD4 However, I think proper return code handling should be something like:
+AD4 
+AD4 diff --git a/drivers/scsi/scsi+AF8-lib.c b/drivers/scsi/scsi+AF8-lib.c
+AD4 index 2018967..21e516e 100644
+AD4 --- a/drivers/scsi/scsi+AF8-lib.c
+AD4 +-+-+- b/drivers/scsi/scsi+AF8-lib.c
+AD4 +AEAAQA -1699,6 +-1699,10 +AEAAQA static blk+AF8-status+AF8-t scsi+AF8-queue+AF8-rq(struct
+AD4 blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
+AD4                         ret +AD0 BLK+AF8-STS+AF8-DEV+AF8-RESOURCE+ADs
+AD4                 break+ADs
+AD4         default:
+AD4 +-               if (unlikely(+ACE-scsi+AF8-device+AF8-online(sdev)))
+AD4 +-                       scsi+AF8-req(req)-+AD4-result +AD0 DID+AF8-NO+AF8-CONNECT +ADwAPA 16+ADs
+AD4 +-               else
+AD4 +-                       scsi+AF8-req(req)-+AD4-result +AD0 DID+AF8-ERROR +ADwAPA 16+ADs
+AD4                 /+ACo
+AD4                  +ACo Make sure to release all allocated ressources when
+AD4                  +ACo we hit an error, as we will never see this command

The above looks better to me than the original patch.

Thanks,

Bart.
