Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0C5C43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 22:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF59C20856
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 22:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfDAWkS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:40:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43222 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfDAWkS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Apr 2019 18:40:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id z9so5476345pgu.10
        for <linux-block@vger.kernel.org>; Mon, 01 Apr 2019 15:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yFtBu2I+024WssHKrugs0gPPoU3RTIWz1TIoNS0D6Nk=;
        b=GfDVsiCIoQXEywQ7fFiwVTuFymjvrJ7KMB679ca/KxxH64tn+i9Vw2eGmXYbTYIS5y
         kmt6SNmZ1DfZLUvvOcL5aPs0o2oQ7mpDOvW0bSkjz28iljhZmXOF7dt0ik1ImzcsyZ82
         /8HRptt2PFtgHD73hjNU80/AjUQT+kxmsdVCIvDOgl0lEHUeJTbEQICh3GzY/yR30wC0
         e9deV/9FPpKYCEIb/NLLycHLBWyEPlwiU6EGZxRXeXgv4UvMZ7m8xJI25xRt7n2QTvKO
         wqAuXS/zorIqj4P6SiKF1SRZMnNKFwG1Z2ZUR0rYGBB4GJXYs/v4mGSZc3+UpzhUxvxK
         0MdA==
X-Gm-Message-State: APjAAAWN5C3EblBXf5r5w/9aVaCSyQV7zpKZnIM+xmsss/D4VN0Ae8Lm
        /nXq6ECaqlhEkRv0QyKep4Q=
X-Google-Smtp-Source: APXvYqz+nFlMxeSBXPkoY+ANKKmBFr0x1tc8rhQWHNWcbFzAJx3AdngLTG6/5NoA+u3G+YoNT5u0vQ==
X-Received: by 2002:a65:6645:: with SMTP id z5mr64430508pgv.251.1554158417409;
        Mon, 01 Apr 2019 15:40:17 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id t12sm19338481pfl.59.2019.04.01.15.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 15:40:16 -0700 (PDT)
Message-ID: <1554158415.118779.126.camel@acm.org>
Subject: Re: [PATCH] block: don't show io_timeout if driver has no timeout
 handler
From:   Bart Van Assche <bvanassche@acm.org>
To:     weiping zhang <zhangweiping@didichuxing.com>
Cc:     Weiping Zhang <zhangweiping@didiglobal.com>, axboe@kernel.dk,
        hch@infradead.org, linux-block@vger.kernel.org
Date:   Mon, 01 Apr 2019 15:40:15 -0700
In-Reply-To: <20190331152824.GA29577@192.168.3.9>
References: <20190107125215.GA5039@192.168.3.9>
         <1546995460.83374.37.camel@acm.org> <20190331152824.GA29577@192.168.3.9>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 2019-03-31 at 23:28 +-0800, weiping zhang wrote:
+AD4 On Tue, Jan 08, 2019 at 04:57:40PM -0800, Bart Van Assche wrote:
+AD4 +AD4 +AD4 +AEAAQA -942,6 +-961,14 +AEAAQA int blk+AF8-register+AF8-queue(struct gendisk +ACo-disk)
+AD4 +AD4 +AD4  		goto unlock+ADs
+AD4 +AD4 +AD4  	+AH0
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4 +-	ret +AD0 sysfs+AF8-create+AF8-group(+ACY-q-+AD4-kobj, +ACY-queue+AF8-attr+AF8-group)+ADs
+AD4 +AD4 +AD4 +-	if (ret) +AHs
+AD4 +AD4 +AD4 +-		kobject+AF8-del(+ACY-q-+AD4-kobj)+ADs
+AD4 +AD4 +AD4 +-		blk+AF8-trace+AF8-remove+AF8-sysfs(dev)+ADs
+AD4 +AD4 +AD4 +-		kobject+AF8-put(+ACY-dev-+AD4-kobj)+ADs
+AD4 +AD4 +AD4 +-		goto unlock+ADs
+AD4 +AD4 +AD4 +-	+AH0
+AD4 +AD4 
+AD4 +AD4 Are you sure the +ACI-goto unlock+ACI is OK here? Shouldn't kobject+AF8-del() be called
+AD4 +AD4 to undo the kobject+AF8-add() call if sysfs+AF8-create+AF8-group() fails?
+AD4 
+AD4 Sorry, can you tell me why it's may be not safe, if goto unlock here,
+AD4 if failed to call sysfs+AF8-create+AF8-group, I think we should call
+AD4 kobject+AF8-del.

Can you address the other comments and repost your patch? I may have misread
your patch when I wrote the above comment.

Thanks,

Bart.
