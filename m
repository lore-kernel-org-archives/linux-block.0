Return-Path: <SRS0=gXx0=YU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB10BCA9EBC
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 15:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AC221850
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 15:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBuGabhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfJ0Pf2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Oct 2019 11:35:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56064 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfJ0Pf2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Oct 2019 11:35:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id g24so6883530wmh.5;
        Sun, 27 Oct 2019 08:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vyNfIEeB8FFSKws4FozkOyHz73ufm0LnxuXkWsfV5aI=;
        b=nBuGabhwTF8ZK72QU98ayBpgNhobfN9ENsGkjeKIzlMBHXRCz78mg3QDsPAuZ2yDNd
         RKs4DZkhJFHga0kqfjYaS82F4RGRw27IMrUYbnH/lSgrBjTrerNEglNOh4dcgrFUTWsD
         zJFUXBiTblNWzlqgsrAFQCDsQHJCYf+6iXzeyklRMVZ1WlmtliFJzVkv3CH8sjDEjO7Z
         5CE48qNJbu8wLuj/icYLbDFwk1eMO0nAbUKsa9n1neh3ZW/xq5wKlWF2MOG0cahyFrar
         Jf557v//c/i4MvQPvX67OsPnwD3Dtr/b3jMImsb+C8cElW+xa1zS6Vch/XZ5+wuwgXnf
         isPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyNfIEeB8FFSKws4FozkOyHz73ufm0LnxuXkWsfV5aI=;
        b=UB+OznfgrUCaKSXCMh3aen0dB74rZExmQTjJuTPJa17w36rJfszohf7UBJEax4THtz
         A8n7SgdQNXYv1VyXwxNtta1/b35sFdSM7Vbb2x1nCUMZCIJIk4qrlwA27H4J1uchyrt0
         RcV+U2r7fxn+x589EmEQd4Cb5ee67hjOek2MES3QYmzCyu7VgJmcy3xgP/5oxzv3rmib
         oqVMlmwh81kpdngjFlCf/9nMYwdNI6FpMSc6yr+OmB+qgBdHkTCjkkD4WDgy5VaU+nfR
         mHiXD9mEF9eLirIhmWJE7+0KqbztVVFmNhTgiUH0YWmMjffztLzD/bKDGtULdXtWcuwF
         Bcnw==
X-Gm-Message-State: APjAAAU1zkm8Xu5e6xwKLbNEQAqKiiLFhKhrl+QVYaKOkDSOb99mCk/R
        ojvWBWA5BO6TkNDhP4nyZiNCamnt
X-Google-Smtp-Source: APXvYqyCA/T9b52BVjDOzud1FUGXdccvL2morLIgpqUHzCyyGJOUDW02Xu/av5NeF/nn9kOImesHJw==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr12813098wmt.112.1572190524660;
        Sun, 27 Oct 2019 08:35:24 -0700 (PDT)
Received: from localhost.localdomain ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id k3sm4226282wrn.95.2019.10.27.08.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 08:35:24 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] io_uring: handle mm_fault outside of submission
Date:   Sun, 27 Oct 2019 18:35:04 +0300
Message-Id: <e208444f3c22d2ee118e88b8e0d591ee6c80a1e3.1572189860.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572189860.git.asml.silence@gmail.com>
References: <cover.1572189860.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Preparation for the following patch.
Let callers of io_submit_sqes() handle an mm_fault case.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 76cc8add9e77..f65727f2ba95 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2640,7 +2640,7 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 }
 
 static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
-			  bool has_user, bool mm_fault)
+			  bool has_user)
 {
 	struct io_submit_state state, *statep = NULL;
 	struct io_kiocb *link = NULL;
@@ -2682,17 +2682,12 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		}
 
 out:
-		if (unlikely(mm_fault)) {
-			io_cqring_add_event(ctx, s.sqe->user_data,
-						-EFAULT);
-		} else {
-			s.has_user = has_user;
-			s.in_async = true;
-			s.needs_fixed_file = true;
-			trace_io_uring_submit_sqe(ctx, true, true);
-			io_submit_sqe(ctx, &s, statep, &link);
-			submitted++;
-		}
+		s.has_user = has_user;
+		s.in_async = true;
+		s.needs_fixed_file = true;
+		trace_io_uring_submit_sqe(ctx, true, true);
+		io_submit_sqe(ctx, &s, statep, &link);
+		submitted++;
 	}
 
 	if (link)
@@ -2703,6 +2698,16 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	return submitted;
 }
 
+static void io_fail_all_sqes(struct io_ring_ctx *ctx)
+{
+	struct sqe_submit s;
+
+	while (io_get_sqring(ctx, &s))
+		io_cqring_add_event(ctx, s.sqe->user_data, -EFAULT);
+
+	io_commit_sqring(ctx);
+}
+
 static int io_sq_thread(void *data)
 {
 	struct io_ring_ctx *ctx = data;
@@ -2813,12 +2818,15 @@ static int io_sq_thread(void *data)
 			}
 		}
 
-		to_submit = min(to_submit, ctx->sq_entries);
-		inflight += io_submit_sqes(ctx, to_submit, cur_mm != NULL,
-					   mm_fault);
-
-		/* Commit SQ ring head once we've consumed all SQEs */
-		io_commit_sqring(ctx);
+		if (unlikely(mm_fault)) {
+			io_fail_all_sqes(ctx);
+		} else {
+			to_submit = min(to_submit, ctx->sq_entries);
+			inflight += io_submit_sqes(ctx, to_submit,
+						   cur_mm != NULL);
+			/* Commit SQ ring head once we've consumed all SQEs */
+			io_commit_sqring(ctx);
+		}
 	}
 
 	set_fs(old_fs);
-- 
2.23.0

