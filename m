Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25E4C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3ADC20878
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3ADC20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeLFQOk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:14:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34958 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeLFQOj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:14:39 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so359449pgs.2
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 08:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3uaP80JemUs5iHtC02rJ9z8WA12EVwF9Q5l7KRmZTA=;
        b=tgUSKwhFE/yCO24M280j4epEhwyfqq++WpApOf5qRwWlCiHvpWs6O13XD6bhHbu+yR
         qagTsCiVvTPdxEfZzykXdKsaqj1A2E4xF9WThQDNEkCZgzNCQrzs9KQNBsNArINBizMb
         mAg36T45nfp1LQusBpnMpYPft7mkcvdr3ENycRwAmkr9p5FBe9eGd7chgvgd9t7IotYc
         M1lxuYJqA4oo0TKKP9iBUDAP/OsK2xxgZqojlSnKgwnL6ObpLzVgkgV1x/UnUGe4NncS
         3MyJkdafmFyewl8+OQizcld3Rqj4TCKWE0oGpNeDr/kZAgV7e/Jr5b+Ry9TUVyURNaQP
         nOwg==
X-Gm-Message-State: AA+aEWbvBwvDHVBHKi2qR/VSxmCzuPQeql91o2RBUJ26rSHKS3dHvTYI
        sy4fGuDk/aNzqglZc5rGwJ8=
X-Google-Smtp-Source: AFSGD/UN/c1YlcZpGOOphNhMZIheaHKsrE51BD12N8d5OqaSsBJ0iT80Un4gES7lhFIGJ9E9V6Wi0A==
X-Received: by 2002:a63:f1f:: with SMTP id e31mr24307715pgl.274.1544112879011;
        Thu, 06 Dec 2018 08:14:39 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id j14sm1047144pfn.175.2018.12.06.08.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 08:14:37 -0800 (PST)
Message-ID: <1544112876.185366.235.camel@acm.org>
Subject: Re: [PATCH 1/2] block: get rid of BLK_MAX_TIMEOUT
From:   Bart Van Assche <bvanassche@acm.org>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     zhangweiping@didiglobal.com, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Date:   Thu, 06 Dec 2018 08:14:36 -0800
In-Reply-To: <CAA70yB5HbEqSRO9KzqCkV=ZPgsRqVLmGZh0XrBAYwPaPbmDaYg@mail.gmail.com>
References: <cover.1544023832.git.zhangweiping@didiglobal.com>
         <997df532a176a435c3581ce180f318a298084393.1544023832.git.zhangweiping@didiglobal.com>
         <1544025539.185366.224.camel@acm.org>
         <CAA70yB5HbEqSRO9KzqCkV=ZPgsRqVLmGZh0XrBAYwPaPbmDaYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-06 at 22:18 +-0800, Weiping Zhang wrote:
+AD4 Before this patch, even we set io+AF8-timeout to 30+ACo-HZ(default), but
+AD4 blk+AF8-rq+AF8-timeout always return jiffies +-5+ACo-HZ,
+AD4   +AFs-1+AF0. if there no pending request in timeout list, the timer callback
+AD4 blk+AF8-rq+AF8-timed+AF8-out+AF8-timer will be called after 5+ACo-HZ, and then
+AD4 blk+AF8-mq+AF8-check+AF8-expired will check is there exist some request
+AD4 was delayed by compare jiffies and request-+AD4-deadline, obvious
+AD4 request is not timeout because we set request's timeouts is 30+ACo-HZ.
+AD4 So for this case timer callback should be called at jiffies +- 30 instead
+AD4 of jiffies +- 5+ACo-HZ.
+AD4 
+AD4   +AFs-2+AF0. if there are pending request in timeout list, we compare request's
+AD4 expiry and queue's expiry. If time+AF8-after(request-+AD4-expire, queue-+AD4-expire) modify
+AD4 queue-+AD4-timeout.expire to request-+AD4-expire, otherwise do nothing.
+AD4 
+AD4 So I think this patch just solve problem in +AFs-1+AF0, no other regression, or what's
+AD4 I missing here ?

The blk+AF8-rq+AF8-timeout() function was introduced by commit 0d2602ca30e4 (+ACI-blk-mq:
improve support for shared tags maps+ACI). I think the purpose of that function
is to make sure that the nr+AF8-active counter in struct blk+AF8-mq+AF8-hw+AF8-ctx gets updated
at least once every five seconds. So there are two problems with this patch:
- It reduces the frequency of 'nr+AF8-active' updates. I think that is wrong and
  also that it will negatively affect drivers that rely on this functionality,
  e.g. the SCSI core.
- The patch description does not match the code changes in this patch.

Bart.

