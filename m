Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF02BC433E1
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 03:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A70920657
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 03:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589599231;
	bh=M+ktMPS112XYqEPH32A6LyNk+vZmwg1qNOPTVnRFj08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uXiot3VVct74xe347OtBg4rnEM56lTsZB6o+yOyoKsuR7rig0rjmC7sOtfPGUqZfm
	 lo3SGBiKKO39ncUAPacgpp2JkjjTBZvPwcLSVF9VNpLXtrF5loiwLgKQcK51eGZkZ1
	 jqH2yMRgOoJhQLvYAZmcZqRmI0WNNtNps8INhx7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgEPDUX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 23:20:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45015 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgEPDUI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 23:20:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id b8so1686318plm.11;
        Fri, 15 May 2020 20:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSjrRs+0uw9ZlSZjuW3x7w+Qi8+kmil3SD7+oVGrims=;
        b=PXMBp90YZy9hdyqb7OsyGKERnhgpdRQoYUvE48W4O8IpBtwxGIpvUJL3qob1aOMsF8
         o6d3SNnNuQn87JBdgxkkr1uuqY1XU9/p/MEUrzNhsOO+MaAjG5DF3shvrfNDdB2U+KYY
         O/QQt5acOVM4k3Bq4b+ZHAcHqXjFyMmGhfExfzyhIv0iHtJ8bk6XWEHhG7e/ZkD/i1XM
         BJryuh/VrtesvePhID/O0OfgrIKi37MToRxsnEgcuNIIl+Pj3SUi8aBVKS6NfW7kq1BD
         ydHTbvf1zfN2PF3VJXE5VR7tZA8ar6uK2n45Y2DsTWiiNXjW5gftMq51N5BgFqpyTkyj
         uMdw==
X-Gm-Message-State: AOAM531BhGzdYnkcMMGrozQkUA5dULCDX9jXat6VariDsYBYOzWnzZhK
        odnx1Jwzf3lsEJUY2ijwwPw=
X-Google-Smtp-Source: ABdhPJzX3emfY2u5XlGWmWnMHz1FoWzaUTuwWxyn8o3ueiTdT13lL7oD1fI78RNo5dxjkInTLInT+A==
X-Received: by 2002:a17:90a:1912:: with SMTP id 18mr6556766pjg.115.1589599207438;
        Fri, 15 May 2020 20:20:07 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id t22sm2578636pjs.1.2020.05.15.20.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 20:20:04 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E0FF742309; Sat, 16 May 2020 03:19:59 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v5 7/7] loop: be paranoid on exit and prevent new additions / removals
Date:   Sat, 16 May 2020 03:19:56 +0000
Message-Id: <20200516031956.2605-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200516031956.2605-1-mcgrof@kernel.org>
References: <20200516031956.2605-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Be pedantic on removal as well and hold the mutex.
This should prevent uses of addition while we exit.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/loop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 14372df0f354..54fbcbd930de 100644
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
2.26.2

