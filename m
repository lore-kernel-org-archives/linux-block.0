Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C9AC10F14
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 16:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3692082E
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 16:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbfDJQ0l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:26:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38317 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730614AbfDJQ0k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 12:26:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so1788236pfo.5;
        Wed, 10 Apr 2019 09:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/tGBg2b5VCtK/pSeQ9BSg2WnVAL+7V/M86RME8OCn1M=;
        b=axYpy8FPLIu+5Eg3JhYlPJmYKtnkLkN+xpvq+xH48ukLWFNlCaY2Q8Hy9T6gJwmnES
         EJVyY5cKaHfWGhfZ9Jixp+qTgKyYIVy2M73Y/n7MJCrw8yCjJzLlE8dh0ycpHJ4ljw0z
         oVIoKNNhpGzcq6+6Gv6TCuRRWx4BiijEsBzDn0OyoApwWroNkYgroarus+zMij8XGU/a
         a/u0MDhKxnZGeMXpqi8khtQ1IRN3TGh9SDSjPaS94vxXYpkNpH+zVf+Fg1By79MDtxwi
         x2bHY19fqYWMEr5aoWpC6XqaY5Y2iJFKMZ8i60fChRVEmU5hfSMiQMhcaWZr8y4p5Fb2
         iOqg==
X-Gm-Message-State: APjAAAX21ARyG41cQQ4zVPo3lLNvBnYgWzXsNw4hWjWSlj6tlVLTY1IJ
        oqujMyoLGDTs9Ov3bK5+M8g=
X-Google-Smtp-Source: APXvYqxMA7JCm63h3ekUfUfstYI6Y3NG9dvoP2mP6iXIiZcjJZNwXmcDoin+vuS5GNXJgqfDN4IgpQ==
X-Received: by 2002:a63:2ace:: with SMTP id q197mr40122894pgq.371.1554913599330;
        Wed, 10 Apr 2019 09:26:39 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id o67sm86352327pga.55.2019.04.10.09.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 09:26:38 -0700 (PDT)
Message-ID: <1554913596.161891.24.camel@acm.org>
Subject: Re: [PATCHv2] scsi: core: set result when the command cannot be
 dispatched
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jaesoo Lee <jalee@purestorage.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Roland Dreier <roland@purestorage.com>
Date:   Wed, 10 Apr 2019 09:26:36 -0700
In-Reply-To: <CAJX3CtgE5oN=uw2rAWS8hsqkEZHCgfy5r=McFTj0rhRd490HhQ@mail.gmail.com>
References: <1554854375-7708-1-git-send-email-jalee@purestorage.com>
         <CAJX3CtgE5oN=uw2rAWS8hsqkEZHCgfy5r=McFTj0rhRd490HhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-09 at 17:02 -0700, Jaesoo Lee wrote:
+AD4 When SCSI blk-mq is enabled, there is a bug in handling errors in scsi+AF8-queue+AF8-rq.
+AD4 Specifically, the bug is not setting result field of scsi+AF8-request correctly when
+AD4 the dispatch of the command has been failed. Since the upper layer code
+AD4 including the sg+AF8-io ioctl expects to receive any error status from result field
+AD4 of scsi+AF8-request, the error is silently ignored and this could cause data
+AD4 corruptions for some applications.
+AD4 
+AD4 Signed-off-by: Jaesoo Lee +ADw-jalee+AEA-purestorage.com+AD4
+AD4 ---
+AD4  drivers/scsi/scsi+AF8-lib.c +AHw 6 +-+-+-+-+--
+AD4  1 file changed, 5 insertions(+-), 1 deletion(-)
+AD4 
+AD4 diff --git a/drivers/scsi/scsi+AF8-lib.c b/drivers/scsi/scsi+AF8-lib.c
+AD4 index 2018967..dc2550c 100644
+AD4 --- a/drivers/scsi/scsi+AF8-lib.c
+AD4 +-+-+- b/drivers/scsi/scsi+AF8-lib.c
+AD4 +AEAAQA -1699,8 +-1699,12 +AEAAQA static blk+AF8-status+AF8-t scsi+AF8-queue+AF8-rq(struct
+AD4 blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
+AD4                         ret +AD0 BLK+AF8-STS+AF8-DEV+AF8-RESOURCE+ADs
+AD4                 break+ADs
+AD4         default:
+AD4 +-               if (unlikely(+ACE-scsi+AF8-device+AF8-online(sdev)))
+AD4 +-                       scsi+AF8-req(req)-+AD4-result +AD0 DID+AF8-NO+AF8-CONNECT +ADwAPA 16+ADs
+AD4 +-               else
+AD4 +-                       scsi+AF8-req(req)-+AD4-result +AD0 DID+AF8-ERROR +ADwAPA 16+ADs
+AD4                 /+ACo
+AD4 -                +ACo Make sure to release all allocated ressources when
+AD4 +-                +ACo Make sure to release all allocated resources when
+AD4                  +ACo we hit an error, as we will never see this command
+AD4                  +ACo again.
+AD4                  +ACo-/

Should +ACI-Fixes:+ACI and +ACI-Cc: stable+ACI tags be added to this patch?

Anyway:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


