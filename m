Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F58C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0F02087C
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCYQjt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:39:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40497 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYQjt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 12:39:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id u9so6841951pgo.7
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 09:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+rwDTY8XsBstYWr62SK57whkQYa0L062kPJaUGHRe4w=;
        b=XzCYiq1nVqVnAuMWGCIvsQLAAGW/s8zo/ofYA2dsIyToN1QmoGVKoFPrK3SryJOyHO
         oZeTIIircztCO0YcaDBWO+tDzMbkzozr85JeXmivC3wEbhe3I3kve9WqYO6hZcCBaxjy
         J1Vwkm6Bs0m+gmKj67//EnanJ+5sgoIYdPvJOE7B5bym+2czTtJk48xZdJ/8+quxL+CY
         HWHW7KsuBT9+GHCoMQy0hw/DsD9XLSn/K3dPYFrWtc/57dSaDqE278qLzSxkEoT17oCR
         4tF3Wy/fcjMLSCeuzJvgm35g5qQ7wo9TJ6cRqn9qCg4Qqv1B9pCBv7WEOpL/aclNXgw0
         ATcQ==
X-Gm-Message-State: APjAAAWFAOw1Ii16JwYJ/IytuIQwmQS8aVGcka7aqwLi6jZucOj0rIRE
        yaretjPsdgNwz84BW9N9Zu8=
X-Google-Smtp-Source: APXvYqzqdX4VKFk4ehpTvZ2oqFp3X/54Bo/OWKc+s0EHmEzmkpzVaF0oN42+FXU+IE8YXxhZcqtLLQ==
X-Received: by 2002:a63:5953:: with SMTP id j19mr9588363pgm.260.1553531988988;
        Mon, 25 Mar 2019 09:39:48 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id e21sm10791238pfd.177.2019.03.25.09.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 09:39:48 -0700 (PDT)
Message-ID: <1553531987.118779.9.camel@acm.org>
Subject: Re: [PATCH] blk-mq: fix sbitmap ws_active for shared tags
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Omar Sandoval <osandov@fb.com>
Date:   Mon, 25 Mar 2019 09:39:47 -0700
In-Reply-To: <c0d3f0c8-a5d7-19dd-7b7f-1d4f860c425b@kernel.dk>
References: <c0d3f0c8-a5d7-19dd-7b7f-1d4f860c425b@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-03-25 at 10:22 -0600, Jens Axboe wrote:
+AD4 We now wrap sbitmap waitqueues in an active counter, so we can avoid
+AD4 iterating wakeups unless we have waiters there. This works as long as
+AD4 everyone that's manipulating the waitqueues use the proper helpers. For
+AD4 the tag wait case for shared tags, however, we add ourselves to the
+AD4 waitqueue without incrementing/decrementing the -+AD4-ws+AF8-active count. This
+AD4 means that wakeups can take a long time to happen.
+AD4 
+AD4 Fix this by manually doing the inc/dec as needed for the wait queue
+AD4 handling.
+AD4 
+AD4 Fixes: 5d2ee7122c73 (+ACI-sbitmap: optimize wakeup check+ACI)
+AD4 Signed-off-by: Jens Axboe +ADw-axboe+AEA-kernel.dk+AD4

Hi Jens,

Since commit 5d2ee7122c73 went upstream in kernel v5.0, does this patch need
a +ACI-Cc: stable+ACI tag?

Thanks,

Bart.
