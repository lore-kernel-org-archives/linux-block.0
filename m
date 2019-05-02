Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7244EC43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 20:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F1920578
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 20:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfEBU4w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 16:56:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45301 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfEBU4w (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 16:56:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id o5so1566763pls.12;
        Thu, 02 May 2019 13:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/6b1F0TJTMRM3bfudiWiJdDExYB3o0dmMac3po5ink=;
        b=G/eFiqRfOPiNA1yZV8oC+zbplftBOSt3SL1C8IsDOldBaxR4xLylUA0g+JJF4J3V07
         9Ce4KTDXyW7RuKDXScx4pdKpwzmYxwTTKwfqeibgU7tlqVfF7kBYZ4Xm+z6rXZuhIBj5
         duCpDtMJAsy5K8WS8Vnlg5tt6iC2+ZcCQI0FOFoXe9jn9vwX3bwL1GhFtf43f+iVvEKl
         5ktzJBQ9qk4UoDCMhfg60cpkqJzQGEmgc0PpeokGx9Hos7seYqqDqYIl4VpJY/LthOsj
         isVF0zfBPuO07Jr7P2nZHhG7V/aswsfIi/TDh5lm6intGeC/ik9MQoYKbJLnxfU+ng9b
         NfZA==
X-Gm-Message-State: APjAAAXNT2bFO4EnAFVZsutoTBejaGCLMhzdNMlDV/PCbiWuwzYhacfl
        XCKeZs7LE9ceCcdXcKa9atg=
X-Google-Smtp-Source: APXvYqwCTZeNDI17Zq5JOzh1cbKyMTWjrIkQaZ+wFrYMImPcrLwBDwk5hBwaVoLtoXzH6v/hIZoS3w==
X-Received: by 2002:a17:902:3324:: with SMTP id a33mr6137181plc.18.1556830611449;
        Thu, 02 May 2019 13:56:51 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id l63sm80022pfb.124.2019.05.02.13.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 13:56:50 -0700 (PDT)
Message-ID: <1556830609.130741.0.camel@acm.org>
Subject: Re: [PATCH] block: Fix function name in comment
From:   Bart Van Assche <bvanassche@acm.org>
To:     Raul Rangel <rrangel@chromium.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Date:   Thu, 02 May 2019 13:56:49 -0700
In-Reply-To: <20190502205109.GA103782@google.com>
References: <20190502194811.200677-1-rrangel@chromium.org>
         <1556829225.12970.10.camel@acm.org> <20190502205109.GA103782@google.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-05-02 at 14:51 -0600, Raul Rangel wrote:
+AD4 On Thu, May 02, 2019 at 01:33:45PM -0700, Bart Van Assche wrote:
+AD4 +AD4 On Thu, 2019-05-02 at 13:48 -0600, Raul E Rangel wrote:
+AD4 +AD4 +AD4 The comment was out of date.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Signed-off-by: Raul E Rangel +ADw-rrangel+AEA-chromium.org+AD4
+AD4 +AD4 +AD4 ---
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4  block/blk-mq.c +AHw 2 +-
+AD4 +AD4 +AD4  1 file changed, 1 insertion(), 1 deletion(-)
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 diff --git a/block/blk-mq.c b/block/blk-mq.c
+AD4 +AD4 +AD4 index 9516304a38ee..0e467ff440a2 100644
+AD4 +AD4 +AD4 --- a/block/blk-mq.c
+AD4 +AD4 +AD4 diff --git a/block/blk-mq.c b/block/blk-mq.c
+AD4 +AD4 +AD4 index 9516304a38ee..0e467ff440a2 100644
+AD4 +AD4 +AD4 --- a/block/blk-mq.c
+AD4 +AD4 +AD4 +-+-+- b/block/blk-mq.c
+AD4 +AD4 +AD4 +AEAAQA -2062,7 +-2062,7 +AEAAQA void blk+AF8-mq+AF8-free+AF8-rqs(struct blk+AF8-mq+AF8-tag+AF8-set +ACo-set, struct blk+AF8-mq+AF8-tags +ACo-tags,
+AD4 +AD4 +AD4                 list+AF8-del+AF8-init(+ACY-page-+AD4-lru)+ADs
+AD4 +AD4 +AD4                 /+ACo
+AD4 +AD4 +AD4                  +ACo Remove kmemleak object previously allocated in
+AD4 +AD4 +AD4 -                +ACo blk+AF8-mq+AF8-init+AF8-rq+AF8-map().
+AD4 +AD4 +AD4 +-                +ACo blk+AF8-mq+AF8-alloc+AF8-rqs().
+AD4 +AD4 +AD4                  +ACo-/
+AD4 +AD4 +AD4                 kmemleak+AF8-free(page+AF8-address(page))+ADs
+AD4 +AD4 +AD4                 +AF8AXw-free+AF8-pages(page, page-+AD4-private)+ADs
+AD4 +AD4 
+AD4 +AD4 Does the entire comment fit on a single 80 column line? In other words, can
+AD4 +AD4 the comment that is spread over four lines be reduced to a single line?
+AD4 
+AD4 No, it would put it at 91 characters long.

That's unfortunate ...
