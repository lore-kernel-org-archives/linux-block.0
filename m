Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A10C4360F
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 15:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1DE2075E
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 15:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfDBPFs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:05:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33774 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbfDBPFs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 11:05:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so6530008pfd.0
        for <linux-block@vger.kernel.org>; Tue, 02 Apr 2019 08:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aYVWFNN124YE02efCvTFCsgleC6NldelIlYwMdZjxp8=;
        b=FXTfE+xS5J6XU52j+o74XBaGPHMsgeP5kBN2bMMHpVLXJRuqZtiBeN3XK6Aof2RF9m
         TYzDademfxC003EKSXMk+gfa5zz/gOM2bncl7wzS/vKB372jxhWoxXhA8ce7G27wJOhd
         KFq9ZszVnXmHugR7JKfosagL5YiY6aKVINp2/+1rqCXvVFUsY6KqBTOWR+EEGneQTSPt
         CSzMdhOViR/91pIxz6dZb1sDSGoAudNcw2lyGYjVp7RpYfamXNHSmj4aZFvrwCb7f5Dy
         vxPxX/7ICLdHfO4k0mqsPv/H7V/2cTQTKPflO5aqkhL1JGbZosLpJUij747enq6qSJF1
         lvEQ==
X-Gm-Message-State: APjAAAUlN4a6K91Drqln5F+ukMoSU8egoYgWX6hnP7w8GmABTabknlEO
        HHAG5p7PW+TFqDHMMXWaJ4o=
X-Google-Smtp-Source: APXvYqw90Aqiqj4jxNe7M2t551kSLy9p0mCykcjKO4/9eHp9Sgf3CBc8q/NUlcn/Z5Ctl/uiVvvX5Q==
X-Received: by 2002:a63:8548:: with SMTP id u69mr66882011pgd.85.1554217546603;
        Tue, 02 Apr 2019 08:05:46 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id r76sm4002334pfa.39.2019.04.02.08.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 08:05:45 -0700 (PDT)
Message-ID: <1554217543.118779.130.camel@acm.org>
Subject: Re: [PATCH v2] block: don't show io_timeout if driver has no
 timeout handler
From:   Bart Van Assche <bvanassche@acm.org>
To:     Weiping Zhang <zhangweiping@didiglobal.com>, axboe@kernel.dk,
        hch@infradead.org
Cc:     linux-block@vger.kernel.org
Date:   Tue, 02 Apr 2019 08:05:43 -0700
In-Reply-To: <20190402131424.GA12935@192.168.3.9>
References: <20190402131424.GA12935@192.168.3.9>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-02 at 21:14 +-0800, Weiping Zhang wrote:
+AD4 +AFs ... +AF0
+AD4 -static struct attribute +ACo-default+AF8-attrs+AFsAXQ +AD0 +AHs
+AD4 +-static struct attribute +ACo-queue+AF8-attrs+AFsAXQ +AD0 +AHs
+AD4  	+ACY-queue+AF8-requests+AF8-entry.attr,
+AD4  	+ACY-queue+AF8-ra+AF8-entry.attr,
+AD4  	+ACY-queue+AF8-max+AF8-hw+AF8-sectors+AF8-entry.attr,
+AD4 +AEAAQA -770,6 +-770,25 +AEAAQA static struct attribute +ACo-default+AF8-attrs+AFsAXQ +AD0 +AHs
+AD4  	NULL,
+AD4  +AH0AOw
+AD4 
+AD4 +AFs ... +AF0
+AD4
+AD4  static ssize+AF8-t
+AD4 +AEAAQA -890,7 +-909,6 +AEAAQA static const struct sysfs+AF8-ops queue+AF8-sysfs+AF8-ops +AD0 +AHs
+AD4  
+AD4  struct kobj+AF8-type blk+AF8-queue+AF8-ktype +AD0 +AHs
+AD4  	.sysfs+AF8-ops	+AD0 +ACY-queue+AF8-sysfs+AF8-ops,
+AD4 -	.default+AF8-attrs	+AD0 default+AF8-attrs,
+AD4  	.release	+AD0 blk+AF8-release+AF8-queue,
+AD4  +AH0AOw
+AD4  
+AD4 +AEAAQA -939,6 +-957,14 +AEAAQA int blk+AF8-register+AF8-queue(struct gendisk +ACo-disk)
+AD4  		goto unlock+ADs
+AD4  	+AH0
+AD4  
+AD4 +-	ret +AD0 sysfs+AF8-create+AF8-group(+ACY-q-+AD4-kobj, +ACY-queue+AF8-attr+AF8-group)+ADs
+AD4 +-	if (ret) +AHs
+AD4 +-		blk+AF8-trace+AF8-remove+AF8-sysfs(dev)+ADs
+AD4 +-		kobject+AF8-del(+ACY-q-+AD4-kobj)+ADs
+AD4 +-		kobject+AF8-put(+ACY-dev-+AD4-kobj)+ADs
+AD4 +-		goto unlock+ADs
+AD4 +-	+AH0
+AD4 +-
+AD4  	if (queue+AF8-is+AF8-mq(q)) +AHs
+AD4  		+AF8AXw-blk+AF8-mq+AF8-register+AF8-dev(dev, q)+ADs
+AD4  		blk+AF8-mq+AF8-debugfs+AF8-register(q)+ADs

This kind of change introduces an unacceptable race against udev. I think we
should wait with making this change until the patch series +ACI-kobject: Add
default group support to kobj+AF8-type and replace subsystem uses+ACI is upstream.

Bart.
