Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD86C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 22:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF5321473
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 22:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfDHWRi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:17:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37831 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfDHWRh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 18:17:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id w23so8131577ply.4
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 15:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8+nDXMVzs3ffBE7sLhrn6yKBCa8WABIyVAjOzZPV28=;
        b=o91dj7ivjSqj5GtrqM1qNCImif6QtF96gfpEmSsccotEWqI9PouLAqjlD/TuThMcAL
         mcczy6uxbafi41N/7IyHkkKFGf4BgKxE2Sg03OTTzJtZ4MQopSKYE7E7z9sLmF5dtKOE
         oexpf/jkwIZCycMHr2M5kandEUpmk/LhhELqYbv/Hb8X6p2JkoM69xuBPSAbSr60Aczi
         +m85bebHxGV1uLkLN80MzfmLLS9Pgno6VNc2KMpoM/h6jl7MfVILZfZRlGAGKz4C8PQ0
         fFQSANUUyoDGVaf/lFYbdUfE5wNOr7O6zA/KfptXH0c64DvZc6DEvPKLAcdq5XmBJZSN
         gNrA==
X-Gm-Message-State: APjAAAUohwr52+H38uxYY3SbQbSEya9P6jaVwR43pF3qOofvKZXeqrSQ
        XOXXf+NceJMq/+4uJu+jI0ApHPuj
X-Google-Smtp-Source: APXvYqxp6Xfn9G+WFDrSUz24rg9W9ANY1/gmhHd3GozIKcFlBO+NY2HpyUMO0ll4HddrbHiz/kflkA==
X-Received: by 2002:a17:902:6b08:: with SMTP id o8mr33550987plk.105.1554761856944;
        Mon, 08 Apr 2019 15:17:36 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id m69sm45977231pfi.151.2019.04.08.15.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 15:17:36 -0700 (PDT)
Message-ID: <1554761855.118779.285.camel@acm.org>
Subject: Re: [PATCH 3/5] block: don't allow multiple bio_iov_iter_get_pages
 calls per bio
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Date:   Mon, 08 Apr 2019 15:17:35 -0700
In-Reply-To: <20190408104641.4905-4-hch@lst.de>
References: <20190408104641.4905-1-hch@lst.de>
         <20190408104641.4905-4-hch@lst.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-04-08 at 12:46 +-0200, Christoph Hellwig wrote:
+AD4 No caller uses bio+AF8-iov+AF8-iter+AF8-get+AF8-pages multiple times on a given bio,
+AD4 and that funtionality isn't all that useful.  Removing it will make
+AD4 some future changes a little easier and also simplifies the function
+AD4 a bit.
+AD4 
+AD4 Signed-off-by: Christoph Hellwig +ADw-hch+AEA-lst.de+AD4
+AD4 ---
+AD4  block/bio.c +AHw 15 +-+-+-+-+-+----------
+AD4  1 file changed, 6 insertions(+-), 9 deletions(-)
+AD4 
+AD4 diff --git a/block/bio.c b/block/bio.c
+AD4 index ad346082a971..2fa624db21c7 100644
+AD4 --- a/block/bio.c
+AD4 +-+-+- b/block/bio.c
+AD4 +AEAAQA -958,7 +-958,10 +AEAAQA static int +AF8AXw-bio+AF8-iov+AF8-iter+AF8-get+AF8-pages(struct bio +ACo-bio, struct iov+AF8-iter +ACo-iter)
+AD4  int bio+AF8-iov+AF8-iter+AF8-get+AF8-pages(struct bio +ACo-bio, struct iov+AF8-iter +ACo-iter)
+AD4  +AHs
+AD4         const bool is+AF8-bvec +AD0 iov+AF8-iter+AF8-is+AF8-bvec(iter)+ADs
+AD4 -       unsigned short orig+AF8-vcnt +AD0 bio-+AD4-bi+AF8-vcnt+ADs
+AD4 +-       int ret +AD0 -EFAULT+ADs

Is the value -EFAULT used anywhere? In other words, can +ACI +AD0 -EFAULT+ACI be left
out? Otherwise this patch looks good to me.

Thanks,

Bart.
