Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CFFC43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 10:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F37C2087E
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 10:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZF7UkoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfARKbp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:31:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36870 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfARKbo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 05:31:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so14417442wrt.4;
        Fri, 18 Jan 2019 02:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ydxFy/2Bm4LOh73jyZznaFZU/ozC3N50GLlK25DN1HY=;
        b=uZF7UkoWqAOS8InqNGoU+Xy56e0FXChmxbtUDcxGtitnfvoq5J69RWhz0T4GLa1XN7
         ic2JWQNYvNwQ7FNdzgTmFlYPuyuMYePIvJOTAkt1rq1qv3npOIlJKnEnuduR5WWdHEMU
         MlEV6xYWBmZqHHmJfgKOCTyUrPl9QLTy0f69SqrgJg39k0nzLx+lxkK10qryRH6si66h
         SstsLC8pwuIVUh/PIvbFTJRHxY8UMxObgeOZiAcdSLK0QxKEj/cCnxFDfynRiCt2uUpM
         bEcteokvSKR89Sej9dLKUFm5hBLlwGls8IDK7sEpaqI46nshsh4x2VRpezr1CsIKYPsC
         DZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ydxFy/2Bm4LOh73jyZznaFZU/ozC3N50GLlK25DN1HY=;
        b=no6shRfODKRhls8Nd2L1gll5YLEpOcGXu5HmjXFTxvZcWpmifjPbaMbhnRgUQvVQsE
         2S6Kg93f0+ijoBRN+/xYL0jJdGBWcvlZ7D6txByP2nS6WRcppRCosTjylFfCHqvoukog
         ITsVzC8aEiRGxhT4ebVawalGutPBCtMUdMRL4Mn3p9+T0ENdVP5G6p7sG4DedfppTCgQ
         PENIe4hRQRu6V/KkQerLsNWxOqyQ0BLrc0TLdpUrV8AaymDtmidCdBAmeiUDyfDKYHTc
         gPFejT2aLQVSyxSJLIuvFW4lCnfTFbTRpUzoii+dkUa2e7vNVvvxF2cDXMW6k+xG2Cam
         Tkww==
X-Gm-Message-State: AJcUukfGl3/jZlg7Tlbvwokm3iX5H7olqvT8yD2AjjtZbIYIv6g1fs4p
        b6dbkrbkCR2IGU6L4Ry51g==
X-Google-Smtp-Source: ALg8bN6Cqcrjp3e6Cz7WFU23YJq5O2/aUYTSzUeLmqK15QNrqZLmKt7cMABpfofO0GTuS7A/NCqhPg==
X-Received: by 2002:adf:ee46:: with SMTP id w6mr16290136wro.261.1547807502038;
        Fri, 18 Jan 2019 02:31:42 -0800 (PST)
Received: from xps-13.homenet.telecomitalia.it (host89-130-dynamic.43-79-r.retail.telecomitalia.it. [79.43.130.89])
        by smtp.gmail.com with ESMTPSA id g9sm39949652wmg.44.2019.01.18.02.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 02:31:41 -0800 (PST)
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Dennis Zhou <dennis@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrea Righi <righi.andrea@gmail.com>
Subject: [RFC PATCH 1/3] fsio-throttle: documentation
Date:   Fri, 18 Jan 2019 11:31:25 +0100
Message-Id: <20190118103127.325-2-righi.andrea@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190118103127.325-1-righi.andrea@gmail.com>
References: <20190118103127.325-1-righi.andrea@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Document the filesystem I/O controller: description, usage, design,
etc.

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
---
 Documentation/cgroup-v1/fsio-throttle.txt | 142 ++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/cgroup-v1/fsio-throttle.txt

