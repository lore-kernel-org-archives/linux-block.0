Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE21C43441
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 23:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369932080D
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 23:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MHQx5tgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369932080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbeKRKLx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Nov 2018 05:11:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44292 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbeKRKLw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Nov 2018 05:11:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so3530003pgr.11
        for <linux-block@vger.kernel.org>; Sat, 17 Nov 2018 15:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DX9PRhymEZ4mlMuP0D8G+UTxW3e/vnqplxNza5QmpL0=;
        b=MHQx5tgNVr/0IzWBFYVFXTD/Q82ukLzGozE8MZvzFd0CIPL9/GSkReYq7ReXoqux7s
         Cbr2xVcE5Lzb0L7LEqndZhia8/+fgZ6dEFFN/b7EhxVeiCluf9vMLtB9EEFc034/ch3+
         rHm1Rf5YwB4LXU9TM8nfO40UNKt3ZloXRib/ZvQOKAh9jFetwf+MUx6ogfSRpC8qalE0
         Uc4n3F0YZbijX2DszRN5Z7x5uc1CaWRxVKWi7a1hL8UbCxfK/ZrVdL+yBg/5D3xEt7o5
         cLNMionl9wOo3nVdbBupaIB1rii/oWw8I1xjsfkMix83te0Fo30T92I+/jV42t4WDo5i
         CGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DX9PRhymEZ4mlMuP0D8G+UTxW3e/vnqplxNza5QmpL0=;
        b=uoMXBiJWkUu+QJPTuFAyqZO8GiX3AqgTXfkblI1Uk0qtnzUWGmXENa1fP4pNM4AQET
         /YYmI+ezUFU8jl7xaVQ5FbLvbb344mikY4zB6HaPb1c0fODvaqPsBythYSwBZbSggypM
         hfbi+BJlMUSzNg+qxhlGOQogObZ28gmc9q6xM8r7MK4UntVmQAid3gbGY3cArX7uGSOy
         h7qBWRDTxbW9qUx7mqztTtpDvCCZA3WGffBa2pnQTO9lYHSQEFW9pBy4nj4GlVZdyBqN
         oeRjBhBlE+ybHq1s2FWTV1MOwACoPAa0buwW0Lo5RaPzoIkP4zN011E1itIbRqUlsKUZ
         YUiw==
X-Gm-Message-State: AA+aEWZiFDj8Iz0gyApwCBq+obsyBpr4KPuoZW9W7tS26Mz/TrfEWGy/
        xvqybcODkmnUfRZw0yEf52jCswFaGDE=
X-Google-Smtp-Source: AJdET5fGzhKB5IK77SMtjoR5qGZO2O0k3GHxUtlUXPL/J33omH8Tp6B4Ghr7+MEMf+DRVlgdB72hNQ==
X-Received: by 2002:a62:868b:: with SMTP id x133mr2492710pfd.252.1542498807089;
        Sat, 17 Nov 2018 15:53:27 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m1sm15812345pgn.9.2018.11.17.15.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 15:53:26 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/5] aio: fix failure to put the file pointer
Date:   Sat, 17 Nov 2018 16:53:14 -0700
Message-Id: <20181117235317.7366-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181117235317.7366-1-axboe@kernel.dk>
References: <20181117235317.7366-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the ioprio capability check fails, we return without putting
the file pointer.

Fixes: d9a08a9e616b ("fs: Add aio iopriority support")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/aio.c b/fs/aio.c
index b36691268b6c..3d9bc81cf500 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1436,6 +1436,7 @@ static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
 		ret = ioprio_check_cap(iocb->aio_reqprio);
 		if (ret) {
 			pr_debug("aio ioprio check cap error: %d\n", ret);
+			fput(req->ki_filp);
 			return ret;
 		}
 
-- 
2.17.1

