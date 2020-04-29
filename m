Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32613C8300D
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 07:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08A3E2085B
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 07:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588146410;
	bh=pGH6tb8Z1TFE2Az7g1DmuO4dOhUUZJEXDtbG2mBRkC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xdF2n4jyU3jntl/yNFfImTTUSuMt8OQ+HrbBk5Avd8w3oXAIE+d5wMaIDdnxEzWuC
	 S9SXam8K4tazzQ+jIASgEZTinqpmHFl7XrTyf/W5n9er60RF5L+zij8I04WLfyaSUK
	 J4iwaD7A/ZuQdC62DKN60WNiGEmdmzBEVsmzOONs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgD2Hqk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:46:40 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33706 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgD2Hqi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 03:46:38 -0400
Received: by mail-pj1-f68.google.com with SMTP id 7so2072191pjo.0;
        Wed, 29 Apr 2020 00:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SGf6Ly+O4Ndriq4xyCuLphKEBBCLbvmraZ/f8/ln1o=;
        b=KUWO2/+Z0dMIHCfl8Wnh+xme9vcLZQxtu1yY2IRBEtSSZbvSAdlkCefQvWzhN01OhE
         mW9+tlqzVfmnXpC2sK7e7fEFk3etPgAJmYYmX3QxOXz/f5FvuXp0H8anOXbP82IVfjK8
         At9XpgLMFS8lxvah73TbMFyXWrlHYB2vApSEel247sPtKCLKfse9QSfOgz8YLJZYVkCA
         D/cJ5wgvL8U0yCiONHFgwS4ZxwNmx2d8qOZlZehBzoitRGe82SwdP43oUDxf5W6RzNpb
         uO9BfAf1KwUJ7epTzpwOOlZ+UCm268rb1t/jgvrzP/bLF0pgwqmWqxUsijnM9ip/+xMw
         n8RA==
X-Gm-Message-State: AGi0PuZr6QRhNjgfIvfyhwBcJp+lFak5nzjxom8pj+zx3zIEbc+Ccww5
        KLCGiCjkpCUvOt9gwURxDpA=
X-Google-Smtp-Source: APiQypKvHe5sxZ7BY9kIc9F1nfVnrNrN57rzYZfJEMB8GR3JOh+gOanykqeVDjgeRVbFaOR+yoZOIQ==
X-Received: by 2002:a17:902:8687:: with SMTP id g7mr30866549plo.59.1588146398422;
        Wed, 29 Apr 2020 00:46:38 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y3sm4096498pjb.41.2020.04.29.00.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:46:35 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1F17E42000; Wed, 29 Apr 2020 07:46:30 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 6/6] loop: be paranoid on exit and prevent new additions / removals
Date:   Wed, 29 Apr 2020 07:46:27 +0000
Message-Id: <20200429074627.5955-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200429074627.5955-1-mcgrof@kernel.org>
References: <20200429074627.5955-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Be pedantic on removal as well and hold the mutex.
This should prevent uses of addition while we exit.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/loop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index da693e6a834e..6dccba22c9b5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2333,6 +2333,8 @@ static void __exit loop_exit(void)
 
 	range = max_loop ? max_loop << part_shift : 1UL << MINORBITS;
 
+	mutex_lock(&loop_ctl_mutex);
+
 	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
 	idr_destroy(&loop_index_idr);
 
@@ -2340,6 +2342,8 @@ static void __exit loop_exit(void)
 	unregister_blkdev(LOOP_MAJOR, "loop");
 
 	misc_deregister(&loop_misc);
+
+	mutex_unlock(&loop_ctl_mutex);
 }
 
 module_init(loop_init);
-- 
2.25.1

