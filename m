Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967DDC64EB1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A7B20892
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544118598;
	bh=UhjuXLBmh1XserCkBPHUP8Bpt//cuqVi04KnlJhBL80=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GObhpJ7KcROvS6u4COeQIMUopwzEzIXueOqQTaM8h/14DNUhtU7k7GS3VnWFCIp+l
	 YbPfNN9btW7KBrq2i/UiP/a1EZ4r02/vHuAMNfEZfyIstQR4SBRmoP5uEY59lIx+zd
	 /KQcw2WK+ARMJfYV6u2nQlCPgGW3leC+HV7K9YrI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A7B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbeLFRtw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:49:52 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44193 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeLFRtw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 12:49:52 -0500
Received: by mail-yb1-f193.google.com with SMTP id j145so1076121ybg.11;
        Thu, 06 Dec 2018 09:49:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s2I4+XiKGymX1GJhBaczK+dUn/gC4npGb++LfKSs/JA=;
        b=UdxkzWsxtHHqpBqe5KUaQrA1G2I/GQFCs/nWu5QzVodRMhb0MhxtfCx6HB29ZnkLy0
         xmvC0kjYRz4sD156/fhU1/hir8S+/gO8l1kxhs/PCsTAsS1msvBH5Twv0o3l96dCSp3I
         EsAeKDcl80M+JQyvVcZBNIQiULtyTrb41tNPMuF5p9XqoMzFpatPYFFWrlLxcBV13bBQ
         tYhHkUiQEr2u8prjfCJDulHR+NvL/Tm3tFJGcYljB2QRIYYg7WHVPZLgUfYA9B/UnvTM
         JB93PTmoBavnU/3OsRk8oLJK13m7ghFt5hoQQvWGzD/GrxP4FHr9s6DbG1ZdQ5JVi3Ku
         ydCQ==
X-Gm-Message-State: AA+aEWbXttP0P3YOD2o9OoBSuUoCP1MmTfeJO2jFRdHMnQd2JGZS5Wm5
        SP0LsGjZoMCnjW8M2DN4L1pd+IvSvx4=
X-Google-Smtp-Source: AFSGD/VVZ0nrOPEWSSJcm9wJ2EszCJIzNmMffSRjVNnj+K1nGLngnUexpI6vkN4hPTyYGUdopdYn8w==
X-Received: by 2002:a5b:28e:: with SMTP id x14-v6mr28221226ybl.238.1544118591409;
        Thu, 06 Dec 2018 09:49:51 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id u81sm228853ywf.6.2018.12.06.09.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 09:49:50 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] blkcg: put back rcu lock in blkcg_bio_issue_check()
Date:   Thu,  6 Dec 2018 12:49:38 -0500
Message-Id: <20181206174938.2326-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I was a little overzealous in removing the rcu_read_lock() call from
blkcg_bio_issue_check() and it broke blk-throttle. Put it back.

Fixes: e35403a034bf ("blkcg: associate blkg when associating a device")
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 include/linux/blk-cgroup.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 752de1becb5c..bf13ecb0fe4f 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -764,6 +764,8 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 	struct blkcg_gq *blkg;
 	bool throtl = false;
 
+	rcu_read_lock();
+
 	if (!bio->bi_blkg) {
 		char b[BDEVNAME_SIZE];
 
@@ -791,6 +793,7 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 
 	blkcg_bio_issue_init(bio);
 
+	rcu_read_unlock();
 	return !throtl;
 }
 
-- 
2.17.1

