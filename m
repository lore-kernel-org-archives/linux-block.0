Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2828C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 22:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9B720878
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 22:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9B720878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeLFWqt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:46:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42811 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeLFWqt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 17:46:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so839095plp.9
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 14:46:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b24ZHI+1aTYH+MPn5sVwkbBiOLZWpJVNmpr1qunhSw4=;
        b=DuT/+ghnClE9RQjJ/1Fp91iGRA6OyRQok9guJXKehA+XsR15IPzF7kcatvdsV2Pm0h
         lJaUHGi84TSRQISeHZ9ODTqkg8yvfbeoLK8+SN7RoL5DdTP+6S+e0L3tp01xWuThEnch
         i4s1dZoXdmfT0nDTQ+OqJ/pOolyK/g0q64z/joxd6Scsc31nFTFe8epBixz7opXG2Yy9
         9Wqi7sCp24FWySdBPJnCqom2PZZIHmFi5/BiFqV124tKnJUXyPknE/5HkQnqsXgJDhaA
         sIVe5Sy+mdU3gForb+lcaL/jFrVzywLvXLvnOGX8AhaxhScl0IwqkdvEbkC4DOpdN/pE
         6QBA==
X-Gm-Message-State: AA+aEWbAGaKRJBlLlIinzQHYa6VuRUDPEqkaWeo4IOFW7HXnbVC2R//Q
        j7PKQBjzIFC2SUs2OPjBrMHiomsM
X-Google-Smtp-Source: AFSGD/WA2qNtnX2h+URgTYxdQr3mBUYdQehXVkmNxW2fgug3HB06acO+GP6NOjTuBB3dwOaFuOqj4Q==
X-Received: by 2002:a17:902:d697:: with SMTP id v23mr29554872ply.261.1544136407751;
        Thu, 06 Dec 2018 14:46:47 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id t24sm1723951pfh.21.2018.12.06.14.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 14:46:47 -0800 (PST)
Message-ID: <1544136406.185366.288.camel@acm.org>
Subject: Re: [PATCH] block: fix direct dispatch issue failure for clones
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Mike Snitzer <snitzer@redhat.com>
Date:   Thu, 06 Dec 2018 14:46:46 -0800
In-Reply-To: <0448060e-4bba-4f53-008e-520b5b7436e9@kernel.dk>
References: <adab29e7-6f9e-0804-5630-73e92be6a990@kernel.dk>
         <0448060e-4bba-4f53-008e-520b5b7436e9@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-06 at 15:21 -0700, Jens Axboe wrote:
+AD4 On 12/6/18 3:20 PM, Jens Axboe wrote:
+AD4 +AD4 After the direct dispatch corruption fix, we permanently disallow direct
+AD4 +AD4 dispatch of non read/write requests. This works fine off the normal IO
+AD4 +AD4 path, as they will be retried like any other failed direct dispatch
+AD4 +AD4 request. But for the blk+AF8-insert+AF8-cloned+AF8-request() that only DM uses to
+AD4 +AD4 bypass the bottom level scheduler, we always first attempt direct
+AD4 +AD4 dispatch. For some types of requests, that's now a permanent failure,
+AD4 +AD4 and no amount of retrying will make that succeed.
+AD4 +AD4 
+AD4 +AD4 Don't use direct dispatch off the cloned insert path, always just use
+AD4 +AD4 bypass inserts. This still bypasses the bottom level scheduler, which is
+AD4 +AD4 what DM wants.
+AD4 +AD4 
+AD4 +AD4 Fixes: ffe81d45322c (+ACI-blk-mq: fix corruption with direct issue+ACI)
+AD4 +AD4 Signed-off-by: Jens Axboe +ADw-axboe+AEA-kernel.dk+AD4
+AD4 
+AD4 Bart, I'll add your reported-by here of course, and also a stable CC
+AD4 since the original patch went into stable.

Feel free to add the following:

Tested-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

