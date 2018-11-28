Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55770C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 17:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232862081C
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 17:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232862081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbeK2EJN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:09:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44515 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbeK2EJN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 23:09:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id k8so7029572pls.11
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 09:06:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bGfLRSqS22nDWx+Ca0c0CbHCoqdf3TUFUnqyNf5H3hE=;
        b=JSLXeuILf8XHGC0u6LpXHVIl+kMfuUkgiia7uc3QxifGTd9tLXxRULNFhxiba5zWJ9
         JBSwhzww4ZeT7WPlvIBx7ZrdW9vpNxXyJJgZCO8XoySgfjPLeXIroVNOedYpBFpoReW4
         JSR+jinNBwQbOZWHsWVoSZ00ahWj7dlwAd1bm0gOqtpN4o3My4b2wujp30mfxi5EqcxS
         nWD4bWAjAagEKxVSHpX2vEaU70XMYd78IXnmiIRZCdDYWqZRZbbgwZhQRDteesltOyQW
         4EF7/LhBu3WUuDViP7gIMDTiP5hgpjSRdkNe6vP+xymLmIWJsEXo5q23Ff2A1iKMh4tS
         xfwQ==
X-Gm-Message-State: AA+aEWaP1Mr5Z2JctOjhdt4OblThzUL6/NLLd2/1y47wtqxeS2naghQC
        qC7M8B/64JIV0VGJPo3OthSYFdKf
X-Google-Smtp-Source: AFSGD/VWZlLuslyYk1XBB998xAznD/NmHcEsdFIeAnk1XjL5S9ow/AfcpfGTxyE8OYQ82ZD23s+Hbw==
X-Received: by 2002:a17:902:1126:: with SMTP id d35mr32407819pla.1.1543424813670;
        Wed, 28 Nov 2018 09:06:53 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z186sm10232485pfz.119.2018.11.28.09.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 09:06:52 -0800 (PST)
Message-ID: <1543424811.185366.106.camel@acm.org>
Subject: Re: [PATCH] block: add documentation for io_timeout
From:   Bart Van Assche <bvanassche@acm.org>
To:     Weiping Zhang <zhangweiping@didiglobal.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Date:   Wed, 28 Nov 2018 09:06:51 -0800
In-Reply-To: <20181128165415.GA38237@192.168.3.9>
References: <20181128165415.GA38237@192.168.3.9>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-11-29 at 00:54 +-0800, Weiping Zhang wrote:
+AD4 add documentation for /sys/block/+ADw-disk+AD4-/queue/io+AF8-timeout
+AD4 
+AD4 Signed-off-by: Weiping Zhang +ADw-zhangweiping+AEA-didiglobal.com+AD4
+AD4 ---
+AD4  Documentation/ABI/testing/sysfs-block +AHw 9 +-+-+-+-+-+-+-+-+-
+AD4  Documentation/block/queue-sysfs.txt   +AHw 6 +-+-+-+-+-+-
+AD4  2 files changed, 15 insertions(+-)
+AD4 
+AD4 diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
+AD4 index dea212db9df3..f37c0000ca16 100644
+AD4 --- a/Documentation/ABI/testing/sysfs-block
+AD4 +-+-+- b/Documentation/ABI/testing/sysfs-block
+AD4 +AEAAQA -271,3 +-271,12 +AEAAQA Description:
+AD4  		size of 512B sectors of the zones of the device, with
+AD4  		the eventual exception of the last zone of the device
+AD4  		which may be smaller.
+AD4 +-
+AD4 +-What:		/sys/block/+ADw-disk+AD4-/queue/io+AF8-timeout
+AD4 +-Date:		November 2018
+AD4 +-Contact:	Weiping Zhang +ADw-zhangweiping+AEA-didiglobal.com+AD4
+AD4 +-Description:
+AD4 +-		io+AF8-timeout is the timeout in millisecods of a request in
+AD4 +-		block layer. The block layer will start a timer when low
+AD4 +-		level device driver start the request, and cancle timer
+AD4 +-		when request completes.
+AD4 diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
+AD4 index 2c1e67058fd3..cbd44fe056fa 100644
+AD4 --- a/Documentation/block/queue-sysfs.txt
+AD4 +-+-+- b/Documentation/block/queue-sysfs.txt
+AD4 +AEAAQA -67,6 +-67,12 +AEAAQA If set to a value larger than 0, the kernel will put the process issuing
+AD4  IO to sleep for this amont of microseconds before entering classic
+AD4  polling.
+AD4  
+AD4 +-io+AF8-timeout (RW)
+AD4 +----------------
+AD4 +-This is the timeout in millisecods of a request in block layer.
+AD4 +-The block layer will start a timer when low level device driver start
+AD4 +-the request, and cancle timer when request completes.
+AD4 +-
+AD4  iostats (RW)
+AD4  -------------
+AD4  This file is used to control (on/off) the iostats accounting of the

Please run this patch through a spelling checker. I think +ACI-millisecods+ACI should
be changed into +ACI-milliseconds+ACI and also that +ACI-cancle+ACI should be changed into
+ACI-cancel+ACI.

Thanks,

Bart.
