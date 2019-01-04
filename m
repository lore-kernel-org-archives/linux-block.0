Return-Path: <SRS0=wxXg=PM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F306EC43387
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 21:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DC42087F
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 21:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbfADVtm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:49:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45833 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfADVtm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jan 2019 16:49:42 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so18861135pfd.12
        for <linux-block@vger.kernel.org>; Fri, 04 Jan 2019 13:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnvOqR4dV81pgmWN3mUz75T7FyYCAiAGJVJP6YJWFIc=;
        b=qfLumtSijroPjU7ooz6rRaONJ5ThkUOsuFj9jK1R9gyrq4T0JkNlhDYizXRDfyLWsM
         7gHYA7DFFtpaVGHSNRSCcJkqoqtf4zokk5/CtUPr/lLzuXTXv9pCjawS0z6K6tHs+izz
         22O7WCoFX/NV5WcheUrNmsZCCNiCZQ7I/QBE7saMCF5KBX4a0a+WI06VaurT6vAEc7np
         nB7+UBav8bYuRTuMHqsSINVdNptJS5lE7urc4KDJltvPLZV72rH2Y+/zvkHGYsrcrUT/
         sn0rAgpT8wmisg7VfC1bO/sswadC+xBRJ+LACvAN99OBCp7gGcnIbpc1PlcFtGQ1vITc
         UxWg==
X-Gm-Message-State: AA+aEWaEX2vXK21WNibsQaUweKXbE6VES8UMeWsLawr1/lR3hu+Peysv
        /am4EMevXdi/ou+L50UOYf4=
X-Google-Smtp-Source: ALg8bN4R9vnL6VBC2fXUl4OedcKJP/bUvsAqiJxU+qZeT1ka7rkcxF6LDFQ1xsg1Jh526HU53Al5qA==
X-Received: by 2002:a62:18ce:: with SMTP id 197mr55563233pfy.88.1546638580850;
        Fri, 04 Jan 2019 13:49:40 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id i2sm24934134pfi.66.2019.01.04.13.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 13:49:40 -0800 (PST)
Message-ID: <1546638578.83374.6.camel@acm.org>
Subject: Re: [PATCH v2] null_blk: add zoned config support information
From:   Bart Van Assche <bvanassche@acm.org>
To:     John Pittman <jpittman@redhat.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, loberman@redhat.com
Date:   Fri, 04 Jan 2019 13:49:38 -0800
In-Reply-To: <20190104170637.8218-1-jpittman@redhat.com>
References: <20190104170637.8218-1-jpittman@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-01-04 at 12:06 -0500, John Pittman wrote:
+AD4 If the kernel is built without CONFIG+AF8-BLK+AF8-DEV+AF8-ZONED, a modprobe
+AD4 of the null+AF8-blk driver with zoned+AD0-1 fails with 'Invalid argument'.
+AD4 This can be confusing to users, prompting a search as to why the
+AD4 parameter is invalid. To assist in that search, add a bit more
+AD4 information to the failure, additionally adding to the documentation
+AD4 that CONFIG+AF8-BLK+AF8-DEV+AF8-ZONED is needed for zoned+AD0-1.
+AD4 
+AD4 Signed-off-by: John Pittman +ADw-jpittman+AEA-redhat.com+AD4
+AD4 ---
+AD4  Documentation/block/null+AF8-blk.txt +AHw 3 +-+--
+AD4  drivers/block/null+AF8-blk.h         +AHw 1 +-
+AD4  2 files changed, 3 insertions(+-), 1 deletion(-)
+AD4 
+AD4 diff --git a/Documentation/block/null+AF8-blk.txt b/Documentation/block/null+AF8-blk.txt
+AD4 index ea2dafe49ae8..4cad1024fff7 100644
+AD4 --- a/Documentation/block/null+AF8-blk.txt
+AD4 +-+-+- b/Documentation/block/null+AF8-blk.txt
+AD4 +AEAAQA -88,7 +-88,8 +AEAAQA shared+AF8-tags+AD0AWw-0/1+AF0: Default: 0
+AD4  
+AD4  zoned+AD0AWw-0/1+AF0: Default: 0
+AD4    0: Block device is exposed as a random-access block device.
+AD4 -  1: Block device is exposed as a host-managed zoned block device.
+AD4 +-  1: Block device is exposed as a host-managed zoned block device. Requires
+AD4 +-     CONFIG+AF8-BLK+AF8-DEV+AF8-ZONED.
+AD4  
+AD4  zone+AF8-size+AD0AWw-MB+AF0: Default: 256
+AD4    Per zone size when exposed as a zoned block device. Must be a power of two.
+AD4 diff --git a/drivers/block/null+AF8-blk.h b/drivers/block/null+AF8-blk.h
+AD4 index b3df2793e7cd..cab4808f14bd 100644
+AD4 --- a/drivers/block/null+AF8-blk.h
+AD4 +-+-+- b/drivers/block/null+AF8-blk.h
+AD4 +AEAAQA -97,6 +-97,7 +AEAAQA void null+AF8-zone+AF8-reset(struct nullb+AF8-cmd +ACo-cmd, sector+AF8-t sector)+ADs
+AD4  +ACM-else
+AD4  static inline int null+AF8-zone+AF8-init(struct nullb+AF8-device +ACo-dev)
+AD4  +AHs
+AD4 +-	pr+AF8-err(+ACI-CONFIG+AF8-BLK+AF8-DEV+AF8-ZONED not enabled+AFw-n+ACI)+ADs
+AD4  	return -EINVAL+ADs
+AD4  +AH0
+AD4  static inline void null+AF8-zone+AF8-exit(struct nullb+AF8-device +ACo-dev) +AHsAfQ

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

