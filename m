Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0DAC43603
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B8C6610CC
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbhDSHib (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 03:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbhDSHib (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 03:38:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF943C061763
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:38:01 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e7so39339141edu.10
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IiTwN52XJKi66N76pNHN0fIgFTasQJk4pE4Qk8xQaVQ=;
        b=CGGBeSLCPzfBJJIRQeB4drNEj0Ni7bvt8JZkARgO1N91wIMNXGFU4JOIu3/j6GD/Hy
         vVFgAsDBETHfxIUonGk0EYrUySNEL++1/872AxXbK4jrZOUFtEnvnvcx8eYz6r5mIkNC
         hkWVhFTEeTg3Lz2Ipr/ZMbe2ohO71/gRcNX9HcB6ye75GYQ5OrF+cg5sb+nxGh60EIkb
         kHXIYjT+azgKVcr3HAqdh8n+AAzNyGv+g+Ox+LgCWnAqCvdi/dhtcRwN+pWXCgMmEO0x
         jnhv1edYhmXZwwPKXPjMEPl3R1Ag42s9EfFtlSXLgp2bT0qIJtLtILZGrxYO9qgkoNyu
         u/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IiTwN52XJKi66N76pNHN0fIgFTasQJk4pE4Qk8xQaVQ=;
        b=F/vqIAewz6vLwkI5Fb0hTdmyYMIFBRYl0MaMwzsoHKw3/3kwYAVNWCi83tnOfATzj6
         Yy8pDTnOZv8PgeQLydvEVtk2oqLMGZM6WVxvW+/L0j9MUTKOuKv/fb/lk+WX9dDgpxEI
         ZQGOzlFtK26USEGH0xr6CInhEEe49ucBoIu3Y/9TKtZt2JUQg4DaVxMyr9qJqqzw/eG2
         5PzEAKLY/eEYwnFDVqm1jxnRrtvFDSPS0RhdmbzuZsD7rPFu+IP/lcgOs3VlQ+874Ps4
         z42DLO2SndHLspGIkaLy9gysFMnuBmv4lTAXa/TJFYOCirmaZaHO4SMW9rULKKgE9DAy
         H9sA==
X-Gm-Message-State: AOAM531MjHueUrv18EcFGvtJXJYDVFyKeHkhsjwrjG2xJHunFXosF7v8
        A3DEYo3fvni+pO3SFfukEJd3OLAEmWRvtko6
X-Google-Smtp-Source: ABdhPJzJ4bulNIFQuTKPJt/dbio7Zwyh0v37DZ/vNOlb9Rn1XnmjypcgAQgK3jX1mQjIrCJXMjas3Q==
X-Received: by 2002:aa7:da01:: with SMTP id r1mr15576469eds.197.1618817880374;
        Mon, 19 Apr 2021 00:38:00 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id g22sm8701833ejz.46.2021.04.19.00.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:38:00 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     axboe@kernel.dk, akinobu.mita@gmail.com, corbet@lwn.net,
        hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCHv5 for-next 14/19] Documentation/ABI/rnbd-clt: Add description for nr_poll_queues
Date:   Mon, 19 Apr 2021 09:37:17 +0200
Message-Id: <20210419073722.15351-15-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419073722.15351-1-gi-oh.kim@ionos.com>
References: <20210419073722.15351-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

describe how to set nr_poll_queues and enable the polling

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 Documentation/ABI/testing/sysfs-block-rnbd        |  6 ++++++
 Documentation/ABI/testing/sysfs-class-rnbd-client | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block-rnbd b/Documentation/ABI/testing/sysfs-block-rnbd
index ec716e1c31a8..80b420b5d6b8 100644
--- a/Documentation/ABI/testing/sysfs-block-rnbd
+++ b/Documentation/ABI/testing/sysfs-block-rnbd
@@ -56,3 +56,9 @@ Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
 Description:	Remap the disconnected device if the session is not destroyed yet.
+
+What:		/sys/block/rnbd<N>/rnbd/nr_poll_queues
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Contains the number of poll-mode queues
diff --git a/Documentation/ABI/testing/sysfs-class-rnbd-client b/Documentation/ABI/testing/sysfs-class-rnbd-client
index 2aa05b3e348e..0b5997ab3365 100644
--- a/Documentation/ABI/testing/sysfs-class-rnbd-client
+++ b/Documentation/ABI/testing/sysfs-class-rnbd-client
@@ -85,6 +85,19 @@ Description:	Expected format is the following::
 
 		By default "rw" is used.
 
+		nr_poll_queues
+		  specifies the number of poll-mode queues. If the IO has HIPRI flag,
+		  the block-layer will send the IO via the poll-mode queue.
+		  For fast network and device the polling is faster than interrupt-base
+		  IO handling because it saves time for context switching, switching to
+		  another process, handling the interrupt and switching back to the
+		  issuing process.
+
+		  Set -1 if you want to set it as the number of CPUs
+		  By default rnbd client creates only irq-mode queues.
+
+		  NOTICE: MUST make a unique session for a device using the poll-mode queues.
+
 		Exit Codes:
 
 		If the device is already mapped it will fail with EEXIST. If the input
-- 
2.25.1

