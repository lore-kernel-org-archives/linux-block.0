Return-Path: <SRS0=Dd+4=PL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D78C43387
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 17:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1803E2073D
	for <linux-block@archiver.kernel.org>; Thu,  3 Jan 2019 17:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfACRNQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:13:16 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38440 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbfACRNQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jan 2019 12:13:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so16256360pgc.5
        for <linux-block@vger.kernel.org>; Thu, 03 Jan 2019 09:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VWe2QUVqZmU0Ra2ge3AKy+jehjScqDak9b5sZakIDZA=;
        b=qpOdJmo+MPOufzMcbeaee79ynEwfEistZTaf0uMlFWHR5C3EELtl3hgdhik/JcPHuC
         kEsipqmOn03e13LbWMneoX8dzPuPaDlBYebtgZe3uvDqhxoxDaNPS88vSRsS0dQ1ecXf
         cY3OBdxi1xdQ6tPyxc8R8lg2ZS6cC8LrNB79YhGQ3ppKKwUZUSA+ZRekyVssU0RCNLBU
         VsGIz6qYnUxNPLFUYC+prSu/TeGQBoWInGX7aPt8oLOXPlfQSmZ8ZdyqrELIhndSo1MO
         2jFTSF/j24E+++5FiZOCBra0vQiTXgGqTbG471OovsHh5N7TH5CtbVvxZrsLZDSnBN0d
         MhTQ==
X-Gm-Message-State: AJcUukdM9sb8UqM3sg6MwuT6KDAouW7VTslZZx8Ht+WLgv87Fl66WlPh
        5PITC5PaBwe1oBE5Dmln5gU=
X-Google-Smtp-Source: ALg8bN4rTYWGT/jswY0tEbqv3jRqZ02fplLjhehzkpxErh73VARkPuUmV0miSXzscJK4B3SQJFo2CA==
X-Received: by 2002:a65:49cd:: with SMTP id t13mr17884616pgs.376.1546535594529;
        Thu, 03 Jan 2019 09:13:14 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id v9sm80558099pfe.49.2019.01.03.09.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 09:13:13 -0800 (PST)
Message-ID: <1546535592.163063.7.camel@acm.org>
Subject: Re: [PATCH v4] block: add documentation for io_timeout
From:   Bart Van Assche <bvanassche@acm.org>
To:     Weiping Zhang <zhangweiping@didiglobal.com>, axboe@kernel.dk
Cc:     hch@infradead.org, linux-block@vger.kernel.org
Date:   Thu, 03 Jan 2019 09:13:12 -0800
In-Reply-To: <20181226035613.GA16642@192.168.3.9>
References: <20181226035613.GA16642@192.168.3.9>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2018-12-26 at 11:56 +-0800, Weiping Zhang wrote:
+AD4 Add documentation for /sys/block/+ADw-disk+AD4-/queue/io+AF8-timeout.
+AD4 
+AD4 Signed-off-by: Weiping Zhang +ADw-zhangweiping+AEA-didiglobal.com+AD4
+AD4 ---
+AD4  Documentation/ABI/testing/sysfs-block +AHw 9 +-+-+-+-+-+-+-+-+-
+AD4  Documentation/block/queue-sysfs.txt   +AHw 7 +-+-+-+-+-+-+-
+AD4  2 files changed, 16 insertions(+-)
+AD4 
+AD4 diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
+AD4 index 7710d4022b19..dfad7427817c 100644
+AD4 --- a/Documentation/ABI/testing/sysfs-block
+AD4 +-+-+- b/Documentation/ABI/testing/sysfs-block
+AD4 +AEAAQA -279,3 +-279,12 +AEAAQA Description:
+AD4  		size in 512B sectors of the zones of the device, with
+AD4  		the eventual exception of the last zone of the device
+AD4  		which may be smaller.
+AD4 +-
+AD4 +-What:		/sys/block/+ADw-disk+AD4-/queue/io+AF8-timeout
+AD4 +-Date:		November 2018
+AD4 +-Contact:	Weiping Zhang +ADw-zhangweiping+AEA-didiglobal.com+AD4
+AD4 +-Description:
+AD4 +-		io+AF8-timeout is the request timeout in milliseconds. If a request
+AD4 +-		does not complete in this time then the block driver timeout
+AD4 +-		handler is invoked. That timeout handler can decide to retry
+AD4 +-		the request, to fail it or to start a device recovery strategy.
+AD4 diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
+AD4 index 39e286d7afc9..83b457e24bba 100644
+AD4 --- a/Documentation/block/queue-sysfs.txt
+AD4 +-+-+- b/Documentation/block/queue-sysfs.txt
+AD4 +AEAAQA -67,6 +-67,13 +AEAAQA If set to a value larger than 0, the kernel will put the process issuing
+AD4  IO to sleep for this amount of microseconds before entering classic
+AD4  polling.
+AD4  
+AD4 +-io+AF8-timeout (RW)
+AD4 +----------------
+AD4 +-io+AF8-timeout is the request timeout in milliseconds. If a request does not
+AD4 +-complete in this time then the block driver timeout handler is invoked.
+AD4 +-That timeout handler can decide to retry the request, to fail it or to start
+AD4 +-a device recovery strategy.
+AD4 +-
+AD4  iostats (RW)
+AD4  -------------
+AD4  This file is used to control (on/off) the iostats accounting of the

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