diff --git a/Documentation/cgroup-v1/fsio-throttle.txt b/Documentation/cgroup-v1/fsio-throttle.txt
new file mode 100644
index 000000000000..4f33cae2adea
--- /dev/null
+++ b/Documentation/cgroup-v1/fsio-throttle.txt
@@ -0,0 +1,142 @@
+
+                 Filesystem I/O throttling controller
+
+----------------------------------------------------------------------
+1. OVERVIEW
+
+This controller allows to limit filesystem I/O of mounted devices of specific
+process containers (cgroups [1]) enforcing delays to the processes that exceed
+the limits defined for their cgroup.
+
+The goal of the filesystem I/O controller is to improve performance
+predictability from applications' point of view and provide performance
+isolation of different control groups sharing the same filesystems.
+
+----------------------------------------------------------------------
+2. DESIGN
+
+I/O activity generated by READs is evaluated at the block layer, WRITEs are
+evaluated when a page changes from clear to dirty (rewriting a page that was
+already dirty doesn't generate extra I/O activity).
+
+Throttling is always performed at the VFS layer.
+
+This solution has the advantage of always being able to determine the
+task/cgroup that originally generated the I/O request and it prevents
+filesystem locking contention and potential priority inversion problems
+(example: journal I/O being throttled that may slow down the entire system).
+
+The downside of this solution is that the controller is more fuzzy (compared to
+the blkio controller) and it allows I/O bursts that may happen at the I/O
+scheduler layer.
+
+----------------------------------------------------------------------
+2.1. TOKEN BUCKET THROTTLING
+
+            Tokens (I/O rate) - <mb_per_second>
+                o
+                o
+                o
+              ....... <--.
+              \     /    | Bucket size (burst limit)
+               \ooo/     | <bucket_size_in_mb>
+                ---   <--'
+                 |ooo
+    Incoming --->|---> Conforming
+    I/O          |oo   I/O
+    requests  -->|-->  requests
+                 |
+            ---->|
+
+Token bucket [2] throttling: <mb_per_second> tokens are added to the bucket
+every seconds; the bucket can hold at the most <bucket_size_in_mb> tokens; I/O
+requests are accepted if there are available tokens in the bucket; when a
+request of N bytes arrives, N tokens are removed from the bucket; if less than
+N tokens are available in the bucket, the request is delayed until a sufficient
+amount of token is available again in the bucket.
+
+----------------------------------------------------------------------
+3. USER INTERFACE
+
+A new I/O limit (in MB/s) can be defined using the file:
+- fsio.max_mbs
+
+The syntax of a throttling policy is the following:
+
+"<major>:<minor> <mb_per_second> <bucket_size_in_mb>"
+
+Examples:
+
+- set a maximum I/O rate of 10MB/s on /dev/sda (8:0), bucket size = 10MB:
+
+  # echo "8:0 10 10" > /sys/fs/cgroup/cg1/fsio.max_mbs
+
+- remove the I/O limit defined for /dev/sda (8:0):
+
+  # echo "8:0 0 0" > /sys/fs/cgroup/cg1/fsio.max_mbs
+
+----------------------------------------------------------------------
+4. Additional parameters
+
+----------------------------------------------------------------------
+4.1. Sleep timeslice
+
+Sleep timeslice is a configurable parameter that allows to decide the minimum
+time of sleep to enforce to throttled tasks. Tasks will never be put to sleep
+for less than the sleep timeslice. Moreover wakeup timers will be always
+aligned to a multiple of the sleep timeslice.
+
+Increasing the sleep timeslice has the advantage of reducing the overhead of
+the controller: with a more coarse-grained control, less timers are created to
+wake-up tasks, that means less softirq pressure in the system and less overhead
+introduced. However, a bigger sleep timeslice makes the controller more fuzzy
+since throttled tasks are going to receive less throttling events with larger
+sleeps.
+
+The parameter can be changed via:
+/sys/module/fsio_throttle/parameters/throttle_timeslice_ms
+
+The default value is 250 ms.
+
+Example:
+  - set the sleep timeslice to 1s:
+
+    # echo 1000 > /sys/module/fsio_throttle/parameters/throttle_timeslice_ms
+
+----------------------------------------------------------------------
+4.2. Sleep timeframe
+
+This parameter defines maximum time to sleep for a throttled task.
+
+The parameter can be changed via:
+/sys/module/fsio_throttle/parameters/throttle_timeslice_ms
+
+The default value is 2 sec.
+
+Example:
+  - set the sleep timeframe to 5s:
+
+    # echo 5000 > /sys/module/fsio_throttle/parameters/throttle_timeframe_ms
+
+4.3. Throttle kernel threads
+
+By default kernel threads are never throttled or accounted for any I/O
+activity. It is possible to change this behavior by setting 1 to:
+
+/sys/module/fsio_throttle/parameters/throttle_kernel_threads
+
+It is strongly recommended to not change this setting unless you know what you
+are doing.
+
+----------------------------------------------------------------------
+5. TODO
+
+- Integration with the blkio controller
+- Provide distinct read/write limits, as well as MBs vs iops
+- Provide additional statistics in cgroupfs
+
+----------------------------------------------------------------------
+6. REFERENCES
+
+[1] Documentation/admin-guide/cgroup-v2.rst
+[2] http://en.wikipedia.org/wiki/Token_bucket
-- 
2.17.1

