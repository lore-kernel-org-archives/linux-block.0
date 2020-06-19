Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36B9C433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 20:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCD821548
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 20:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592599668;
	bh=GFDS5ZeXJWKepPtGtYd1p8VC4NzatXMF4WFN56n95Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PZv8eQSiZq0mZsN5gCO+srWycyqWKc5PZAYZlajEis3+pWYRfsjvOlLVy8MtrvzEI
	 WVGFrEBMStkgMtuXBxeHbEAEAR8eLerCgSbpW5LfzJMC6OIoXU1s+doZDl1debTqEz
	 GpLnjBL4NqRtzao+lJ3WNgnCSANnXRbhLHDTDDy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390831AbgFSUrr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:47:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35810 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391113AbgFSUrn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 16:47:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id k1so4385638pls.2;
        Fri, 19 Jun 2020 13:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f88bEORI++QIsnJdKm2ca64CmhxGUzC3g+SSrwClYUg=;
        b=b597umi/vwQhZzxLMDHbVDwgdPWBKhCvCp4M01vq276lf1KR8jDcUF058/2qmLGs/3
         zyGtULDU824dglz2AvD0OHy0l6HmqBwJ1rYigiWiRtbUrQcQz4rGnLmH92s95CAFvgTH
         UB3N41EPWoNpUqlso6CmVTwEr/eIEr1GEg+A4sW8al8AhwMyfUkIaq4NLyH7B25VjEFd
         hru93WuDmgMrbn88iON5pAeBoCRXONHlddX/t5TaLdcJi0loWUj/FhQL4NbKDxQccNAO
         GOuCdGxHBBYZOMlQxu6386i8aXVaoa+kI5hCVAYr8Zx12IwBItDDOiPGDlUJZIoRQ3P9
         QaVw==
X-Gm-Message-State: AOAM532f0wYUxQEaiopXZcaukXN4eTb/3VruOK97Io0KNAUyBtOmcSrd
        7YqEyuGYevviWu/I+zIV7AY=
X-Google-Smtp-Source: ABdhPJyoZ4/dvNRCLnarrxnxISmW+vu/kyGF815p5j84q6q1BrSobxtKcghLOojyOlj8eKMv/rwguw==
X-Received: by 2002:a17:90a:8083:: with SMTP id c3mr5595094pjn.83.1592599661138;
        Fri, 19 Jun 2020 13:47:41 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id m10sm5741217pjs.27.2020.06.19.13.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 13:47:39 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 792F241DAB; Fri, 19 Jun 2020 20:47:32 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 5/8] loop: be paranoid on exit and prevent new additions / removals
Date:   Fri, 19 Jun 2020 20:47:27 +0000
Message-Id: <20200619204730.26124-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200619204730.26124-1-mcgrof@kernel.org>
References: <20200619204730.26124-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Be pedantic on removal as well and hold the mutex.
This should prevent uses of addition while we exit.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/loop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c33bbbfd1bd9..d55e1b52f076 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2402,6 +2402,8 @@ static void __exit loop_exit(void)
 
 	range = max_loop ? max_loop << part_shift : 1UL << MINORBITS;
 
+	mutex_lock(&loop_ctl_mutex);
+
 	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
 	idr_destroy(&loop_index_idr);
 
@@ -2409,6 +2411,8 @@ static void __exit loop_exit(void)
 	unregister_blkdev(LOOP_MAJOR, "loop");
 
 	misc_deregister(&loop_misc);
+
+	mutex_unlock(&loop_ctl_mutex);
 }
 
 module_init(loop_init);
-- 
2.26.2

