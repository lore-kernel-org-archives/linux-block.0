Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C39C433E2
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 17:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC5242053B
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591635739;
	bh=GFDS5ZeXJWKepPtGtYd1p8VC4NzatXMF4WFN56n95Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xqFw7Ta+HSgtVJRQ18agwA3oZsbIXsyvY4JmANN2gDf0h6guaOoS+oCykAPQWQcV/
	 3au0qabkdmG6f+RAYeGo6k1lts69OR3oeLhWmf61mFeaqEfj9WR4j0V2BpzHU4u+N0
	 oyPA4mOPBW5wj7Q1qxkVXuAq6sDJARrb2RjqEPj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387504AbgFHRCC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:02:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33115 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730726AbgFHRBj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 13:01:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id b201so8822009pfb.0;
        Mon, 08 Jun 2020 10:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f88bEORI++QIsnJdKm2ca64CmhxGUzC3g+SSrwClYUg=;
        b=fFY9lOlx1tsbi3CWNCs5HITSv6HGFSS6uQzU2SDIeXdrSs9JSC0cGIGAUKMcznY3uM
         ZXLpFFlhw+Tjvs56UTnnFK1JykEDSVXDQ3MatEDJ7aTGn7GljYVGtOrNgJxZARHZVi3O
         dWCa5bI8l/IHKozet5oo9FqZB8sF3hUX650r5yRvyHFRfXknw2SX9WARPjMDiq1RuGfX
         TsiwrJe1qPx1/J0S9yp7gygBdcZCrPoU2OC71PBpE/ZLWLC91o7/kreIhHwxjzW8aV/0
         JggYnb4B1GohPdV8pa0ONRUTBAMrED/pgubAQfp34+SRtJkLgYM43VCWuKmWLA4/RKmO
         YNUw==
X-Gm-Message-State: AOAM5320Ph1jDP87dX0Cxdx510UX79yeV9sGxJ/uASUotrxq8vIe/Maj
        1Jf9Dzv1nAt3p/MZtAg8BR4=
X-Google-Smtp-Source: ABdhPJwmTcpNrr37VElfNpqehHSBvOJFHFFfHrHovcAKxDpg8BeyMYMNILKDT4r2RmVxa1x2U8XKog==
X-Received: by 2002:a63:f14a:: with SMTP id o10mr21710759pgk.216.1591635696982;
        Mon, 08 Jun 2020 10:01:36 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id iq3sm103489pjb.6.2020.06.08.10.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 10:01:32 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9045A41DD1; Mon,  8 Jun 2020 17:01:28 +0000 (UTC)
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
Subject: [PATCH v6 5/6] loop: be paranoid on exit and prevent new additions / removals
Date:   Mon,  8 Jun 2020 17:01:25 +0000
Message-Id: <20200608170127.20419-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200608170127.20419-1-mcgrof@kernel.org>
References: <20200608170127.20419-1-mcgrof@kernel.org>
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

