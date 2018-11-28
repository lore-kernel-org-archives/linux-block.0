Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07275C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 16:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1842081C
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 16:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1842081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeK2DPy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:15:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45824 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeK2DPy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 22:15:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so9693915pgc.12
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 08:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aJmgXMVakle8nhpo7wutZxNTNokkJFvPGTeddihIW7E=;
        b=Iaj9AE8wl14XYt3VqOywq9qO7KPfZtdbOSdTgDs24eiZvovmPdphqAQPAF1Rx/aXik
         8YQSdFclINqKRuQMIAX7qb0QZCQ/baMCocT7540qaCaSjWDS62l6ytvbROoTRjvWZCTV
         ZEDQiUJwFnimJ1V/J0MSgm0kEdIemYX27J7lA+ChWebDJrBalae3F/7SJQwiqcfMvlKj
         K8h/CqCPw8QMLqzEQw3jR5f05JFVDIGDD2eyC/XPLBC9hsO5EA5SfJEnqJ4UnhNTas+h
         GnqWwr75dfHy4hmMAPQldErJhgdCAfiAAVxjhj+W6PMV15i8+FQgVbjCBBg8SJcFDadX
         NnKA==
X-Gm-Message-State: AA+aEWZRpCCQjeUAo1LgCIFe85dlUnyDXnZWYFPVtYZvGRjAGKmC5Law
        ACH4WV89/7XrVmifTWb34NdQ36cf
X-Google-Smtp-Source: AFSGD/X1NnQ5PBSf2Uhtm/XedUO/102G716ldFZB7yUHiUBCtTUc0q5NllcjJYDkPP6VF7RwCwQkeA==
X-Received: by 2002:a63:1b1f:: with SMTP id b31mr9423001pgb.66.1543421623249;
        Wed, 28 Nov 2018 08:13:43 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id m3sm7643580pgl.69.2018.11.28.08.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 08:13:42 -0800 (PST)
Message-ID: <1543421621.185366.101.camel@acm.org>
Subject: Re: [RFC PATCH v2] block: add io timeout to sysfs
From:   Bart Van Assche <bvanassche@acm.org>
To:     Weiping Zhang <zhangweiping@didiglobal.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Date:   Wed, 28 Nov 2018 08:13:41 -0800
In-Reply-To: <20181119141145.GA25638@192.168.3.9>
References: <20181119141145.GA25638@192.168.3.9>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2018-11-19 at 22:11 +-0800, Weiping Zhang wrote:
+AD4 Give a interface to adjust io timeout by device.
+AD4 
+AD4 Signed-off-by: Weiping Zhang +ADw-zhangweiping+AEA-didiglobal.com+AD4
+AD4 ---
+AD4 
+AD4 Changes since v1:
+AD4 +ACo make sure timeout +AD4 0
+AD4 
+AD4  block/blk-sysfs.c +AHw 27 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
+AD4  1 file changed, 27 insertions(+-)

Documentation for new block layer sysfs attributes should be added in
Documentation/ABI/testing/sysfs-block and also in Documentation/block/queue-sysfs.txt.
Please add such documentation for this new attribute.

+AD4 +-static ssize+AF8-t queue+AF8-io+AF8-timeout+AF8-store(struct request+AF8-queue +ACo-q, const char +ACo-page,
+AD4 +-				  size+AF8-t count)
+AD4 +-+AHs
+AD4 +-	unsigned int val+ADs
+AD4 +-	int err+ADs
+AD4 +-
+AD4 +-	err +AD0 kstrtou32(page, 10, +ACY-val)+ADs
+AD4 +-	if (err +AHwAfA val +AD0APQ 0)
+AD4 +-		return -EINVAL+ADs
+AD4 +-
+AD4 +-	blk+AF8-queue+AF8-rq+AF8-timeout(q, val)+ADs
+AD4 +-
+AD4 +-	return count+ADs
+AD4 +-+AH0

Setting the block layer timeout to a very high value (e.g. hours) may make it look
like a request got stuck without users having an easy way of figuring out what is
going on. I'm wondering whether this function should restrict the upper bound for
block layer timeouts. How about limiting timeout values to ten minutes?

Thanks,

Bart.
