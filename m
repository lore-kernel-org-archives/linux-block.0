Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C944CC7618F
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 14:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF302173C
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 14:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563289115;
	bh=GVa3Pzfot0wGOMqXW/rBABUae/1hIs7xVjZ0/iD6hwE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Qr7ZTQYl0VtEEMz3DahyfMpK8kXsY+2qDvRRcSF0F3C/Z8rIVaGeR0ytepuyBjMF/
	 KHqNJuf3Rx47NmTCzbY0w0imNBOxip/GpJveDiGBZSv8ErwzjW034d69hTB5yS3GW5
	 AjLEoNsSrsXZo34H+daUaslR28KaCP0eaEvK+ZdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387896AbfGPO6f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 10:58:35 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:36606 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387892AbfGPO6e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 10:58:34 -0400
Received: by mail-pl1-f172.google.com with SMTP id k8so10263967plt.3;
        Tue, 16 Jul 2019 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=noCeewt6B+I5mcY7gyfnCkii7BiHslOWQNbYJEI0Pb4=;
        b=XCra2U/8s0/cYjDOtIiT9fbHvLoYIm6g/EVkcLR6hAGgt1K6xJTzPp/r7/1IUlombn
         Ty/5nx4zAM3jpfGXsh5oT264gV2XSNm5OOKbruZ/t0kgGv8zv/5AtCMYklYe27U6PVj4
         6Gl+OoVHh0IEEYjkPvLB96ghC6uWIRsnDSbhOHamJaNzUxXgVazDL8f4yJfH7S3/uEuu
         8oosKVbzLgUCwIOTv832g6N+fiCQB1wbC7YbjPrNaPbi3uKtuyXuALUVPpe2roi3PsDJ
         JsQU06BDaQqrppSILlkXfj3JG9gh7GsBtbpDlf3ETHm5T4gMXE28M32YAfmJgcwibKq6
         z00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=noCeewt6B+I5mcY7gyfnCkii7BiHslOWQNbYJEI0Pb4=;
        b=FPxQV6uxOq+jvhTrrHw954l7bTFqJUFZBQj7azLQJ3dMbKsw+Qd7LEayYzcByY8KD8
         V/WeMEhkShNLy/7KT3BfiFi6C61+clZJC1t8CziQdc6hd/U0/72gZH1qQRJGE6BW2hH7
         4L2oK4UGaep326jpCrqkhmlTzEJLZ44iJtPUgvppcdgqAMh86J46+Ug+Tprid5TOrZDt
         HNjKdlQeYZdX4neV4wtb02VqNI7Vo1qQ6jtThZzV41dCBeCWg7wqXEAGv6xkbxLsfLbx
         k9iFkZGftgNLT8DS4eMGCIzlELKfdI1aMjL8/LECzmQZ3y1aLlEAoYXBNtnuI7W75P0j
         qsHQ==
X-Gm-Message-State: APjAAAUm51NmFYdTvFsXCOSR49Op+TfEhp+cvH4+n8B6toKetnwNW4aJ
        /MogewwcUmUHPpxvGxCJ8B4=
X-Google-Smtp-Source: APXvYqw2X0R6A9irqs2ehIdF3GIdr3HsMC92RKvPU9jNmrTnLAKYQ+Gbiz7GIp7uVeYgcRaztqOBbQ==
X-Received: by 2002:a17:902:1566:: with SMTP id b35mr37124834plh.147.1563289113589;
        Tue, 16 Jul 2019 07:58:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:4779])
        by smtp.gmail.com with ESMTPSA id m4sm30712788pgs.71.2019.07.16.07.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:58:33 -0700 (PDT)
Date:   Tue, 16 Jul 2019 07:58:31 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH block/for-linus] blkcg: allow blkcg_policy->pd_stat() to
 print non-debug info too
Message-ID: <20190716145749.GB680549@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, ->pd_stat() is called only when moduleparam
blkcg_debug_stats is set which prevents it from printing non-debug
policy-specific statistics.  Let's move debug testing down so that
->pd_stat() can print non-debug stat too.  This patch doesn't cause
any visible behavior change.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-cgroup.c         |    9 +++------
 block/blk-iolatency.c      |    3 +++
 include/linux/blk-cgroup.h |    1 +
 3 files changed, 7 insertions(+), 6 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -54,7 +54,7 @@ static struct blkcg_policy *blkcg_policy
 
 static LIST_HEAD(all_blkcgs);		/* protected by blkcg_pol_mutex */
 
-static bool blkcg_debug_stats = false;
+bool blkcg_debug_stats = false;
 static struct workqueue_struct *blkcg_punt_bio_wq;
 
 static bool blkcg_policy_enabled(struct request_queue *q,
@@ -968,10 +968,7 @@ static int blkcg_print_stat(struct seq_f
 					 dbytes, dios);
 		}
 
-		if (!blkcg_debug_stats)
-			goto next;
-
-		if (atomic_read(&blkg->use_delay)) {
+		if (blkcg_debug_stats && atomic_read(&blkg->use_delay)) {
 			has_stats = true;
 			off += scnprintf(buf+off, size-off,
 					 " use_delay=%d delay_nsec=%llu",
@@ -991,7 +988,7 @@ static int blkcg_print_stat(struct seq_f
 				has_stats = true;
 			off += written;
 		}
-next:
+
 		if (has_stats) {
 			if (off < size - 1) {
 				off += scnprintf(buf+off, size-off, "\n");
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -917,6 +917,9 @@ static size_t iolatency_pd_stat(struct b
 	unsigned long long avg_lat;
 	unsigned long long cur_win;
 
+	if (!blkcg_debug_stats)
+		return 0;
+
 	if (iolat->ssd)
 		return iolatency_ssd_stat(iolat, buf, size);
 
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -182,6 +182,7 @@ struct blkcg_policy {
 
 extern struct blkcg blkcg_root;
 extern struct cgroup_subsys_state * const blkcg_root_css;
+extern bool blkcg_debug_stats;
 
 struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
 				      struct request_queue *q, bool update_hint);
