Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BA3C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 16:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17692083D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 16:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17692083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeLGQTt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:19:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46783 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeLGQTt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 11:19:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so1912621pgp.13
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 08:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vGYMTI9fK9hw2tgH3mqE2PflhJjPUFeYy0RI0Jz3PBY=;
        b=VLsNVskmEaqmTQQwwou9O4xgC7yFJ6EmYllmUm3Ei9quGiB1Ajsw08wOW0N3etFAsO
         4Ut9JgwxlGWuruZws89CAWonAn84l/zuNWiMxBFrNMx/FhbGnAEcJXaxWOR/IIlcLBxW
         mmrd8a6U9/zNBcZQ/SPWTaD5Oioa2PSiYoU+713LXpPoY353l/fyIb9GpMJHdp5qUgsN
         wlpc7xZkmS2pXdU6JObFuqzEPoNwu0c9G9E4rCw7FiPpLrUm27+cI4fATDMZROkcyBu3
         dU6uqlYePmU/Lch8rDxcurrrQs5MSESZknsTLRgA8+r7BwQcqT2p+SOcQ2ZGk4/zJV5h
         KTpg==
X-Gm-Message-State: AA+aEWbgEmr2fffMHcBkUx6KE/YnpwEpqG+yCM8JmMGzTnjJst9r2grZ
        p6KlH3/xGRTlSZNF0CjSHcc=
X-Google-Smtp-Source: AFSGD/WtoCl2N2ErMPb/Fz5QLPLsWzVGMgprVCdnRr1fQqQDCpiMBfeHf7Ew0ox61FjvqpO6b6lgig==
X-Received: by 2002:a63:d34a:: with SMTP id u10mr2532425pgi.301.1544199587241;
        Fri, 07 Dec 2018 08:19:47 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id u6sm4463915pgr.79.2018.12.07.08.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 08:19:46 -0800 (PST)
Message-ID: <1544199585.185366.303.camel@acm.org>
Subject: Re: [PATCH v3] blk-mq: punt failed direct issue to dispatch list
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@redhat.com>
Date:   Fri, 07 Dec 2018 08:19:45 -0800
In-Reply-To: <aa6abfa7-30c3-57d7-7369-754d514584f5@kernel.dk>
References: <aa6abfa7-30c3-57d7-7369-754d514584f5@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-06 at 22:17 -0700, Jens Axboe wrote:
+AD4 Instead of making special cases for what we can direct issue, and now
+AD4 having to deal with DM solving the livelock while still retaining a BUSY
+AD4 condition feedback loop, always just add a request that has been through
+AD4 -+AD4-queue+AF8-rq() to the hardware queue dispatch list. These are safe to use
+AD4 as no merging can take place there. Additionally, if requests do have
+AD4 prepped data from drivers, we aren't dependent on them not sharing space
+AD4 in the request structure to safely add them to the IO scheduler lists.

How about making blk+AF8-mq+AF8-sched+AF8-insert+AF8-request() complain if a request is passed
to it in which the RQF+AF8-DONTPREP flag has been set to avoid that this problem is
reintroduced in the future? Otherwise this patch looks fine to me.

Bart.
