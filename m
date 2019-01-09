Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898DCC43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 00:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5D820883
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 00:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfAIA5n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 19:57:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34720 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfAIA5n (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 19:57:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id j10so2520642pga.1
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 16:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iN7r0ygJFbaIpQCveVVdIXEWuuY14muYD6sH3JURit0=;
        b=ObpmScuepEuhrp4LI9axHiWFb65LW3MnwajnzmdGCK4U4hhFQAkkfgkd72pLJ98Nf0
         LPLiXXgNjkDFiC65c5mwI65HBlpCDLvJCknphUBmOrQbWR0Bea0nFIRMWERijtc9ZFIT
         Dj1zY/lu5Pd1N18FrHyFs4yRuyZyfz9MML5bExGyJ8stWnLZmt0+RpfuSL9jtlrBsnot
         Q3y9n8SBIooB60UdhrnTPfeU+2K1EQUsBUozOIoizVkTK7Mlv5/AkAMPl3i3YX1IUu7/
         zlTzZ1t5BOvr/q9pqZuRbnBadco4KY3FmD28Y6A75p6U9R6tFMKjOoybK/x3ACzd7U1o
         kEvQ==
X-Gm-Message-State: AJcUukcvKt9YFDPx+yzP0SBvPx1Qmvr1G9JKk8UYeZz15HaUUXNfsMzE
        1IVOjaR0ccx25P1rXZjdvxheG1CQGTo=
X-Google-Smtp-Source: ALg8bN4FNORYqe5JnOu/m8TjGcmLvkubayC1CznVAuqVgr9Hs3C1vIefbV2Uq0giL+7FutcbZ+Gpww==
X-Received: by 2002:a62:5444:: with SMTP id i65mr4029167pfb.193.1546995462169;
        Tue, 08 Jan 2019 16:57:42 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id a15sm99236376pgb.1.2019.01.08.16.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 16:57:41 -0800 (PST)
Message-ID: <1546995460.83374.37.camel@acm.org>
Subject: Re: [PATCH] block: don't show io_timeout if driver has no timeout
 handler
From:   Bart Van Assche <bvanassche@acm.org>
To:     Weiping Zhang <zhangweiping@didiglobal.com>, axboe@kernel.dk
Cc:     hch@infradead.org, linux-block@vger.kernel.org
Date:   Tue, 08 Jan 2019 16:57:40 -0800
In-Reply-To: <20190107125215.GA5039@192.168.3.9>
References: <20190107125215.GA5039@192.168.3.9>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-01-07 at 20:52 +-0800, Weiping Zhang wrote:
+AD4 If the low level driver has no timerout handler, the
                                 +AF4AXgBeAF4AXgBeAF4AXg
                                 timeout?

+AD4 +-static umode+AF8-t queue+AF8-attr+AF8-visible(struct kobject +ACo-kobj, struct attribute +ACo-attr,
+AD4 +-				int n)
+AD4 +-+AHs
+AD4 +-	struct request+AF8-queue +ACo-q +AD0
+AD4 +-		container+AF8-of(kobj, struct request+AF8-queue, kobj)+ADs
+AD4 +-
+AD4 +-	if (attr +AD0APQ +ACY-queue+AF8-io+AF8-timeout+AF8-entry.attr) +AHs
+AD4 +-		if (+ACE-q-+AD4-mq+AF8-ops +AHwAfA +ACE-q-+AD4-mq+AF8-ops-+AD4-timeout)
+AD4 +-			return 0+ADs
+AD4 +-	+AH0

Are there any legacy block drivers left? Do we really need the mq+AF8-ops test?

Additionally, please combine the two nested if-statements into a single
if-statement.

+AD4 +AEAAQA -942,6 +-961,14 +AEAAQA int blk+AF8-register+AF8-queue(struct gendisk +ACo-disk)
+AD4  		goto unlock+ADs
+AD4  	+AH0
+AD4  
+AD4 +-	ret +AD0 sysfs+AF8-create+AF8-group(+ACY-q-+AD4-kobj, +ACY-queue+AF8-attr+AF8-group)+ADs
+AD4 +-	if (ret) +AHs
+AD4 +-		kobject+AF8-del(+ACY-q-+AD4-kobj)+ADs
+AD4 +-		blk+AF8-trace+AF8-remove+AF8-sysfs(dev)+ADs
+AD4 +-		kobject+AF8-put(+ACY-dev-+AD4-kobj)+ADs
+AD4 +-		goto unlock+ADs
+AD4 +-	+AH0

Are you sure the +ACI-goto unlock+ACI is OK here? Shouldn't kobject+AF8-del() be called
to undo the kobject+AF8-add() call if sysfs+AF8-create+AF8-group() fails?

+AD4  	if (queue+AF8-is+AF8-mq(q)) +AHs
+AD4  		+AF8AXw-blk+AF8-mq+AF8-register+AF8-dev(dev, q)+ADs
+AD4  		blk+AF8-mq+AF8-debugfs+AF8-register(q)+ADs
+AD4 +AEAAQA -958,6 +-985,7 +AEAAQA int blk+AF8-register+AF8-queue(struct gendisk +ACo-disk)
+AD4  		if (ret) +AHs
+AD4  			mutex+AF8-unlock(+ACY-q-+AD4-sysfs+AF8-lock)+ADs
+AD4  			kobject+AF8-uevent(+ACY-q-+AD4-kobj, KOBJ+AF8-REMOVE)+ADs
+AD4 +-			sysfs+AF8-remove+AF8-group(+ACY-q-+AD4-kobj, +ACY-queue+AF8-attr+AF8-group)+ADs
+AD4  			kobject+AF8-del(+ACY-q-+AD4-kobj)+ADs
+AD4  			blk+AF8-trace+AF8-remove+AF8-sysfs(dev)+ADs
+AD4  			kobject+AF8-put(+ACY-dev-+AD4-kobj)+ADs
+AD4 +AEAAQA -1006,6 +-1034,7 +AEAAQA void blk+AF8-unregister+AF8-queue(struct gendisk +ACo-disk)
+AD4  		blk+AF8-mq+AF8-unregister+AF8-dev(disk+AF8-to+AF8-dev(disk), q)+ADs
+AD4  	mutex+AF8-unlock(+ACY-q-+AD4-sysfs+AF8-lock)+ADs
+AD4  
+AD4 +-	sysfs+AF8-remove+AF8-group(+ACY-q-+AD4-kobj, +ACY-queue+AF8-attr+AF8-group)+ADs
+AD4  	kobject+AF8-uevent(+ACY-q-+AD4-kobj, KOBJ+AF8-REMOVE)+ADs
+AD4  	kobject+AF8-del(+ACY-q-+AD4-kobj)+ADs
+AD4  	blk+AF8-trace+AF8-remove+AF8-sysfs(disk+AF8-to+AF8-dev(disk))+ADs

Is it necessary to call sysfs+AF8-remove+AF8-group() explicitly? Isn't this something
kobject+AF8-del() does automatically?

Thanks,

Bart.

