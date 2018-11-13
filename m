Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073A1C43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CA92086B
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hmK6k6uV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CA92086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387822AbeKNBlg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:41:36 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53009 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733221AbeKNBlf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 20:41:35 -0500
Received: by mail-it1-f193.google.com with SMTP id t190-v6so18849734itb.2
        for <linux-block@vger.kernel.org>; Tue, 13 Nov 2018 07:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WYF2DQMSuLBvvC6oyWCzDINndqOwZo6FPKocRmVKp6k=;
        b=hmK6k6uVJxPb1qUWCvMc5U9Pv/+DMsVVBZakScafbVw5unRaW65N5aNBXnO4FrUsDo
         ptd7nzKjjncEQGSIZSe58OnkU3m3oacrC0kXlcDoJcPn9xgyXqy7dE1CkoSQdv1+yKMO
         CfANTyyhZAshywUGG6E9phPvjHLUHUvgujBM2eAXGXRqUMn/wsRVCs6GM5WmUBshgp7J
         RijzXDKPbiGbb8ZT1IBIgYWt31ut7XYEbHW8Ij6OGYgyaHtXN+8QkhO/GUVpGmZqqENS
         QC+Yne2KXjF+qd3vAq22AdFw/JxbP1YLFXAJ4ao74Kg/zROjq5jwzylJMm1R/zYVQBb8
         OSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WYF2DQMSuLBvvC6oyWCzDINndqOwZo6FPKocRmVKp6k=;
        b=tFaOAUBudMvc/4dK6Qe3XYUEcGxdhpeqibNHMfe/zjZirr/lKnGdxYEPA1Je+xKLZ9
         fXdq2scy7Nz3oy/ux+E2yXDsaWUw3CWP0dkXtsI6735HMyRH1FtfgDQk1vtz81/jXHWQ
         46vr7dgbJ+tJ0kQRykRiMsv1yoQsVbVhNQhLkEPJpbGuG8HmdUJAoXA5stnTgU//En5r
         s8HrK1FMuJK/+5/IAXJoL3d9ANXUyWCHsA05GvLLHPGXB4BSFYvJMzHfXJfU9yNxUeh/
         qNQeCrH1p044o6MI2PitqWGOCO9Fj2V3BkiRPL8ev4TsA3BBQHEDdAylINSQy9mnrPo2
         Aysw==
X-Gm-Message-State: AGRZ1gKG1EV73rGGaA8tPWhB79eoUXhFx78CT81xUStU73Ai2skLqeD/
        0uK+r8JYkySpxiv0YZkp7uG5wS9Hmfw=
X-Google-Smtp-Source: AJdET5feneHfO+11L+1WkRWHozWrSM1jwBb9x85mmhaXPrgYI1YRpV1vAmno6Jj68Pjx1VZUTgal8w==
X-Received: by 2002:a24:d997:: with SMTP id p145mr4242077itg.30.1542123776482;
        Tue, 13 Nov 2018 07:42:56 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o14-v6sm6721987ito.3.2018.11.13.07.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:42:55 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/11] block: for async O_DIRECT, mark us as polling if asked to
Date:   Tue, 13 Nov 2018 08:42:32 -0700
Message-Id: <20181113154233.15256-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113154233.15256-1-axboe@kernel.dk>
References: <20181113154233.15256-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Inherit the iocb IOCB_HIPRI flag, and pass on REQ_HIPRI for
those kinds of requests.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7810f5b588ea..c124982b810d 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -386,6 +386,9 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 
 		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
 		if (!nr_pages) {
+			if (iocb->ki_flags & IOCB_HIPRI)
+				bio->bi_opf |= REQ_HIPRI;
+
 			qc = submit_bio(bio);
 			break;
 		}
-- 
2.17.1

