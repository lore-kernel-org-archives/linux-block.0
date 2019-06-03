Return-Path: <SRS0=uYlv=UC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29498C04AB5
	for <linux-block@archiver.kernel.org>; Mon,  3 Jun 2019 23:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E9122CBB
	for <linux-block@archiver.kernel.org>; Mon,  3 Jun 2019 23:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfFCXk1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jun 2019 19:40:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37545 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFCXk1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jun 2019 19:40:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id a23so11513110pff.4
        for <linux-block@vger.kernel.org>; Mon, 03 Jun 2019 16:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T6N2AN/mDZwJiN/A1khArLhBe3bNyHn2EYSZQY457vg=;
        b=Rq5JesfYw0Xnu3q+RlK4BZP+ojoXmVHF70/ZC3oegYUzeGZSqQTD1vdQQTerFIQ0+A
         Kj2dJVIKooLtu4Rep9jtg2If/Wjs160Q2DB9+aX/GmDSHtulIPIS7oOtc1yHvm+e+N83
         KHsvVlHFV/5F4N2GUpWR1fh/0h7AAtki+czne7QpgCprLhV/bybLficsFjTnkDgo4bMH
         bCJZjlsRIC0QG7eMd5kybQ3sLBxE4Gmue5xNPivNgCDVtGDYHXA8GyLbXvfPFQ1IIVCW
         Wsrmlv21qVQJ4pECBK+IOdgO+4vn3BSu9KLM+9qLRCUPBDYOEsPR7lmN6eOfZ+eVLwBW
         XtCg==
X-Gm-Message-State: APjAAAXXdf9Dt4iEIYTRjUdR+d/u4qvwBAx9IZheQP/fMvDyqPHHcUn8
        WU9KvaV/Oes8CN1erdmgJWs=
X-Google-Smtp-Source: APXvYqwB0OEonZuw27M4M57C+AZeHjlWU7zaUC/55XhdoEhQ6s5XoGlbNBi4PpZlXRXmB1uLkPMrug==
X-Received: by 2002:a63:af44:: with SMTP id s4mr31693870pgo.411.1559605226193;
        Mon, 03 Jun 2019 16:40:26 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id h11sm17327359pfn.170.2019.06.03.16.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 16:40:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH] MAINTAINERS: Hand over skd maintainership
Date:   Mon,  3 Jun 2019 16:40:19 -0700
Message-Id: <20190603234019.107514-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since I do no longer have access to any STEC SSDs, hand over
maintainership of the skd driver to Damien who still has access to
STEC SSDs.

Cc: Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fac3f405e7c0..2bdc4acb22ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14979,7 +14979,7 @@ S:	Odd Fixes
 F:	drivers/net/ethernet/adaptec/starfire*
 
 STEC S1220 SKD DRIVER
-M:	Bart Van Assche <bart.vanassche@wdc.com>
+M:	Damien Le Moal <Damien.LeMoal@wdc.com>
 L:	linux-block@vger.kernel.org
 S:	Maintained
 F:	drivers/block/skd*[ch]
-- 
2.22.0.rc1

