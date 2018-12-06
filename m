Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC9EC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C741208E7
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C741208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbeLFRN1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:13:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40510 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLFRN1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 12:13:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so480037pfo.7;
        Thu, 06 Dec 2018 09:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uBSsYghMeFQQDxLCLKojd78HxcxwJr7ofTfRHQ04Tyo=;
        b=qqFhCIkHoI1AegO42QOJeNyGXBDTaa40FywQFx+mOH2Mo6lBWkRhEQ3blgRid+CrK7
         anCDGvrE+AOi6277t5tRFcp+bfTC/QdDtW0KqkRZbgUZl6nkgHAbwoz2EhnnHFBlBa3Y
         gyP5tVUj8+Tb2hEat0vIB2gOoIKO0WelqQEiq+GAYvsH6Ih3QnPBUNiVfcd4oE4pU/Ak
         U6huzwrjFcGMZZ8KHHiMKmNyB5/ttmiLEf4CfiwT/itYuC3FKJu0LAbQi01IceV2adVm
         7XTed5qbr/S2hpn5RWM8nbSaKA7I7lLGcUlsCRy/lcsL4vxArQaPpF1uhngBYD7P+UVj
         oDwQ==
X-Gm-Message-State: AA+aEWZtLJnnsUF218aFBaRUdektKKm0utf782edG8oiwi+rWyGA7SuS
        wDZx8iIPfaZCzIU5JBZ9wo8=
X-Google-Smtp-Source: AFSGD/V2Ww4c3+94yRlVc7bon64Dt4q5aYupkDeSBn1P4DEDOWCF4VwTv0O1xSrwzAV8+d5U8R1qKg==
X-Received: by 2002:a63:65c7:: with SMTP id z190mr24983524pgb.249.1544116406552;
        Thu, 06 Dec 2018 09:13:26 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id p2sm1053226pgc.94.2018.12.06.09.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 09:13:25 -0800 (PST)
Message-ID: <1544116404.185366.256.camel@acm.org>
Subject: Re: [PATCH 8/9] scsi: remove the use_clustering flag
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Date:   Thu, 06 Dec 2018 09:13:24 -0800
In-Reply-To: <20181206155258.11465-9-hch@lst.de>
References: <20181206155258.11465-1-hch@lst.de>
         <20181206155258.11465-9-hch@lst.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-06 at 07:52 -0800, Christoph Hellwig wrote:
+AD4 The same effects can be archived by setting the dma+AF8-boundary to
                          +AF4AXgBeAF4AXgBeAF4AXg
                          achieved?
+AD4 PAGE+AF8-SIZE - 1 and the max+AF8-segment+AF8-size to PAGE+AF8-SIZE, so shift those
+AD4 settings into the drivers.  Note that in many cases the setting might
+AD4 be bogus, but this keeps the status quo.
+AFs ... +AF0
+AD4  Documentation/scsi/scsi+AF8-mid+AF8-low+AF8-api.txt +AHw  2 --
+AD4  arch/ia64/hp/sim/simscsi.c              +AHw  3 +-+--
+AD4  drivers/scsi/a2091.c                    +AHw  3 +-+--
+AD4  drivers/scsi/advansys.c                 +AHw  4 +-+---
+AD4  drivers/scsi/aha152x.c                  +AHw  3 +-+--
+AD4  drivers/scsi/arm/acornscsi.c            +AHw  3 +-+--
+AD4  drivers/scsi/arm/arxescsi.c             +AHw  3 +-+--
+AD4  drivers/scsi/arm/cumana+AF8-1.c             +AHw  3 +-+--
+AD4  drivers/scsi/arm/cumana+AF8-2.c             +AHw  3 +-+--
+AD4  drivers/scsi/arm/eesox.c                +AHw  3 +-+--
+AD4  drivers/scsi/arm/oak.c                  +AHw  3 +-+--
+AD4  drivers/scsi/atari+AF8-scsi.c               +AHw  3 +-+--
+AD4  drivers/scsi/cxgbi/cxgb3i/cxgb3i.c      +AHw  3 +-+--
+AD4  drivers/scsi/cxgbi/cxgb4i/cxgb4i.c      +AHw  3 +-+--
+AD4  drivers/scsi/dc395x.c                   +AHw  3 +-+--
+AD4  drivers/scsi/dmx3191d.c                 +AHw  3 +-+--
+AD4  drivers/scsi/g+AF8-NCR5380.c                +AHw  3 +-+--
+AD4  drivers/scsi/gvp11.c                    +AHw  3 +-+--
+AD4  drivers/scsi/hosts.c                    +AHw  1 -
+AD4  drivers/scsi/ips.c                      +AHw  1 -
+AD4  drivers/scsi/iscsi+AF8-tcp.c                +AHw  3 +-+--
+AD4  drivers/scsi/mac+AF8-esp.c                  +AHw  3 +-+--
+AD4  drivers/scsi/mac+AF8-scsi.c                 +AHw  3 +-+--
+AD4  drivers/scsi/mvumi.c                    +AHw  3 +-+--
+AD4  drivers/scsi/nsp32.c                    +AHw  3 +-+--
+AD4  drivers/scsi/pcmcia/nsp+AF8-cs.c            +AHw  3 +-+--
+AD4  drivers/scsi/pcmcia/qlogic+AF8-stub.c       +AHw  3 +-+--
+AD4  drivers/scsi/qlogicfas.c                +AHw  3 +-+--
+AD4  drivers/scsi/scsi+AF8-debug.c               +AHw  6 +-+-+-+---
+AD4  drivers/scsi/scsi+AF8-lib.c                 +AHw  3 ---
+AD4  drivers/scsi/sgiwd93.c                  +AHw  3 +-+--
+AD4  drivers/scsi/stex.c                     +AHw  3 +-+--
+AD4  drivers/scsi/sun3+AF8-scsi.c                +AHw  3 +-+--
+AD4  drivers/scsi/ufs/ufshcd.c               +AHw  3 +-+--
+AD4  drivers/target/loopback/tcm+AF8-loop.c      +AHw  3 +-+--
+AD4  drivers/usb/storage/uas.c               +AHw  3 +-+--
+AD4  include/scsi/scsi+AF8-host.h                +AHw 13 -------------
+AD4  37 files changed, 66 insertions(+-), 54 deletions(-)

Please split this patch into two patches: one that affects SCSI LLD drivers
and another patch that affects the SCSI core. That will make both reviewing
and bisecting easier.

Thanks,

Bart.
