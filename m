Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B67C5B578
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 21:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4C020B7C
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 21:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGAVml (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:42:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36767 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGAVml (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 17:42:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so7195890pfl.3
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2019 14:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bG2LnbMYvOccRlx7DVirIuQd/L6sa/tQjdqObHdreCA=;
        b=Vr9H2tpVMnL1o+oN0BZ7y0mIkcYpARjHtEfyBMF+wt0b1E+MlncOsUZ/CGNFtKG4jE
         UCNw1OtsVBM1VP7KhV8KznitwMhgIa/y8I/NlsbrPRkQa/xGfab26KxuCl81hoHyaKza
         coJaHPqSxWB3qknYazvN3GST8OEjww8o8sh3sdU1EOZu8E8uN5EJV2blBMmA91o/WW0I
         xOe0zDFt4nWGFVlRh8FUV4VYPhl6DyRGo35UgcAUNjte8ZKwCQ7ZPKYknT/uF1x3YVLx
         qkfsO6ZFSdo0ZyuIBoSfCJ+De1wYfRwiKQUwRR/Z6Cb6F/hwANDWbdmLM1uLn+V+ecAw
         Ay6g==
X-Gm-Message-State: APjAAAWF04eSNyUfxVbk/uA3r4maKWM5O8lKMq5ahBOby2a8MVc7Ak6T
        kPwTZnh6bkDMmpyk7LDD0ro=
X-Google-Smtp-Source: APXvYqy3QL7jbJGnY4KnDegZZAKXOlMdVMYNJxp9DmPMnaGQhVc1NJAoA/T74OmkXDz/ZSZKpCvmVQ==
X-Received: by 2002:a17:90a:20c6:: with SMTP id f64mr1558449pjg.57.1562017360512;
        Mon, 01 Jul 2019 14:42:40 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c83sm15892282pfb.111.2019.07.01.14.42.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 14:42:39 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH liburing 0/2] Memory synchronization improvements
Date:   Mon,  1 Jul 2019 14:42:30 -0700
Message-Id: <20190701214232.29338-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The two patches in this series reduce the number of memory barrier calls from
liburing and also fix a few memory synchronization bugs. Please consider these
patches for the official liburing git repository.

Thanks,

Bart.

Bart Van Assche (2):
  __io_uring_get_cqe(): Use io_uring_for_each_cqe()
  Fix the use of memory barriers

 man/io_uring_setup.2  |  6 ++-
 src/barrier.h         | 87 +++++++++++++++++++++++++++++++++++++++++--
 src/liburing.h        | 15 +++-----
 src/queue.c           | 48 ++++++------------------
 test/io_uring_enter.c |  8 ++--
 5 files changed, 110 insertions(+), 54 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

