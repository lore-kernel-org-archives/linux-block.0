Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B9DC43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 18:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2581320851
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 18:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfCHSHZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:07:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35504 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfCHSHZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Mar 2019 13:07:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id j5so14699220pfa.2
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 10:07:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kJLBZZC/xoJZaBRDfirKNDW3mKZYmFQsQrjrn33xXz0=;
        b=ZZchyJRjaQT4M9cO/XRpfkF32CruYJOZ7iSlkHZJwNlX/dJD0Yyq5v/Ixco9rl23VT
         /umCI/sHn+UwUi/sgWmAEaj2XpCQTCqD2vfZWySWGZyLhzRdhPeAo17Kn081HrbBYjE7
         DueihRqYncjdrhj1JQ//exxLDi6GTOJPKmaNcTAGYgGFrKIYzy7H7jAKMbW8Ehueueln
         1L1FmZLfp/XRt7Ok/RrjjnmZq3Di4oaQc5fWjcF/1a5S4R4KJeUspyvqsC/lwPft9Sdm
         5TAQ6MpL+UVdkYi5An0p1//VeBeQ9jSo/C1IEoHS8VPz8MiociG5+0lSDD0Q3xZ5ceiq
         gBWQ==
X-Gm-Message-State: APjAAAU1N2Qx7cStThS5zgXdCrkZHV2lvrSb+Qk5AqCvR3xZj0DA/yfC
        JnYCmPzMbhswHM2k8hI+mJA=
X-Google-Smtp-Source: APXvYqxoAxylxbt7nK+YZG2QdJC8/EiLM7VZKVdTPjnh8nYMGd9wK3QN6QR0oYDPtA+KKwLnEH+gXQ==
X-Received: by 2002:a65:5a81:: with SMTP id c1mr17676068pgt.217.1552068444715;
        Fri, 08 Mar 2019 10:07:24 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id e14sm28538301pga.61.2019.03.08.10.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 10:07:24 -0800 (PST)
Message-ID: <1552068443.45180.24.camel@acm.org>
Subject: Re: [PATCH 1/5] blk-mq: Export reading mq request state
From:   Bart Van Assche <bvanassche@acm.org>
To:     Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Date:   Fri, 08 Mar 2019 10:07:23 -0800
In-Reply-To: <20190308174006.5032-1-keith.busch@intel.com>
References: <20190308174006.5032-1-keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-03-08 at 10:40 -0700, Keith Busch wrote:
+AD4 Drivers may need to know the state of their requets.

Hi Keith,

What makes you think that drivers should be able to check the state of their
requests? Please elaborate.

+AD4 diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
+AD4 index faed9d9eb84c..db113aee48bb 100644
+AD4 --- a/include/linux/blkdev.h
+AD4 +-+-+- b/include/linux/blkdev.h
+AD4 +AEAAQA -241,6 +-241,15 +AEAAQA struct request +AHs
+AD4  	struct request +ACo-next+AF8-rq+ADs
+AD4  +AH0AOw
+AD4  
+AD4 +-/+ACoAKg
+AD4 +- +ACo blk+AF8-mq+AF8-rq+AF8-state() - read the current MQ+AF8-RQ+AF8AKg state of a request
+AD4 +- +ACo +AEA-rq: target request.
+AD4 +- +ACo-/
+AD4 +-static inline enum mq+AF8-rq+AF8-state blk+AF8-mq+AF8-rq+AF8-state(struct request +ACo-rq)
+AD4 +-+AHs
+AD4 +-	return READ+AF8-ONCE(rq-+AD4-state)+ADs
+AD4 +-+AH0

Please also explain how drivers can use this function without triggering a
race condition with the code that modifies rq-+AD4-state.

Thanks,

Bart.
