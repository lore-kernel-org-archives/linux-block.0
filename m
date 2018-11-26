Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B241DC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA3B20855
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PdAr8Mh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA3B20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeK0Dka (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:40:30 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44736 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeK0Dk3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:40:29 -0500
Received: by mail-io1-f68.google.com with SMTP id r200so14451904iod.11
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uXUPTEErriSDBDqj30UJ7EFKAesBtDa0/H0fvvZRr1Y=;
        b=PdAr8Mh5pSv9yS/FtEHQciRH9nioWconVE1xeU06K388kUaDINPQDZM2bC8MYoUZPk
         cADijkXboEKoP97mhm7rmUdgBqCg9zwHXgo+u7FRhuaFNKbBikrw/Sa+0x8BFVFIXNtl
         PFvp3eWlhkNr9XSSSrqml519jqy6drw8TcX7bzM9/WeUXyHda3ojj6iAsAhWbTs+096M
         OyC0bgaM3mPUqpWBfRbJqd3/TrkPy00s4CmJUlSAmtuW1OKjqujlYoAOeLmdn613MoAA
         EH/jWPcC0mAnXBEW52lr0f5GN383ezv3T4R+pnO5z8qU8oKV/hM3m12RsOugKM5heJig
         JEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uXUPTEErriSDBDqj30UJ7EFKAesBtDa0/H0fvvZRr1Y=;
        b=dix1GGAL9/JU9UnUDq1aiOuqFXimDbUs0gI9Vtj3XgVTlo+E/s+oXDQ7iW3YqIkSv9
         hu15mEk7s4/pL08DNwJMIFXmy+qfpokzzxq1G/9SvEuTElay/KwwvQJ3PbFbfd5vUhCu
         sgC1rmxGT7YWJKYl7ePZYnYBZbaSe2Dy1EJnR9Fph2YLVSCEmXpJn8o7h3F9M6GR6FcF
         xJVigpxkNp1O8GOHVjIFJDnZV2L3j5v6JT0lb+tXbGYZTRSIWCixc2IIVmwqrSrgKZ8h
         zKVEZqXWP05e57464ainCwg/fi0Ui88Fx1lYBJt0DCpOLTKj9R50A4LbwtJCnrq6Brpp
         +LUQ==
X-Gm-Message-State: AA+aEWbAYKE3NcyvqUOCPnSJbi914zAMb5hFJSuJfeleTeVUc3ytaUb9
        OVwkflewv/Vm1KUoN7aFKU1DpHIpalg=
X-Google-Smtp-Source: AFSGD/WjSR+dAatWBussqO1RZbe8Dy24Pf+/goQkghIvtZu04nyJojsMaeUw6MUT73GFlyFXV67WVg==
X-Received: by 2002:a5d:8b8d:: with SMTP id p13mr14268158iol.223.1543250749785;
        Mon, 26 Nov 2018 08:45:49 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t65-v6sm486801ita.9.2018.11.26.08.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:45:48 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/20] aio: fix failure to put the file pointer
Date:   Mon, 26 Nov 2018 09:45:25 -0700
Message-Id: <20181126164544.5699-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126164544.5699-1-axboe@kernel.dk>
References: <20181126164544.5699-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the ioprio capability check fails, we return without putting
the file pointer.

Fixes: d9a08a9e616b ("fs: Add aio iopriority support")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/aio.c b/fs/aio.c
index b984918be4b7..205390c0c1bb 100644
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

