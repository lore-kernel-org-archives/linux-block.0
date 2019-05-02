Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE3AC43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 20:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2439A20651
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 20:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfEBUds (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 16:33:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45660 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBUds (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 16:33:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id o5so1541037pls.12;
        Thu, 02 May 2019 13:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hQ7lBIhgfPpGMZJrKjNhXXqITmAg5lved+q95m2VFgk=;
        b=bFs5I0W0ZM0TBZAfmoAJEWnhsrnXuTDmJeLN23+soXPVAZEKQjzGNTFRyKNkfrOh72
         E471d06aD2507pF7hlqsKqx3O2jnVlbCtVrA1306S9IjdbOGSNnXDvYZKiCDzfDpAY3V
         8PXJNpzk8su8/XVWIbJGyVluAZg16mJpWSyhGI9lSsYhXWojIhnpOAfDfphwTh0O9liW
         pabpCPTPSnc4wwDu4VoZHk1D7Mm+8AsGHCSsY66JCiu+o0AesZy5hhwU89KsCi9Lydm7
         WEybLeWEk/EkZ3bZHHbhZJ3/ZHzbbPPWc/Xh8M9P20JymSpRCkVRSDvivsVRZ2liw1Vh
         0QbA==
X-Gm-Message-State: APjAAAVJRITmh8Kaa17eRVggVrupTh/N9fr8Cemn4TNX/43lsx8z1VF0
        pzg8l2Hxn84IBNNFnDymcDw=
X-Google-Smtp-Source: APXvYqyBlJsVjRtg9rVycLQN3Brb/nm5nqmt+UjuyNy4JEBjOBpYyZNTpQotR7J8hQs19PyCmjF6+w==
X-Received: by 2002:a17:902:22f:: with SMTP id 44mr5794712plc.175.1556829227688;
        Thu, 02 May 2019 13:33:47 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id i7sm165893pgg.4.2019.05.02.13.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 13:33:46 -0700 (PDT)
Message-ID: <1556829225.12970.10.camel@acm.org>
Subject: Re: [PATCH] block: Fix function name in comment
From:   Bart Van Assche <bvanassche@acm.org>
To:     Raul E Rangel <rrangel@chromium.org>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Date:   Thu, 02 May 2019 13:33:45 -0700
In-Reply-To: <20190502194811.200677-1-rrangel@chromium.org>
References: <20190502194811.200677-1-rrangel@chromium.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-05-02 at 13:48 -0600, Raul E Rangel wrote:
+AD4 The comment was out of date.
+AD4 
+AD4 Signed-off-by: Raul E Rangel +ADw-rrangel+AEA-chromium.org+AD4
+AD4 ---
+AD4 
+AD4  block/blk-mq.c +AHw 2 +-
+AD4  1 file changed, 1 insertion(), 1 deletion(-)
+AD4 
+AD4 diff --git a/block/blk-mq.c b/block/blk-mq.c
+AD4 index 9516304a38ee..0e467ff440a2 100644
+AD4 --- a/block/blk-mq.c
+AD4 diff --git a/block/blk-mq.c b/block/blk-mq.c
+AD4 index 9516304a38ee..0e467ff440a2 100644
+AD4 --- a/block/blk-mq.c
+AD4 +-+-+- b/block/blk-mq.c
+AD4 +AEAAQA -2062,7 +-2062,7 +AEAAQA void blk+AF8-mq+AF8-free+AF8-rqs(struct blk+AF8-mq+AF8-tag+AF8-set +ACo-set, struct blk+AF8-mq+AF8-tags +ACo-tags,
+AD4                 list+AF8-del+AF8-init(+ACY-page-+AD4-lru)+ADs
+AD4                 /+ACo
+AD4                  +ACo Remove kmemleak object previously allocated in
+AD4 -                +ACo blk+AF8-mq+AF8-init+AF8-rq+AF8-map().
+AD4 +-                +ACo blk+AF8-mq+AF8-alloc+AF8-rqs().
+AD4                  +ACo-/
+AD4                 kmemleak+AF8-free(page+AF8-address(page))+ADs
+AD4                 +AF8AXw-free+AF8-pages(page, page-+AD4-private)+ADs

Does the entire comment fit on a single 80 column line? In other words, can
the comment that is spread over four lines be reduced to a single line?

Thanks,

Bart.
