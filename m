Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016F5C282C5
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 00:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAF4218A1
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 00:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfAXAE2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 19:04:28 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33866 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfAXAE1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 19:04:27 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so1994047plz.1;
        Wed, 23 Jan 2019 16:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukmfil8Ro1uaYmy8j748uwC2GPRtccxaHxg9ACXeukk=;
        b=qE2qAw3BHZlxCD//gQ36LMftsRrA3cuOflXu8vzQmOY7ISOWS4I35ZyfsDkJkJ7UrV
         YgKYiNqFXxOldHZvrkm9O2F6CQXMRuCogu4SblOqg2Wah8nvta8050gDnTJebotw7hzx
         PQ+1ulSvGjc0rOQYsvKWfWs3NcS42hDnLp0Cb2DEcfRU7qD1A8aCpW0V7qOWaXSJhIVn
         YnkkWJF0cznlrZpz4rCNHYyG8rDCKRwqalZXRBLPfGNEcOqtBXQ3xmfPeCs0r1t95u0f
         iJ28oobPvE2/+vvYvZVi0N3WKI8vtBN9Cz3VYQ79933hUfJ3QForqpGlXBRpB1CE0zX3
         +Rzg==
X-Gm-Message-State: AJcUukd0qm47Npx/cOAAJ1v0e7lqalwJUldK59wxFmTvp3mLc5qJBhiS
        0Dg7zToE4pxtCeal9dCZGyIjzs2L
X-Google-Smtp-Source: ALg8bN5Y+p/39ACpwYwVK+yo8PWbxIsIRvsnQP94H/0mJHYXGXeeG28uAMLlgPWgBz7ghQyV+cSR+A==
X-Received: by 2002:a17:902:bc81:: with SMTP id bb1mr4235733plb.223.1548288266978;
        Wed, 23 Jan 2019 16:04:26 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 186sm54888919pga.36.2019.01.23.16.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 16:04:26 -0800 (PST)
Message-ID: <1548288265.9266.75.camel@acm.org>
Subject: Re: [PATCH] block: Allocate a sense buffer before executing an
 SG_IO ioctl
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>, stable@vger.kernel.org
Date:   Wed, 23 Jan 2019 16:04:25 -0800
In-Reply-To: <20190123190645.119109-1-bvanassche@acm.org>
References: <20190123190645.119109-1-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-01-23 at 11:06 -0800, Bart Van Assche wrote:
+AD4 Some time ago blk+AF8-execute+AF8-rq() was modified such that it no longer
+AD4 allocates a sense buffer. Make sg+AF8-io() allocate and use a sense buffer.
+AD4 This patch avoids that the following bug is triggered when running the
+AD4 libiscsi tests against the scsi+AF8-debug driver:
+AD4 
+AD4 usercopy: Kernel memory exposure attempt detected from null address (offset 0, size 18)+ACE
+AD4 ------------+AFs cut here +AF0-------------
+AD4 kernel BUG at mm/usercopy.c:102+ACE
+AD4 CPU: 5 PID: 693 Comm: iscsi-test-cu Not tainted 5.0.0-rc3-dbg+- +ACM-3
+AD4 Hardware name: QEMU Standard PC (i440FX +- PIIX, 1996), BIOS 1.10.2-1 04/01/2014
+AD4 RIP: 0010:usercopy+AF8-abort+-0x7a/0x7c
+AD4 Call Trace:
+AD4  +AF8AXw-check+AF8-object+AF8-size.cold.1+-0x37/0x3d
+AD4  sg+AF8-io+-0x5a2/0x700
+AD4  scsi+AF8-cmd+AF8-ioctl+-0x4d4/0x540
+AD4  scsi+AF8-cmd+AF8-blk+AF8-ioctl+-0x7b/0x8b
+AD4  sd+AF8-ioctl+-0xba/0x150
+AD4  blkdev+AF8-ioctl+-0x6e1/0xea0
+AD4  block+AF8-ioctl+-0x79/0x90
+AD4  do+AF8-vfs+AF8-ioctl+-0x12b/0x9b0
+AD4  ksys+AF8-ioctl+-0x41/0x80
+AD4  +AF8AXw-x64+AF8-sys+AF8-ioctl+-0x43/0x50
+AD4  do+AF8-syscall+AF8-64+-0x71/0x210
+AD4  entry+AF8-SYSCALL+AF8-64+AF8-after+AF8-hwframe+-0x49/0xbe
+AD4 
+AD4 Cc: Christoph Hellwig +ADw-hch+AEA-lst.de+AD4
+AD4 Cc: Martin K. Petersen +ADw-martin.petersen+AEA-oracle.com+AD4
+AD4 Cc: Douglas Gilbert +ADw-dgilbert+AEA-interlog.com+AD4
+AD4 Cc: +ADw-stable+AEA-vger.kernel.org+AD4 +ACM v4.11+-
+AD4 Fixes: 82ed4db499b8 (+ACI-block: split scsi+AF8-request out of struct request+ACI)
+AD4 Signed-off-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 ---
+AD4  block/scsi+AF8-ioctl.c +AHw 2 +-+-
+AD4  1 file changed, 2 insertions(+-)
+AD4 
+AD4 diff --git a/block/scsi+AF8-ioctl.c b/block/scsi+AF8-ioctl.c
+AD4 index 533f4aee8567..066929ec0d61 100644
+AD4 --- a/block/scsi+AF8-ioctl.c
+AD4 +-+-+- b/block/scsi+AF8-ioctl.c
+AD4 +AEAAQA -299,6 +-299,7 +AEAAQA static int sg+AF8-io(struct request+AF8-queue +ACo-q, struct gendisk +ACo-bd+AF8-disk,
+AD4  	struct request +ACo-rq+ADs
+AD4  	struct scsi+AF8-request +ACo-req+ADs
+AD4  	struct bio +ACo-bio+ADs
+AD4 +-	u8 sense+AFs-SCSI+AF8-SENSE+AF8-BUFFERSIZE+AF0AOw
+AD4  
+AD4  	if (hdr-+AD4-interface+AF8-id +ACEAPQ 'S')
+AD4  		return -EINVAL+ADs
+AD4 +AEAAQA -361,6 +-362,7 +AEAAQA static int sg+AF8-io(struct request+AF8-queue +ACo-q, struct gendisk +ACo-bd+AF8-disk,
+AD4  
+AD4  	bio +AD0 rq-+AD4-bio+ADs
+AD4  	req-+AD4-retries +AD0 0+ADs
+AD4 +-	req-+AD4-sense +AD0 sense+ADs
+AD4  
+AD4  	start+AF8-time +AD0 jiffies+ADs

Please ignore this patch - I just realized that this is not the right way to
fix the reported issue.

Bart.
